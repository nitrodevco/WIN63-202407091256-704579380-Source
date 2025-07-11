package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.freeflowchat.class_1809;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class RoomToolsWidget extends RoomWidgetBase
   {
      
      private static const ROOM_HISTORY_MAX_LENGTH:int = 10;
      
      private static var _visitedRooms:Vector.<class_1675> = new Vector.<class_1675>();
      
      private static var var_3034:int;
       
      
      private var _currentRoomName:String = "";
      
      private var var_1733:RoomToolsToolbarCtrl;
      
      private var var_2266:RoomToolsInfoCtrl;
      
      private var var_2894:IRoomDesktop;
      
      private var var_3141:class_1809;
      
      private var var_2494:Timer;
      
      public function RoomToolsWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:RoomUI)
      {
         super(param1,param2,param3,param4.localization);
         handler.widget = this;
         var_2894 = param4.getDesktop("hard_coded_room_id");
         var_3141 = param4.freeFlowChat;
         var_2266 = new RoomToolsInfoCtrl(this,param2,param3);
         var_1733 = new RoomToolsToolbarCtrl(this,param2,param3);
         var_1733.updateRoomHistoryButtons();
         var_1733.setChatHistoryButton(!var_3141 || !var_3141.isDisabledInPreferences);
         var _loc5_:String = param4.getProperty("camera.launch.ui.position");
         var_1733.setCameraButton(handler.container.sessionDataManager.isPerkAllowed("CAMERA") && (StringUtil.isBlank(_loc5_) || _loc5_ == "room-menu"));
         var_1733.setLikeButton(handler.canRate);
         var_1733.setCollapsed(handler.sessionDataManager.isNoob || !(handler.sessionDataManager.uiFlags & 2));
      }
      
      override public function dispose() : void
      {
         if(var_2494)
         {
            var_2494.stop();
            var_2494 = null;
         }
         if(var_1733)
         {
            var_1733.dispose();
            var_1733 = null;
         }
         if(var_2266)
         {
            var_2266.dispose();
            var_2266 = null;
         }
         var_3141 = null;
         var_2894 = null;
         super.dispose();
      }
      
      public function updateRoomData(param1:class_1675) : void
      {
         for each(var _loc2_ in _visitedRooms)
         {
            if(_loc2_.flatId == param1.flatId)
            {
               _loc2_.roomName = param1.roomName;
            }
         }
      }
      
      public function storeRoomData(param1:class_1675) : void
      {
         for each(var _loc2_ in _visitedRooms)
         {
            if(_loc2_.flatId == param1.flatId)
            {
               return;
            }
         }
         _visitedRooms.push(param1);
         if(_visitedRooms.length > 10)
         {
            _visitedRooms.shift();
         }
         var_3034 = _visitedRooms.length - 1;
         if(var_1733)
         {
            var_1733.setLikeButton(handler.canRate);
         }
      }
      
      public function showRoomInfo(param1:Boolean, param2:String, param3:String, param4:Array) : void
      {
         if(!var_2266)
         {
            return;
         }
         _currentRoomName = param2;
         var_2266.showRoomInfo(param1,param2,param3,param4);
      }
      
      public function enterNewRoom(param1:int) : void
      {
         if(!var_1733 || !var_2266)
         {
            return;
         }
         var _loc3_:int = 0;
         for each(var _loc2_ in _visitedRooms)
         {
            if(_loc2_.flatId == param1)
            {
               var_3034 = _loc3_;
            }
            _loc3_++;
         }
         var_1733.disableRoomHistoryButtons();
         if(var_2494 != null)
         {
            var_2494.stop();
         }
         var_2494 = new Timer(2000,1);
         var_2494.addEventListener("timer",roomButtonTimerEventHandler);
         var_2494.start();
         var_2266.setElementVisible("tags",true);
      }
      
      private function roomButtonTimerEventHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",roomButtonTimerEventHandler);
         }
         if(var_1733)
         {
            var_1733.updateRoomHistoryButtons();
         }
      }
      
      public function setCollapsed(param1:Boolean) : void
      {
         if(var_1733)
         {
            var_1733.setCollapsed(param1);
         }
         if(var_2266)
         {
            var_2266.setToolbarCollapsed(param1);
         }
      }
      
      public function get handler() : RoomToolsWidgetHandler
      {
         return var_1653 as RoomToolsWidgetHandler;
      }
      
      public function getIconLocation(param1:String) : IWindow
      {
         return var_1733.window.findChildByName(param1);
      }
      
      public function getWidgetAreaWidth() : int
      {
         return !!var_1733 ? var_1733.right : 0;
      }
      
      public function getChatInputY() : int
      {
         if(!var_2894)
         {
            return 0;
         }
         var _loc1_:RoomChatInputWidget = var_2894.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget;
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.getChatInputY();
      }
      
      public function getRoomToolbarRight() : int
      {
         return !!var_1733 ? var_1733.right : 0;
      }
      
      public function goToNextRoom() : void
      {
         var _loc1_:* = var_3034 + 1;
         var _loc2_:int = int(_visitedRooms.length);
         if(_loc1_ > _loc2_)
         {
            _loc1_ = _loc2_;
         }
         handler.goToPrivateRoom(_visitedRooms[_loc1_].flatId);
         var_1733.disableRoomHistoryButtons();
      }
      
      public function goToPreviousRoom() : void
      {
         var _loc1_:int = var_3034 - 1;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         handler.goToPrivateRoom(_visitedRooms[_loc1_].flatId);
         var_1733.disableRoomHistoryButtons();
      }
      
      public function get freeFlowChat() : class_1809
      {
         return var_3141;
      }
      
      public function get visitedRooms() : Vector.<class_1675>
      {
         return _visitedRooms;
      }
      
      public function get currentRoomIndex() : int
      {
         return var_3034;
      }
      
      public function get currentRoomName() : String
      {
         return _currentRoomName;
      }
   }
}
