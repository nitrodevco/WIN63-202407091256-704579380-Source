package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniConfirmWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.class_1005;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.class_464;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.class_541;
   import com.sulake.habbo.communication.messages.outgoing.friendfurni.class_395;
   
   public class class_3642 implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1629:FriendFurniConfirmWidget;
      
      private var var_26:IConnection;
      
      private var var_3310:IMessageEvent = null;
      
      private var var_4064:IMessageEvent = null;
      
      private var var_4108:IMessageEvent = null;
      
      public function class_3642()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:FriendFurniConfirmWidget) : void
      {
         var_1629 = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_26 && var_3310)
            {
               var_26.removeMessageEvent(var_3310);
               var_26.removeMessageEvent(var_4064);
               var_26.removeMessageEvent(var_4108);
               var_26 = null;
            }
            var_1629 = null;
            _container = null;
            _disposed = true;
         }
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_26 = param1;
         if(!var_3310)
         {
            var_3310 = new class_464(onStartConfirmation);
            var_4064 = new class_1005(onOtherLockConfirmed);
            var_4108 = new class_541(onCancelLock);
            var_26.addMessageEvent(var_3310);
            var_26.addMessageEvent(var_4064);
            var_26.addMessageEvent(var_4108);
         }
      }
      
      public function sendLockConfirm(param1:int, param2:Boolean) : void
      {
         var_26.send(new class_395(param1,param2));
      }
      
      private function onStartConfirmation(param1:class_464) : void
      {
         var_1629.open(param1.getParser().stuffId,param1.getParser().isOwner);
      }
      
      private function onOtherLockConfirmed(param1:class_1005) : void
      {
         var_1629.otherConfirmed(param1.getParser().stuffId);
      }
      
      private function onCancelLock(param1:class_541) : void
      {
         var_1629.close(param1.getParser().stuffId);
      }
      
      public function get type() : String
      {
         return "";
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function getWidgetMessages() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function update() : void
      {
      }
   }
}
