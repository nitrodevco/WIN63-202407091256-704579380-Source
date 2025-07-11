package com.sulake.habbo.navigator.view.search.results
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.view.search.ViewMode;
   import com.sulake.habbo.window.utils.class_3822;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_1061;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_771;
   
   public class RoomEntryElementFactory
   {
      
      public static const TILES_PER_CONTAINER:int = 3;
       
      
      private var _navigator:HabboNewNavigator;
      
      private var var_4080:IWindowContainer;
      
      private var var_4735:IWindowContainer;
      
      private var var_4523:IItemListWindow;
      
      private var var_425:int;
      
      public function RoomEntryElementFactory(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         var_425 = ViewMode.getViewMode("hotel_view");
      }
      
      public function set viewMode(param1:int) : void
      {
         var_425 = param1;
      }
      
      public function set rowEntryTemplate(param1:IWindowContainer) : void
      {
         var_4080 = param1;
      }
      
      public function set tileEntryTemplate(param1:IWindowContainer) : void
      {
         var_4735 = param1;
      }
      
      public function set tileContainerTemplate(param1:IItemListWindow) : void
      {
         var_4523 = param1;
      }
      
      public function get rowEntryTemplateHeight() : int
      {
         return var_4080.height;
      }
      
      public function getNewRowElement(param1:class_1675, param2:int, param3:int = -1) : IWindowContainer
      {
         var _loc4_:IWindowContainer = IWindowContainer(var_4080.clone());
         if(param3 != -1)
         {
            _loc4_.width = param3;
         }
         class_3437(_loc4_).color = RoomEntryUtils.getModulatedBackgroundColor(param2,class_3437(_loc4_).color);
         updateCommonEntryElements(_loc4_,param1,false);
         _loc4_.findChildByName("grouphome_icon").visible = param1.groupBadgeCode != "";
         return _loc4_;
      }
      
      public function getNewTileElement(param1:class_1675, param2:int) : IWindowContainer
      {
         var _loc3_:IWindowContainer = IWindowContainer(var_4735.clone());
         updateCommonEntryElements(_loc3_,param1,true);
         if(param1.groupBadgeCode != "")
         {
            _loc3_.findChildByName("room_group_badge").visible = true;
            IBadgeImageWidget(IWidgetWindow(_loc3_.findChildByName("room_group_badge")).widget).badgeId = param1.groupBadgeCode;
         }
         if(param1.officialRoomPicRef != null)
         {
            if(_navigator.getBoolean("new.navigator.official.room.thumbnails.in.amazon"))
            {
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("room_pic_placeholder")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + param1.officialRoomPicRef;
            }
            else
            {
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("room_pic_placeholder")).assetUri = _navigator.getProperty("image.library.url") + param1.officialRoomPicRef;
            }
         }
         else
         {
            IStaticBitmapWrapperWindow(_loc3_.findChildByName("room_pic_placeholder")).assetUri = _navigator.getProperty("navigator.thumbnail.url_base") + param1.flatId + ".png";
         }
         return _loc3_;
      }
      
      private function updateCommonEntryElements(param1:IWindowContainer, param2:class_1675, param3:Boolean) : void
      {
         param1.findChildByName("room_usercount").caption = param2.userCount.toString();
         param1.findChildByName("room_name").caption = ViewMode.isEventViewMode(var_425) ? param2.roomAdName : param2.roomName;
         param1.findChildByName("go_to_room_region").id = param2.flatId;
         param1.findChildByName("go_to_room_region").addEventListener("WME_CLICK",onGoButtonClicked);
         param1.findChildByName("go_to_room_region").addEventListener("WME_OVER",param3 ? onTileGoToRoomMouseOver : onGoToRoomMouseOver);
         param1.findChildByName("info_popup_click_region").id = param2.flatId;
         param1.findChildByName("info_popup_click_region").addEventListener("WME_CLICK",onMouseClicked);
         param1.findChildByName("info_popup_click_region").addEventListener("WME_OVER",onRoomRoomInfoMouseOver);
         class_3437(param1.findChildByName("room_info_usercount_border")).color = class_3822.getUserCountColor(param2.userCount,param2.maxUserCount);
         IStaticBitmapWrapperWindow(param1.findChildByName("doormode_icon")).assetUri = RoomEntryUtils.getDoorModeIconAsset(param2.doorMode);
      }
      
      public function getNewTileContainerElement() : IItemListWindow
      {
         return var_4523.clone() as IItemListWindow;
      }
      
      private function onGoButtonClicked(param1:WindowEvent) : void
      {
         _navigator.goToRoom(param1.window.id);
      }
      
      private function onMouseClicked(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = new Rectangle();
         param1.window.getGlobalRectangle(_loc2_);
         _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top);
      }
      
      private function onRoomRoomInfoMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_navigator.view.isRoomInfoBubbleVisible)
         {
            _loc2_ = new Rectangle();
            param1.window.getGlobalRectangle(_loc2_);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top,true);
         }
      }
      
      private function onTileGoToRoomMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_navigator.view.isRoomInfoBubbleVisible)
         {
            _loc2_ = new Rectangle();
            param1.window.getGlobalRectangle(_loc2_);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right - 6,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top + 56,true);
         }
      }
      
      private function onGoToRoomMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:Rectangle = null;
         if(_navigator.view.isRoomInfoBubbleVisible)
         {
            _loc2_ = new Rectangle();
            param1.window.getGlobalRectangle(_loc2_);
            _navigator.view.showRoomInfoBubbleAt(_navigator.currentResults.findGuestRoom(param1.window.id),_loc2_.right + 20,(_loc2_.bottom - _loc2_.top) / 2 + _loc2_.top,true);
         }
      }
      
      private function onOwnerLinkClicked(param1:WindowEvent) : void
      {
         _navigator.getExtendedProfile(param1.window.id);
      }
      
      private function onGroupLinkClicked(param1:WindowEvent) : void
      {
         _navigator.getGuildInfo(param1.window.id);
      }
      
      private function onFavoriteRegionClicked(param1:WindowEvent) : void
      {
         var _loc2_:Boolean = _navigator.legacyNavigator.isRoomFavorite(param1.window.id);
         if(_loc2_)
         {
            _navigator.communication.connection.send(new class_1061(param1.window.id));
         }
         else
         {
            _navigator.communication.connection.send(new class_771(param1.window.id));
         }
         IStaticBitmapWrapperWindow(IRegionWindow(param1.window).findChildByName("favourite_icon")).assetUri = RoomEntryUtils.getFavoriteIcon(!_loc2_);
      }
   }
}
