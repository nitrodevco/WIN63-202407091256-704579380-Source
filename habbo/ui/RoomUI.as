package com.sulake.habbo.ui
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.advertisement.class_1811;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.advertisement.events.InterstitialEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.class_1881;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.freeflowchat.class_1809;
   import com.sulake.habbo.freeflowchat.style.class_3511;
   import com.sulake.habbo.friendbar.IHabboFriendBar;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.class_1805;
   import com.sulake.habbo.groups.class_1880;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.quest.class_2197;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
   import com.sulake.habbo.room.events.RoomEngineZoomEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.RoomWidgetFactory;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
   import com.sulake.habbo.ui.widget.events.RoomDesktopMouseZoomEnableEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.*;
   import com.sulake.room.utils.RoomId;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.advertisement.class_168;
   import com.sulake.habbo.communication.messages.incoming.perk.class_828;
   
   public class RoomUI extends Component implements IRoomUI, IUpdateReceiver
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var var_3132:IRoomWidgetFactory;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _friendList:IHabboFriendList;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _inventory:class_1814;
      
      private var _toolbar:IHabboToolbar;
      
      private var _navigator:IHabboNavigator;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _habboGroupsManager:class_1880;
      
      private var _avatarEditor:class_1881;
      
      private var _catalog:IHabboCatalog;
      
      private var _adManager:class_1811;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _messenger:IHabboMessenger;
      
      private var _moderation:IHabboModeration;
      
      private var _soundManager:class_2240;
      
      private var _gameManager:class_1805;
      
      private var _friendBar:IHabboFriendBar;
      
      private var _friendBarView:IHabboFriendBarView;
      
      private var _landingView:IHabboLandingView;
      
      private var _questEngine:class_2197;
      
      private var _freeFlowChat:class_1809;
      
      private var _communication:IHabboCommunicationManager;
      
      private var var_1849:Map;
      
      private var var_4057:int = -1;
      
      private var var_1988:Boolean;
      
      private var var_3319:int;
      
      private var _habboTracking:IHabboTracking;
      
      private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
      
      private var var_3851:Boolean = false;
      
      private var _isInRoom:Boolean = false;
      
      private var _perkAllowancesMessageEvent:IMessageEvent;
      
      public function RoomUI(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_3132 = new RoomWidgetFactory(this);
         var_1849 = new Map();
         registerUpdateReceiver(this,0);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },true,[{
            "type":"REE_ENGINE_INITIALIZED",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_INITIALIZED",
            "callback":roomEventHandler
         },{
            "type":"REE_OBJECTS_INITIALIZED",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         },{
            "type":"REE_NORMAL_MODE",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_GAME_MODE",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_ENTRANCE_AFTER_SPECTATE",
            "callback":roomEventHandler
         },{
            "type":"REDSE_ROOM_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REE_ROOM_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REE_ROOM_ZOOM",
            "callback":roomEventHandler
         },{
            "type":"ROHSLCEE_ROOM_BACKGROUND_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REOE_SELECTED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_DESELECTED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_ADDED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REMOVED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_PLACED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_MOVE",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_ROTATE",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_PICKUP",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_MOUSE_ENTER",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_MOUSE_LEAVE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_OPEN_WIDGET",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_CLOSE_WIDGET",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_OPEN_FURNI_CONTEXT_MENU",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_CLOSE_FURNI_CONTEXT_MENU",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_CREDITFURNI",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_STICKIE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PRESENT",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_TROPHY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_TEASER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ECOTRONBOX",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PLACEHOLDER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_DIMMER",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_FURNI_CLICK",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_FURNI_DOUBLE_CLICK",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_TOOLTIP_SHOW",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_TOOLTIP_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REMOVE_DIMMER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_CLOTHING_CHANGE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PLAYLIST_EDITOR",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_MANNEQUIN",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_BACKGROUND_COLOR",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_AREA_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_UPDATE_STATE_AREA_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_USE_PRODUCT_FROM_INVENTORY",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_USE_PRODUCT_FROM_ROOM",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_JUKEBOX_DISPOSE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_HIGH_SCORE_DISPLAY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_INTERNAL_LINK",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ROOM_LINK",
            "callback":roomObjectEventHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },true,[{
            "type":"RSE_CREATED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_STARTED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ROOM_DATA",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSCE_CHAT_EVENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSCE_FLOOD_EVENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSUBE_BADGES",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_DOORBELL",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_REJECTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_ACCEPTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_PRESENT_OPENED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSOPPE_OPEN_PET_PACKAGE_REQUESTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSOPPE_OPEN_PET_PACKAGE_RESULT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSEME_KICKED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_PETS_FORBIDDEN_IN_HOTEL",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_PETS_FORBIDDEN_IN_FLAT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_MAX_PETS",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_MAX_NUMBER_OF_OWN_PETS",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_NO_FREE_TILES_FOR_PET",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_PET",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOTS_FORBIDDEN_IN_HOTEL",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOTS_FORBIDDEN_IN_FLAT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOT_LIMIT_REACHED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOT_NAME_NOT_ACCEPTED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSQE_QUEUE_STATUS",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_CONTENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_ERROR",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_OFFER",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_QUESTION_ANSWERED",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_QUESION_FINSIHED",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_NEW_QUESTION",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDPE_PRESETS",
            "callback":roomSessionEventHandler
         },{
            "type":"RSFRE_FRIEND_REQUEST",
            "callback":roomSessionEventHandler
         },{
            "type":"rsudue_user_data_updated",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_DANCE",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_1814):void
         {
            _inventory = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         }),new ComponentDependency(new IIDHabboGroupsManager(),function(param1:class_1880):void
         {
            _habboGroupsManager = param1;
         }),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_1881):void
         {
            _avatarEditor = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboAdManager(),function(param1:class_1811):void
         {
            _adManager = param1;
         },true,[{
            "type":"AE_INTERSTITIAL_NOT_SHOWN",
            "callback":interstitialNotAvailableEventHandler
         },{
            "type":"AE_INTERSTITIAL_COMPLETE",
            "callback":interstitialCompleteEventHandler
         },{
            "type":"AE_INTERSTITIAL_SHOW",
            "callback":interstitialShowEventHandler
         },{
            "type":"AE_ROOM_AD_SHOW",
            "callback":adEventHandler
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboModeration(),function(param1:IHabboModeration):void
         {
            _moderation = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_2240):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _userDefinedRoomEvents = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_1805):void
         {
            _gameManager = param1;
         },true,[{
            "type":"gce_game_chat",
            "callback":gameEventHandler
         }]),new ComponentDependency(new IIDHabboFriendBar(),function(param1:IHabboFriendBar):void
         {
            _friendBar = param1;
         }),new ComponentDependency(new IIDHabboFriendBarView(),function(param1:IHabboFriendBarView):void
         {
            _friendBarView = param1;
         },true,[{
            "type":"FBE_BAR_RESIZE_EVENT",
            "callback":bottomBarResizeHandler
         }]),new ComponentDependency(new IIDHabboLandingView(),function(param1:IHabboLandingView):void
         {
            _landingView = param1;
         }),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_2197):void
         {
            _questEngine = param1;
         }),new ComponentDependency(new IIDHabboMessenger(),function(param1:IHabboMessenger):void
         {
            _messenger = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_1809):void
         {
            _freeFlowChat = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _perkAllowancesMessageEvent = _communication.addHabboConnectionMessageEvent(new class_828(onPerkAllowances));
      }
      
      override public function dispose() : void
      {
         var _loc2_:String = null;
         var _loc1_:RoomDesktop = null;
         if(disposed)
         {
            return;
         }
         if(var_3132 != null)
         {
            var_3132.dispose();
            var_3132 = null;
         }
         if(_communication != null)
         {
            _communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
            _perkAllowancesMessageEvent = null;
         }
         if(var_1849 != null)
         {
            while(var_1849.length > 0)
            {
               _loc2_ = var_1849.getKey(0) as String;
               _loc1_ = var_1849.remove(_loc2_) as RoomDesktop;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
            }
            var_1849.dispose();
            var_1849 = null;
         }
         removeUpdateReceiver(this);
         super.dispose();
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSE_CREATED":
               createDesktop(param1.session);
               if(param1.session.isGameSession)
               {
                  if(_toolbar)
                  {
                     _toolbar.setToolbarState("HTE_STATE_HIDDEN");
                  }
                  if(_friendBar)
                  {
                     _friendBar.visible = false;
                  }
                  if(_landingView)
                  {
                     _landingView.disable();
                  }
               }
               break;
            case "RSE_STARTED":
               if(_toolbar)
               {
                  defineToolbarState(param1.session);
               }
               if(_landingView)
               {
                  _landingView.disable();
               }
               break;
            case "RSE_ROOM_DATA":
               defineToolbarState(param1.session);
               break;
            case "RSE_ENDED":
               if(param1.session != null)
               {
                  disposeDesktop(getRoomIdentifier(param1.session.roomId));
                  if(param1.session.isGameSession)
                  {
                     _friendBar.visible = true;
                     if(_gameManager)
                     {
                        _gameManager.onSnowWarArenaSessionEnded();
                     }
                  }
                  else if(param1.openLandingPage)
                  {
                     if(getBoolean("nux.lobbies.enabled") && _sessionDataManager.isRealNoob)
                     {
                        if(_navigator.enteredGuestRoomData && _navigator.enteredGuestRoomData.doorMode == 4)
                        {
                           _navigator.goToHomeRoom();
                        }
                        else
                        {
                           context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                        }
                     }
                     else if(_landingView)
                     {
                        _landingView.activate();
                     }
                  }
               }
         }
      }
      
      private function defineToolbarState(param1:IRoomSession) : void
      {
         if(getBoolean("nux.lobbies.enabled") && _sessionDataManager.isRealNoob)
         {
            if(param1 && param1.isNoobRoom)
            {
               _toolbar.setToolbarState("HTE_STATE_NOOB_NOT_HOME");
            }
            else
            {
               _toolbar.setToolbarState("HETE_STATE_NOOB_HOME");
            }
         }
         else
         {
            _toolbar.setToolbarState("HTE_STATE_ROOM_VIEW");
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:IRoomDesktop = null;
         if(_roomEngine == null)
         {
            return;
         }
         if(param1.session != null)
         {
            _loc2_ = getRoomIdentifier(param1.session.roomId);
            _loc3_ = getDesktop(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.processEvent(param1);
            }
         }
      }
      
      private function roomSessionDialogEventHandler(param1:RoomSessionEvent) : void
      {
         var errorMessage:String;
         var event:RoomSessionEvent = param1;
         var errorTitle:String = "${error.title}";
         switch(event.type)
         {
            case "RSEME_MAX_PETS":
               errorMessage = "${room.error.max_pets}";
               break;
            case "RSEME_MAX_NUMBER_OF_OWN_PETS":
               errorMessage = "${room.error.max_own_pets}";
               break;
            case "RSEME_KICKED":
               errorMessage = "${room.error.kicked}";
               errorTitle = "${generic.alert.title}";
               break;
            case "RSEME_PETS_FORBIDDEN_IN_HOTEL":
               errorMessage = "${room.error.pets.forbidden_in_hotel}";
               break;
            case "RSEME_PETS_FORBIDDEN_IN_FLAT":
               errorMessage = "${room.error.pets.forbidden_in_flat}";
               break;
            case "RSEME_NO_FREE_TILES_FOR_PET":
               errorMessage = "${room.error.pets.no_free_tiles}";
               break;
            case "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET":
               errorMessage = "${room.error.pets.selected_tile_not_free}";
               break;
            case "RSEME_BOTS_FORBIDDEN_IN_HOTEL":
               errorMessage = "${room.error.bots.forbidden_in_hotel}";
               break;
            case "RSEME_BOTS_FORBIDDEN_IN_FLAT":
               errorMessage = "${room.error.bots.forbidden_in_flat}";
               break;
            case "RSEME_BOT_LIMIT_REACHED":
               errorMessage = "${room.error.max_bots}";
               break;
            case "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT":
               errorMessage = "${room.error.bots.selected_tile_not_free}";
               break;
            case "RSEME_BOT_NAME_NOT_ACCEPTED":
               errorMessage = "${room.error.bots.name.not.accepted}";
               break;
            default:
               return;
         }
         _windowManager.alert(errorTitle,errorMessage,0,function(param1:class_3348, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function interstitialShowEventHandler(param1:InterstitialEvent) : void
      {
         var _loc2_:String = getRoomIdentifier(var_3319);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ != null)
         {
            _loc3_.processEvent(param1);
         }
         var_1988 = true;
      }
      
      public function triggerbottomBarResize() : void
      {
         bottomBarResizeHandler(new FriendBarResizeEvent());
      }
      
      private function bottomBarResizeHandler(param1:FriendBarResizeEvent) : void
      {
         var _loc2_:String = getRoomIdentifier(_roomEngine.activeRoomId);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ != null)
         {
            _loc3_.processEvent(param1);
         }
      }
      
      private function interstitialNotAvailableEventHandler(param1:InterstitialEvent) : void
      {
         var_1988 = false;
      }
      
      private function interstitialCompleteEventHandler(param1:InterstitialEvent) : void
      {
         var _loc4_:IRoomSession = null;
         var_1988 = false;
         if(param1.status == "complete")
         {
            _communication.connection.send(new class_168());
         }
         var _loc2_:String = getRoomIdentifier(var_3319);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ != null)
         {
            _loc3_.processEvent(param1);
            if((_loc4_ = _roomSessionManager.getSession(_roomEngine.activeRoomId)) != null)
            {
               _loc4_.sendChangePostureMessage(0);
            }
         }
      }
      
      private function adEventHandler(param1:AdEvent) : void
      {
         var _loc2_:String = getRoomIdentifier(param1.roomId);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ != null)
         {
            _loc3_.processEvent(param1);
         }
      }
      
      private function onPerkAllowances(param1:class_828) : void
      {
         var _loc3_:Timer = null;
         var _loc2_:String = null;
         var _loc4_:RoomDesktop = null;
         if(_freeFlowChat && !_freeFlowChat.isDisabledInPreferences && _isInRoom && !var_3851)
         {
            _loc3_ = new Timer(250,1);
            _loc3_.addEventListener("timerComplete",delayedAddToStageFreeFlowChat);
            _loc3_.start();
         }
         if(_isInRoom)
         {
            _loc2_ = getRoomIdentifier(_roomEngine.activeRoomId);
            if((_loc4_ = getDesktop(_loc2_) as RoomDesktop) != null)
            {
               _loc4_.processEvent(new RoomDesktopMouseZoomEnableEvent(param1.getParser().isPerkAllowed("MOUSE_ZOOM")));
            }
         }
      }
      
      private function delayedAddToStageFreeFlowChat(param1:TimerEvent) : void
      {
         var _loc2_:RoomDesktop = getDesktop(getRoomIdentifier(_roomEngine.activeRoomId)) as RoomDesktop;
         if(_loc2_ && _freeFlowChat.displayObject)
         {
            _loc2_.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
            var_3851 = true;
         }
      }
      
      private function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:RoomDesktop = null;
         var _loc4_:IRoomSession = null;
         if(param1.type == "REE_GAME_MODE" || param1.type == "REE_NORMAL_MODE")
         {
            _loc2_ = getRoomIdentifier(param1.roomId);
            _loc3_ = getDesktop(_loc2_) as RoomDesktop;
            if(_loc3_ != null)
            {
               _loc3_.roomEngineEventHandler(param1);
            }
         }
         if(param1.roomId == var_3319)
         {
            if(param1.type == "REE_OBJECTS_INITIALIZED")
            {
               if(var_1988 == true)
               {
                  if((_loc4_ = _roomSessionManager.getSession(var_3319)) != null)
                  {
                     _loc4_.sendAvatarExpressionMessage(AvatarExpressionEnum.const_423.ordinal);
                  }
               }
               var_1988 = false;
            }
            else if(param1.type == "REE_DISPOSED")
            {
               var_1988 = false;
            }
         }
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc5_:IRoomSession = null;
         var _loc6_:RoomEngineRoomColorEvent = null;
         var _loc3_:RoomEngineZoomEvent = null;
         var _loc7_:RoomEngineHSLColorEnableEvent = null;
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId);
         var _loc4_:RoomDesktop;
         if((_loc4_ = getDesktop(_loc2_) as RoomDesktop) == null)
         {
            if(_roomSessionManager == null)
            {
               return;
            }
            if((_loc5_ = _roomSessionManager.getSession(param1.roomId)) != null)
            {
               _loc4_ = createDesktop(_loc5_) as RoomDesktop;
            }
         }
         if(_loc4_ == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "REE_INITIALIZED":
               _loc4_.createRoomView(getActiveCanvasId(param1.roomId));
               if(_roomEngine != null && !RoomId.isRoomPreviewerId(param1.roomId))
               {
                  _roomEngine.setActiveRoom(param1.roomId);
               }
               _loc4_.createWidget("RWE_CHAT_WIDGET");
               if(_freeFlowChat && !_freeFlowChat.isDisabledInPreferences)
               {
                  var_3851 = true;
                  if(_freeFlowChat.displayObject != null)
                  {
                     _loc4_.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
                  }
               }
               _loc4_.createWidget("RWE_INFOSTAND");
               _loc4_.createWidget("RWE_LOCATION_WIDGET");
               _loc4_.createWidget("RWE_ROOM_TOOLS");
               if(!_loc4_.session.isSpectatorMode)
               {
                  _loc4_.createWidget("RWE_ME_MENU");
                  _loc4_.createWidget("RWE_CHAT_INPUT_WIDGET");
                  _loc4_.createWidget("RWE_FRIEND_REQUEST");
                  if(getBoolean("avatar.widget.enabled"))
                  {
                     _loc4_.createWidget("RWE_AVATAR_INFO");
                  }
               }
               _loc4_.createWidget("RWE_FURNI_PLACEHOLDER");
               _loc4_.createWidget("RWE_FURNI_CREDIT_WIDGET");
               _loc4_.createWidget("RWE_FURNI_STICKIE_WIDGET");
               _loc4_.createWidget("RWE_FURNI_PRESENT_WIDGET");
               _loc4_.createWidget("RWE_FURNI_TROPHY_WIDGET");
               _loc4_.createWidget("RWE_FURNI_ECOTRONBOX_WIDGET");
               _loc4_.createWidget("RWE_FURNI_PET_PACKAGE_WIDGET");
               _loc4_.createWidget("RWE_DOORBELL");
               _loc4_.createWidget("RWE_ROOM_POLL");
               _loc4_.createWidget("RWE_ROOM_DIMMER");
               _loc4_.createWidget("RWE_CLOTHING_CHANGE");
               _loc4_.createWidget("RWE_CONVERSION_TRACKING");
               if(!getBoolean("memenu.effects.widget.disabled"))
               {
                  _loc4_.createWidget("RWE_EFFECTS");
               }
               _loc4_.createWidget("RWE_MANNEQUIN");
               _loc4_.createWidget("RWE_ROOM_BACKGROUND_COLOR");
               _loc4_.createWidget("RWE_AREA_HIDE");
               _loc4_.createWidget("RWE_CUSTOM_USER_NOTIFICATION");
               _loc4_.createWidget("RWE_FURNI_CHOOSER");
               _loc4_.createWidget("RWE_USER_CHOOSER");
               if(var_4057 != -1)
               {
                  _loc4_.initializeWidget("RWE_USER_CHOOSER",var_4057);
               }
               _loc4_.createWidget("RWE_PLAYLIST_EDITOR_WIDGET");
               _loc4_.createWidget("RWE_SPAMWALL_POSTIT_WIDGET");
               _loc4_.createWidget("RWE_FURNITURE_CONTEXT_MENU");
               _loc4_.createWidget("RWE_CAMERA");
               _loc4_.createWidget("RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING");
               _loc4_.createWidget("RWE_FRIEND_FURNI_CONFIRM");
               _loc4_.createWidget("RWE_FRIEND_FURNI_ENGRAVING");
               _loc4_.createWidget("RWE_HIGH_SCORE_DISPLAY");
               _loc4_.createWidget("RWE_INTERNAL_LINK");
               _loc4_.createWidget("RWE_CUSTOM_STACK_HEIGHT");
               _loc4_.createWidget("RWE_YOUTUBE");
               _loc4_.createWidget("RWE_RENTABLESPACE");
               _loc4_.createWidget("RWE_VIMEO");
               _loc4_.createWidget("RWE_EXTERNAL_IMAGE");
               _loc4_.createWidget("RWE_UI_HELP_BUBBLE");
               _loc4_.createWidget("RWE_WORD_QUIZZ");
               _loc4_.createWidget("RWE_ROOM_THUMBNAIL_CAMERA");
               _loc4_.createWidget("RWE_ROOM_LINK");
               _loc4_.createWidget("RWE_CRAFTING");
               _isInRoom = true;
               break;
            case "REE_ENTRANCE_AFTER_SPECTATE":
               _loc4_.enterAfterSpectate();
               _loc4_.disposeWidget("RWE_ROOM_QUEUE");
               _loc4_.createWidget("RWE_ME_MENU");
               _loc4_.createWidget("RWE_CHAT_INPUT_WIDGET");
               _loc4_.createWidget("RWE_FRIEND_REQUEST");
               if(getBoolean("avatar.widget.enabled"))
               {
                  _loc4_.createWidget("RWE_AVATAR_INFO");
               }
               break;
            case "REE_DISPOSED":
               disposeDesktop(_loc2_);
               _isInRoom = false;
               break;
            case "REE_ROOM_COLOR":
               if((_loc6_ = param1 as RoomEngineRoomColorEvent) != null)
               {
                  if(_loc6_.bgOnly)
                  {
                     _loc4_.setRoomViewColor(16777215,255);
                  }
                  else
                  {
                     _loc4_.setRoomViewColor(_loc6_.color,_loc6_.brightness);
                  }
               }
               break;
            case "REE_ROOM_ZOOM":
               _loc3_ = param1 as RoomEngineZoomEvent;
               if(_loc3_ != null)
               {
                  _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId,getActiveCanvasId(_roomEngine.activeRoomId),_loc3_.level < 1 ? 0.5 : 1 << Math.floor(_loc3_.level) - 1,null,null,_loc3_.isFlipForced);
               }
               break;
            case "REDSE_ROOM_COLOR":
               _loc4_.processEvent(param1);
               break;
            case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
               if(!(_loc7_ = RoomEngineHSLColorEnableEvent(param1)).enable)
               {
                  _loc4_.setRoomBackgroundColor(0,0,0);
               }
               else
               {
                  _loc4_.setRoomBackgroundColor(_loc7_.hue,_loc7_.saturation,_loc7_.lightness);
               }
         }
      }
      
      private function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId);
         var _loc3_:RoomDesktop = getDesktop(_loc2_) as RoomDesktop;
         if(_loc3_ != null)
         {
            _loc3_.roomObjectEventHandler(param1);
         }
      }
      
      private function gameEventHandler(param1:Event) : void
      {
         var _loc2_:RoomDesktop = getDesktop(getRoomIdentifier(0)) as RoomDesktop;
         if(_loc2_)
         {
            _loc2_.processEvent(param1);
         }
      }
      
      public function createDesktop(param1:IRoomSession) : IRoomDesktop
      {
         if(param1 == null)
         {
            return null;
         }
         if(_roomEngine == null)
         {
            return null;
         }
         var _loc3_:String = getRoomIdentifier(param1.roomId);
         var _loc2_:RoomDesktop = getDesktop(_loc3_) as RoomDesktop;
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = new RoomDesktop(param1,assets,_communication.connection);
         _loc2_.roomEngine = _roomEngine;
         _loc2_.windowManager = _windowManager;
         _loc2_.roomWidgetFactory = var_3132;
         _loc2_.sessionDataManager = _sessionDataManager;
         _loc2_.roomSessionManager = _roomSessionManager;
         _loc2_.communicationManager = _communication;
         _loc2_.friendList = _friendList;
         _loc2_.avatarRenderManager = _avatarRenderManager;
         _loc2_.inventory = _inventory;
         _loc2_.messenger = _messenger;
         _loc2_.toolbar = _toolbar;
         _loc2_.navigator = _newNavigator.legacyNavigator;
         _loc2_.habboGroupsManager = _habboGroupsManager;
         _loc2_.avatarEditor = _avatarEditor;
         _loc2_.catalog = _catalog;
         _loc2_.adManager = _adManager;
         _loc2_.localization = _localization;
         _loc2_.habboHelp = _habboHelp;
         _loc2_.moderation = _moderation;
         _loc2_.config = this;
         _loc2_.soundManager = _soundManager;
         _loc2_.habboTracking = _habboTracking;
         _loc2_.userDefinedRoomEvents = _userDefinedRoomEvents;
         _loc2_.gameManager = _gameManager;
         _loc2_.questEngine = _questEngine;
         _loc2_.freeFlowChat = _freeFlowChat;
         var _loc4_:XmlAsset;
         if((_loc4_ = assets.getAssetByName("room_desktop_layout_xml") as XmlAsset) != null)
         {
            _loc2_.layout = _loc4_.content as XML;
         }
         _loc2_.createWidget("RWE_LOADINGBAR");
         _loc2_.createWidget("RWE_ROOM_QUEUE");
         _loc2_.init();
         _loc2_.requestInterstitial();
         var_1988 = false;
         var_3319 = param1.roomId;
         var_1849.add(_loc3_,_loc2_);
         return _loc2_;
      }
      
      public function get chatContainer() : class_3431
      {
         var _loc1_:RoomDesktop = getDesktop(getRoomIdentifier(_roomEngine.activeRoomId)) as RoomDesktop;
         if(!_loc1_ || !_loc1_.layoutManager)
         {
            return null;
         }
         return _loc1_.layoutManager.getChatContainer();
      }
      
      public function disposeDesktop(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:RoomDesktop = var_1849.remove(param1) as RoomDesktop;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getWidgetState("RWE_USER_CHOOSER");
            if(_loc2_ != -1)
            {
               var_4057 = _loc2_;
            }
            _loc3_.dispose();
            var_1988 = false;
         }
      }
      
      public function getDesktop(param1:String) : IRoomDesktop
      {
         return var_1849.getValue(param1) as RoomDesktop;
      }
      
      public function getActiveCanvasId(param1:int) : int
      {
         return 1;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc2_:RoomDesktop = null;
         _loc3_ = 0;
         while(_loc3_ < var_1849.length)
         {
            _loc2_ = var_1849.getWithIndex(_loc3_) as RoomDesktop;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc3_++;
         }
      }
      
      private function getRoomIdentifier(param1:int) : String
      {
         return "hard_coded_room_id";
      }
      
      public function set visible(param1:Boolean) : void
      {
         var _loc2_:RoomDesktop = var_1849.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function hideWidget(param1:String) : void
      {
         var _loc2_:RoomDesktop = var_1849.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
         if(_loc2_ != null)
         {
            _loc2_.processEvent(new HideRoomWidgetEvent(param1));
         }
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:RoomDesktop;
         if((_loc5_ = var_1849.getValue(getRoomIdentifier(_roomEngine.activeRoomId))) != null)
         {
            _loc5_.showGamePlayerName(param1,param2,param3,param4);
         }
      }
      
      public function mouseEventPositionHasContextMenu(param1:MouseEvent) : Boolean
      {
         var _loc2_:RoomDesktop = var_1849.getValue(getRoomIdentifier(_roomEngine.activeRoomId));
         if(_loc2_ != null)
         {
            return _loc2_.mouseEventPositionHasInputEventWindow(param1,0);
         }
         return false;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get inventory() : class_1814
      {
         return _inventory;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function get habboGroupsManager() : class_1880
      {
         return _habboGroupsManager;
      }
      
      public function get friendBarView() : IHabboFriendBarView
      {
         return _friendBarView;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get chatStyleLibrary() : class_3511
      {
         if(_freeFlowChat)
         {
            return _freeFlowChat.chatStyleLibrary;
         }
         return null;
      }
      
      public function get freeFlowChat() : class_1809
      {
         return _freeFlowChat;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
   }
}
