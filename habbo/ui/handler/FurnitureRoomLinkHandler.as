package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_898;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomSettingsDataEvent;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_553;
   
   public class FurnitureRoomLinkHandler implements IRoomWidgetHandler
   {
      
      private static const INTERNAL_LINK_KEY:String = "internalLink";
       
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var _confirmDialog:class_3441;
      
      private var _communicationManagerMessageEvents:Vector.<IMessageEvent>;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var var_1199:int = 0;
      
      private var var_445:String;
      
      public function FurnitureRoomLinkHandler()
      {
         _communicationManagerMessageEvents = new Vector.<IMessageEvent>();
         super();
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_LINK";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set communicationManager(param1:IHabboCommunicationManager) : void
      {
         _communicationManager = param1;
         _communicationManagerMessageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new class_898(onRoomInfo)));
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var message:String;
         var roomName:String;
         var ownerName:String;
         var event:IMessageEvent = param1;
         var p:RoomSettingsDataEvent = class_898(event).getParser();
         var roomData:class_1675 = p.data;
         if(roomData && roomData.flatId == var_1199)
         {
            var_1199 = 0;
            message = "${room.link.confirmation.message}";
            roomName = roomData.roomName;
            ownerName = roomData.ownerName;
            message = String(_container.localization.getLocalization("room.link.confirmation.message"));
            if(message != null && message.indexOf("%%room_name%%") > -1)
            {
               message = message.replace("%%room_name%%",roomName);
            }
            if(message != null && message.indexOf("%%room_owner%%") > -1)
            {
               message = message.replace("%%room_owner%%",ownerName);
            }
            _confirmDialog = _container.windowManager.confirm("${room.link.confirmation.title}",message,16 | 32,function(param1:class_3348, param2:WindowEvent):void
            {
               if(_container.roomEngine != null && param2.type == "WE_OK")
               {
                  if(var_445 != null && var_445.length > 0)
                  {
                     (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/" + var_445);
                  }
               }
               param1.dispose();
            });
         }
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
         return ["RETWE_REQUEST_ROOM_LINK"];
      }

      public function processEvent(event: Event): void {
         var roomEvent: RoomEngineToWidgetEvent;
         var roomObject: IRoomObject;
         var objectModel: IRoomObjectModel;
         var internalLink: String;

         switch (event.type) {
            case "RETWE_REQUEST_ROOM_LINK":
               roomEvent = event as RoomEngineToWidgetEvent;
               if (roomEvent == null || _container.roomEngine == null) {
                  return;
               }

               roomObject = _container.roomEngine.getRoomObject(roomEvent.roomId, roomEvent.objectId, roomEvent.category);
               if (roomObject == null) {
                  return;
               }

               objectModel = roomObject.getModel();
               internalLink = objectModel.getStringToStringMap("furniture_data").getValue("internalLink");
               if (internalLink == null || internalLink.length == 0) {
                  internalLink = objectModel.getString("furniture_internal_link");
               }

               if (internalLink == null) {
                  break;
               }

               if (_container.navigator != null && _container.localization != null) {
                  if (_confirmDialog != null) {
                     _confirmDialog.dispose();
                     _confirmDialog = null;
                  }

                  var_445 = internalLink;
                  var_1199 = parseInt(internalLink, 10);
                  _communicationManager.connection.send(new class_553(var_1199, false, false));
               } else {
                  (_container.roomEngine as Component).context.createLinkEvent("navigator/goto/" + internalLink);
               }
               break;
         }
      }
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(_communicationManager)
         {
            for each(var _loc1_ in _communicationManagerMessageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
            _communicationManagerMessageEvents = null;
            _communicationManager = null;
         }
         if(_confirmDialog != null)
         {
            _confirmDialog.dispose();
            _confirmDialog = null;
         }
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
   }
}
