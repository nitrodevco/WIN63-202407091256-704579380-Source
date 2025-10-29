package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendlist.RelationshipStatusEnum;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class InfoStandUserView
   {
      
      protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 16777215;
      
      protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
       
      
      protected var var_1629:InfoStandWidget;
      
      protected var _window:IItemListWindow;
      
      protected var var_1693:IItemListWindow;
      
      protected var var_4825:IItemListWindow;
      
      private var var_1638:class_3437;
      
      private var var_2899:TagListRenderer;
      
      private var _badgeDetails:class_3437;
      
      private var var_4341:int;
      
      protected var var_2126:IRegionWindow;
      
      private const ITEM_SPACER:int = 5;
      
      private const MOTTO_TEXT_OFFSET:int = 3;
      
      private const MOTTO_EDITED_COLOR:int = 11184810;
      
      private const MOTTO_UNCHANGED_COLOR:int = 16777215;
      
      private const const_798:int = 2000;
      
      private const MAX_MOTTO_HEIGHT:int = 50;
      
      private const MIN_MOTTO_HEIGHT:int = 23;
      
      private const TOOLTIP_DELAY:int = 100;
      
      public function InfoStandUserView(param1:InfoStandWidget, param2:String)
      {
         super();
         var_1629 = param1;
         createWindow(param2);
         var_2899 = new TagListRenderer(param1,onTagSelected);
      }
      
      public function dispose() : void
      {
         if(var_2126)
         {
            var_2126.dispose();
            var_2126 = null;
         }
         var_1629 = null;
         _window.dispose();
         _window = null;
         var_2899.dispose();
         var_2899 = null;
         disposeBadgeDetails();
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      protected function updateWindow() : void
      {
         if(var_1693 == null || var_1638 == null)
         {
            return;
         }
         var_1693.height = var_1693.scrollableRegion.height;
         var_1638.height = var_1693.height + 20;
         _window.width = var_1638.width;
         _window.height = _window.scrollableRegion.height;
         var_1629.refreshContainer();
      }
      
      protected function createWindow(param1:String) : void
      {
         var _loc8_:BitmapDataAsset = null;
         var _loc7_:BitmapData = null;
         var _loc3_:IWindow = null;
         var _loc6_:int = 0;
         _window = var_1629.getXmlWindow("user_view") as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_1638 = _window.getListItemByName("info_border") as class_3437;
         if(var_1638 != null)
         {
            var_1693 = var_1638.findChildByName("infostand_element_list") as IItemListWindow;
            var_4825 = var_1638.findChildByName("relationship_status_container") as IItemListWindow;
            var_4825.visible = var_1629.config.getBoolean("relationship.status.enabled");
            var_1638.findChildByName("heart_randomusername").procedure = onRelationshipUserNameLinkClicked;
            var_1638.findChildByName("smile_randomusername").procedure = onRelationshipUserNameLinkClicked;
            var_1638.findChildByName("bobba_randomusername").procedure = onRelationshipUserNameLinkClicked;
         }
         _window.name = param1;
         var _loc5_:IBitmapWrapperWindow;
         if((_loc5_ = var_1638.findChildByName("home_icon") as IBitmapWrapperWindow) != null)
         {
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            _loc7_ = (_loc8_ = var_1629.assets.getAssetByName("icon_home") as BitmapDataAsset).content as BitmapData;
            _loc5_.bitmap = new BitmapData(_loc5_.width,_loc5_.height,true,0);
            _loc5_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(0,0));
            _loc5_.addEventListener("WME_CLICK",onButtonClicked);
         }
         var_1629.mainContainer.addChild(_window);
         var _loc4_:IWindow;
         if((_loc4_ = var_1638.findChildByTag("close")) != null)
         {
            _loc4_.addEventListener("WME_CLICK",onClose);
         }
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc3_ = var_1638.findChildByName("badge_" + _loc6_);
            if(_loc3_ != null)
            {
               _loc3_.addEventListener("WME_OVER",showBadgeInfo);
               _loc3_.addEventListener("WME_OUT",hideBadgeInfo);
            }
            _loc6_++;
         }
         _loc3_ = var_1638.findChildByName("badge_group");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",selectGroupBadge);
            _loc3_.addEventListener("WME_OVER",showGroupBadgeInfo);
            _loc3_.addEventListener("WME_OUT",hideGroupBadgeInfo);
         }
         var _loc2_:IWindow = var_1638.findChildByName("avatar_image_profile_link");
         if(_loc2_ != null)
         {
            _loc2_.procedure = onProfileLink;
         }
         if(var_1629.handler.isActivityDisplayEnabled)
         {
            var_1638.findChildByName("score_spacer").visible = true;
            var_1638.findChildByName("score_value").visible = true;
            var_1638.findChildByName("score_text").visible = true;
         }
      }
      
      private function selectGroupBadge(param1:WindowMouseEvent) : void
      {
         if(var_1629.userData.groupId < 0)
         {
            return;
         }
         var _loc2_:* = var_1629.userData.type == "RWUIUE_OWN_USER";
         var _loc3_:RoomWidgetGetBadgeDetailsMessage = new RoomWidgetGetBadgeDetailsMessage(_loc2_,var_1629.userData.groupId);
         var_1629.messageListener.processWidgetMessage(_loc3_);
      }
      
      private function showGroupBadgeInfo(param1:WindowMouseEvent) : void
      {
         if(var_1629.userData.groupId < 0)
         {
            return;
         }
         createBadgeDetails();
         if(param1.window == null)
         {
            return;
         }
         _badgeDetails.findChildByName("name").caption = var_1629.userData.groupName;
         var _loc2_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc2_);
         _badgeDetails.x = _loc2_.left - _badgeDetails.width;
         _badgeDetails.y = _loc2_.top + (_loc2_.height - _badgeDetails.height) / 2;
      }
      
      private function hideGroupBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function showBadgeInfo(param1:WindowMouseEvent) : void
      {
         var _loc5_:ITextWindow = null;
         if(param1.window == null)
         {
            return;
         }
         var _loc6_:int;
         if((_loc6_ = int(param1.window.name.replace("badge_",""))) < 0)
         {
            return;
         }
         var _loc2_:Array = var_1629.userData.badges;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc6_ >= _loc2_.length)
         {
            return;
         }
         var _loc3_:String = String(var_1629.userData.badges[_loc6_]);
         if(_loc3_ == null)
         {
            return;
         }
         createBadgeDetails();
         if((_loc5_ = _badgeDetails.getChildByName("name") as ITextWindow) != null)
         {
            _loc5_.text = var_1629.localizations.getBadgeName(_loc3_);
         }
         if((_loc5_ = _badgeDetails.getChildByName("description") as ITextWindow) != null)
         {
            _loc5_.text = var_1629.localizations.getBadgeDesc(_loc3_);
            _badgeDetails.height = _loc5_.text == "" ? 40 : 99;
         }
         var _loc4_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc4_);
         _badgeDetails.x = _loc4_.left - _badgeDetails.width;
         _badgeDetails.y = _loc4_.top + (_loc4_.height - _badgeDetails.height) / 2;
      }
      
      private function hideBadgeInfo(param1:WindowMouseEvent) : void
      {
         disposeBadgeDetails();
      }
      
      private function createBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            return;
         }
         var _loc1_:XmlAsset = var_1629.assets.getAssetByName("badge_details") as XmlAsset;
         if(_loc1_ == null)
         {
            return;
         }
         _badgeDetails = var_1629.windowManager.buildFromXML(_loc1_.content as XML) as class_3437;
         if(_badgeDetails == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
      }
      
      private function disposeBadgeDetails() : void
      {
         if(_badgeDetails != null)
         {
            _badgeDetails.dispose();
            _badgeDetails = null;
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         var_1629.close();
      }
      
      public function set name(param1:String) : void
      {
         if(var_2126 == null)
         {
            var_2126 = var_1693.getListItemByName("profile_link") as IRegionWindow;
            if(var_2126 == null)
            {
               return;
            }
            var_2126.procedure = onProfileLink;
            var_2126.visible = true;
         }
         var _loc2_:ITextWindow = var_2126.findChildByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      public function set realName(param1:String) : void
      {
         var _loc2_:ITextWindow = var_1693.getListItemByName("realname_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(param1.length == 0)
         {
            _loc2_.text = "";
         }
         else
         {
            var_1629.localizations.registerParameter("infostand.text.realname","realname",param1);
            _loc2_.text = var_1629.localizations.getLocalization("infostand.text.realname");
         }
         _loc2_.height = _loc2_.textHeight + 5;
         _loc2_.visible = param1.length > 0;
      }
      
      public function setFigure(param1:String) : void
      {
         var _loc2_:IAvatarImageWidget = IWidgetWindow(var_1638.findChildByName("avatar_image")).widget as IAvatarImageWidget;
         _loc2_.figure = param1;
      }
      
      public function setMotto(param1:String, param2:Boolean) : void
      {
         var _loc7_:IWindowContainer;
         if(!(_loc7_ = var_1693.getListItemByName("motto_container") as IWindowContainer))
         {
            return;
         }
         var _loc3_:IWindow = _loc7_.findChildByName("changemotto.image");
         var _loc6_:ITextWindow = _loc7_.findChildByName("motto_text") as ITextWindow;
         var _loc5_:IWindowContainer = var_1693.getListItemByName("motto_spacer") as IWindowContainer;
         if(_loc6_ == null || _loc5_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2)
         {
            _loc3_.visible = true;
            if(param1 == "")
            {
               param1 = String(var_1629.localizations.getLocalization("infostand.motto.change"));
               _loc6_.textColor = 11184810;
            }
            else
            {
               _loc6_.textColor = 16777215;
            }
            _loc6_.enable();
         }
         else
         {
            _loc3_.visible = false;
            _loc6_.textColor = 16777215;
            _loc6_.disable();
         }
         if(!var_1629.config.getBoolean("infostand.motto.change.enabled"))
         {
            _loc6_.disable();
         }
         _loc6_.text = param1;
         _loc6_.height = Math.min(_loc6_.textHeight + 5,50);
         _loc6_.height = Math.max(_loc6_.height,23);
         _loc7_.height = _loc6_.height + 3;
         if(param2)
         {
            _loc6_.addEventListener("WKE_KEY_UP",onMottoKeyboard);
            _loc6_.addEventListener("WME_CLICK",onMottoClicked);
         }
         else
         {
            _loc6_.removeEventListener("WKE_KEY_UP",onMottoClicked);
         }
         var _loc4_:Boolean = _loc6_.text && _loc6_.text.toLowerCase().indexOf("crikey") >= 0;
         if(var_1638)
         {
            var_1638.findChildByName("sticker_croco").visible = _loc4_;
            var_1638.findChildByName("avatar_image").visible = !_loc4_;
         }
         updateWindow();
      }
      
      public function set achievementScore(param1:int) : void
      {
         if(!var_1629.handler.isActivityDisplayEnabled)
         {
            return;
         }
         var _loc2_:ITextWindow = var_1693.getListItemByName("score_value") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = String(param1);
      }
      
      public function set carryItem(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc6_:ITextWindow = var_1693.getListItemByName("handitem_txt") as ITextWindow;
         var _loc3_:IWindowContainer = var_1693.getListItemByName("handitem_spacer") as IWindowContainer;
         if(_loc6_ == null || _loc3_ == null)
         {
            return;
         }
         if(param1 > 0 && param1 < 999999)
         {
            _loc2_ = String(var_1629.localizations.getLocalization("handitem" + param1,"handitem" + param1));
            var_1629.localizations.registerParameter("infostand.text.handitem","item",_loc2_);
         }
         _loc6_.height = _loc6_.textHeight + 5;
         var _loc4_:Boolean = Boolean(_loc6_.visible);
         var _loc5_:Boolean = param1 > 0 && param1 < 999999;
         _loc6_.visible = _loc5_;
         _loc3_.visible = _loc5_;
         if(_loc5_ != _loc4_)
         {
            var_1693.arrangeListItems();
         }
         updateWindow();
      }
      
      public function set xp(param1:int) : void
      {
         var _loc5_:ITextWindow = var_1693.getListItemByName("xp_text") as ITextWindow;
         var _loc2_:IWindowContainer = var_1693.getListItemByName("xp_spacer") as IWindowContainer;
         if(_loc5_ == null || _loc2_ == null)
         {
            return;
         }
         var_1629.localizations.registerParameter("infostand.text.xp","xp",param1.toString());
         _loc5_.height = _loc5_.textHeight + 5;
         var _loc3_:Boolean = Boolean(_loc5_.visible);
         var _loc4_:* = param1 > 0;
         _loc5_.visible = _loc4_;
         _loc2_.visible = _loc4_;
         if(_loc4_ != _loc3_)
         {
            var_1693.arrangeListItems();
         }
         updateWindow();
      }
      
      public function setBadge(param1:int, param2:String) : void
      {
         var _loc3_:IBadgeImageWidget = IWidgetWindow(var_1638.findChildByName("badge_" + param1)).widget as IBadgeImageWidget;
         _loc3_.badgeId = param2;
      }
      
      public function clearBadges() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IBadgeImageWidget = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = IWidgetWindow(var_1638.findChildByName("badge_" + _loc2_)).widget as IBadgeImageWidget;
            _loc1_.badgeId = "";
            _loc2_++;
         }
      }
      
      public function clearGroupBadge() : void
      {
         var _loc1_:IBadgeImageWidget = IWidgetWindow(var_1638.findChildByName("badge_group")).widget as IBadgeImageWidget;
         _loc1_.badgeId = "";
      }
      
      public function setGroupBadge(param1:String) : void
      {
         var _loc2_:IBadgeImageWidget = IWidgetWindow(var_1638.findChildByName("badge_group")).widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
      }
      
      private function onTagSelected(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var_1629.messageListener.processWidgetMessage(new RoomWidgetRoomTagSearchMessage(_loc2_.text));
      }
      
      public function update(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         clearBadges();
         clearGroupBadge();
         setGroupBadge(param1.groupBadgeId);
         updateInfo(param1);
      }
      
      public function setRelationshipStatuses(param1:Map) : void
      {
         var _loc5_:String = null;
         var _loc2_:IWindow = null;
         var _loc3_:class_1758 = null;
         var _loc7_:String = null;
         var _loc6_:IWindow = null;
         if(!var_1638 || !var_1629)
         {
            return;
         }
         for each(var _loc4_ in RelationshipStatusEnum.displayableStatuses)
         {
            _loc5_ = RelationshipStatusEnum.statusAsString(_loc4_);
            _loc2_ = var_1638.findChildByName("relationship_" + _loc5_);
            _loc3_ = param1.getValue(_loc4_);
            if(_loc3_)
            {
               _loc2_.visible = _loc3_.friendCount > 0;
               _loc7_ = _loc5_ + "_randomusername";
               if(_loc6_ = var_1638.findChildByName(_loc7_))
               {
                  _loc6_.caption = _loc3_.randomFriendName;
                  _loc6_.id = _loc3_.randomFriendId;
               }
               var_1638.findChildByName(_loc5_ + "_others").visible = _loc3_.friendCount > 1;
               var_1629.localizations.registerParameter("infostand.relstatus." + _loc5_ + ".others","amount",(_loc3_.friendCount - 1).toString());
            }
            else
            {
               _loc2_.visible = false;
            }
         }
      }
      
      protected function updateInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         name = param1.name;
         setMotto(param1.motto,param1.type == "RWUIUE_OWN_USER");
         achievementScore = param1.achievementScore;
         carryItem = param1.carryItem;
         xp = param1.xp;
         setFigure(param1.figure);
      }
      
      protected function onMottoKeyboard(param1:WindowKeyboardEvent) : void
      {
         var _loc5_:RoomWidgetChangeMottoMessage = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:IWindowContainer;
         if(!(_loc7_ = var_1693.getListItemByName("motto_container") as IWindowContainer))
         {
            return;
         }
         var _loc4_:ITextFieldWindow;
         var _loc3_:String = String((_loc4_ = _loc7_.findChildByName("motto_text") as ITextFieldWindow).text);
         if(param1.keyCode == 13)
         {
            _loc2_ = getTimer();
            if(_loc2_ - var_4341 > 2000 && _loc3_ != var_1629.localizations.getLocalization("infostand.motto.change"))
            {
               _loc6_ = var_1629.userData.userId;
               _loc5_ = new RoomWidgetChangeMottoMessage(_loc3_);
               var_1629.messageListener.processWidgetMessage(_loc5_);
               var_4341 = _loc2_;
               _loc4_.textColor = 16777215;
               _loc4_.unfocus();
            }
         }
         else
         {
            _loc4_.textColor = 11184810;
         }
         _loc4_.height = Math.min(_loc4_.textHeight + 5,50);
         _loc4_.height = Math.max(_loc4_.height,23);
         _loc7_.height = _loc4_.height + 3;
      }
      
      protected function onMottoClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindowContainer = var_1693.getListItemByName("motto_container") as IWindowContainer;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:ITextWindow = _loc3_.findChildByName("motto_text") as ITextWindow;
         if(_loc2_.text == var_1629.localizations.getLocalization("infostand.motto.change"))
         {
            _loc2_.text = "";
         }
         _loc2_.textColor = 11184810;
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc3_:RoomWidgetMessage = null;
         var _loc4_:String = null;
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc5_:* = _loc2_.name;
         if("home_icon" === _loc5_)
         {
            _loc4_ = "RWUAM_OPEN_HOME_PAGE";
         }
         if(_loc4_ != null)
         {
            _loc3_ = new RoomWidgetUserActionMessage(_loc4_,var_1629.userData.userId);
            HabboTracking.getInstance().trackEventLog("InfoStand","click",_loc4_);
         }
         if(_loc3_ != null)
         {
            var_1629.messageListener.processWidgetMessage(_loc3_);
         }
         updateWindow();
      }
      
      protected function onProfileLink(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:ITextWindow = null;
         if(param1.type == "WME_CLICK")
         {
            var_1629.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_1629.userData.userId,"infoStand_userView"));
         }
         if(param2.name == "profile_link")
         {
            if(param1.type == "WME_OVER")
            {
               _loc3_ = var_2126.findChildByName("name_text") as ITextWindow;
               _loc3_.textColor = 9552639;
            }
            if(param1.type == "WME_OUT")
            {
               _loc3_ = var_2126.findChildByName("name_text") as ITextWindow;
               _loc3_.textColor = 16777215;
            }
         }
      }
      
      private function onRelationshipUserNameLinkClicked(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK" && param2 is ITextLinkWindow)
         {
            var_1629.handler.container.connection.send(new GetExtendedProfileMessageComposer(param2.id));
         }
      }
   }
}
