package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.geom.Rectangle;
   
   public class InfoStandBotView
   {
       
      
      private var var_1629:InfoStandWidget;
      
      private var _window:IItemListWindow;
      
      private var var_1693:IItemListWindow;
      
      private var var_1638:class_3437;
      
      private var _badgeDetails:class_3437;
      
      private const ITEM_SPACER:int = 5;
      
      private const MOTTO_TEXT_OFFSET:int = 3;
      
      private const MAX_MOTTO_HEIGHT:int = 50;
      
      private const MIN_MOTTO_HEIGHT:int = 23;
      
      public function InfoStandBotView(param1:InfoStandWidget, param2:String)
      {
         super();
         var_1629 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         var_1629 = null;
         _window.dispose();
         _window = null;
         disposeBadgeDetails();
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      private function updateWindow() : void
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
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:IWindow = null;
         var _loc4_:int = 0;
         _window = var_1629.getXmlWindow("bot_view") as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_1638 = _window.getListItemByName("info_border") as class_3437;
         var_1693 = var_1638.findChildByName("infostand_element_list") as IItemListWindow;
         if(var_1638 != null)
         {
            var_1693 = var_1638.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_1629.mainContainer.addChild(_window);
         var _loc3_:IWindow = var_1638.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = var_1638.findChildByName("badge_" + _loc4_);
            if(_loc2_ != null)
            {
               _loc2_.addEventListener("WME_OVER",showBadgeInfo);
               _loc2_.addEventListener("WME_OUT",hideBadgeInfo);
            }
            _loc4_++;
         }
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
      
      public function setFigure(param1:String) : void
      {
         var _loc2_:IAvatarImageWidget = IWidgetWindow(var_1638.findChildByName("avatar_image")).widget as IAvatarImageWidget;
         _loc2_.figure = param1;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:ITextWindow = var_1693.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
      }
      
      public function setMotto(param1:String) : void
      {
         var _loc4_:IWindowContainer;
         if(!(_loc4_ = var_1693.getListItemByName("motto_container") as IWindowContainer))
         {
            return;
         }
         var _loc3_:ITextWindow = _loc4_.findChildByName("motto_text") as ITextWindow;
         var _loc2_:IWindowContainer = var_1693.getListItemByName("motto_spacer") as IWindowContainer;
         if(_loc3_ == null || _loc2_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = "";
         }
         _loc3_.text = param1;
         _loc3_.height = Math.min(_loc3_.textHeight + 5,50);
         _loc3_.height = Math.max(_loc3_.height,23);
         _loc4_.height = _loc3_.height + 3;
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
      
      public function update(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         clearBadges();
         updateInfo(param1);
      }
      
      private function updateInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         name = param1.name;
         setMotto(param1.motto);
         achievementScore = param1.achievementScore;
         carryItem = param1.carryItem;
         setFigure(param1.figure);
         updateBadges(param1.badges);
      }
      
      private function updateBadges(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            setBadge(_loc2_,param1[_loc2_]);
            _loc2_++;
         }
      }
   }
}
