package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.rentablespace.RentableSpaceDisplayWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentFailedMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceCancelRentMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceRentMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RentableSpaceStatusMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentOkMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceRentFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RentableSpaceStatusMessageEvent;
   
   public class class_3559 implements IRoomWidgetHandler
   {
       
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_1629:RentableSpaceDisplayWidget;
      
      private var var_3065:RentableSpaceStatusMessageEvent;
      
      private var var_3201:RentableSpaceRentOkMessageEvent;
      
      private var var_3062:RentableSpaceRentFailedMessageEvent;
      
      public function class_3559()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_RENTABLESPACE";
      }
      
      public function set widget(param1:RentableSpaceDisplayWidget) : void
      {
         var_1629 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         var_3065 = new RentableSpaceStatusMessageEvent(onRentableSpaceStatusMessage);
         _container.connection.addMessageEvent(var_3065);
         var_3201 = new RentableSpaceRentOkMessageEvent(onRentableSpaceRentOkMessage);
         _container.connection.addMessageEvent(var_3201);
         var_3062 = new RentableSpaceRentFailedMessageEvent(onRentableSpaceRentFailedMessage);
         _container.connection.addMessageEvent(var_3062);
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container.roomEngine == null)
         {
            return;
         }
         var _loc3_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc3_.roomId,_loc3_.objectId,_loc3_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(_loc2_ != null)
               {
                  var_1629.show(_loc2_);
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               var_1629.hide(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_3065 != null)
         {
            _container.connection.removeMessageEvent(var_3065);
            var_3065 = null;
         }
         if(var_3201 != null)
         {
            _container.connection.removeMessageEvent(var_3201);
            var_3201 = null;
         }
         if(var_3062 != null)
         {
            _container.connection.removeMessageEvent(var_3062);
            var_3062 = null;
         }
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function onRentableSpaceRentOkMessage(param1:RentableSpaceRentOkMessageEvent) : void
      {
         var_1629.updateWidgetState();
      }
      
      public function onRentableSpaceRentFailedMessage(param1:RentableSpaceRentFailedMessageEvent) : void
      {
         var _loc2_:RentableSpaceRentFailedMessageEventParser = param1.getParser();
         var_1629.showErrorView(_loc2_.reason);
      }
      
      public function onRentableSpaceStatusMessage(param1:RentableSpaceStatusMessageEvent) : void
      {
         var _loc2_:RentableSpaceStatusMessageEventParser = param1.getParser();
         var_1629.populateRentInfo(_loc2_.rented,_loc2_.canRent,_loc2_.canRentErrorCode,_loc2_.renterId,_loc2_.renterName,_loc2_.timeRemaining,_loc2_.price);
      }
      
      public function getRentableSpaceStatus(param1:int) : void
      {
         _container.connection.send(new RentableSpaceStatusMessageComposer(param1));
      }
      
      public function cancelRent(param1:int) : void
      {
         _container.connection.send(new RentableSpaceCancelRentMessageComposer(param1));
      }
      
      public function rentSpace(param1:int) : void
      {
         _container.connection.send(new RentableSpaceRentMessageComposer(param1));
      }
      
      public function getUsersClubLevel() : int
      {
         return _container.sessionDataManager.clubLevel;
      }
      
      public function getUsersCreditAmount() : int
      {
         return _container.catalog.getPurse().credits;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
   }
}
