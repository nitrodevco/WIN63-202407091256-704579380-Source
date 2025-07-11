package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.groups.badge.BadgeEditorCtrl;
   import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.users.class_1183;
   import com.sulake.habbo.communication.messages.incoming.users.class_1184;
   import com.sulake.habbo.communication.messages.incoming.users.class_1197;
   import com.sulake.habbo.communication.messages.incoming.users.class_1677;
   import com.sulake.habbo.communication.messages.incoming.users.class_1688;
   import com.sulake.habbo.communication.messages.outgoing.users.class_1010;
   import com.sulake.habbo.communication.messages.outgoing.users.class_251;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildBadgeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.class_906;
   import com.sulake.habbo.communication.messages.outgoing.users.class_935;
   
   public class GuildManagementWindowCtrl implements IDisposable
   {
      
      private static const VIEW_IDENTITY:int = 1;
      
      private static const VIEW_BADGE:int = 2;
      
      private static const VIEW_COLORS:int = 3;
      
      private static const VIEW_CONFIRM:int = 4;
      
      private static const VIEW_SETTINGS:int = 5;
      
      private static const const_1194:int = 43;
      
      private static const const_702:int = 69;
      
      private static const EDIT_HEADER_TEXTS_OFFSET:int = -20;
      
      private static const CREATE_HEADER_BITMAP_OFFSET:int = 36;
      
      private static const STEP_TITLE_Y_OFFSET_ACTIVE:int = 5;
      
      private static const STEP_TITLE_Y_OFFSET_INACTIVE:int = 9;
      
      private static const STEP_TITLE_CREDIT_Y_OFFSET_ACTIVE:int = 6;
      
      private static const STEP_TITLE_CREDIT_Y_OFFSET_INACTIVE:int = 10;
      
      private static const MAX_DESCRIPTION_LENGTH:int = 255;
      
      private static const MAX_NAME_LENGTH:int = 30;
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:IWindowContainer;
      
      private var var_1764:BadgeEditorCtrl;
      
      private var var_1809:ColorGridCtrl;
      
      private var var_1814:ColorGridCtrl;
      
      private var var_2741:class_3537;
      
      private var var_3678:Boolean = false;
      
      private var var_2600:int = 0;
      
      private var var_47:class_1183;
      
      private var var_1684:int = 1;
      
      public function GuildManagementWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_480 = param1;
         var_1764 = new BadgeEditorCtrl(var_480);
         var_1809 = new ColorGridCtrl(var_480,onPrimaryColorSelected);
         var_1814 = new ColorGridCtrl(var_480,onSecondaryColorSelected);
         var_2741 = new class_3537();
      }
      
      public function dispose() : void
      {
         var_480 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1764)
         {
            var_1764.dispose();
            var_1764 = null;
         }
         if(var_1809)
         {
            var_1809.dispose();
            var_1809 = null;
         }
         if(var_1814)
         {
            var_1814.dispose();
            var_1814 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      private function prepare() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(var_480.getXmlWindow("group_management_window"));
         _window.findChildByTag("close").procedure = onCloseWindow;
         _window.center();
         _window.findChildByName("create_room_link_region").procedure = onCreateRoomLink;
         _window.findChildByName("cancel_link_region").procedure = onCancelLink;
         _window.findChildByName("next_step_button").procedure = onNextStep;
         _window.findChildByName("previous_step_link_region").procedure = onPreviousStep;
         _window.findChildByName("buy_button").procedure = onBuy;
         _window.findChildByName("vip_required_region").procedure = onGetVip;
         _window.addEventListener("WE_DEACTIVATED",onWindowUnActivated);
         _window.findChildByName("edit_tab_1").procedure = onTab;
         _window.findChildByName("edit_tab_2").procedure = onTab;
         _window.findChildByName("edit_tab_3").procedure = onTab;
         _window.findChildByName("edit_tab_5").procedure = onTab;
         _window.findChildByName("reset_badge").procedure = onBadgeReset;
         _window.findChildByName("reset_colors").procedure = onColorReset;
         _window.findChildByName("step_1_members_region").procedure = onMembersClick;
         var_2741.prepare(_window);
      }
      
      public function onFlatCreated(param1:int, param2:String) : void
      {
         if(_window != null && Boolean(_window.visible) && var_47 != null && !var_47.exists)
         {
            var_47.ownedRooms.splice(0,0,new class_1677(param1,param2,false));
            prepareRoomSelection();
            this.getBaseDropMenu().selection = 0;
         }
      }
      
      public function onSubscriptionChange() : void
      {
         if(_window != null && Boolean(_window.visible) && var_47 != null && !var_47.exists && var_1684 == 4)
         {
            refresh();
         }
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindow = null;
         prepare();
         var _loc3_:Boolean = !var_47.exists || Boolean(var_47.isOwner);
         _window.findChildByName("edit_tab_1").visible = _loc3_;
         _window.findChildByName("edit_tab_2").visible = _loc3_;
         _window.findChildByName("edit_tab_3").visible = _loc3_;
         _window.findChildByName("edit_tab_5").visible = _loc3_;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            getStepContainer(_loc2_).visible = var_1684 == _loc2_;
            _loc1_ = _window.findChildByName("header_pic_bitmap_step_" + _loc2_);
            _loc1_.y = !!var_47.exists ? 0 : 36;
            _loc1_.visible = var_1684 == _loc2_;
            _loc2_++;
         }
         _window.findChildByName("header_caption_txt").caption = getStepCaption();
         _window.findChildByName("header_desc_txt").caption = getStepDesc();
         _window.findChildByName("header_pic_bitmap");
         _window.findChildByName("header_caption_txt").y = 43 + getHeaderTextOffset();
         _window.findChildByName("header_desc_txt").y = 69 + getHeaderTextOffset();
         _window.findChildByName("edit_guild_tab_context").visible = var_47.exists;
         _window.findChildByName("footer_cont").visible = !var_47.exists;
         _window.findChildByName("reset_badge").visible = false;
         _window.findChildByName("reset_colors").visible = false;
         if(var_1684 == 2)
         {
            if(!var_47.exists)
            {
               var_480.trackGoogle("groupPurchase","step2_badge");
            }
            if(!var_1764.isIntialized)
            {
               var_1764.createWindow(getStepContainer(2),var_47.badgeSettings);
               var_1764.resetLayerOptions(var_47.badgeSettings);
            }
            _window.findChildByName("reset_badge").visible = var_47.exists;
         }
         if(var_1684 == 3)
         {
            if(!var_47.exists)
            {
               var_480.trackGoogle("groupPurchase","step3_colors");
            }
            if(!var_1809.isInitialized)
            {
               var_1809.createAndAttach(getStepContainer(3),"guild_primary_color_selector",var_480.guildEditorData.guildPrimaryColors);
               if(var_47.exists)
               {
                  var_1809.setSelectedColorById(var_47.primaryColorId);
               }
               else
               {
                  var_1809.setSelectedColorById(var_480.guildEditorData.findMatchingPrimaryColorId(var_1764.primaryColorIndex));
               }
            }
            if(!var_1814.isInitialized)
            {
               var_1814.createAndAttach(getStepContainer(3),"guild_secondary_color_selector",var_480.guildEditorData.guildSecondaryColors);
               if(var_47.exists)
               {
                  var_1814.setSelectedColorById(var_47.secondaryColorId);
               }
               else
               {
                  var_1814.setSelectedColorById(var_480.guildEditorData.findMatchingSecondaryColorId(var_1764.secondaryColorIndex));
               }
            }
            _window.findChildByName("reset_colors").visible = var_47.exists;
         }
         if(var_1684 == 5)
         {
            if(!var_2741.isInitialized)
            {
               var_2741.refresh(var_47);
            }
         }
         if(var_1684 == 4)
         {
            if(!var_47.exists)
            {
               var_480.trackGoogle("groupPurchase","step4_confirm");
            }
            updateConfirmPreview();
         }
         if(var_1684 == 1)
         {
            if(!var_47.exists)
            {
               var_480.trackGoogle("groupPurchase","step1_identity");
            }
            else
            {
               var_480.windowManager.registerLocalizationParameter("group.membercount","totalMembers","" + var_47.membershipCount);
               _window.findChildByName("step_1_members_txt").caption = var_480.localization.getLocalization("group.membercount");
            }
            _window.findChildByName("base_label").visible = !var_47.exists;
            _window.findChildByName("base_dropmenu").visible = !var_47.exists;
            _window.findChildByName("base_warning").visible = !var_47.exists;
            _window.findChildByName("create_room_link_region").visible = !var_47.exists;
            _window.findChildByName("step_1_members_region").visible = data.exists;
         }
         refreshCreateHeader();
      }
      
      private function updateConfirmPreview() : void
      {
         var _loc1_:BitmapData = null;
         var _loc5_:IBitmapWrapperWindow = null;
         var _loc2_:class_1688 = null;
         var _loc4_:IWindow = null;
         var _loc6_:class_1688 = null;
         var _loc3_:IWindow = null;
         if(var_480.guildEditorData == null || _window == null)
         {
            return;
         }
         if(var_1764.isIntialized)
         {
            _loc1_ = var_1764.getBadgeBitmap();
            _loc5_ = _window.findChildByName("badge_preview_image") as IBitmapWrapperWindow;
            if(_loc1_ != null && _loc5_ != null)
            {
               _loc5_.bitmap = _loc1_;
            }
         }
         if(var_1809.isInitialized)
         {
            _loc2_ = var_1809.getSelectedColorData();
            _loc4_ = _window.findChildByName("badge_preview_primary_color_top");
            if(_loc2_ != null && _loc4_ != null)
            {
               _loc4_.color = _loc2_.color;
            }
         }
         if(var_1814.isInitialized)
         {
            _loc6_ = var_1814.getSelectedColorData();
            _loc3_ = _window.findChildByName("badge_preview_secondary_color_top");
            if(_loc6_ != null && _loc3_ != null)
            {
               _loc3_.color = _loc6_.color;
            }
         }
         if(var_480.hasVip)
         {
            _window.findChildByName("buy_button").enable();
            _window.findChildByName("buy_border").color = 16761600;
         }
         else
         {
            _window.findChildByName("buy_border").color = 11184810;
            _window.findChildByName("buy_button").disable();
         }
         _window.findChildByName("vip_required_border").visible = !var_480.hasVip;
         _window.findChildByName("confirmation_caption").caption = ITextWindow(_window.findChildByName("name_txt")).text;
      }
      
      private function getHeaderTextOffset() : int
      {
         return !!var_47.exists ? -20 : 0;
      }
      
      private function refreshCreateHeader() : void
      {
         var _loc1_:int = 0;
         _window.findChildByName("steps_header_cont").visible = !var_47.exists;
         if(var_47.exists)
         {
            return;
         }
         _window.findChildByName("next_step_button").visible = hasNextStep();
         _window.findChildByName("previous_step_link_region").visible = hasPreviousStep();
         _window.findChildByName("cancel_link_region").visible = !hasPreviousStep();
         _window.findChildByName("buy_border").visible = !hasNextStep();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            getStepHeader(_loc1_,false).visible = _loc1_ != var_1684;
            getStepHeader(_loc1_,true).visible = _loc1_ == var_1684;
            _window.findChildByName("step_title_" + _loc1_).y = _loc1_ == var_1684 ? 5 : 9;
            _loc1_++;
         }
         _window.findChildByName("gcreate_icon_credit").y = var_1684 == 4 ? 6 : 10;
      }
      
      private function getStepHeader(param1:int, param2:Boolean) : IWindow
      {
         return _window.findChildByName("gcreate_" + param1 + "_" + (param2 ? "1" : "0"));
      }
      
      private function getStepContainer(param1:int) : IWindowContainer
      {
         return IWindowContainer(_window.findChildByName("step_cont_" + param1));
      }
      
      private function getStepCaption() : String
      {
         var _loc1_:String = (!!var_47.exists ? "group.edit.tabcaption." : "group.create.stepcaption.") + var_1684;
         return var_480.localization.getLocalization(_loc1_,_loc1_);
      }
      
      private function getStepDesc() : String
      {
         var _loc1_:String = (!!var_47.exists ? "group.edit.tabdesc." : "group.create.stepdesc.") + var_1684;
         return var_480.localization.getLocalization(_loc1_,_loc1_);
      }
      
      public function onGuildCreationInfo(param1:class_1197) : void
      {
         var_47 = param1;
         var_1684 = 1;
         var_2600 = 0;
         refresh();
         refreshBadgeImage();
         setupInputs();
         var_480.localization.registerParameter("group.create.confirm.buyinfo","amount","" + param1.costInCredits);
         _window.visible = true;
         _window.activate();
      }
      
      public function onGuildEditInfo(param1:class_1184) : void
      {
         var_47 = param1;
         var_1684 = 1;
         var_2600 = 0;
         refresh();
         refreshBadgeImage();
         setupInputs();
         var _loc2_:ITabContextWindow = ITabContextWindow(_window.findChildByName("edit_guild_tab_context"));
         var _loc3_:ISelectableWindow = ISelectableWindow(_window.findChildByName("edit_tab_" + var_1684));
         _loc2_.selector.setSelected(_loc3_);
         _window.visible = true;
         _window.activate();
      }
      
      private function setupInputs() : void
      {
         ITextWindow(_window.findChildByName("name_txt")).text = var_47.groupName;
         ITextWindow(_window.findChildByName("desc_txt")).text = var_47.groupDesc;
         prepareRoomSelection();
         var_1764.resetLayerOptions(var_47.badgeSettings);
         var_1809.setSelectedColorById(var_47.primaryColorId);
         var_1814.setSelectedColorById(var_47.secondaryColorId);
         var_2741.refresh(var_47);
      }
      
      private function onTab(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_SELECT" || param2.id == var_1684)
         {
            return;
         }
         if(!validateView())
         {
            param1.preventDefault();
            return;
         }
         saveView();
         var_1684 = param2.id;
         refresh();
      }
      
      private function onColorReset(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(var_1809.isInitialized)
            {
               var_1809.setSelectedColorById(var_47.primaryColorId);
            }
            if(var_1814.isInitialized)
            {
               var_1814.setSelectedColorById(var_47.secondaryColorId);
            }
         }
      }
      
      private function onBadgeReset(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK" && var_1764.isIntialized)
         {
            var_1764.resetLayerOptions(var_47.badgeSettings);
         }
      }
      
      private function onMembersClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK" && Boolean(var_47.exists) && var_480.guildMembersWindowCtrl != null)
         {
            var_480.trackGoogle("groupManagement","groupMembers");
            var_480.guildMembersWindowCtrl.onMembersClick(var_47.groupId,0);
         }
      }
      
      private function onCancelLink(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      private function onCreateRoomLink(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.navigator.startRoomCreation();
      }
      
      private function onNextStep(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!validateView())
         {
            return;
         }
         var_1684 = limitStep(var_1684 + 1);
         refresh();
      }
      
      private function onPreviousStep(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!validateView())
         {
            return;
         }
         var_1684 = limitStep(var_1684 - 1);
         refresh();
      }
      
      private function onBuy(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!var_47.exists)
         {
            var_480.trackGoogle("groupPurchase","buyGroup");
         }
         sendCreateGuildMessage();
      }
      
      private function onGetVip(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!var_47.exists)
         {
            var_480.trackGoogle("groupPurchase","buyVip");
         }
         var_480.openVipPurchase("GuildManagementWindowCtrl");
      }
      
      private function showAlert(param1:String, param2:String) : void
      {
         if(!var_3678)
         {
            var_3678 = true;
            var_480.windowManager.alert(param1,param2,0,onAlertClose);
         }
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
         var_3678 = false;
      }
      
      private function validateView() : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:class_1677 = null;
         var _loc4_:String = null;
         var _loc1_:Array = null;
         switch(var_1684 - 1)
         {
            case 0:
               _loc2_ = String(ITextFieldWindow(_window.findChildByName("name_txt")).text);
               if(!var_47.exists)
               {
                  _loc3_ = resolveBaseRoom();
                  if(_loc2_ == null || _loc2_.length == 0 || _loc3_ == null || _loc3_.roomId == 0)
                  {
                     showAlert("${group.edit.error.title}","${group.edit.error.no.name.or.room.selected}");
                     return false;
                  }
                  if(_loc3_.hasControllers && var_2600 != _loc3_.roomId)
                  {
                     var_2600 = _loc3_.roomId;
                     showAlert("${group.edit.error.warning}","${group.edit.error.controllers}");
                     return false;
                  }
               }
               if(_loc2_.length > 30)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.name.length}");
                  return false;
               }
               if((_loc4_ = String(ITextFieldWindow(_window.findChildByName("desc_txt")).text)) != null && _loc4_.length >= 255)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.desc.length}");
                  return false;
               }
               return true;
               break;
            case 1:
               _loc1_ = var_1764.isIntialized ? var_1764.getBadgeSettings() : var_47.badgeSettings;
               var_1764.onViewChange();
               return true;
            case 2:
               if(var_1809.getSelectedColorData() == null || var_1814.getSelectedColorData() == null)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.no.color.selected}");
                  return false;
               }
               return true;
               break;
            default:
               return true;
         }
      }
      
      private function saveView() : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         switch(var_1684 - 1)
         {
            case 0:
               _loc3_ = String(ITextFieldWindow(_window.findChildByName("name_txt")).text);
               _loc5_ = String(ITextFieldWindow(_window.findChildByName("desc_txt")).text);
               if(var_47.isOwner)
               {
                  var_480.send(new class_935(var_47.groupId,_loc3_,_loc5_));
               }
               var_480.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",var_47.groupId));
               return;
            case 1:
               _loc1_ = var_1764.isIntialized ? var_1764.getBadgeSettings() : var_47.badgeSettings;
               if(var_47.isOwner)
               {
                  var_480.send(new UpdateGuildBadgeMessageComposer(var_47.groupId,_loc1_));
               }
               var_480.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",var_47.groupId));
               break;
            case 2:
               _loc2_ = var_1809.isInitialized ? var_1809.getSelectedColorId() : int(var_47.primaryColorId);
               _loc4_ = var_1814.isInitialized ? var_1814.getSelectedColorId() : int(var_47.secondaryColorId);
               if(var_47.isOwner)
               {
                  var_480.send(new class_1010(var_47.groupId,_loc2_,_loc4_));
               }
               var_480.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",var_47.groupId));
               break;
            case 4:
               if(var_47.isOwner)
               {
                  var_480.send(new class_906(var_47.groupId,var_2741.guildType,var_2741.rightsLevel));
               }
               var_2741.resetModified();
         }
      }
      
      private function sendCreateGuildMessage() : void
      {
         var _loc3_:String = String(ITextFieldWindow(_window.findChildByName("name_txt")).text);
         var _loc5_:String = String(ITextFieldWindow(_window.findChildByName("desc_txt")).text);
         var _loc6_:class_1677 = resolveBaseRoom();
         var _loc1_:Array = var_1764.isIntialized ? var_1764.getBadgeSettings() : var_47.badgeSettings;
         var _loc2_:int = var_1809.isInitialized ? var_1809.getSelectedColorId() : int(var_47.primaryColorId);
         var _loc4_:int = var_1814.isInitialized ? var_1814.getSelectedColorId() : int(var_47.secondaryColorId);
         var_2600 = 0;
         var_480.send(new class_251(_loc3_,_loc5_,_loc6_.roomId,_loc2_,_loc4_,_loc1_));
      }
      
      private function hasPreviousStep() : Boolean
      {
         return var_1684 != limitStep(var_1684 - 1);
      }
      
      private function hasNextStep() : Boolean
      {
         return var_1684 != limitStep(var_1684 + 1);
      }
      
      private function limitStep(param1:int) : int
      {
         return Math.max(1,Math.min(param1,4));
      }
      
      private function getBaseDropMenu() : class_3520
      {
         return class_3520(_window.findChildByName("base_dropmenu"));
      }
      
      private function prepareRoomSelection() : void
      {
         var _loc2_:int = 0;
         var _loc4_:class_1677 = null;
         var _loc1_:class_3520 = getBaseDropMenu();
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         _loc3_.push(var_480.localization.getLocalization("group.edit.base.select.room","group.edit.base.select.room"));
         _loc2_ = 0;
         while(_loc2_ < var_47.ownedRooms.length)
         {
            _loc4_ = var_47.ownedRooms[_loc2_];
            _loc3_.push(_loc4_.roomName);
            if(_loc4_.roomId == var_47.baseRoomId)
            {
               _loc5_ = _loc2_ + 1;
            }
            _loc2_++;
         }
         _loc1_.populate(_loc3_);
         if(_loc3_.length > 0)
         {
            _loc1_.selection = _loc5_;
         }
      }
      
      private function resolveBaseRoom() : class_1677
      {
         var _loc1_:class_3520 = class_3520(_window.findChildByName("base_dropmenu"));
         var _loc2_:int = _loc1_.selection - 1;
         if(_loc2_ >= 0 && _loc2_ < var_47.ownedRooms.length && var_47.ownedRooms[_loc2_] != null)
         {
            return class_1677(var_47.ownedRooms[_loc2_]);
         }
         return null;
      }
      
      private function onCloseWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(var_47.exists)
         {
            if(!validateView())
            {
               return;
            }
            saveView();
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      public function onPrimaryColorSelected(param1:ColorGridCtrl) : void
      {
         var _loc3_:class_1688 = null;
         var _loc2_:IWindow = _window.findChildByName("guild_color_primary_color_top");
         if(_loc2_ != null && var_480.guildEditorData != null && param1.selectedColorIndex >= 0 && param1.selectedColorIndex <= var_480.guildEditorData.guildPrimaryColors.length)
         {
            _loc3_ = var_480.guildEditorData.guildPrimaryColors[param1.selectedColorIndex];
            _loc2_.color = _loc3_.color;
         }
      }
      
      public function onSecondaryColorSelected(param1:ColorGridCtrl) : void
      {
         var _loc3_:class_1688 = null;
         var _loc2_:IWindow = _window.findChildByName("guild_color_secondary_color_top");
         if(var_480.guildEditorData != null && param1.selectedColorIndex >= 0 && param1.selectedColorIndex <= var_480.guildEditorData.guildSecondaryColors.length)
         {
            _loc3_ = var_480.guildEditorData.guildSecondaryColors[param1.selectedColorIndex];
            _loc2_.color = _loc3_.color;
         }
      }
      
      public function get data() : class_1183
      {
         return var_47;
      }
      
      private function refreshBadgeImage() : void
      {
         var _loc2_:IWindow = _window.findChildByName("step_1_badge");
         var _loc1_:IBadgeImageWidget = IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget;
         if(_loc1_ == null || _loc2_ == null)
         {
            return;
         }
         if(!var_47.exists)
         {
            _loc2_.visible = false;
            _loc2_.invalidate();
         }
         else
         {
            _loc1_.badgeId = var_47.badgeCode;
            _loc1_.groupId = var_47.groupId;
            _loc2_.visible = true;
            _loc2_.invalidate();
         }
      }
      
      private function onWindowUnActivated(param1:WindowEvent) : void
      {
         if(var_47 != null && Boolean(var_47.exists) && _window != null && Boolean(_window.visible))
         {
            saveView();
         }
      }
   }
}
