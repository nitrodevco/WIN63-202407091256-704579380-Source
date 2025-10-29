package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.SessionDataPreferencesEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomSettingsDataEvent;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_130;
   
   public class RoomToolsWidgetHandler implements IRoomWidgetHandler
   {
       
      
      private var _disposed:Boolean;
      
      private var _communicationManagerMessageEvents:Vector.<IMessageEvent>;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _navigator:IHabboNavigator;
      
      private var var_1629:RoomToolsWidget;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      public function RoomToolsWidgetHandler()
      {
         _communicationManagerMessageEvents = new Vector.<IMessageEvent>();
         super();
      }
      
      public function set widget(param1:RoomToolsWidget) : void
      {
         var_1629 = param1;
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:RoomSettingsDataEvent = GetGuestRoomResultEvent(param1).getParser();
         var _loc4_:class_1675;
         if(_loc4_ = _loc2_.data)
         {
            var_1629.updateRoomData(_loc4_);
         }
         if(_loc2_.enterRoom)
         {
            if(_loc4_)
            {
               _loc3_ = _loc4_.showOwner ? var_1629.localizations.getLocalizationWithParams("room.tool.room.owner.prefix","By") + " " + _loc4_.ownerName : String(var_1629.localizations.getLocalizationWithParams("room.tool.public.room","Public room"));
               var_1629.showRoomInfo(true,_loc4_.roomName,_loc3_,_loc4_.tags);
               var_1629.storeRoomData(_loc4_);
               var_1629.enterNewRoom(_loc4_.flatId);
            }
         }
      }
      
      public function toggleRoomInfoWindow() : void
      {
         _navigator.toggleRoomInfoVisibility();
      }
      
      public function goToPrivateRoom(param1:int) : void
      {
         _navigator.goToPrivateRoom(param1);
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_TOOLS";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         _container.sessionDataManager.events.addEventListener("APUE_UPDATED",onSessionDataPreferences);
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWZTM_ZOOM_TOGGLE"];
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
      }
      
      private function onSessionDataPreferences(param1:SessionDataPreferencesEvent) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         _disposed = true;
         if(_communicationManager)
         {
            for each(var _loc1_ in _communicationManagerMessageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
            _communicationManagerMessageEvents = null;
            _communicationManager = null;
         }
         if(_container && _container.sessionDataManager)
         {
            _container.sessionDataManager.events.removeEventListener("APUE_UPDATED",onSessionDataPreferences);
         }
         _navigator = null;
         var_1629 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set navigator(param1:IHabboNavigator) : void
      {
         _navigator = param1;
      }
      
      public function get navigator() : IHabboNavigator
      {
         return _navigator;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _container.sessionDataManager;
      }
      
      public function set communicationManager(param1:IHabboCommunicationManager) : void
      {
         _communicationManager = param1;
         _communicationManagerMessageEvents.push(_communicationManager.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(onRoomInfo)));
      }
      
      public function rateRoom() : void
      {
         _container.connection.send(new class_130(1));
      }
      
      public function get canRate() : Boolean
      {
         return _navigator.canRateRoom();
      }
   }
}
