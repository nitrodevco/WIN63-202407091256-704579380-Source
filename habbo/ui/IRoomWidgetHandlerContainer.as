package com.sulake.habbo.ui
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.class_1881;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.freeflowchat.class_1809;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.class_1805;
   import com.sulake.habbo.groups.class_1880;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.quest.class_2197;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.object.IRoomObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IRoomWidgetHandlerContainer
   {
       
      
      function get habboTracking() : IHabboTracking;
      
      function get roomSession() : IRoomSession;
      
      function get sessionDataManager() : ISessionDataManager;
      
      function get events() : IEventDispatcher;
      
      function get roomEngine() : IRoomEngine;
      
      function get friendList() : IHabboFriendList;
      
      function get avatarRenderManager() : IAvatarRenderManager;
      
      function get inventory() : class_1814;
      
      function get toolbar() : IHabboToolbar;
      
      function get navigator() : IHabboNavigator;
      
      function get habboGroupsManager() : class_1880;
      
      function get roomWidgetFactory() : IRoomWidgetFactory;
      
      function get roomSessionManager() : IRoomSessionManager;
      
      function get avatarEditor() : class_1881;
      
      function get catalog() : IHabboCatalog;
      
      function get localization() : IHabboLocalizationManager;
      
      function get habboHelp() : IHabboHelp;
      
      function get config() : ICoreConfiguration;
      
      function get soundManager() : class_2240;
      
      function get messenger() : IHabboMessenger;
      
      function get moderation() : IHabboModeration;
      
      function get windowManager() : IHabboWindowManager;
      
      function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents;
      
      function get connection() : IConnection;
      
      function get gameManager() : class_1805;
      
      function get questEngine() : class_2197;
      
      function get freeFlowChat() : class_1809;
      
      function get layoutManager() : class_3604;
      
      function setRoomViewColor(param1:uint, param2:int) : void;
      
      function getFirstCanvasId() : int;
      
      function getRoomViewRect() : Rectangle;
      
      function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent;
      
      function addUpdateListener(param1:IRoomWidgetHandler) : void;
      
      function removeUpdateListener(param1:IRoomWidgetHandler) : void;
      
      function isOwnerOfFurniture(param1:IRoomObject) : Boolean;
      
      function getFurnitureOwnerId(param1:IRoomObject) : int;
      
      function isOwnerOfPet(param1:class_3490) : Boolean;
      
      function setRoomBackgroundColor(param1:int, param2:int, param3:int) : void;
   }
}
