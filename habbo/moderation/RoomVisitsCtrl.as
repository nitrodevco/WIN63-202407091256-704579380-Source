package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1667;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_1775;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomVisitsMessageComposer;
   
   public class RoomVisitsCtrl implements IDisposable, ITrackedWindow
   {
      
      private static var ROOM_ROW_POOL:Array = [];
      
      private static var ROOM_ROW_POOL_MAX_SIZE:int = 200;
       
      
      private var _main:ModerationManager;
      
      private var _frame:class_3514;
      
      private var var_19:IItemListWindow;
      
      private var var_418:int;
      
      private var _rooms:Array;
      
      private var _disposed:Boolean;
      
      private var var_2563:IWindowContainer;
      
      private var var_2303:Timer;
      
      private var var_3437:Array;
      
      public function RoomVisitsCtrl(param1:ModerationManager, param2:int)
      {
         var_3437 = [];
         super();
         _main = param1;
         var_418 = param2;
      }
      
      public static function getFormattedTime(param1:int, param2:int) : String
      {
         return padToTwoDigits(param1) + ":" + padToTwoDigits(param2);
      }
      
      public static function padToTwoDigits(param1:int) : String
      {
         return param1 < 10 ? "0" + param1 : "" + param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         var_2303 = new Timer(300,1);
         var_2303.addEventListener("timer",onResizeTimer);
         _main.messageHandler.addRoomVisitsListener(this);
         _main.connection.send(new GetRoomVisitsMessageComposer(var_418));
         _frame = class_3514(_main.getXmlWindow("roomvisits_frame"));
         var_19 = IItemListWindow(_frame.findChildByName("visits_list"));
         var_2563 = var_19.getListItemAt(0) as IWindowContainer;
         var_19.removeListItems();
         _frame.procedure = onWindow;
         var _loc1_:IWindow = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
      }
      
      public function onRoomVisits(param1:class_1667) : void
      {
         if(param1.userId != var_418)
         {
            return;
         }
         if(_disposed)
         {
            return;
         }
         this._rooms = param1.rooms;
         _frame.caption = "Room visits: " + param1.userName;
         populate();
         onResizeTimer(null);
         _frame.visible = true;
         _main.messageHandler.removeRoomVisitsListener(this);
      }
      
      public function getType() : int
      {
         return 6;
      }
      
      public function getId() : String
      {
         return "" + var_418;
      }
      
      public function getFrame() : class_3514
      {
         return _frame;
      }
      
      private function populate() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = true;
         for each(_loc2_ in _rooms)
         {
            populateRoomRow(_loc2_,_loc1_);
            _loc1_ = !_loc1_;
         }
      }
      
      private function populateRoomRow(param1:class_1775, param2:Boolean) : void
      {
         var _loc4_:IWindowContainer = getRoomRowWindow();
         var _loc3_:uint = param2 ? 4288861930 : 4294967295;
         _loc4_.color = _loc3_;
         var _loc7_:IWindow;
         (_loc7_ = _loc4_.findChildByName("room_name_txt")).caption = param1.roomName;
         new OpenRoomTool(_frame,_main,_loc7_,param1.roomId);
         _loc7_.color = _loc3_;
         var _loc5_:ITextWindow;
         (_loc5_ = ITextWindow(_loc4_.findChildByName("time_txt"))).text = getFormattedTime(param1.enterHour,param1.enterMinute);
         var _loc6_:ITextWindow = ITextWindow(_loc4_.findChildByName("view_room_txt"));
         new OpenRoomInSpectatorMode(_main,_loc6_,param1.roomId);
         _loc6_.color = _loc3_;
         addRoomRowToList(_loc4_,var_19);
      }
      
      private function addRoomRowToList(param1:IWindowContainer, param2:IItemListWindow) : void
      {
         param2.addListItem(param1);
         var_3437.push(param1);
      }
      
      private function getRoomRowWindow() : IWindowContainer
      {
         if(ROOM_ROW_POOL.length > 0)
         {
            return ROOM_ROW_POOL.pop() as IWindowContainer;
         }
         return IWindowContainer(var_2563.clone());
      }
      
      private function storeRoomRowWindow(param1:IWindowContainer) : void
      {
         var _loc3_:IWindow = null;
         var _loc2_:IWindow = null;
         if(ROOM_ROW_POOL.length < ROOM_ROW_POOL_MAX_SIZE)
         {
            _loc3_ = param1.findChildByName("room_name_txt");
            _loc3_.procedure = null;
            _loc2_ = param1.findChildByName("view_room_txt");
            _loc2_.procedure = null;
            param1.width = var_2563.width;
            param1.height = var_2563.height;
            ROOM_ROW_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onWindow(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_RESIZED" || param2 != _frame)
         {
            return;
         }
         if(!this.var_2303.running)
         {
            this.var_2303.reset();
            this.var_2303.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         var _loc3_:IWindowContainer = IWindowContainer(var_19.parent);
         var _loc5_:IWindow = _loc3_.getChildByName("scroller") as IWindow;
         var _loc4_:* = var_19.scrollableRegion.height > var_19.height;
         var _loc2_:int = 17;
         if(_loc5_.visible)
         {
            if(!_loc4_)
            {
               _loc5_.visible = false;
               var_19.width += _loc2_;
            }
         }
         else if(_loc4_)
         {
            _loc5_.visible = true;
            var_19.width -= _loc2_;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(var_19 != null)
         {
            var_19.removeListItems();
            var_19.dispose();
            var_19 = null;
         }
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _main = null;
         if(var_2303 != null)
         {
            var_2303.stop();
            var_2303.removeEventListener("timer",onResizeTimer);
            var_2303 = null;
         }
         for each(_loc1_ in var_3437)
         {
            storeRoomRowWindow(_loc1_);
         }
         if(var_2563 != null)
         {
            var_2563.dispose();
            var_2563 = null;
         }
         var_3437 = [];
      }
   }
}
