package com.sulake.habbo.ui
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IToolTipWindow;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.advertisement.class_1811;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.class_1881;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
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
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.handler.*;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.events.RoomContentLoadedEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.ColorTransitioner;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.RoomId;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.DisplacementMapFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.room.bots.class_1442;
   import com.sulake.habbo.communication.messages.parser.room.bots.class_1493;
   import com.sulake.habbo.communication.messages.incoming.room.bots.class_181;
   import com.sulake.habbo.communication.messages.incoming.room.bots.class_612;
   
   public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer
   {
      
      public static const STATE_UNDEFINED:int = -1;
      
      private static const RESIZE_UPDATE_TIMEOUT_MS:int = 1000;
      
      private static const SCALE_UPDATE_TIMEOUT_MS:int = 1000;
       
      
      private var name_1:EventDispatcherWrapper;
      
      private var _windowManager:IHabboWindowManager = null;
      
      private var _roomEngine:IRoomEngine = null;
      
      private var var_3132:IRoomWidgetFactory = null;
      
      private var _sessionDataManager:ISessionDataManager = null;
      
      private var _roomSessionManager:IRoomSessionManager = null;
      
      private var _communicationManager:IHabboCommunicationManager = null;
      
      private var _avatarRenderManager:IAvatarRenderManager = null;
      
      private var _friendList:IHabboFriendList = null;
      
      private var _inventory:class_1814 = null;
      
      private var _toolbar:IHabboToolbar = null;
      
      private var _navigator:IHabboNavigator = null;
      
      private var _messenger:IHabboMessenger = null;
      
      private var _habboGroupsManager:class_1880 = null;
      
      private var _avatarEditor:class_1881 = null;
      
      private var _catalog:IHabboCatalog = null;
      
      private var _adManager:class_1811 = null;
      
      private var _localization:IHabboLocalizationManager = null;
      
      private var _habboHelp:IHabboHelp = null;
      
      private var var_26:IConnection = null;
      
      private var _moderation:IHabboModeration;
      
      private var _config:ICoreConfiguration;
      
      private var _soundManager:class_2240;
      
      private var _habboTracking:IHabboTracking;
      
      private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
      
      private var _gameManager:class_1805;
      
      private var _questEngine:class_2197;
      
      private var _freeFlowChat:class_1809;
      
      private var _assets:IAssetLibrary = null;
      
      private var var_52:IRoomSession = null;
      
      private var var_2007:Array;
      
      private var var_1643:Map;
      
      private var var_2739:Map;
      
      private var var_2510:Map;
      
      private var _updateListeners:Array;
      
      private var var_1873:class_3604;
      
      private var var_1749:class_3431;
      
      private var var_3933:Boolean = true;
      
      private var var_2901:Array;
      
      private var var_1909:IToolTipWindow;
      
      private var var_2557:ColorTransitioner = null;
      
      private var _roomColor:uint = 16777215;
      
      private var var_4963:Boolean = false;
      
      private var _zoomChangedMillis:int = 0;
      
      private var var_2577:ColorTransitioner = null;
      
      private var _roomBackgroundColor:uint = 0;
      
      private var var_2303:Timer;
      
      private var var_3932:Rectangle;
      
      private var var_2791:IMessageEvent;
      
      private var var_2922:IMessageEvent;
      
      private var var_2932:Point;
      
      private var var_3212:Number = 0;
      
      private var var_2812:Number = 0;
      
      private var var_3785:Boolean;
      
      public function RoomDesktop(param1:IRoomSession, param2:IAssetLibrary, param3:IConnection)
      {
         var_2007 = [];
         super();
         name_1 = new EventDispatcherWrapper();
         var_52 = param1;
         _assets = param2;
         var_26 = param3;
         var_2791 = new class_612(onBotSkillListUpdateEvent);
         var_26.addMessageEvent(var_2791);
         var_2922 = new class_181(onBotForceOpenContextMenuEvent);
         var_26.addMessageEvent(var_2922);
         var_1643 = new Map();
         var_2739 = new Map();
         var_2510 = new Map();
         var_1873 = new class_3604();
         checkInterrupts();
         var_2557 = new ColorTransitioner();
         var_2577 = new ColorTransitioner(0,0);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_1749)
         {
            var_1749.visible = param1;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_52;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get friendList() : IHabboFriendList
      {
         return _friendList;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get inventory() : class_1814
      {
         return _inventory && !_inventory.disposed ? _inventory : null;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomWidgetFactory() : IRoomWidgetFactory
      {
         return var_3132;
      }
      
      public function get navigator() : IHabboNavigator
      {
         return _navigator;
      }
      
      public function get habboGroupsManager() : class_1880
      {
         return _habboGroupsManager;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get avatarEditor() : class_1881
      {
         return _avatarEditor;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get config() : ICoreConfiguration
      {
         return _config;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function get messenger() : IHabboMessenger
      {
         return _messenger;
      }
      
      public function get moderation() : IHabboModeration
      {
         return _moderation;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function get session() : IRoomSession
      {
         return var_52;
      }
      
      public function get gameManager() : class_1805
      {
         return _gameManager;
      }
      
      public function get questEngine() : class_2197
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : class_1809
      {
         return _freeFlowChat;
      }
      
      public function get roomBackgroundColor() : uint
      {
         return _roomBackgroundColor;
      }
      
      public function set catalog(param1:IHabboCatalog) : void
      {
         _catalog = param1;
      }
      
      public function set avatarEditor(param1:class_1881) : void
      {
         _avatarEditor = param1;
      }
      
      public function set roomWidgetFactory(param1:IRoomWidgetFactory) : void
      {
         var_3132 = param1;
      }
      
      public function set sessionDataManager(param1:ISessionDataManager) : void
      {
         _sessionDataManager = param1;
      }
      
      public function set roomSessionManager(param1:IRoomSessionManager) : void
      {
         _roomSessionManager = param1;
         checkInterrupts();
      }
      
      public function set communicationManager(param1:IHabboCommunicationManager) : void
      {
         _communicationManager = param1;
      }
      
      public function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents
      {
         return _userDefinedRoomEvents;
      }
      
      public function get connection() : IConnection
      {
         return var_26;
      }
      
      public function set friendList(param1:IHabboFriendList) : void
      {
         _friendList = param1;
         if(_friendList)
         {
            _friendList.events.addEventListener("FRE_ACCEPTED",processEvent);
            _friendList.events.addEventListener("FRE_DECLINED",processEvent);
         }
      }
      
      public function set avatarRenderManager(param1:IAvatarRenderManager) : void
      {
         _avatarRenderManager = param1;
      }
      
      public function set windowManager(param1:IHabboWindowManager) : void
      {
         _windowManager = param1;
      }
      
      public function set inventory(param1:class_1814) : void
      {
         _inventory = param1;
      }
      
      public function set navigator(param1:IHabboNavigator) : void
      {
         _navigator = param1;
      }
      
      public function set adManager(param1:class_1811) : void
      {
         _adManager = param1;
      }
      
      public function set localization(param1:IHabboLocalizationManager) : void
      {
         _localization = param1;
      }
      
      public function set habboHelp(param1:IHabboHelp) : void
      {
         _habboHelp = param1;
      }
      
      public function set moderation(param1:IHabboModeration) : void
      {
         _moderation = param1;
      }
      
      public function set config(param1:ICoreConfiguration) : void
      {
         _config = param1;
      }
      
      public function set soundManager(param1:class_2240) : void
      {
         _soundManager = param1;
      }
      
      public function set habboTracking(param1:IHabboTracking) : void
      {
         _habboTracking = param1;
      }
      
      public function set userDefinedRoomEvents(param1:IHabboUserDefinedRoomEvents) : void
      {
         _userDefinedRoomEvents = param1;
      }
      
      public function set gameManager(param1:class_1805) : void
      {
         _gameManager = param1;
      }
      
      public function set questEngine(param1:class_2197) : void
      {
         _questEngine = param1;
      }
      
      public function set freeFlowChat(param1:class_1809) : void
      {
         _freeFlowChat = param1;
      }
      
      public function set habboGroupsManager(param1:class_1880) : void
      {
         _habboGroupsManager = param1;
      }
      
      public function set roomEngine(param1:IRoomEngine) : void
      {
         _roomEngine = param1;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.addEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _roomEngine.events.addEventListener("RCLE_FAILURE",onRoomContentLoaded);
            _roomEngine.events.addEventListener("RCLE_CANCEL",onRoomContentLoaded);
         }
      }
      
      public function set messenger(param1:IHabboMessenger) : void
      {
         _messenger = param1;
      }
      
      public function set toolbar(param1:IHabboToolbar) : void
      {
         _toolbar = param1;
         _toolbar.events.addEventListener("HTIE_ICON_ZOOM",onToolbarEvent);
      }
      
      public function set layout(param1:XML) : void
      {
         var_1873.setLayout(param1,_windowManager,_config);
      }
      
      public function dispose() : void
      {
         var _loc5_:IRoomGeometry = null;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc1_:IRoomWidget = null;
         if(_roomEngine != null && var_52 != null)
         {
            if((_loc5_ = _roomEngine.getRoomCanvasGeometry(var_52.roomId,getFirstCanvasId())) != null)
            {
               trackZooming(_loc5_.isZoomedIn(),false);
            }
         }
         var _loc2_:int = 0;
         if(var_2007 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_2007.length)
            {
               _loc4_ = int(var_2007[_loc2_]);
               _loc3_ = getWindowName(_loc4_);
               if(_windowManager)
               {
                  _windowManager.removeWindow(_loc3_);
               }
               _loc2_++;
            }
         }
         _updateListeners = null;
         if(var_1643 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_1643.length)
            {
               _loc1_ = var_1643.getWithIndex(_loc2_) as IRoomWidget;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_1643.dispose();
            var_1643 = null;
         }
         if(var_2739 != null)
         {
            var_2739.dispose();
            var_2739 = null;
         }
         if(var_2510 != null)
         {
            var_2510.dispose();
            var_2510 = null;
         }
         if(var_26)
         {
            if(var_2791 != null)
            {
               var_26.removeMessageEvent(var_2791);
               var_2791.dispose();
               var_2791 = null;
            }
            if(var_2922 != null)
            {
               var_26.removeMessageEvent(var_2922);
               var_2922.dispose();
               var_2922 = null;
            }
            var_26 = null;
         }
         _assets = null;
         _avatarRenderManager = null;
         var_2007 = null;
         name_1 = null;
         if(_friendList && _friendList.events)
         {
            _friendList.events.removeEventListener("FRE_ACCEPTED",processEvent);
            _friendList.events.removeEventListener("FRE_DECLINED",processEvent);
         }
         _friendList = null;
         var_1873.dispose();
         var_1873 = null;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.removeEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _roomEngine.events.removeEventListener("RCLE_FAILURE",onRoomContentLoaded);
            _roomEngine.events.removeEventListener("RCLE_CANCEL",onRoomContentLoaded);
         }
         _roomEngine = null;
         _roomSessionManager = null;
         var_3132 = null;
         var_52 = null;
         _sessionDataManager = null;
         _windowManager = null;
         _inventory = null;
         _localization = null;
         _config = null;
         _soundManager = null;
         _habboGroupsManager = null;
         if(_toolbar && toolbar.events)
         {
            _toolbar.events.removeEventListener("HTIE_ICON_ZOOM",onToolbarEvent);
            _toolbar = null;
         }
         _navigator = null;
         if(var_1909 != null)
         {
            var_1909.dispose();
            var_1909 = null;
         }
         if(var_2303 != null)
         {
            var_2303.reset();
            var_2303.removeEventListener("timer",onResizeTimerEvent);
            var_2303 = null;
         }
         var_3932 = null;
         var_2557 = null;
         var_2577 = null;
      }
      
      private function onBotSkillListUpdateEvent(param1:class_612) : void
      {
         var _loc2_:class_3490 = null;
         var _loc3_:class_1442 = param1.getParser();
         if(var_52 != null)
         {
            _loc2_ = var_52.userDataManager.getRentableBotUserData(_loc3_.botId);
            _loc2_.botSkillData = param1.getParser().skillList.concat();
         }
         events.dispatchEvent(new RoomWidgetRentableBotSkillListUpdateEvent(_loc3_.botId,_loc3_.skillList));
      }
      
      private function onBotForceOpenContextMenuEvent(param1:class_181) : void
      {
         var _loc2_:class_1493 = param1.getParser();
         events.dispatchEvent(new RoomWidgetRentableBotForceOpenContextMenuEvent(_loc2_.botId));
      }
      
      public function init() : void
      {
         if(_roomEngine != null && var_52 != null)
         {
            var_2901 = [];
            if(var_2901.length > 0)
            {
               var_3933 = false;
               processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUE_SHOW_LOADING_BAR"));
            }
         }
      }
      
      public function requestInterstitial() : void
      {
         if(_adManager != null)
         {
            _adManager.showInterstitial();
         }
      }
      
      private function onRoomContentLoaded(param1:RoomContentLoadedEvent) : void
      {
         if(var_2901 == null || var_2901.length == 0)
         {
            return;
         }
         var _loc2_:int = var_2901.indexOf(param1.contentType);
         if(_loc2_ != -1)
         {
            var_2901.splice(_loc2_,1);
         }
         if(var_2901.length == 0)
         {
            var_3933 = true;
            checkInterrupts();
         }
      }
      
      public function createWidget(param1:String) : void
      {
         var _loc8_:Boolean = false;
         var _loc2_:IRoomWidgetHandler = null;
         var _loc6_:ChatWidgetHandler = null;
         var _loc15_:PlayListEditorWidgetHandler = null;
         var _loc3_:SpamWallPostItWidgetHandler = null;
         var _loc5_:FurnitureContextMenuWidgetHandler = null;
         var _loc10_:FurnitureRoomLinkHandler = null;
         var _loc7_:RoomToolsWidgetHandler = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc16_:Array = null;
         var _loc11_:RoomWidgetRoomViewUpdateEvent = null;
         if(var_3132 == null)
         {
            return;
         }
         var _loc4_:IRoomWidget;
         if((_loc4_ = var_1643.getValue(param1) as IRoomWidget) != null)
         {
            return;
         }
         if(var_52.isGameSession && !isGameWidget(param1))
         {
            return;
         }
         switch(param1)
         {
            case "RWE_CHAT_WIDGET":
               (_loc6_ = new ChatWidgetHandler()).connection = var_26;
               _loc2_ = _loc6_;
               _loc8_ = true;
               break;
            case "RWE_INFOSTAND":
               _loc2_ = new InfoStandWidgetHandler(_soundManager.musicController);
               break;
            case "RWE_CHAT_INPUT_WIDGET":
               _loc8_ = true;
               _loc2_ = new ChatInputWidgetHandler();
               break;
            case "RWE_ME_MENU":
               _loc2_ = new MeMenuWidgetHandler();
               break;
            case "RWE_FURNI_PLACEHOLDER":
               _loc2_ = new PlaceholderWidgetHandler();
               break;
            case "RWE_FURNI_CREDIT_WIDGET":
               _loc2_ = new FurnitureCreditWidgetHandler();
               break;
            case "RWE_FURNI_STICKIE_WIDGET":
               _loc2_ = new FurnitureStickieWidgetHandler();
               break;
            case "RWE_FURNI_PRESENT_WIDGET":
               _loc2_ = new FurniturePresentWidgetHandler();
               break;
            case "RWE_FURNI_TROPHY_WIDGET":
               _loc2_ = new FurnitureTrophyWidgetHandler();
               break;
            case "RWE_FURNI_ECOTRONBOX_WIDGET":
               _loc2_ = new FurnitureEcotronBoxWidgetHandler();
               break;
            case "RWE_FURNI_PET_PACKAGE_WIDGET":
               _loc2_ = new PetPackageFurniWidgetHandler();
               break;
            case "RWE_DOORBELL":
               _loc2_ = new DoorbellWidgetHandler();
               break;
            case "RWE_ROOM_QUEUE":
               _loc2_ = new RoomQueueWidgetHandler();
               break;
            case "RWE_LOADINGBAR":
               _loc2_ = new LoadingBarWidgetHandler();
               break;
            case "RWE_ROOM_POLL":
               _loc2_ = new PollWidgetHandler();
               break;
            case "RWE_WORD_QUIZZ":
               _loc2_ = new WordQuizWidgetHandler();
               break;
            case "RWE_FURNI_CHOOSER":
               _loc2_ = new FurniChooserWidgetHandler();
               break;
            case "RWE_USER_CHOOSER":
               _loc2_ = new UserChooserWidgetHandler();
               break;
            case "RWE_ROOM_DIMMER":
               _loc2_ = new FurnitureDimmerWidgetHandler();
               break;
            case "RWE_FRIEND_REQUEST":
               _loc2_ = new FriendRequestWidgetHandler();
               break;
            case "RWE_CLOTHING_CHANGE":
               _loc2_ = new FurnitureClothingChangeWidgetHandler();
               break;
            case "RWE_CONVERSION_TRACKING":
               _loc2_ = new ConversionPointWidgetHandler();
               break;
            case "RWE_AVATAR_INFO":
               _loc2_ = new AvatarInfoWidgetHandler();
               break;
            case "RWE_PLAYLIST_EDITOR_WIDGET":
               (_loc15_ = new PlayListEditorWidgetHandler()).connection = var_26;
               _loc2_ = _loc15_ as IRoomWidgetHandler;
               break;
            case "RWE_SPAMWALL_POSTIT_WIDGET":
               _loc3_ = new SpamWallPostItWidgetHandler();
               _loc3_.connection = var_26;
               _loc2_ = _loc3_ as IRoomWidgetHandler;
               break;
            case "RWE_EFFECTS":
               _loc2_ = new class_3647();
               break;
            case "RWE_MANNEQUIN":
               _loc2_ = new MannequinWidgetHandler();
               break;
            case "RWE_FURNITURE_CONTEXT_MENU":
               (_loc5_ = new FurnitureContextMenuWidgetHandler()).connection = var_26;
               _loc2_ = _loc5_ as IRoomWidgetHandler;
               break;
            case "RWE_LOCATION_WIDGET":
               _loc2_ = new ObjectLocationRequestHandler();
               break;
            case "RWE_CAMERA":
               _loc2_ = new CameraWidgetHandler(this);
               break;
            case "RWE_ROOM_BACKGROUND_COLOR":
               _loc2_ = new FurnitureBackgroundColorWidgetHandler();
               break;
            case "RWE_AREA_HIDE":
               _loc2_ = new FurnitureAreaHideWidgetHandler();
               break;
            case "RWE_CUSTOM_USER_NOTIFICATION":
               _loc2_ = new CustomUserNotificationWidgetHandler();
               break;
            case "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               _loc2_ = new class_3572();
               break;
            case "RWE_FRIEND_FURNI_CONFIRM":
               _loc2_ = new class_3642();
               class_3642(_loc2_).connection = connection;
               break;
            case "RWE_FRIEND_FURNI_ENGRAVING":
               _loc2_ = new class_3560();
               break;
            case "RWE_HIGH_SCORE_DISPLAY":
               _loc2_ = new class_3569();
               break;
            case "RWE_INTERNAL_LINK":
               _loc2_ = new class_3575();
               break;
            case "RWE_ROOM_LINK":
               (_loc10_ = new FurnitureRoomLinkHandler()).communicationManager = _communicationManager;
               _loc2_ = _loc10_;
               break;
            case "RWE_CUSTOM_STACK_HEIGHT":
               _loc2_ = new class_3586();
               break;
            case "RWE_YOUTUBE":
               _loc2_ = new class_3561();
               break;
            case "RWE_RENTABLESPACE":
               _loc2_ = new class_3559();
               break;
            case "RWE_VIMEO":
               _loc2_ = new class_3640();
               break;
            case "RWE_ROOM_TOOLS":
               (_loc7_ = new RoomToolsWidgetHandler()).communicationManager = _communicationManager;
               _loc7_.navigator = _navigator;
               _loc2_ = _loc7_;
               break;
            case "RWE_EXTERNAL_IMAGE":
               _loc2_ = new ExternalImageWidgetHandler();
               break;
            case "RWE_UI_HELP_BUBBLE":
               _loc2_ = new UiHelpBubbleWidgetHandler();
               break;
            case "RWE_ROOM_THUMBNAIL_CAMERA":
               _loc2_ = new RoomThumbnailCameraWidgetHandler(this);
               break;
            case "RWE_CRAFTING":
               _loc2_ = new CraftingWidgetHandler(this);
         }
         if(_loc2_ != null)
         {
            _loc2_.container = this;
            _loc12_ = null;
            if((_loc13_ = _loc2_.getWidgetMessages()) != null)
            {
               for each(var _loc9_ in _loc13_)
               {
                  if((_loc12_ = var_2739.getValue(_loc9_)) == null)
                  {
                     _loc12_ = [];
                     var_2739.add(_loc9_,_loc12_);
                  }
                  _loc12_.push(_loc2_);
               }
            }
            if((_loc16_ = _loc2_.getProcessedEvents()) != null)
            {
               _loc16_.push("RETWE_OPEN_WIDGET");
               _loc16_.push("RETWE_CLOSE_WIDGET");
               for each(var _loc14_ in _loc16_)
               {
                  if((_loc12_ = var_2510.getValue(_loc14_)) == null)
                  {
                     _loc12_ = [];
                     var_2510.add(_loc14_,_loc12_);
                  }
                  _loc12_.push(_loc2_);
               }
            }
         }
         if((_loc4_ = var_3132.createWidget(param1,_loc2_)) == null)
         {
            return;
         }
         _loc4_.messageListener = this;
         _loc4_.registerUpdateEvents(name_1);
         if(!var_1643.add(param1,_loc4_))
         {
            _loc4_.dispose();
         }
         else
         {
            var_1873.addWidgetWindow(param1,_loc4_.mainWindow);
         }
         if(_loc8_)
         {
            param1 = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
            _loc11_ = new RoomWidgetRoomViewUpdateEvent(param1,var_1873.roomViewRect);
            this.events.dispatchEvent(_loc11_);
         }
      }
      
      private function isGameWidget(param1:String) : Boolean
      {
         switch(param1)
         {
            case "RWE_CHAT_INPUT_WIDGET":
            case "RWE_CHAT_WIDGET":
            case "RWE_AVATAR_INFO":
            case "RWE_LOCATION_WIDGET":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function disposeWidget(param1:String) : void
      {
         var _loc2_:IRoomWidget = null;
         if(var_1643 != null)
         {
            _loc2_ = var_1643.remove(param1);
            if(_loc2_ != null)
            {
               if(var_1873 != null)
               {
                  var_1873.removeWidgetWindow(param1,_loc2_.mainWindow);
               }
               _loc2_.dispose();
            }
         }
      }
      
      public function getWidget(param1:String) : IRoomWidget
      {
         var _loc2_:IRoomWidget = null;
         if(var_1643 != null)
         {
            _loc2_ = var_1643[param1];
         }
         return _loc2_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetUpdateEvent = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1.type == "RWZTM_ZOOM_TOGGLE")
         {
            toggleZoom();
         }
         var _loc3_:Array = var_2739.getValue(param1.type);
         if(_loc3_ != null)
         {
            for each(var _loc2_ in _loc3_)
            {
               if((_loc4_ = _loc2_.processWidgetMessage(param1)) != null)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:RoomEngineToWidgetEvent = null;
         if(!param1 || !var_2510)
         {
            return;
         }
         if(var_1749 && param1.type == "RDMZEE_ENABLED")
         {
            checkAndEnableMouseZoomEvent(var_1749.getDisplayObject());
         }
         var _loc4_:Array;
         if((_loc4_ = var_2510.getValue(param1.type)) != null)
         {
            for each(var _loc2_ in _loc4_)
            {
               _loc3_ = true;
               if(param1.type == "RETWE_OPEN_WIDGET" || param1.type == "RETWE_CLOSE_WIDGET")
               {
                  _loc3_ = (_loc5_ = param1 as RoomEngineToWidgetEvent) != null && _loc2_.type == _loc5_.widget;
               }
               if(param1.type == "RWZTM_ZOOM_TOGGLE")
               {
                  toggleZoom();
               }
               if(_loc3_)
               {
                  _loc2_.processEvent(param1);
               }
            }
         }
      }
      
      private function isFurnitureSelectionDisabled(param1:RoomEngineObjectEvent) : Boolean
      {
         var _loc4_:IRoomObjectModel = null;
         var _loc3_:Boolean = false;
         var _loc2_:IRoomObject = roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
         if(_loc2_ != null)
         {
            if((_loc4_ = _loc2_.getModel()) != null)
            {
               if(_loc4_.getNumber("furniture_selection_disable") == 1)
               {
                  _loc3_ = true;
                  if(_sessionDataManager.isAnyRoomController)
                  {
                     _loc3_ = false;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc7_:String = null;
         var _loc10_:class_3490 = null;
         var _loc12_:IRoomObject = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = false;
         var _loc11_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:int = param1.objectId;
         var _loc6_:int = param1.category;
         var _loc3_:RoomWidgetRoomObjectUpdateEvent = null;
         var _loc9_:RoomWidgetFurniToWidgetMessage = null;
         switch(param1.type)
         {
            case "REOE_SELECTED":
               if(!isFurnitureSelectionDisabled(param1))
               {
                  _loc3_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_SELECTED",_loc5_,_loc6_,param1.roomId);
               }
               if(_moderation != null && _loc6_ == 100)
               {
                  if((_loc10_ = var_52.userDataManager.getUserDataByIndex(_loc5_)) != null && _loc10_.type == 1)
                  {
                     _moderation.userSelected(_loc10_.webID,_loc10_.name);
                  }
               }
               break;
            case "REOE_ADDED":
               switch(_loc6_)
               {
                  case 10:
                  case 20:
                     _loc7_ = "RWROUE_FURNI_ADDED";
                     break;
                  case 100:
                     _loc7_ = "RWROUE_USER_ADDED";
               }
               if(_loc7_ != null)
               {
                  _loc3_ = new RoomWidgetRoomObjectUpdateEvent(_loc7_,_loc5_,_loc6_,param1.roomId);
               }
               break;
            case "REOE_REMOVED":
               switch(_loc6_)
               {
                  case 10:
                  case 20:
                     _loc7_ = "RWROUE_FURNI_REMOVED";
                     break;
                  case 100:
                     _loc7_ = "RWROUE_USER_REMOVED";
               }
               if(_loc7_ != null)
               {
                  _loc3_ = new RoomWidgetRoomObjectUpdateEvent(_loc7_,_loc5_,_loc6_,param1.roomId);
               }
               break;
            case "REOE_DESELECTED":
               _loc3_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_DESELECTED",_loc5_,_loc6_,param1.roomId);
               break;
            case "REOE_MOUSE_ENTER":
               _loc3_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OVER",_loc5_,_loc6_,param1.roomId);
               break;
            case "REOE_MOUSE_LEAVE":
               _loc3_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OUT",_loc5_,_loc6_,param1.roomId);
               break;
            case "REOE_REQUEST_MOVE":
               if(checkFurniManipulationRights(param1.roomId,param1.objectId,param1.category))
               {
                  _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_MOVE");
               }
               break;
            case "REOE_REQUEST_ROTATE":
               if(checkFurniManipulationRights(param1.roomId,param1.objectId,param1.category))
               {
                  _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_ROTATE_POSITIVE");
               }
               break;
            case "REOE_REQUEST_PICKUP":
               _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_PICKUP");
               break;
            case "RETWE_REQUEST_CREDITFURNI":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CREDITFURNI",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_STICKIE":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_STICKIE",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_PRESENT":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PRESENT",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_TROPHY":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TROPHY",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_TEASER":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TEASER",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_ECOTRONBOX":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_ECOTRONBOX",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_DIMMER":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_DIMMER",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_PLACEHOLDER":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLACEHOLDER",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RERAE_FURNI_CLICK":
            case "RERAE_FURNI_DOUBLE_CLICK":
               handleRoomAdClick(param1);
               break;
            case "RERAE_TOOLTIP_SHOW":
            case "RERAE_TOOLTIP_HIDE":
               handleRoomAdTooltip(param1);
               break;
            case "RETWE_REQUEST_CLOTHING_CHANGE":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_PLAYLIST_EDITOR":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING":
               _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING",_loc5_,_loc6_,param1.roomId);
               processWidgetMessage(_loc9_);
               break;
            case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED":
               if((_loc12_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category)) != null)
               {
                  _loc8_ = int(_loc12_.getModel().getNumber("furniture_owner_id"));
                  _loc4_ = _sessionDataManager.userId;
                  if(_loc8_ == _loc4_)
                  {
                     _loc9_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",_loc5_,_loc6_,param1.roomId);
                     processWidgetMessage(_loc9_);
                  }
               }
               break;
            case "RETWE_OPEN_WIDGET":
            case "RETWE_CLOSE_WIDGET":
            case "RETWE_OPEN_FURNI_CONTEXT_MENU":
            case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
            case "RETWE_REMOVE_DIMMER":
            case "ROSM_JUKEBOX_DISPOSE":
            case "RETWE_REQUEST_MANNEQUIN":
            case "ROSM_USE_PRODUCT_FROM_INVENTORY":
            case "ROSM_USE_PRODUCT_FROM_ROOM":
            case "RETWE_REQUEST_BACKGROUND_COLOR":
            case "RETWE_REQUEST_AREA_HIDE":
            case "RETWE_UPDATE_STATE_AREA_HIDE":
            case "RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING":
            case "RETWE_REQUEST_HIGH_SCORE_DISPLAY":
            case "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY":
            case "RETWE_REQUEST_INTERNAL_LINK":
            case "RETWE_REQUEST_ROOM_LINK":
               processEvent(param1);
         }
         if(_loc3_ != null)
         {
            _loc2_ = true;
            if(_loc3_ is RoomWidgetRoomObjectUpdateEvent)
            {
               _loc11_ = (_loc3_ as RoomWidgetRoomObjectUpdateEvent).roomId;
               _loc2_ = !RoomId.isRoomPreviewerId(_loc11_);
            }
            else if(_loc3_ is RoomWidgetRoomEngineUpdateEvent)
            {
               _loc11_ = (_loc3_ as RoomWidgetRoomEngineUpdateEvent).roomId;
               _loc2_ = !RoomId.isRoomPreviewerId(_loc11_);
            }
            if(_loc2_)
            {
               events.dispatchEvent(_loc3_);
            }
         }
      }
      
      private function checkFurniManipulationRights(param1:int, param2:int, param3:int) : Boolean
      {
         return var_52.roomControllerLevel >= 1 || _sessionDataManager.isAnyRoomController || isOwnerOfFurniture(_roomEngine.getRoomObject(param1,param2,param3));
      }
      
      public function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:RoomWidgetUpdateEvent = null;
         switch(param1.type)
         {
            case "REE_NORMAL_MODE":
               _loc2_ = new RoomWidgetRoomEngineUpdateEvent("RWREUE_NORMAL_MODE",param1.roomId);
               break;
            case "REE_GAME_MODE":
               _loc2_ = new RoomWidgetRoomEngineUpdateEvent("RWREUE_GAME_MODE",param1.roomId);
         }
         if(_loc2_ != null)
         {
            events.dispatchEvent(_loc2_);
         }
      }
      
      public function createRoomView(param1:int) : void
      {
         var _loc15_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc6_:IWindow = null;
         var _loc3_:Rectangle = var_1873.roomViewRect;
         var _loc16_:int = _loc3_.width;
         var _loc22_:int = _loc3_.height;
         var _loc7_:int = var_52.isGameSession ? 32 : 64;
         if(var_2007.indexOf(param1) >= 0)
         {
            return;
         }
         if(var_52 == null || _windowManager == null || _roomEngine == null)
         {
            return;
         }
         var _loc17_:DisplayObject;
         if((_loc17_ = _roomEngine.createRoomCanvas(var_52.roomId,param1,_loc16_,_loc22_,_loc7_)) == null)
         {
            return;
         }
         var _loc18_:RoomGeometry;
         if((_loc18_ = _roomEngine.getRoomCanvasGeometry(var_52.roomId,param1) as RoomGeometry) != null)
         {
            _loc15_ = _roomEngine.getRoomNumberValue(var_52.roomId,"room_min_x");
            _loc5_ = _roomEngine.getRoomNumberValue(var_52.roomId,"room_max_x");
            _loc14_ = _roomEngine.getRoomNumberValue(var_52.roomId,"room_min_y");
            _loc4_ = _roomEngine.getRoomNumberValue(var_52.roomId,"room_max_y");
            _loc13_ = (_loc15_ + _loc5_) / 2;
            _loc10_ = (_loc14_ + _loc4_) / 2;
            _loc8_ = 20;
            _loc13_ += _loc8_ - 1;
            _loc10_ += _loc8_ - 1;
            _loc11_ = Math.sqrt(_loc8_ * _loc8_ + _loc8_ * _loc8_) * Math.tan(0.16666666666666666 * 3.141592653589793);
            _loc18_.location = new Vector3d(_loc13_,_loc10_,_loc11_);
         }
         var _loc20_:XmlAsset;
         if((_loc20_ = _assets.getAssetByName("room_view_container_xml") as XmlAsset) == null)
         {
            return;
         }
         var _loc9_:IWindowContainer;
         if((_loc9_ = _windowManager.buildFromXML(_loc20_.content as XML) as IWindowContainer) == null)
         {
            return;
         }
         _loc9_.width = _loc16_;
         _loc9_.height = _loc22_;
         var_1749 = _loc9_.findChildByName("room_canvas_wrapper") as class_3431;
         if(var_1749 == null)
         {
            return;
         }
         var_1749.setDisplayObject(_loc17_);
         if(var_52.isGameSession)
         {
            _loc17_.addEventListener("click",mouseEventHandler);
         }
         checkAndEnableMouseZoomEvent(_loc17_);
         var_1749.addEventListener("WME_CLICK",canvasMouseHandler);
         var_1749.addEventListener("WME_DOUBLE_CLICK",canvasMouseHandler);
         var_1749.addEventListener("WME_MOVE",canvasMouseHandler);
         var_1749.addEventListener("WME_DOWN",canvasMouseHandler);
         var_1749.addEventListener("WME_UP",canvasMouseHandler);
         var_1749.addEventListener("WME_UP_OUTSIDE",canvasMouseHandler);
         var_1749.addEventListener("WE_RESIZED",onRoomViewResized);
         var _loc19_:Sprite;
         (_loc19_ = new Sprite()).mouseEnabled = false;
         _loc19_.blendMode = "multiply";
         var _loc21_:class_3431;
         if((_loc21_ = _loc9_.findChildByName("colorizer_wrapper") as class_3431) == null)
         {
            return;
         }
         _loc21_.setDisplayObject(_loc19_);
         _loc21_.addEventListener("WE_RESIZED",resizeColorizer);
         var _loc2_:Sprite = new Sprite();
         _loc2_.mouseEnabled = false;
         var _loc12_:class_3431;
         if((_loc12_ = _loc9_.findChildByName("background_wrapper") as class_3431) == null)
         {
            return;
         }
         _loc12_.setDisplayObject(_loc2_);
         _loc12_.addEventListener("WE_RESIZED",resizeBackgroundColorizer);
         if(var_52.isSpectatorMode)
         {
            if((_loc6_ = getSpectatorModeVisualization()) != null)
            {
               _loc6_.width = _loc9_.width;
               _loc6_.height = _loc9_.height;
               _loc9_.addChild(_loc6_);
            }
         }
         var_1873.addRoomView(_loc9_);
         var_2007.push(param1);
      }
      
      public function enterAfterSpectate() : void
      {
         var _loc2_:IWindowContainer = var_1873.getRoomView() as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:IWindow = _loc2_.findChildByName("spectator_mode_container");
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_.removeChild(_loc1_);
         _loc1_.dispose();
      }
      
      private function checkAndEnableMouseZoomEvent(param1:DisplayObject) : void
      {
         param1.removeEventListener("mouseWheel",mouseWheelHandler);
         if(_sessionDataManager.isPerkAllowed("MOUSE_ZOOM"))
         {
            param1.addEventListener("mouseWheel",mouseWheelHandler);
         }
      }
      
      private function mouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1.ctrlKey && !param1.altKey && !param1.shiftKey)
         {
            var_2812 += param1.delta == 0 ? 0 : (param1.delta < 0 ? -20 : 20);
            _loc3_ = new Point();
            var_1749.getGlobalPosition(_loc3_);
            _loc2_ = param1.stageX - _loc3_.x;
            _loc4_ = param1.stageY - _loc3_.y;
            var_2932 = new Point(_loc2_,_loc4_);
         }
      }
      
      private function resizeColorizer(param1:WindowEvent) : void
      {
         var _loc2_:class_3431 = param1.target as class_3431;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Sprite = _loc2_.getDisplayObject() as Sprite;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.graphics.clear();
         _loc3_.graphics.beginFill(_roomColor);
         _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc3_.graphics.endFill();
      }
      
      private function resizeBackgroundColorizer(param1:WindowEvent) : void
      {
         var _loc2_:class_3431 = param1.target as class_3431;
         if(_loc2_ == null)
         {
            return;
         }
         fillBackgroundColorizer(_loc2_);
      }
      
      private function fillBackgroundColorizer(param1:class_3431) : void
      {
         var _loc2_:Sprite = param1.getDisplayObject() as Sprite;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.graphics.clear();
         _loc2_.graphics.beginFill(_roomBackgroundColor);
         _loc2_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc2_.graphics.endFill();
      }
      
      public function setRoomViewColor(param1:uint, param2:int) : void
      {
         if(var_2557)
         {
            var_2557.startTransition(param1,param2,getTimer());
         }
      }
      
      private function updateColor() : void
      {
         if(var_2557 && var_2557.updateColor(getTimer()))
         {
            _roomColor = var_2557.color;
            drawRoomColor();
         }
         if(var_2577 && var_2577.updateColor(getTimer()))
         {
            _roomBackgroundColor = var_2577.color;
            drawRoomBackgroundColor();
         }
      }
      
      private function drawRoomColor() : void
      {
         var _loc2_:IWindowContainer = var_1873.getRoomView() as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_3431 = _loc2_.getChildByName("colorizer_wrapper") as class_3431;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Sprite = _loc3_.getDisplayObject() as Sprite;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(_roomColor);
         _loc1_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
         _loc1_.graphics.endFill();
      }
      
      public function setRoomBackgroundColor(param1:int, param2:int, param3:int) : void
      {
         if(var_2577)
         {
            var_2577.startTransition(ColorConverter.hslToRGB(((param1 & 255) << 16) + ((param2 & 255) << 8) + (param3 & 255)),param3,getTimer());
         }
      }
      
      private function drawRoomBackgroundColor() : void
      {
         var _loc1_:IWindowContainer = var_1873.getRoomView() as IWindowContainer;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:class_3431 = _loc1_.getChildByName("background_wrapper") as class_3431;
         if(_loc2_ == null)
         {
            return;
         }
         if(roomBackgroundColor == 0)
         {
            _loc2_.visible = false;
         }
         else
         {
            _loc2_.visible = true;
            fillBackgroundColorizer(_loc2_);
         }
      }
      
      public function getFirstCanvasId() : int
      {
         if(var_2007 != null)
         {
            if(var_2007.length > 0)
            {
               return var_2007[0];
            }
         }
         return 0;
      }
      
      public function getRoomViewRect() : Rectangle
      {
         if(!var_1873)
         {
            return null;
         }
         return var_1873.roomViewRect;
      }
      
      public function addListenerToStage(param1:String, param2:Function) : void
      {
         if(!var_1749 || !var_1749.getDisplayObject() || !var_1749.getDisplayObject().stage)
         {
            return;
         }
         var_1749.getDisplayObject().stage.addEventListener(param1,param2,false,0,true);
      }
      
      public function removeListenerFromStage(param1:String, param2:Function) : void
      {
         if(!var_1749 || !var_1749.getDisplayObject() || !var_1749.getDisplayObject().stage)
         {
            return;
         }
         var_1749.getDisplayObject().stage.removeEventListener(param1,param2);
      }
      
      public function canvasMouseHandler(param1:WindowEvent) : void
      {
         var _loc5_:Point = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Point = null;
         if(_roomEngine == null || var_52 == null)
         {
            return;
         }
         var _loc4_:WindowMouseEvent;
         if((_loc4_ = param1 as WindowMouseEvent) == null)
         {
            return;
         }
         var _loc8_:String = "";
         switch(_loc4_.type)
         {
            case "WME_CLICK":
               _loc8_ = "click";
               break;
            case "WME_DOUBLE_CLICK":
               _loc8_ = "doubleClick";
               break;
            case "WME_DOWN":
               _loc8_ = "mouseDown";
               break;
            case "WME_UP":
            case "WME_UP_OUTSIDE":
               _loc8_ = "mouseUp";
               break;
            case "WME_MOVE":
               _loc8_ = "mouseMove";
               break;
            default:
               return;
         }
         var _loc2_:class_3431 = _loc4_.target as class_3431;
         if(_loc2_ == _loc4_.target)
         {
            _loc5_ = new Point();
            _loc2_.getGlobalPosition(_loc5_);
            _loc3_ = _loc4_.stageX - _loc5_.x;
            _loc7_ = _loc4_.stageY - _loc5_.y;
            _roomEngine.setActiveRoom(var_52.roomId);
            _roomEngine.handleRoomCanvasMouseEvent(var_2007[0],_loc3_,_loc7_,_loc8_,_loc4_.altKey,_loc4_.ctrlKey,_loc4_.shiftKey,_loc4_.buttonDown);
         }
         if(_loc8_ == "mouseMove" && var_1909 != null)
         {
            (_loc6_ = new Point(_loc4_.stageX,_loc4_.stageY)).offset(-var_1909.width / 2,15);
            var_1909.setGlobalPosition(_loc6_);
         }
      }
      
      private function mouseEventHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = new Point();
         var_1749.getGlobalPosition(_loc3_);
         var _loc2_:int = param1.stageX - _loc3_.x;
         var _loc4_:int = param1.stageY - _loc3_.y;
         _roomEngine.setActiveRoom(var_52.roomId);
         param1.stopImmediatePropagation();
         _roomEngine.handleRoomCanvasMouseEvent(var_2007[0],_loc2_,_loc4_,param1.type,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
      }
      
      private function onRoomViewResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.window;
         var_3932 = _loc2_.rectangle;
         _roomEngine.modifyRoomCanvas(var_52.roomId,var_2007[0],_loc2_.width,_loc2_.height);
         if(var_2303 == null)
         {
            var_2303 = new Timer(1000,1);
            var_2303.addEventListener("timer",onResizeTimerEvent);
         }
         else
         {
            var_2303.reset();
         }
         var_2303.start();
      }
      
      private function onResizeTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
         events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent(_loc2_,var_3932));
      }
      
      private function trackZooming(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(var_4963)
         {
            _loc3_ = getTimer();
            _loc4_ = Math.round((_loc3_ - _zoomChangedMillis) / 1000);
            if(_habboTracking != null)
            {
               if(param1)
               {
                  if(param2)
                  {
                     _habboTracking.trackGoogle("zoomEvent","out");
                  }
                  _habboTracking.trackGoogle("zoomEnded","in",_loc4_);
               }
               else
               {
                  if(param2)
                  {
                     _habboTracking.trackGoogle("zoomEvent","in");
                  }
                  _habboTracking.trackGoogle("zoomEnded","out",_loc4_);
               }
            }
            _zoomChangedMillis = _loc3_;
         }
      }
      
      private function onToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTIE_ICON_ZOOM")
         {
            toggleZoom();
         }
      }
      
      private function toggleZoom() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:IRoomGeometry = null;
         if(var_52 != null)
         {
            if((_roomEngine as Component).getBoolean("zoom.enabled"))
            {
               _loc1_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
               _loc2_ = _loc1_ == 1 ? 0.5 : 1;
               _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId,getFirstCanvasId(),_loc2_);
            }
            else
            {
               _loc3_ = _roomEngine.getRoomCanvasGeometry(var_52.roomId,getFirstCanvasId());
               if(_loc3_ != null)
               {
                  trackZooming(_loc3_.isZoomedIn(),true);
                  _loc3_.performZoom();
               }
            }
         }
      }
      
      public function update() : void
      {
         var _loc6_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:IRoomWidgetHandler = null;
         var _loc1_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         if(_updateListeners == null)
         {
            return;
         }
         var _loc3_:int = int(_updateListeners.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _updateListeners[_loc4_] as IRoomWidgetHandler;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc4_++;
         }
         if(Math.abs(var_2812) > 0.01)
         {
            _loc6_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
            _loc1_ = hibit(_loc6_);
            _loc7_ = (_loc1_ > 1 ? _loc1_ << 1 : 1) / 10;
            _loc5_ = var_2812 > 0 ? _loc6_ - _loc7_ : _loc6_ + _loc7_;
            _loc5_ = Math.max(0.5,_loc5_);
            var_3785 = true;
            var_2812 *= 0.05;
            _roomEngine.setRoomCanvasScale(var_52.roomId,getFirstCanvasId(),_loc5_,var_2932,null,false,true);
         }
         else if(var_3785)
         {
            var_3785 = false;
            if((_loc6_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId)) < 0.75)
            {
               _roomEngine.setRoomCanvasScale(var_52.roomId,getFirstCanvasId(),0.5,var_2932,null,false,true);
            }
            else
            {
               _roomEngine.setRoomCanvasScale(var_52.roomId,getFirstCanvasId(),Math.round(_loc6_),var_2932,null,false,true);
            }
         }
         updateColor();
      }
      
      private function hibit(param1:int) : int
      {
         param1 |= param1 >> 1;
         param1 |= param1 >> 2;
         param1 |= param1 >> 4;
         param1 |= param1 >> 8;
         param1 |= param1 >> 16;
         return param1 - (param1 >> 1);
      }
      
      private function getWindowName(param1:int) : String
      {
         return "Room_Engine_Window_" + param1;
      }
      
      private function createFilter(param1:int, param2:int) : Array
      {
         var _loc3_:BlurFilter = new BlurFilter(2,2);
         return [];
      }
      
      private function getBitmapFilter(param1:int, param2:int) : BitmapFilter
      {
         var _loc9_:BitmapData;
         (_loc9_ = new BitmapData(param1,param2)).perlinNoise(param1,param2,5,Math.random() * 2000000000,true,false);
         var _loc6_:Point = new Point(0,0);
         var _loc12_:uint;
         var _loc11_:* = _loc12_ = 1;
         var _loc3_:Number = param1 / 20;
         var _loc5_:Number = -param1 / 25;
         var _loc4_:String = "color";
         var _loc8_:uint = 0;
         var _loc10_:Number = 0;
         return new DisplacementMapFilter(_loc9_,_loc6_,_loc12_,_loc11_,_loc3_,_loc5_,_loc4_,_loc8_,_loc10_);
      }
      
      private function checkInterrupts() : Boolean
      {
         if(_roomSessionManager != null && var_52 != null && var_3933)
         {
            _roomSessionManager.startSession(var_52);
            processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUW_HIDE_LOADING_BAR"));
            return true;
         }
         return false;
      }
      
      private function handleRoomAdClick(param1:RoomEngineObjectEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:IRoomObject;
         if((_loc4_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category)) == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModel = _loc4_.getModel() as IRoomObjectModel;
         var _loc2_:String = String(_loc3_.getString("furniture_ad_url"));
         if(_loc2_ == null || _loc2_.indexOf("http") != 0)
         {
            return;
         }
         switch(param1.type)
         {
            case "RERAE_FURNI_CLICK":
               if(var_52.roomControllerLevel >= 1 || _sessionDataManager.isAnyRoomController)
               {
                  return;
               }
               HabboWebTools.openWebPage(_loc2_);
               break;
            case "RERAE_FURNI_DOUBLE_CLICK":
               if(!var_52.roomControllerLevel >= 1 && !_sessionDataManager.isAnyRoomController)
               {
                  return;
               }
               HabboWebTools.openWebPage(_loc2_);
               break;
         }
      }
      
      private function handleRoomAdTooltip(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc4_:* = null;
         var _loc5_:IRoomObjectModel = null;
         var _loc2_:String = null;
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RERAE_TOOLTIP_SHOW":
               if(var_1909 != null)
               {
                  return;
               }
               _loc3_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
               if(_loc3_ == null)
               {
                  return;
               }
               if((_loc4_ = String(_localization.getLocalization(_loc3_.getType() + ".tooltip","${ads.roomad.tooltip}"))) == null)
               {
                  _loc2_ = String((_loc5_ = _loc3_.getModel() as IRoomObjectModel).getString("furniture_ad_url"));
                  if(_loc2_ != null && _loc2_.indexOf("http") == 0)
                  {
                     _loc4_ = _loc2_;
                  }
               }
               if(_loc4_ == null)
               {
                  return;
               }
               var_1909 = _windowManager.createWindow("room_ad_tooltip",_loc4_,8,0,32) as IToolTipWindow;
               var_1909.setParamFlag(1,false);
               var_1909.visible = true;
               var_1909.center();
               break;
            case "RERAE_TOOLTIP_HIDE":
               if(var_1909 == null)
               {
                  return;
               }
               var_1909.dispose();
               var_1909 = null;
               break;
         }
      }
      
      private function getSpectatorModeVisualization() : IWindow
      {
         var _loc2_:XmlAsset = _assets.getAssetByName("spectator_mode_xml") as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc1_:IWindowContainer = _windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         if(_loc1_ == null)
         {
            return null;
         }
         setBitmap(_loc1_.findChildByName("top_left"),"spec_top_left_png");
         setBitmap(_loc1_.findChildByName("top_middle"),"spec_top_middle_png");
         setBitmap(_loc1_.findChildByName("top_right"),"spec_top_right_png");
         setBitmap(_loc1_.findChildByName("middle_left"),"spec_middle_left_png");
         setBitmap(_loc1_.findChildByName("middle_right"),"spec_middle_right_png");
         setBitmap(_loc1_.findChildByName("bottom_left"),"spec_bottom_left_png");
         setBitmap(_loc1_.findChildByName("bottom_middle"),"spec_bottom_middle_png");
         setBitmap(_loc1_.findChildByName("bottom_right"),"spec_bottom_right_png");
         return _loc1_;
      }
      
      private function setBitmap(param1:IWindow, param2:String) : void
      {
         var _loc4_:IBitmapWrapperWindow;
         if((_loc4_ = param1 as IBitmapWrapperWindow) == null || _assets == null)
         {
            return;
         }
         var _loc5_:BitmapDataAsset;
         if((_loc5_ = _assets.getAssetByName(param2) as BitmapDataAsset) == null)
         {
            return;
         }
         var _loc3_:BitmapData = _loc5_.content as BitmapData;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_.bitmap = _loc3_.clone();
      }
      
      public function initializeWidget(param1:String, param2:int = 0) : void
      {
         var _loc3_:IRoomWidget = var_1643[param1];
         if(_loc3_ == null)
         {
            class_14.log("Tried to initialize an unknown widget " + param1);
            return;
         }
         _loc3_.initialize(param2);
      }
      
      public function getWidgetState(param1:String) : int
      {
         var _loc2_:IRoomWidget = var_1643[param1];
         if(_loc2_ == null)
         {
            class_14.log("Requested the state of an unknown widget " + param1);
            return -1;
         }
         return _loc2_.state;
      }
      
      public function addUpdateListener(param1:IRoomWidgetHandler) : void
      {
         if(_updateListeners == null)
         {
            _updateListeners = [];
         }
         if(_updateListeners.indexOf(param1) == -1)
         {
            _updateListeners.push(param1);
         }
      }
      
      public function removeUpdateListener(param1:IRoomWidgetHandler) : void
      {
         if(_updateListeners == null)
         {
            return;
         }
         var _loc2_:int = _updateListeners.indexOf(param1);
         if(_loc2_ != -1)
         {
            _updateListeners.splice(_loc2_,1);
         }
      }
      
      public function isOwnerOfFurniture(param1:IRoomObject) : Boolean
      {
         var _loc4_:int = sessionDataManager.userId;
         var _loc3_:IRoomObjectModel = param1.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Number = Number(_loc3_.getNumber("furniture_owner_id"));
         return _loc2_ == _loc4_;
      }
      
      public function getFurnitureOwnerId(param1:IRoomObject) : int
      {
         var _loc2_:Number = NaN;
         var _loc3_:IRoomObjectModel = param1.getModel();
         if(_loc3_ != null)
         {
            _loc2_ = Number(_loc3_.getNumber("furniture_owner_id"));
            if(!isNaN(_loc2_))
            {
               return _loc2_;
            }
         }
         return -1;
      }
      
      public function isOwnerOfPet(param1:class_3490) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = sessionDataManager.userId;
         return _loc2_ == param1.ownerId;
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:AvatarInfoWidget;
         if(!(_loc5_ = var_1643["RWE_AVATAR_INFO"] as AvatarInfoWidget))
         {
            return;
         }
         _loc5_.showGamePlayerName(param1,param2,param3,param4);
      }
      
      public function get layoutManager() : class_3604
      {
         return var_1873;
      }
      
      public function mouseEventPositionHasInputEventWindow(param1:MouseEvent, param2:int) : Boolean
      {
         var _loc3_:Array = new Array(0);
         var _loc4_:Point = new Point(param1.stageX,param1.stageY);
         _windowManager.getDesktop(param2).groupParameterFilteredChildrenUnderPoint(_loc4_,_loc3_,1);
         return _loc3_.length > 1;
      }
   }
}
