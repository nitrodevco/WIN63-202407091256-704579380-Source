package com.sulake.habbo.quest
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.quest.events.UnseenAchievementsCountUpdateEvent;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1724;
   import com.sulake.habbo.communication.messages.outgoing.inventory.achievements.class_1095;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class AchievementController implements IDisposable, IUpdateReceiver
   {
      
      private static const CATEGORIES_COLUMN_COUNT:int = 3;
      
      private static const CATEGORY_SPACING_X:int = 8;
      
      private static const CATEGORY_SPACING_Y:int = 5;
      
      private static const CATEGORY_SPACING_TOP:int = 6;
      
      private static const CATEGORY_ROWS_MAX:int = 3;
      
      private static const ACHIEVEMENT_ROWS_MIN:int = 2;
      
      private static const ACHIEVEMENT_ROWS_MAX:int = 4;
      
      private static const ACHIEVEMENT_COLUMNS:int = 6;
      
      private static const IN_LEVEL_PROGRESS_BAR_WIDTH:int = 180;
      
      private static const TOTAL_PROGRESS_BAR_WIDTH:int = 246;
      
      private static const const_595:uint = 12910463;
      
      private static const const_823:int = 45;
      
      private static const IN_LEVEL_PROGRESS_BAR_LOC:Point = new Point(115,93);
      
      private static const TOTAL_PROGRESS_BAR_LOC:Point = new Point(72,1);
      
      private static const const_766:int = 20;
      
      private static const ACHIEVEMENT_TOP_SPACING:int = 3;
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_3514;
      
      private var var_2240:IWindowContainer;
      
      private var var_2860:IWindowContainer;
      
      private var var_2161:IWindowContainer;
      
      private var var_2755:IWindowContainer;
      
      private var var_3235:IWindowContainer;
      
      private var var_1357:AchievementCategories;
      
      private var var_638:AchievementCategory;
      
      private var var_419:class_1724;
      
      private var var_2331:Timer;
      
      private var var_3916:Dictionary;
      
      private var var_2506:ProgressBar;
      
      private var var_2567:ProgressBar;
      
      private var _pendingCategorySelect:String = null;
      
      private var var_3481:class_1724;
      
      private var var_2637:Timer;
      
      private var var_2745:Dictionary;
      
      private var var_3778:Boolean;
      
      private var var_2106:Dictionary;
      
      public function AchievementController(param1:HabboQuestEngine)
      {
         var_3916 = new Dictionary();
         var_2745 = new Dictionary();
         var_2106 = new Dictionary();
         super();
         _questEngine = param1;
         var_2331 = new Timer(100,1);
         var_2331.addEventListener("timer",doBadgeRefresh);
         var_2637 = new Timer(2000,1);
         var_2637.addEventListener("timer",switchIntoPendingLevel);
         var_2745[16] = 1;
         var_2745[28] = 6;
         var_2745[38] = 4;
         var_2745[39] = 3;
         var_2745[40] = 1;
      }
      
      public static function moveAllChildrenToColumn(param1:IWindowContainer, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:IWindow = null;
         while(_loc4_ < param1.numChildren)
         {
            if((_loc5_ = param1.getChildAt(_loc4_)) != null && _loc5_.visible && _loc5_.height > 0)
            {
               _loc5_.y = param2;
               param2 += _loc5_.height + param3;
            }
            _loc4_++;
         }
      }
      
      public static function getLowestPoint(param1:IWindowContainer) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindow = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if((_loc4_ = param1.getChildAt(_loc2_)).visible)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         var_3916 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2331)
         {
            var_2331.removeEventListener("timer",doBadgeRefresh);
            var_2331.reset();
            var_2331 = null;
         }
         if(var_2637)
         {
            var_2637.removeEventListener("timer",switchIntoPendingLevel);
            var_2637.reset();
            var_2637 = null;
         }
         if(var_2506)
         {
            var_2506.dispose();
            var_2506 = null;
         }
         if(var_2567)
         {
            var_2567.dispose();
            var_2567 = null;
         }
         var_2240 = null;
         var_2161 = null;
         var_2161 = null;
         var_2755 = null;
         var_3235 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         var_2106 = new Dictionary();
         broadcastUnseenAchievementsCount();
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function broadcastUnseenAchievementsCount() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in var_2106)
         {
            if(!isSkippedForUnseenBroadcast(_loc1_.badgeId))
            {
               _loc2_++;
            }
         }
         _questEngine.events.dispatchEvent(new UnseenAchievementsCountUpdateEvent(_loc2_));
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(isVisible())
         {
            close();
         }
         else
         {
            show();
         }
      }
      
      public function ensureAchievementsInitialized() : void
      {
         if(var_1357 == null)
         {
            _questEngine.send(new class_1095());
         }
      }
      
      public function show() : void
      {
         if(var_1357 == null)
         {
            _questEngine.send(new class_1095());
            var_3778 = true;
         }
         else
         {
            refresh();
            this._window.visible = true;
            this._window.activate();
         }
      }
      
      public function onAchievements(param1:Array, param2:String) : void
      {
         if(var_1357 == null)
         {
            var_1357 = new AchievementCategories(param1);
         }
         if(!var_3778)
         {
            return;
         }
         var_3778 = false;
         refresh();
         this._window.visible = true;
         this._window.activate();
         var _loc3_:String = _pendingCategorySelect == null ? param2 : _pendingCategorySelect;
         var _loc4_:AchievementCategory;
         if((_loc4_ = var_1357.getCategoryByCode(_loc3_)) != null)
         {
            pickCategory(_loc4_);
            _pendingCategorySelect = null;
         }
      }
      
      public function onAchievement(param1:class_1724) : void
      {
         var _loc2_:Boolean = false;
         if(var_1357 != null)
         {
            _loc2_ = var_419 && var_419.achievementId == param1.achievementId;
            if(!_loc2_ && !(param1.achievementId in var_2106))
            {
               var_2106[param1.achievementId] = param1;
               broadcastUnseenAchievementsCount();
            }
            if(_loc2_ && param1.level > var_419.level)
            {
               var_419.setMaxProgress();
               var_3481 = param1;
               var_2637.start();
            }
            else
            {
               var_1357.update(param1);
               if(_loc2_)
               {
                  var_419 = param1;
               }
            }
            if(_window && _window.visible)
            {
               refresh();
            }
         }
      }
      
      private function getCategoryUnseenCount(param1:String) : int
      {
         var _loc3_:int = 0;
         for each(var _loc2_ in var_2106)
         {
            if(_loc2_.category == param1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function refresh() : void
      {
         prepareWindow();
         refreshCategoryList();
         refreshCategoryListFooter();
         refreshAchievementsHeader();
         refreshAchievementList();
         refreshAchievementDetails();
         moveAllChildrenToColumn(_window.content,0,4);
         _window.height = getLowestPoint(_window.content) + 45;
      }
      
      private function refreshCategoryList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Boolean = false;
         if(var_638 != null)
         {
            var_2240.visible = false;
            return;
         }
         var_2240.visible = true;
         var _loc2_:Vector.<AchievementCategory> = var_1357.categoryList;
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ < _loc2_.length)
            {
               refreshCategoryEntry(_loc3_,_loc2_[_loc3_]);
            }
            else
            {
               _loc1_ = refreshCategoryEntry(_loc3_,null);
               if(_loc1_)
               {
                  break;
               }
            }
            _loc3_++;
         }
         var_2240.height = getLowestPoint(var_2240);
      }
      
      private function refreshCategoryListFooter() : void
      {
         if(var_638 != null)
         {
            var_3235.visible = false;
            return;
         }
         var_3235.visible = true;
         var_2567.refresh(var_1357.getProgress(),var_1357.getMaxProgress(),0,0);
      }
      
      private function refreshAchievementList() : void
      {
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:IWindow = _window.findChildByName("achievements_list");
         if(var_638 == null)
         {
            _loc2_.visible = false;
            return;
         }
         _loc2_.visible = true;
         class_14.log(var_638.code + " has " + var_638.achievements.length + " achievemenets");
         var _loc4_:Vector.<class_1724> = var_638.achievements;
         while(var_2860.numChildren > 0)
         {
            var_2860.removeChildAt(0);
         }
         _loc5_ = 0;
         while(true)
         {
            if(_loc5_ < _loc4_.length)
            {
               refreshAchievementEntry(_loc5_,_loc4_[_loc5_]);
            }
            else
            {
               _loc3_ = refreshAchievementEntry(_loc5_,null);
               if(_loc3_)
               {
                  break;
               }
            }
            _loc5_++;
         }
         var_2860.height = getLowestPoint(var_2860);
         _loc2_.height = var_2860.height + 1;
         _window.findChildByName("achievements_scrollarea").height = _loc2_.height;
         var _loc1_:IWindow = _window.findChildByName("achievements_scrollbar");
         _loc1_.visible = achievementsNeedScrolling;
         _loc1_.height = _loc2_.height;
      }
      
      private function refreshAchievementsHeader() : void
      {
         if(var_638 == null)
         {
            var_2755.visible = false;
            return;
         }
         var_2755.visible = true;
         var_2755.findChildByName("category_name_txt").caption = _questEngine.getAchievementCategoryName(var_638.code);
         _questEngine.localization.registerParameter("achievements.details.categoryprogress","progress",var_638.getProgress().toString());
         _questEngine.localization.registerParameter("achievements.details.categoryprogress","limit",var_638.getMaxProgress().toString());
         _questEngine.setupAchievementCategoryImage(var_2755,var_638,false);
      }
      
      private function refreshAchievementDetails() : void
      {
         if(var_419 == null)
         {
            var_2161.visible = false;
            return;
         }
         var_2161.visible = true;
         var _loc2_:String = getAchievedBadgeId(var_419);
         var_2161.findChildByName("achievement_name_txt").caption = _questEngine.localization.getBadgeName(_loc2_);
         var _loc1_:String = String(_questEngine.localization.getBadgeDesc(_loc2_));
         var_2161.findChildByName("achievement_desc_txt").caption = _loc1_ == null ? "" : _loc1_;
         _questEngine.localization.registerParameter("achievements.details.level","level",var_419.finalLevel ? var_419.level.toString() : (var_419.level - 1).toString());
         _questEngine.localization.registerParameter("achievements.details.level","limit",var_419.levelCount.toString());
         _questEngine.refreshReward(!var_419.finalLevel,var_2161,var_419.levelRewardPointType,var_419.levelRewardPoints);
         refreshBadgeImageLarge(var_2161,var_419);
         var_2506.refresh(var_419.currentPoints,var_419.scoreLimit,var_419.achievementId * 10000 + var_419.level,var_419.scoreAtStartOfLevel);
         var_2506.visible = var_419.displayMethod != 1 && !var_419.finalLevel;
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_3514(_questEngine.getXmlWindow("Achievements"));
         _window.findChildByTag("close").procedure = onWindowClose;
         _window.findChildByName("back_button").procedure = onBack;
         _window.center();
         _window.y = 20;
         var_2240 = IWindowContainer(_window.findChildByName("categories_cont"));
         var_2755 = IWindowContainer(_window.findChildByName("achievements_header_cont"));
         var_2860 = IWindowContainer(_window.findChildByName("achievements_cont"));
         var_2161 = IWindowContainer(_window.findChildByName("achievement_cont"));
         var_3235 = IWindowContainer(_window.findChildByName("categories_footer_cont"));
         var_2506 = new ProgressBar(_questEngine,var_2161,180,"achievements.details.progress",true,IN_LEVEL_PROGRESS_BAR_LOC);
         var_2567 = new ProgressBar(_questEngine,var_3235,246,"achievements.categories.totalprogress",true,TOTAL_PROGRESS_BAR_LOC);
      }
      
      private function refreshCategoryEntry(param1:int, param2:AchievementCategory) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:IWindowContainer = IWindowContainer(var_2240.getChildByName(param1.toString()));
         var _loc4_:int;
         var _loc6_:* = (_loc4_ = Math.floor(param1 / 3)) < 3;
         if(_loc3_ == null)
         {
            if(param2 == null && !_loc6_)
            {
               return true;
            }
            _loc3_ = IWindowContainer(_questEngine.getXmlWindow("AchievementCategory"));
            _loc3_.name = param1.toString();
            var_2240.addChild(_loc3_);
            _loc3_.findChildByName("category_region").procedure = onSelectCategory;
            _loc3_.x = (_loc3_.width + 8) * (param1 % 3);
            _loc3_.y = (_loc3_.height + 5) * Math.floor(param1 / 3) + 6;
         }
         _loc3_.findChildByName("category_region").id = param1;
         _loc3_.findChildByName("category_region").visible = param2 != null;
         _loc3_.findChildByName("category_bg_inact").visible = param2 == null;
         _loc3_.findChildByName("category_bg_act").visible = param2 != null;
         _loc3_.findChildByName("category_bg_act_hover").visible = false;
         _loc3_.findChildByName("header_txt").visible = param2 != null;
         _loc3_.findChildByName("completion_txt").visible = param2 != null;
         _loc3_.findChildByName("category_pic_bitmap").visible = param2 != null;
         _loc3_.findChildByName("unseen_count_border").visible = false;
         if(param2)
         {
            _loc3_.findChildByName("header_txt").caption = _questEngine.getAchievementCategoryName(param2.code);
            _loc3_.findChildByName("completion_txt").caption = param2.getProgress() + "/" + param2.getMaxProgress();
            _questEngine.setupAchievementCategoryImage(_loc3_,param2,true);
            if((_loc5_ = getCategoryUnseenCount(param2.code)) > 0)
            {
               _loc3_.findChildByName("unseen_count_border").visible = true;
               _loc3_.findChildByName("unseen_count").caption = _loc5_.toString();
            }
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = _loc6_;
         }
         return false;
      }
      
      private function refreshAchievementEntry(param1:int, param2:class_1724) : Boolean
      {
         var _loc5_:int;
         var _loc8_:* = (_loc5_ = param1 / achievementsColumnCount) < 2;
         if(param2 == null && !_loc8_)
         {
            return true;
         }
         var _loc3_:IWindowContainer = _questEngine.getXmlWindow("Achievement") as IWindowContainer;
         var_2860.addChild(_loc3_);
         _loc3_.x = (_loc3_.width + (achievementsNeedScrolling ? 5 : 0)) * (param1 % achievementsColumnCount);
         class_14.log("Refreshing " + param1 + " where count is " + var_638.achievements.length + ", row=" + _loc5_ + ", column=" + param1 % achievementsColumnCount);
         _loc3_.y = _loc3_.height * _loc5_ + 3;
         _loc3_.findChildByName("bg_region").procedure = onSelectAchievement;
         var _loc6_:IWindow;
         (_loc6_ = _loc3_.findChildByName("bg_region")).id = param1;
         _loc6_.visible = param2 != null;
         var _loc4_:IWindow = _loc3_.findChildByName("bg_unselected_bitmap");
         var _loc7_:IWindow = _loc3_.findChildByName("bg_selected_bitmap");
         this.refreshBadgeImage(_loc3_,param2);
         _loc4_.color = param2 != null && param2.achievementId in var_2106 ? 12910463 : 16777215;
         if(param2)
         {
            _loc4_.visible = param2 != var_419;
            _loc7_.visible = param2 == var_419;
            _loc3_.visible = true;
         }
         else if(_loc8_)
         {
            _loc7_.visible = false;
            _loc4_.visible = true;
            _loc3_.visible = true;
         }
         else
         {
            _loc3_.visible = false;
         }
         return false;
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function onSelectCategory(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = param2.id;
         class_14.log("Category index: " + _loc3_);
         if(param1.type == "WME_CLICK")
         {
            pickCategory(var_1357.categoryList[_loc3_]);
         }
         else if(param1.type == "WME_OUT")
         {
            refreshMouseOver(-999);
         }
         else if(param1.type == "WME_OVER")
         {
            refreshMouseOver(_loc3_);
         }
      }
      
      private function pickCategory(param1:AchievementCategory) : void
      {
         var_638 = param1;
         var_419 = var_638.achievements[0];
         class_14.log("Category: " + var_638.code);
         this.refresh();
         _questEngine.send(new EventLogMessageComposer("Achievements",var_638.code,"Category selected"));
      }
      
      public function selectCategoryInternalLink(param1:String) : void
      {
         var _loc2_:AchievementCategory = var_1357 != null ? var_1357.getCategoryByCode(param1) : null;
         if(_loc2_ != null)
         {
            pickCategory(_loc2_);
         }
         else
         {
            _pendingCategorySelect = param1;
         }
      }
      
      private function refreshMouseOver(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = false;
         var _loc3_:IWindowContainer = null;
         var _loc5_:IWindow = null;
         _loc4_ = 0;
         while(_loc4_ < var_2240.numChildren)
         {
            _loc2_ = _loc4_ == param1;
            _loc3_ = IWindowContainer(var_2240.getChildAt(_loc4_));
            _loc3_.findChildByName("category_bg_act").visible = !_loc2_ && _loc4_ < var_1357.categoryList.length;
            _loc3_.findChildByName("category_bg_act_hover").visible = _loc2_;
            (_loc5_ = _loc3_.findChildByName("hover_container")).x = _loc2_ ? 0 : 1;
            _loc5_.y = _loc2_ ? 0 : 1;
            _loc4_++;
         }
      }
      
      private function onSelectAchievement(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:int = param2.id;
         var_419 = var_638.achievements[_loc3_];
         this.refresh();
         _questEngine.send(new EventLogMessageComposer("Achievements",var_419.achievementId.toString(),"Achievement selected"));
      }
      
      private function onBack(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:Array = null;
         var _loc3_:* = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(var_638 != null)
         {
            _loc4_ = [];
            for each(_loc3_ in var_2106)
            {
               if(_loc3_.category != var_638.code)
               {
                  _loc4_.push(_loc3_);
               }
            }
            var_2106 = new Dictionary();
            for each(_loc3_ in _loc4_)
            {
               var_2106[_loc3_.achievementId] = _loc3_;
            }
            broadcastUnseenAchievementsCount();
         }
         var_638 = null;
         var_419 = null;
         this.refresh();
      }
      
      private function refreshBadgeImage(param1:IWindowContainer, param2:class_1724) : void
      {
         var _loc4_:IWidgetWindow;
         var _loc3_:IBadgeImageWidget = (_loc4_ = param1.findChildByName("achievement_pic_bitmap") as IWidgetWindow).widget as IBadgeImageWidget;
         if(param2 == null)
         {
            _loc4_.visible = false;
            return;
         }
         IStaticBitmapWrapperWindow(IWindowContainer(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = getAchievedBadgeId(param2);
         _loc3_.greyscale = !param2.firstLevelAchieved;
         _loc4_.visible = true;
      }
      
      private function refreshBadgeImageLarge(param1:IWindowContainer, param2:class_1724) : void
      {
         var _loc4_:IWidgetWindow;
         var _loc3_:IBadgeImageWidget = (_loc4_ = param1.findChildByName("achievement_pic_bitmap") as IWidgetWindow).widget as IBadgeImageWidget;
         IStaticBitmapWrapperWindow(IWindowContainer(_loc4_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc3_.badgeId = getAchievedBadgeId(param2);
         _loc3_.greyscale = !param2.firstLevelAchieved;
         _loc4_.visible = true;
      }
      
      private function doBadgeRefresh(param1:TimerEvent) : void
      {
         this.var_2331.reset();
         this.refresh();
      }
      
      private function switchIntoPendingLevel(param1:TimerEvent) : void
      {
         var_419 = var_3481;
         var_1357.update(var_3481);
         var_3481 = null;
         this.refresh();
      }
      
      public function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         this.var_3916[param1.badgeId] = param1.badgeImage;
         if(!this.var_2331.running)
         {
            this.var_2331.start();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_2506 != null)
         {
            var_2506.updateView(param1);
         }
         if(var_2567 != null)
         {
            var_2567.updateView(param1);
         }
      }
      
      private function getAchievedBadgeId(param1:class_1724) : String
      {
         if(param1.levelCount == 1)
         {
            return param1.badgeId;
         }
         return param1.finalLevel ? param1.badgeId : String(_questEngine.localization.getPreviousLevelBadgeId(param1.badgeId));
      }
      
      private function getPositionFix(param1:int) : int
      {
         return !!var_2745[param1] ? var_2745[param1] : 0;
      }
      
      private function get achievementsColumnCount() : int
      {
         if(achievementsNeedScrolling)
         {
            return 6 - 1;
         }
         return 6;
      }
      
      private function get achievementsNeedScrolling() : Boolean
      {
         return var_638 != null && var_638.achievements.length > 4 * 6;
      }
      
      private function isSkippedForUnseenBroadcast(param1:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Array = _questEngine.getProperty("toolbar.unseen_notification.skipped_badge_ids").split(",");
         for each(var _loc2_ in _loc4_)
         {
            if(param1.search(_loc2_) != -1)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getAchievementLevel(param1:String, param2:String) : int
      {
         var _loc4_:AchievementCategory = null;
         if(var_1357 != null)
         {
            if((_loc4_ = var_1357.getCategoryByCode(param1)) != null)
            {
               for each(var _loc3_ in _loc4_.achievements)
               {
                  if(_loc3_.badgeId.indexOf(param2) == 0)
                  {
                     return _loc3_.finalLevel ? _loc3_.level : Math.max(0,_loc3_.level - 1);
                  }
               }
            }
         }
         return 0;
      }
   }
}
