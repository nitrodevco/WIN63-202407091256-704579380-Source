package com.sulake.habbo.friendbar.talent
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.session.talent.TalentEnum;
   import com.sulake.habbo.utils.class_419;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.parser.talent.class_1193;
   import com.sulake.habbo.communication.messages.parser.talent.class_1700;
   import com.sulake.habbo.communication.messages.parser.talent.class_1716;
   import com.sulake.habbo.communication.messages.parser.talent.class_1756;
   import com.sulake.habbo.communication.messages.parser.talent.class_1771;
   import com.sulake.habbo.communication.messages.parser.talent.class_1783;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   import com.sulake.habbo.communication.messages.incoming.users.class_547;
   import com.sulake.habbo.communication.messages.incoming.users.class_693;
   import com.sulake.habbo.communication.messages.incoming.users.class_835;
   import com.sulake.habbo.communication.messages.outgoing.users.class_1056;
   import com.sulake.habbo.communication.messages.outgoing.users.class_201;
   import com.sulake.habbo.communication.messages.outgoing.users.class_607;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_1018;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_639;
   import com.sulake.habbo.communication.messages.incoming.talent.class_559;
   
   public class TalentTrackController implements IDisposable
   {
      
      private static const MODAL_DIALOG_LAYER:int = 3;
      
      private static const HORIZONTAL_MARGIN:int = 100;
      
      private static const BEGIN_PANE_PREFIX:String = "begin_";
      
      private static const LEVEL_PANE_PREFIX:String = "level_pane_";
      
      private static const NO_CITIZENSHIP_SUFFIX:String = "_no_citizenship";
      
      private static const PROGRESS_BAR_MARGIN:int = 40;
      
      private static const DEFAULT_PADDING:int = 10;
      
      private static const REWARD_WIDTH:int = 200;
      
      private static const BADGE_RECT_SIZE:int = 60;
       
      
      private var _habboTalent:HabboTalent;
      
      private var _disposed:Boolean = false;
      
      private var var_1907:IModalDialog;
      
      private var _window:IWindowContainer;
      
      private var _taskProgressPopup:IModalDialog;
      
      private var var_1777:IItemListWindow;
      
      private var _talentTrack:class_1716;
      
      private var _talentProgressMeter:TalentProgressMeter;
      
      private var var_2387:IWindowContainer;
      
      private var var_3063:class_3437;
      
      private var var_3169:class_3437;
      
      private var var_3080:class_3437;
      
      private var var_3026:class_3437;
      
      private var var_3202:IWindowContainer;
      
      private var var_3222:IWindowContainer;
      
      private var var_3091:IWindowContainer;
      
      private var _overlayTemplate:IWindow;
      
      private var var_3940:int = -1;
      
      public function TalentTrackController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_talentProgressMeter)
            {
               _talentProgressMeter.dispose();
               _talentProgressMeter = null;
            }
            destroyWindow();
            _habboTalent = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get talentTrack() : class_1716
      {
         return _talentTrack;
      }
      
      public function initialize() : void
      {
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new class_559(onTalentTrack));
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new class_693(onChangeEmailResult));
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new class_835(onGroupDetails));
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new class_547(onEmailStatus));
      }
      
      private function onEmailStatus(param1:class_547) : void
      {
         var _loc2_:IWindowContainer = getEmailContainer();
         if(_loc2_ != null)
         {
            getEmailText().text = param1.getParser().email;
            _loc2_.findChildByName("unverified_container").visible = !param1.getParser().isVerified;
            _loc2_.findChildByName("verified_txt").visible = param1.getParser().isVerified;
         }
      }
      
      private function onChangeEmailResult(param1:class_693) : void
      {
         setEmailErrorStatus(true,param1.getParser().result);
      }
      
      private function onTalentTrack(param1:class_559) : void
      {
         var _loc2_:class_1193 = param1.getParser();
         _talentTrack = _loc2_.getTalentTrack();
         createWindow();
      }
      
      private function onGroupDetails(param1:class_835) : void
      {
         var _loc2_:class_1199 = param1.data;
         if(_loc2_.groupId == var_3940)
         {
            var_3940 = -1;
            _habboTalent.navigator.goToPrivateRoom(_loc2_.roomId);
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc5_:int = 0;
         destroyWindow();
         var_1907 = _habboTalent.getModalXmlWindow("talent_track");
         _window = IWindowContainer(var_1907.rootWindow);
         _window.procedure = onWindowEvent;
         var_1907.background.procedure = onModalWindowBackgroundEvent;
         _habboTalent.windowManager.getWindowContext(3).getDesktopWindow().addEventListener("WE_RESIZED",onDesktopResized);
         var_1777 = IItemListWindow(_window.findChildByName("panorama"));
         var_2387 = IWindowContainer(var_1777.removeListItem(var_1777.getListItemByName("level_pane")));
         var _loc2_:IItemListWindow = IItemListWindow(var_2387.findChildByName("reward_list"));
         var_3063 = class_3437(_loc2_.removeListItem(_loc2_.getListItemByName("reward_achieved")));
         var_3169 = class_3437(_loc2_.removeListItem(_loc2_.getListItemByName("reward_locked")));
         var_3080 = class_3437(_loc2_.removeListItem(_loc2_.getListItemByName("reward_product")));
         var_3026 = class_3437(_loc2_.removeListItem(_loc2_.getListItemByName("reward_vip")));
         var _loc4_:IItemListWindow = IItemListWindow(var_2387.findChildByName("task_list_top"));
         var_3202 = IWindowContainer(_loc4_.removeListItem(_loc4_.getListItemByName("task_achieved")));
         var_3222 = IWindowContainer(_loc4_.removeListItem(_loc4_.getListItemByName("task_ongoing")));
         var_3091 = IWindowContainer(_loc4_.removeListItem(_loc4_.getListItemByName("task_locked")));
         _overlayTemplate = var_2387.removeChild(var_2387.findChildByName("action_overlay"));
         var _loc3_:Boolean = _habboTalent.citizenshipEnabled;
         for each(var _loc7_ in TalentEnum.asArray)
         {
            _loc1_ = var_1777.getListItemByName("begin_" + _loc7_) as IWindowContainer;
            if(_loc1_ != null)
            {
               _loc1_.visible = _loc7_ == _talentTrack.name && _loc3_;
               if(_loc1_.visible)
               {
                  showAvatarInContainer(_loc1_);
               }
            }
            if(_loc7_ != "citizenship")
            {
               _loc1_ = var_1777.getListItemByName("begin_" + _loc7_ + "_no_citizenship") as IWindowContainer;
               if(_loc1_ != null)
               {
                  _loc1_.visible = _loc7_ == _talentTrack.name && !_loc3_;
                  if(_loc1_.visible)
                  {
                     showAvatarInContainer(_loc1_);
                  }
               }
            }
         }
         _window.findChildByName("frame_title").caption = "${talent.track." + _talentTrack.name + ".frame.title}";
         _window.findChildByName("frame_subtitle").caption = "${talent.track." + _talentTrack.name + ".frame.subtitle}";
         _window.findChildByName("progress_text").caption = "${talent.track." + _talentTrack.name + ".progress.title}";
         if(_loc3_ && _talentTrack.name != "citizenship")
         {
            _talentTrack.removeFirstLevel();
         }
         var _loc6_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < _talentTrack.levels.length)
         {
            createLevelPane(_talentTrack.levels[_loc5_],_loc5_);
            if(_talentTrack.levels[_loc5_].state == 1)
            {
               _loc6_ = _loc5_;
            }
            _loc5_++;
         }
         _talentProgressMeter = new TalentProgressMeter(_habboTalent,this);
         var_1777.setListItemIndex(var_1777.getListItemByName("end_padding"),var_1777.numListItems - 1);
         resizeWindow();
         scrollToLevel(_loc6_);
      }
      
      private function showAvatarInContainer(param1:IWindowContainer) : void
      {
         var _loc2_:IWidgetWindow = param1.findChildByName("avatar_image") as IWidgetWindow;
         if(_loc2_ != null)
         {
            IAvatarImageWidget(_loc2_.widget).figure = _habboTalent.sessionManager.figure;
         }
      }
      
      private function createLevelPane(param1:class_1783, param2:int) : void
      {
         var _loc16_:class_3437 = null;
         var _loc3_:ITextWindow = null;
         var _loc4_:ITextWindow = null;
         var _loc21_:ITextWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc7_:IItemListWindow = null;
         var _loc18_:int = 0;
         var _loc22_:IWindow = null;
         var _loc17_:* = undefined;
         var _loc15_:IWindow = null;
         var _loc5_:Point = null;
         var _loc9_:IWindowContainer = IWindowContainer(var_2387.clone());
         var _loc14_:IItemListWindow = IItemListWindow(_loc9_.findChildByName("status_list"));
         var _loc19_:IWindowContainer = IWindowContainer(_loc9_.findChildByName("level_reward"));
         var _loc10_:IWindowContainer = IWindowContainer(_loc9_.findChildByName("level_task"));
         var _loc12_:IItemListWindow = IItemListWindow(_loc9_.findChildByName("task_list_top"));
         var _loc20_:IItemListWindow = IItemListWindow(_loc9_.findChildByName("task_list_bottom"));
         _loc9_.name = "level_pane_" + param2;
         _loc9_.findChildByName("level_title").caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".title}";
         _loc9_.findChildByName("level_description").caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".description}";
         if(param2 == 0)
         {
            _loc19_.width = 0;
            _loc19_.visible = false;
            _loc14_.x = 4 * 10;
         }
         else
         {
            _loc16_ = class_3437(_loc19_.findChildByName("border"));
            _loc3_ = ITextWindow(_loc19_.findChildByName("title_locked"));
            _loc4_ = ITextWindow(_loc19_.findChildByName("title_achieved"));
            _loc21_ = ITextWindow(_loc19_.findChildByName("description_locked"));
            _loc6_ = ITextWindow(_loc19_.findChildByName("description_achieved"));
            _loc7_ = IItemListWindow(_loc19_.findChildByName("reward_list"));
            switch(param1.state)
            {
               case 0:
                  _loc16_.color = 12434877;
                  _loc16_.findChildByName("unlocked").visible = false;
                  _loc3_.caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".title}";
                  _loc4_.visible = false;
                  _loc21_.caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".unlock}";
                  _loc6_.visible = false;
                  _loc19_.findChildByName("achieved").visible = false;
                  break;
               case 1:
               case 2:
                  _loc16_.color = 4537147;
                  _loc3_.visible = false;
                  _loc4_.caption = _habboTalent.localizationManager.getLocalization("talent.track.common.unlocked.level.prefix") + " " + _habboTalent.localizationManager.getLocalization("talent.track." + _talentTrack.name + ".level." + param1.level + ".title");
                  _loc21_.visible = false;
                  _loc6_.caption = "${talent.track." + _talentTrack.name + ".level." + param1.level + ".unlock}";
                  _loc19_.findChildByName("locked").visible = false;
            }
            if(param1.rewardCount == 0)
            {
               _loc18_ = Math.max(200,Math.max(_loc4_.width,_loc3_.width));
               _loc21_.width = _loc18_;
               _loc6_.width = _loc18_;
               _loc16_.width = _loc18_ + 2 * 10;
               _loc19_.width = _loc18_ + 2 * 10;
               _loc16_.height = _loc6_.y + Math.max(_loc6_.height,_loc21_.height) + 10;
               _loc19_.height = _loc16_.height + _loc16_.y;
               _loc7_.visible = false;
            }
            else if(param1.rewardCount == 1 && param1.rewardProducts.length > 0)
            {
               _loc18_ = Math.max(200 + 10 * 2,Math.max(_loc4_.width,_loc3_.width));
               _loc21_.width = _loc18_;
               _loc6_.width = _loc18_;
               _loc7_.addListItem(createRewardProduct(param1,param1.rewardProducts[0]));
               _loc16_.width = _loc18_ + 2 * 10;
               _loc19_.width = _loc18_ + 2 * 10;
            }
            else if(param1.rewardCount == 1)
            {
               _loc16_.width = 420;
               _loc21_.width = 200 * 2;
               _loc6_.width = 200 * 2;
               _loc7_.addListItem(param1.rewardPerks.length > 0 ? createRewardPerk(param1,param1.rewardPerks[0]) : createRewardProduct(param1,param1.rewardProducts[0]));
               _loc7_.arrangeListItems();
               _loc19_.width = _loc7_.width + 2 * 10;
               _loc16_.width = _loc7_.width + 2 * 10;
            }
            else
            {
               for each(var _loc11_ in param1.rewardPerks)
               {
                  _loc7_.addListItem(createRewardPerk(param1,_loc11_));
               }
               for each(var _loc8_ in param1.rewardProducts)
               {
                  _loc7_.addListItem(createRewardProduct(param1,_loc8_));
               }
               _loc7_.arrangeListItems();
               _loc19_.width = _loc7_.width + 2 * 10;
               _loc16_.width = _loc7_.width + 2 * 10;
               _loc6_.width = _loc16_.width - 2 * 10;
            }
         }
         if(param1.tasks.length == 0)
         {
            _loc10_.width = 0;
            _loc10_.visible = false;
         }
         else
         {
            _loc17_ = new Vector.<IWindow>();
            for each(var _loc13_ in param1.tasks)
            {
               _loc22_ = createTask(param1,_loc13_);
               if(_loc12_.numListItems == _loc20_.numListItems)
               {
                  _loc12_.addListItem(_loc22_);
               }
               else
               {
                  _loc20_.addListItem(_loc22_);
               }
               if(_loc13_.badgeCode == "ACH_SafetyQuizGraduate1" && _loc13_.state == 1)
               {
                  _loc17_.push(_loc22_);
               }
            }
            _loc12_.arrangeListItems();
            _loc20_.arrangeListItems();
            _loc10_.width = Math.max(_loc12_.width,_loc20_.width);
            for each(_loc22_ in _loc17_)
            {
               _loc15_ = _overlayTemplate.clone();
               _loc5_ = new Point();
               _loc9_.addChild(_loc15_);
               _loc22_.convertPointFromLocalToGlobalSpace(_loc5_);
               _loc9_.convertPointFromGlobalToLocalSpace(_loc5_);
               _loc15_.x += _loc5_.x;
               _loc15_.y += _loc5_.y;
               _loc15_.visible = true;
            }
         }
         _loc14_.arrangeListItems();
         _loc14_.width = _loc19_.width + 10 + _loc10_.width;
         _loc9_.width = _loc14_.x + _loc14_.width + 10;
         repositionLevelIllustration(param1,_loc9_);
         var_1777.addListItem(_loc9_);
      }
      
      private function repositionLevelIllustration(param1:class_1783, param2:IWindowContainer) : void
      {
         var _loc3_:IWindow = param2.findChildByName("level_description");
         var _loc4_:IStaticBitmapWrapperWindow;
         (_loc4_ = IStaticBitmapWrapperWindow(param2.findChildByName("level_illustration"))).assetUri = "${image.library.url}talent/" + _talentTrack.name + "_" + param1.level + ".png";
         if(param1.level == 8 && _talentTrack.name == "helper")
         {
            _loc4_.width = 220;
            _loc4_.height = 270;
            _loc4_.x = Math.max(_loc3_.right,param2.width);
         }
         else if(param1.level == 0 && _talentTrack.name == "citizenship")
         {
            _loc4_.width = 0;
            _loc4_.x = Math.max(_loc3_.right,param2.width);
         }
         else if(param1.level == 4 && _talentTrack.name == "citizenship")
         {
            _loc4_.width = 220;
            _loc4_.height = 280;
            _loc4_.x = Math.max(_loc3_.right,param2.width);
         }
         else
         {
            _loc4_.x = Math.max(_loc3_.right,param2.width - _loc4_.width);
         }
         param2.width = Math.max(param2.width,_loc4_.right);
      }
      
      private function createRewardPerk(param1:class_1783, param2:class_1756) : IWindowContainer
      {
         var _loc3_:IWindowContainer = null;
         switch(param1.state)
         {
            case 0:
               _loc3_ = IWindowContainer(var_3169.clone());
               break;
            case 1:
            case 2:
               _loc3_ = IWindowContainer(var_3063.clone());
               IBadgeImageWidget(IWidgetWindow(_loc3_.findChildByName("achieved")).widget).badgeId = param2.perkId;
         }
         var _loc5_:IWindow = IWindow(_loc3_.findChildByName("title"));
         var _loc4_:IWindow = ITextWindow(_loc3_.findChildByName("description"));
         _loc5_.caption = "${perk." + param2.perkId + ".name}";
         _loc4_.caption = "${perk." + param2.perkId + ".description}";
         if(param1.rewardCount == 1)
         {
            _loc3_.width = 200 * 2;
            _loc3_.findChildByName("title").width = 200 * 2 - 60;
            _loc3_.findChildByName("description").width = 200 * 2 - 60;
         }
         else
         {
            if(_loc4_.height > 30)
            {
               _loc4_.width += 4 * 10;
            }
            _loc4_.width = Math.max(_loc4_.width,_loc5_.width);
            _loc3_.width = Math.max(_loc4_.width,_loc5_.width) + 60 + 10;
         }
         return _loc3_;
      }
      
      private function createRewardProduct(param1:class_1783, param2:class_1700) : IWindowContainer
      {
         var _loc3_:IWindowContainer = null;
         if(param2.vipDays == 0)
         {
            _loc3_ = IWindowContainer(var_3080.clone());
            IStaticBitmapWrapperWindow(_loc3_.findChildByName("product_icon")).assetUri = "${image.library.url}talent/reward_product_" + param2.productCode.toLowerCase().replace(" ","_") + ".png";
         }
         else
         {
            _loc3_ = IWindowContainer(var_3026.clone());
            _loc3_.findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days","","num_days",param2.vipDays);
         }
         if(param1.state == 0)
         {
            _loc3_.color = 9934743;
            _loc3_.blend = 0.6;
         }
         return _loc3_;
      }
      
      private function createTask(param1:class_1783, param2:class_1771) : IWindowContainer
      {
         var _loc6_:IWindowContainer = null;
         var _loc3_:IRegionWindow = null;
         if(param2.badgeCode == null || param2.badgeCode == "")
         {
            return null;
         }
         switch(param2.state)
         {
            case 0:
               _loc6_ = IWindowContainer(var_3091.clone());
               break;
            case 1:
               _loc6_ = IWindowContainer(var_3222.clone());
               IBadgeImageWidget(IWidgetWindow(_loc6_.findChildByName("badge")).widget).badgeId = param2.badgeCode;
               _loc6_.findChildByName("task_progress_fg").width = class_419.map(param2.currentScore,0,param2.totalScore,0,48);
               _loc3_ = _loc6_.findChildByName("task_ongoing_region") as IRegionWindow;
               _loc3_.id = param2.achievementId;
               if(param2.badgeCode == "ACH_SafetyQuizGraduate1")
               {
                  _loc3_.toolTipCaption = "";
                  _loc3_.name = param2.badgeCode;
               }
               break;
            case 2:
               _loc6_ = IWindowContainer(var_3202.clone());
               IBadgeImageWidget(IWidgetWindow(_loc6_.findChildByName("badge")).widget).badgeId = param2.badgeCode;
         }
         var _loc5_:IWindow = _loc6_.findChildByName("title");
         var _loc4_:IWindow = _loc6_.findChildByName("description");
         _loc5_.caption = _habboTalent.localizationManager.getAchievementName(param2.badgeCode).toUpperCase();
         _loc4_.caption = _habboTalent.localizationManager.getAchievementInstruction(param2.badgeCode);
         if(_loc5_.height > 20)
         {
            _loc5_.y -= 5;
            _loc4_.y += 5;
         }
         else if(_loc4_.height > 30)
         {
            _loc5_.y -= 5;
            _loc4_.y -= 5;
         }
         return _loc6_;
      }
      
      private function destroyWindow() : void
      {
         destroyTaskProgressDialog();
         if(_overlayTemplate != null)
         {
            _overlayTemplate.dispose();
            _overlayTemplate = null;
         }
         if(var_2387)
         {
            var_2387.dispose();
            var_2387 = null;
         }
         if(var_3063)
         {
            var_3063.dispose();
            var_3063 = null;
         }
         if(var_3169)
         {
            var_3169.dispose();
            var_3169 = null;
         }
         if(var_3080)
         {
            var_3080.dispose();
            var_3080 = null;
         }
         if(var_3026)
         {
            var_3026.dispose();
            var_3026 = null;
         }
         if(var_3202)
         {
            var_3202.dispose();
            var_3202 = null;
         }
         if(var_3222)
         {
            var_3222.dispose();
            var_3222 = null;
         }
         if(var_3091)
         {
            var_3091.dispose();
            var_3091 = null;
         }
         if(var_1907)
         {
            var_1907.dispose();
            var_1907 = null;
            _window = null;
            _habboTalent.windowManager.getWindowContext(3).getDesktopWindow().removeEventListener("WE_RESIZED",onDesktopResized);
         }
      }
      
      private function resizeWindow() : void
      {
         if(var_1907 == null || Boolean(var_1907.disposed))
         {
            return;
         }
         _window.x = 100;
         _window.width = _window.desktop.width - 2 * 100;
         _window.findChildByName("frame").width = _window.width;
         _window.findChildByName("panorama").width = _window.width;
         _window.findChildByName("panorama_scrollbar").width = _window.width;
         _talentProgressMeter.resize();
         var_1777.arrangeListItems();
         _window.invalidate();
      }
      
      private function onDesktopResized(param1:WindowEvent) : void
      {
         resizeWindow();
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(_window == null || Boolean(_window.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               destroyWindow();
               break;
            case "progress_container":
               _loc3_ = int(WindowMouseEvent(param1).localX);
               if(_loc3_ < 40)
               {
                  var_1777.scrollH = 0;
               }
               else if(_loc3_ > _talentProgressMeter.width - 40)
               {
                  var_1777.scrollH = 1;
               }
               else
               {
                  scrollToLevel(int(Math.floor(_loc3_ / _talentProgressMeter.progressPerLevelWidth)));
               }
               break;
            case "task_ongoing_region":
               createTaskProgressDialog(param2.id);
               break;
            case "citizenship_button":
               _habboTalent.tracking.trackTalentTrackOpen("citizenship","talentrack");
               _habboTalent.send(new class_1018("citizenship"));
               break;
            case "button_track_citizenship":
            case "button_track_helper":
               break;
            case "ACH_SafetyQuizGraduate1":
               closeAndLog(param2.name);
               _habboTalent.habboHelp.showSafetyBooklet();
         }
      }
      
      private function onModalWindowBackgroundEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(_window == null || Boolean(_window.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         destroyWindow();
      }
      
      private function scrollToLevel(param1:int) : void
      {
         var _loc2_:IWindow = null;
         if(param1 == 0)
         {
            var_1777.scrollH = 0;
         }
         else
         {
            _loc2_ = var_1777.getListItemByName("level_pane_" + param1);
            if(_loc2_ != null)
            {
               class_14.log(var_1777.scrollH);
               var_1777.scrollH = class_419.map(_loc2_.x - 20,0,var_1777.scrollableRegion.width - var_1777.visibleRegion.width,0,1);
               class_14.log(_loc2_.x + " " + var_1777.scrollableRegion.width + " " + class_419.map(_loc2_.x,0,var_1777.scrollableRegion.width,0,1) + " " + var_1777.scrollH);
            }
         }
      }
      
      private function createTaskProgressDialog(param1:int) : void
      {
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc4_:Boolean = false;
         destroyTaskProgressDialog();
         var _loc3_:class_1771 = _talentTrack.findTaskByAchievementId(param1);
         if(_loc3_ == null || _loc3_.badgeCode == null || _loc3_.badgeCode == "")
         {
            return;
         }
         _habboTalent.tracking.trackEventLog("Talent",talentTrack.name,"talent.progress.show",_loc3_.badgeCode);
         if(_loc3_.badgeCode == "ACH_GuideAdvertisementReader1")
         {
            setupTourAdvertisement();
            return;
         }
         _taskProgressPopup = _habboTalent.getModalXmlWindow("task_progress_dialog");
         _taskProgressPopup.rootWindow.procedure = onTaskProgressWindowEvent;
         _taskProgressPopup.background.procedure = onTaskProgressBackgroundWindowEvent;
         var _loc2_:IWindowContainer = IWindowContainer(_taskProgressPopup.rootWindow);
         _loc2_.findChildByName("instruction").caption = _habboTalent.localizationManager.getAchievementInstruction(_loc3_.badgeCode);
         _loc2_.findChildByName("title").caption = _habboTalent.localizationManager.getAchievementName(_loc3_.badgeCode);
         _loc2_.findChildByName("progress_text").caption = _habboTalent.localizationManager.getLocalization("talent.track.task.progress.dialog.progress") + " " + _loc3_.currentScore + "/" + _loc3_.totalScore;
         IBadgeImageWidget(IWidgetWindow(_loc2_.findChildByName("badge")).widget).badgeId = _loc3_.badgeCode;
         getEmailContainer().visible = false;
         if(_habboTalent.citizenshipEnabled)
         {
            _loc7_ = String(_habboTalent.localizationManager.getLocalization("talent.track.task.action." + _talentTrack.name + "." + mapBadgeCode(_loc3_.badgeCode) + ".description",""));
            _loc5_ = String(_habboTalent.localizationManager.getLocalization("talent.track.task.action." + _talentTrack.name + "." + mapBadgeCode(_loc3_.badgeCode) + ".link",""));
            _loc4_ = _loc7_ != "" || _loc5_ != "";
            _loc2_.findChildByName("action_separator").visible = _loc4_;
            _loc2_.findChildByName("action_title").visible = _loc4_;
            setText(_loc2_,"action_description",_loc7_);
            setText(_loc2_,"action_link",_loc5_);
            _loc2_.findChildByName("action_link").name = _loc3_.badgeCode;
            _loc2_.findChildByName("progress_separator").visible = _loc5_ != "";
            if(_loc3_.badgeCode == "ACH_EmailVerification1" && emailChangeEnabled)
            {
               getEmailContainer().visible = true;
               getEmailContainer().findChildByName("change_email_region").procedure = onChangeEmail;
               getEmailText().procedure = onEmailTxt;
               _habboTalent.send(new class_1056());
               setEmailErrorStatus(false);
            }
         }
         else
         {
            _loc2_.findChildByName("action_separator").visible = false;
            _loc2_.findChildByName("action_title").visible = false;
            _loc2_.findChildByName("action_description").visible = false;
            _loc2_.findChildByName("action_link").visible = false;
         }
         IItemListWindow(_loc2_.findChildByName("top_list")).arrangeListItems();
         if(_loc3_.currentScore <= 0)
         {
            _loc2_.findChildByName("achieved_left").visible = false;
            _loc2_.findChildByName("achieved_right").visible = false;
            _loc2_.findChildByName("achieved_mid").visible = false;
         }
         else if(_loc3_.currentScore < _loc3_.totalScore)
         {
            _loc2_.findChildByName("achieved_right").visible = false;
            _loc2_.findChildByName("achieved_mid").width = class_419.map(_loc3_.currentScore,0,_loc3_.totalScore,0,_loc2_.findChildByName("unachieved_mid").width);
         }
         var _loc6_:IItemListWindow = IItemListWindow(_loc2_.findChildByName("list"));
         if(!_loc3_.hasProgressDisplay())
         {
            _loc6_.removeListItem(_loc6_.getListItemByName("progress_main_container"));
         }
         _loc6_.arrangeListItems();
      }
      
      private function getEmailContainer() : IWindowContainer
      {
         if(_taskProgressPopup == null || _taskProgressPopup.rootWindow == null)
         {
            return null;
         }
         var _loc1_:IWindowContainer = IWindowContainer(_taskProgressPopup.rootWindow);
         return _loc1_ == null ? null : IWindowContainer(_loc1_.findChildByName("email_container"));
      }
      
      private function mapBadgeCode(param1:String) : String
      {
         if(param1 == "ACH_RoomEntry1" || param1 == "ACH_RoomEntry2")
         {
            return "ACH_RoomEntry";
         }
         return param1;
      }
      
      private function setText(param1:IWindowContainer, param2:String, param3:String) : void
      {
         var _loc4_:IWindow;
         (_loc4_ = param1.findChildByName(param2)).caption = param3;
         _loc4_.visible = param3 != "";
      }
      
      private function destroyTaskProgressDialog() : void
      {
         if(_taskProgressPopup != null)
         {
            _taskProgressPopup.dispose();
            _taskProgressPopup = null;
         }
      }
      
      private function onTaskProgressWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(_taskProgressPopup == null || Boolean(_taskProgressPopup.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "thanks_button":
               destroyTaskProgressDialog();
               break;
            case "ACH_HabboWayGraduate1":
               closeAndLog(param2.name);
               _habboTalent.habboHelp.showHabboWay();
               break;
            case "ACH_GuideGroupMember1":
               closeAndLog(param2.name);
               _loc3_ = _habboTalent.getInteger("guide.help.alpha.groupid",0);
               if(_loc3_ > 0)
               {
                  var_3940 = _loc3_;
                  _habboTalent.send(new class_201(_loc3_,false));
               }
               break;
            case "ACH_SafetyQuizGraduate1":
               closeAndLog(param2.name);
               _habboTalent.habboHelp.showSafetyBooklet();
               break;
            case "ACH_RoomEntry1":
            case "ACH_RoomEntry2":
               closeAndLog(param2.name);
               _habboTalent.navigator.openNavigator(null);
               break;
            case "ACH_AvatarLooks1":
               closeAndLog(param2.name);
               _habboTalent.avatarEditor.openEditor(0,null,null,true);
               _habboTalent.avatarEditor.loadOwnAvatarInEditor(0);
         }
      }
      
      private function closeAndLog(param1:String) : void
      {
         destroyWindow();
         _habboTalent.tracking.trackEventLog("Talent",_talentTrack.name,"talent.progress.click_activity",param1);
      }
      
      private function setupTourAdvertisement() : void
      {
         _taskProgressPopup = _habboTalent.getModalXmlWindow("tour_task_progress_dialog");
         var _loc1_:IWindowContainer = IWindowContainer(_taskProgressPopup.rootWindow);
         _loc1_.findChildByName("take_tour_button").procedure = onTakeTour;
         _loc1_.findChildByName("decline_tour_region").procedure = onDeclineTour;
         _loc1_.findChildByName("header_button_close").procedure = onCloseTourAd;
      }
      
      private function onTakeTour(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            destroyWindow();
            destroyTaskProgressDialog();
            _habboTalent.send(new class_639());
            _habboTalent.habboHelp.requestGuide();
            _habboTalent.tracking.trackEventLog("Help","","tour.new_user.accept");
            _habboTalent.tracking.trackGoogle("newbieTourWindow","click_acceptTour");
         }
      }
      
      private function onCloseTourAd(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            destroyTaskProgressDialog();
         }
      }
      
      private function onDeclineTour(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            destroyWindow();
            destroyTaskProgressDialog();
            _habboTalent.send(new class_639());
            _habboTalent.tracking.trackEventLog("Help","","tour.new_user.cancel");
            _habboTalent.tracking.trackGoogle("newbieTourWindow","click_refuseTour");
         }
      }
      
      private function onChangeEmail(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = String(getEmailText().text);
            _habboTalent.send(new class_607(_loc3_));
         }
      }
      
      private function onEmailTxt(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_FOCUSED")
         {
            setEmailErrorStatus(false);
         }
      }
      
      private function setEmailErrorStatus(param1:Boolean, param2:int = 0) : void
      {
         if(getEmailContainer() == null)
         {
            return;
         }
         var _loc3_:Boolean = param1 && param2 != 0;
         var _loc5_:IWindow;
         var _loc4_:IWindowContainer;
         (_loc5_ = (_loc4_ = getEmailContainer()).findChildByName("error_txt")).visible = _loc3_;
         _loc5_.caption = "${welcome.gift.email.error." + param2 + "}";
         _loc4_.findChildByName("error_border").visible = _loc3_;
         _loc4_.findChildByName("change_email_region").visible = !param1;
         _loc4_.findChildByName("changed_container").visible = param1 && param2 == 0;
      }
      
      private function getEmailText() : ITextFieldWindow
      {
         return ITextFieldWindow(getEmailContainer().findChildByName("email_txt"));
      }
      
      private function onTaskProgressBackgroundWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(_taskProgressPopup == null || Boolean(_taskProgressPopup.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         destroyTaskProgressDialog();
      }
      
      private function get emailChangeEnabled() : Boolean
      {
         return _habboTalent.getBoolean("talent.progress.emailchange.enabled");
      }
   }
}
