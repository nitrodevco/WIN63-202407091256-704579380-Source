package com.sulake.habbo.toolbar
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.CoreComponentContext;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.Motion;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.campaign.HabboCampaigns;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.catalog.purse.PurseEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.freeflowchat.class_1809;
   import com.sulake.habbo.friendbar.groupforums.UnseenForumsCountUpdatedEvent;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.inventory.events.HabboUnseenItemsUpdatedEvent;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.messenger.events.MiniMailMessageEvent;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.nux.HabboNuxDialogs;
   import com.sulake.habbo.phonenumber.HabboPhoneNumber;
   import com.sulake.habbo.quest.class_2197;
   import com.sulake.habbo.quest.events.UnseenAchievementsCountUpdateEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.toolbar.extensions.CitizenshipVipDiscountPromoExtension;
   import com.sulake.habbo.toolbar.extensions.CitizenshipVipQuestsPromoExtension;
   import com.sulake.habbo.toolbar.extensions.ClubDiscountPromoExtension;
   import com.sulake.habbo.toolbar.extensions.PurseAreaExtension;
   import com.sulake.habbo.toolbar.extensions.SettingsExtension;
   import com.sulake.habbo.toolbar.extensions.VideoOfferExtension;
   import com.sulake.habbo.toolbar.extensions.purse.indicators.SeasonalCurrencyIndicator;
   import com.sulake.habbo.toolbar.offers.OfferExtension;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDCoreLocalizationManager;
   import com.sulake.iid.IIDHabboCampaigns;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboGroupForumController;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboMessenger;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboNuxDialogs;
   import com.sulake.iid.IIDHabboPhoneNumber;
   import com.sulake.iid.IIDHabboQuestEngine;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboUserDefinedRoomEvents;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.room.utils.RoomEnterEffect;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.class_955;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_143;
   
   public class HabboToolbar extends Component implements IHabboToolbar
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var var_1631:BottomBarLeft;
      
      private var var_4915:BottomBackgroundBorder;
      
      private var var_1618:Boolean;
      
      private var var_2095:PurseAreaExtension;
      
      private var var_2555:SettingsExtension;
      
      private var var_26:IConnection;
      
      private var _catalog:IHabboCatalog;
      
      private var _messenger:IHabboMessenger;
      
      private var _navigator:IHabboNavigator;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _roomEvents:IHabboUserDefinedRoomEvents;
      
      private var var_4198:SeasonalCurrencyIndicator;
      
      private var var_2943:ClubDiscountPromoExtension;
      
      private var var_3426:CitizenshipVipQuestsPromoExtension;
      
      private var var_2934:CitizenshipVipDiscountPromoExtension;
      
      private var var_2689:VideoOfferExtension;
      
      private var _localization:ICoreLocalizationManager;
      
      private var _inventory:class_1814;
      
      private var var_1945:ExtensionView;
      
      private var _soundManager:class_2240;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _questEngine:class_2197;
      
      private var _freeFlowChat:class_1809;
      
      private var _roomUI:IRoomUI;
      
      private var _offerExtension:OfferExtension;
      
      private var var_2124:Timer;
      
      private var var_2513:Timer;
      
      private var var_2464:Timer;
      
      public function HabboToolbar(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         param1.attachComponent(new HabboPhoneNumber(param1,0,param3),[new IIDHabboPhoneNumber()]);
         param1.attachComponent(new HabboNuxDialogs(param1,0,param3),[new IIDHabboNuxDialogs()]);
         param1.attachComponent(new HabboCampaigns(param1,0,param3),[new IIDHabboCampaigns()]);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         },true),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },true,[{
            "type":"CATALOG_INITIALIZED",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NOT_READY",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NEW_ITEMS_SHOW",
            "callback":onCatalogEvent
         },{
            "type":"CATALOG_NEW_ITEMS_HIDE",
            "callback":onCatalogEvent
         }]),new ComponentDependency(new IIDCoreLocalizationManager(),function(param1:ICoreLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_1814):void
         {
            _inventory = param1;
         },false,[{
            "type":"HUIUE_UNSEEN_ITEMS_CHANGED",
            "callback":onUnseenItemsUpdate
         },{
            "type":"HIHCE_HABBO_CLUB_CHANGED",
            "callback":onClubChanged
         }]),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_2240):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },true,[{
            "type":"PUE_perks_updated",
            "callback":onPerksUpdated
         }]),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         },false),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_1809):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_2197):void
         {
            _questEngine = param1;
         },false,[{
            "type":"qe_uacue",
            "callback":onUnseenAchievementsCountUpdate
         }]),new ComponentDependency(new IIDHabboMessenger(),function(param1:IHabboMessenger):void
         {
            _messenger = param1;
         },false,[{
            "type":"MMME_new",
            "callback":onMiniMailUpdate
         },{
            "type":"MMME_unread",
            "callback":onMiniMailUpdate
         },{
            "type":"HUIUE_UNSEEN_ITEMS_CHANGED",
            "callback":onUnseenItemsUpdate
         }]),new ComponentDependency(new IIDHabboGroupForumController(),null,false,[{
            "type":"UNSEEN_FORUMS_COUNT",
            "callback":onUnseenForumsCountUpdate
         }]),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         },false),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _roomEvents = param1;
         },false,[{
            "type":"WIRED_MENU_BUTTON_PREFERENCE_CHANGED",
            "callback":onWiredMenuEvent
         }])]);
      }
      
      override public function dispose() : void
      {
         var_1618 = false;
         var_26 = null;
         destroyClientPromoTimer();
         destroyDimmerTimer();
         destroyOwnRoomPromoTimer();
         if(var_1945)
         {
            var_1945.dispose();
            var_1945 = null;
         }
         if(var_2095)
         {
            var_2095.dispose();
            var_2095 = null;
         }
         if(var_2555)
         {
            var_2555.dispose();
            var_2555 = null;
         }
         if(_offerExtension != null)
         {
            _offerExtension.dispose();
            _offerExtension = null;
         }
         if(var_2943)
         {
            var_2943.dispose();
            var_2943 = null;
         }
         if(var_3426)
         {
            var_3426.dispose();
            var_3426 = null;
         }
         if(var_2934)
         {
            var_2934.dispose();
            var_2934 = null;
         }
         if(var_2689)
         {
            var_2689.dispose();
            var_2689 = null;
         }
         if(_messenger != null)
         {
            if(_messenger.events)
            {
               _messenger.events.removeEventListener("MMME_new",onMiniMailUpdate);
               _messenger.events.removeEventListener("MMME_unread",onMiniMailUpdate);
            }
            _messenger = null;
         }
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         super.dispose();
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
      }
      
      override protected function initComponent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var_26 = _communicationManager.connection;
         _communicationManager.addHabboConnectionMessageEvent(new class_143(onUserRights));
         var_4915 = new BottomBackgroundBorder(this);
         var_1631 = new BottomBarLeft(this,_windowManager,assets,events);
         var_1631.window.visible = false;
         initRoomEnterEffect();
         var_1945 = new ExtensionView(_windowManager,assets,this);
         if(var_1631 == null)
         {
            class_14.log("Error, toolbar view was not available");
            return;
         }
         var _loc3_:String = getProperty("new.user.wing");
         if(_loc3_ != "")
         {
            _loc1_ = getInteger("new.user.promo.delay",10) * 1000;
            if(_loc1_ > 0 && var_2513 == null)
            {
               var_2513 = new Timer(_loc1_,1);
               var_2513.addEventListener("timerComplete",onShowClientPromo);
               var_2513.start();
            }
            if(_loc3_ == "social" || _loc3_ == "quest" || _loc3_ == "group" || _loc3_ == "game")
            {
               _loc2_ = getInteger("new.user.promo.room.delay",180) * 1000;
               if(_loc2_ > 0 && var_2464 == null)
               {
                  var_2464 = new Timer(_loc2_,1);
                  var_2464.addEventListener("timerComplete",onShowOwnRoomPromo);
                  var_2464.start();
               }
            }
         }
      }
      
      private function onPerksUpdated(param1:PerksUpdatedEvent) : void
      {
         if(var_1945 && !var_1618)
         {
            initPurseAreaExtension();
            initSeasonalCurrencyExtension();
            initVipExtendExtension();
            initCitizenshipVipExtendExtension();
            initCitizenshipVipQuestsExtension();
            initVideoOfferExtension();
            initOfferExtension();
            initSettingsExtension();
            var_1618 = true;
         }
      }
      
      private function onCatalogEvent(param1:CatalogEvent) : void
      {
         if(var_1631)
         {
            var_1631.onCatalogEvent(param1);
         }
      }
      
      private function onWiredMenuEvent(param1:WiredMenuEvent) : void
      {
         if(var_1631)
         {
            var_1631.onWiredMenuEvent(param1);
         }
      }
      
      private function onUserRights(param1:IMessageEvent) : void
      {
         if(!var_2689)
         {
            initVideoOfferExtension();
         }
      }
      
      private function onShowClientPromo(param1:TimerEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         destroyClientPromoTimer();
         var _loc5_:String = getProperty("new.user.wing");
         var _loc4_:int = 0;
         var _loc6_:String = null;
         switch(_loc5_)
         {
            case "social":
               _loc3_ = "new.user.promo.social";
               _loc2_ = "HTIE_ICON_NAVIGATOR";
               _loc6_ = "NAVIGATOR";
               break;
            case "group":
               _loc3_ = "new.user.promo.group";
               _loc2_ = "HTIE_EXT_GROUP";
               _loc4_ = 1;
               break;
            case "quest":
               _loc3_ = "new.user.promo.quest";
               _loc2_ = "HTIE_ICON_QUESTS";
               _loc6_ = "QUESTS";
               break;
            case "game":
               _loc3_ = "new.user.promo.game";
               _loc2_ = "HTIE_ICON_GAMES";
               _loc6_ = "GAMES";
               break;
            default:
               return;
         }
         if(getIconLocation(_loc2_) != null)
         {
            _habboHelp.showWelcomeScreen(_loc2_,_loc3_,_loc4_,_loc6_);
         }
      }
      
      private function onShowOwnRoomPromo(param1:TimerEvent) : void
      {
         destroyOwnRoomPromoTimer();
         _habboHelp.showWelcomeScreen("HTIE_ICON_NAVIGATOR","new.user.promo.room",0,"NAVIGATOR_ME_TAB");
      }
      
      private function initRoomEnterEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!isNewIdentity())
         {
            return;
         }
         if(getBoolean("room.enter.effect.enabled"))
         {
            _loc1_ = getInteger("room.enter.effect.delay",4000);
            _loc2_ = getInteger("room.enter.effect.duration",2000);
            RoomEnterEffect.init(_loc1_,_loc2_);
            createAndAttachDimmerWindow(IWindowContainer(var_1631.window));
            if(var_2124 == null)
            {
               var_2124 = new Timer(_loc1_ + _loc2_,1);
               var_2124.addEventListener("timerComplete",onRemoveDimmer);
               var_2124.start();
            }
         }
      }
      
      private function initPurseAreaExtension() : void
      {
         var_2095 = new PurseAreaExtension(this,_catalog);
         var_2095.getClubArea().onClubChanged();
      }
      
      private function initSettingsExtension() : void
      {
         var_2555 = new SettingsExtension(this);
      }
      
      private function initSeasonalCurrencyExtension() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PurseEvent = null;
         if(getBoolean("seasonalcurrencyindicator.enabled"))
         {
            var_4198 = new SeasonalCurrencyIndicator(this,_windowManager,assets,_catalog,_localization);
            _loc1_ = var_4198.displayedActivityPointType;
            _loc2_ = new PurseEvent("catalog_purse_activity_point_balance",_catalog.getPurse().getActivityPointsForType(_loc1_),_loc1_);
            var_4198.onBalance(_loc2_);
         }
      }
      
      private function initVipExtendExtension() : void
      {
         if(getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            var_2943 = new ClubDiscountPromoExtension(this);
         }
      }
      
      private function initCitizenshipVipQuestsExtension() : void
      {
         if(getBoolean("citizenship.vip.quest.promotion.enabled"))
         {
            var_3426 = new CitizenshipVipQuestsPromoExtension(this,_windowManager,assets,events,_localization,var_26);
         }
      }
      
      private function initCitizenshipVipExtendExtension() : void
      {
         if(getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            var_2934 = new CitizenshipVipDiscountPromoExtension(this);
         }
      }
      
      private function initVideoOfferExtension() : void
      {
         var _loc1_:Boolean = !isNewIdentity() || !getBoolean("new.identity.hide.ui");
         if(_catalog.videoOffers.enabled && getBoolean("toolbar.extension.video.promo.enabled") && _loc1_)
         {
            var_2689 = new VideoOfferExtension(this);
         }
      }
      
      private function initOfferExtension() : void
      {
         var _loc1_:Boolean = !isNewIdentity() || !getBoolean("new.identity.hide.ui");
         if(getBoolean("offers.enabled") && _loc1_ && !getBoolean("offers.habboclub.enabled"))
         {
            _offerExtension = new OfferExtension(this,_windowManager,assets,_catalog);
         }
      }
      
      public function toggleSettingVisibility() : void
      {
         if(var_2555 && var_2555.window)
         {
            var_2555.window.visible = !var_2555.window.visible;
         }
         extensionView.refreshItemWindow();
      }
      
      private function onRemoveDimmer(param1:TimerEvent) : void
      {
         destroyDimmerTimer();
         if(var_1631)
         {
            removeDimmer(var_1631.window as IWindowContainer);
         }
         if(var_1945)
         {
            var_1945.removeDimmers();
         }
      }
      
      public function createAndAttachDimmerWindow(param1:IWindowContainer) : void
      {
         var _loc2_:IWindow = null;
         if(RoomEnterEffect.isRunning())
         {
            if(param1 == null)
            {
               return;
            }
            _loc2_ = _windowManager.createWindow("toolbar_dimmer","",30,1,128 | 2048 | 1,new Rectangle(0,0,param1.width,param1.height),null,0);
            _loc2_.color = 0;
            _loc2_.blend = 0.3;
            param1.addChild(_loc2_);
            param1.invalidate();
         }
      }
      
      public function removeDimmer(param1:IWindowContainer) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IWindow = param1.findChildByName("toolbar_dimmer");
         if(_loc2_ != null)
         {
            param1.removeChild(_loc2_);
            param1.invalidate();
            _windowManager.destroy(_loc2_);
         }
      }
      
      public function toggleWindowVisibility(param1:String) : void
      {
         var _loc4_:HabboToolbarEvent = null;
         var _loc5_:HabboToolbarEvent = null;
         var _loc2_:String = String(HabboToolbarIconEnum[param1]);
         if(_loc2_ == "HTIE_ICON_CAMERA")
         {
            (_loc4_ = new HabboToolbarEvent("HTE_ICON_CAMERA")).iconName = "toolBarCameraIcon";
            events.dispatchEvent(_loc4_);
         }
         else
         {
            (_loc5_ = new HabboToolbarEvent("HTE_TOOLBAR_CLICK")).iconId = _loc2_;
            _loc5_.iconName = param1;
            events.dispatchEvent(_loc5_);
         }
         var _loc3_:class_955 = new class_955("Toolbar",param1,"client.toolbar.clicked");
         if(var_26)
         {
            var_26.send(_loc3_);
         }
      }
      
      public function getIconLocation(param1:String) : Rectangle
      {
         var _loc2_:Rectangle = null;
         if(param1 == "HTIE_EXT_GROUP")
         {
            _loc2_ = var_1945.getIconLocation(param1);
         }
         else if(var_1631)
         {
            _loc2_ = var_1631.getIconLocation(param1);
         }
         if(!_loc2_ && var_2095)
         {
            _loc2_ = var_2095.getIconLocation(param1);
         }
         return _loc2_;
      }
      
      public function getIcon(param1:String) : IWindow
      {
         var _loc2_:IWindow = null;
         if(param1 == "HTIE_EXT_GROUP")
         {
            _loc2_ = var_1945.getIcon(param1);
         }
         else if(var_1631)
         {
            _loc2_ = var_1631.geIcon(param1);
            if(_loc2_ as IStaticBitmapWrapperWindow)
            {
               _loc2_ = _loc2_.parent;
            }
         }
         if(!_loc2_ && var_2095)
         {
            _loc2_ = var_2095.getIcon(param1);
         }
         return _loc2_;
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         if(var_1631)
         {
            var_1631.setUnseenItemCount(param1,param2);
         }
      }
      
      public function setToolbarState(param1:String) : void
      {
         switch(param1)
         {
            case "HTE_STATE_HOTEL_VIEW":
            case "HTE_STATE_GAME_CENTER_VIEW":
               showExtensions(true);
               break;
            case "HTE_STATE_ROOM_VIEW":
               showExtensions(true);
               break;
            case "HTE_STATE_HIDDEN":
               showExtensions(false);
         }
         if(var_1945 != null)
         {
            var_1945.landingView = param1 == "HTE_STATE_HOTEL_VIEW";
         }
         if(var_1631)
         {
            var_1631.setToolbarState(param1);
            var_1631.window.visible = true;
         }
         if(_habboHelp != null)
         {
            _habboHelp.outsideRoom = param1 != "HTE_STATE_ROOM_VIEW";
         }
         var _loc2_:HabboToolbarEvent = new HabboToolbarEvent("HTE_RESIZED");
         events.dispatchEvent(_loc2_);
      }
      
      private function showExtensions(param1:Boolean) : void
      {
         if(var_1945)
         {
            var_1945.visible = param1;
         }
      }
      
      public function setIconBitmap(param1:String, param2:BitmapData) : void
      {
         var _loc3_:BitmapData = null;
         if(param2 != null)
         {
            _loc3_ = param2.clone();
         }
         if(var_1631)
         {
            var_1631.setIconBitmap(param1,param2);
         }
      }
      
      public function getRect() : Rectangle
      {
         if(var_1631)
         {
            return var_1631.window.rectangle;
         }
         return new Rectangle();
      }
      
      public function get extensionView() : IExtensionView
      {
         return var_1945;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function createTransitionToIcon(param1:String, param2:BitmapData, param3:int, param4:int) : Motion
      {
         if(var_1631 && !var_1631.disposed)
         {
            return var_1631.animateToIcon(param1,param2,param3,param4);
         }
         param2.dispose();
         return null;
      }
      
      public function isXmasEnabled() : Boolean
      {
         return getBoolean("xmas11.enabled");
      }
      
      public function isValentinesEnabled() : Boolean
      {
         return getBoolean("valentines.enabled");
      }
      
      public function isNewIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function setIconVisibility(param1:String, param2:Boolean) : void
      {
         if(var_1631)
         {
            var_1631.iconVisibility(param1,param2);
         }
      }
      
      private function destroyDimmerTimer() : void
      {
         if(var_2124)
         {
            var_2124.removeEventListener("timerComplete",onRemoveDimmer);
            var_2124.stop();
            var_2124 = null;
         }
      }
      
      private function destroyClientPromoTimer() : void
      {
         if(var_2513)
         {
            var_2513.removeEventListener("timerComplete",onShowClientPromo);
            var_2513.stop();
            var_2513 = null;
         }
      }
      
      private function destroyOwnRoomPromoTimer() : void
      {
         if(var_2464)
         {
            var_2464.removeEventListener("timerComplete",onShowOwnRoomPromo);
            var_2464.stop();
            var_2464 = null;
         }
      }
      
      private function onMiniMailUpdate(param1:MiniMailMessageEvent) : void
      {
         if(!_messenger || !var_1631)
         {
            return;
         }
         if(var_1631 != null)
         {
            var_1631.unseenMiniMailMessageCount = _messenger.getUnseenMiniMailMessageCount();
            var_1631.memenu.unseenMinimailsCount = _messenger.getUnseenMiniMailMessageCount();
            setUnseenItemCount("HTIE_ICON_MEMENU",var_1631.unseenMeMenuCount);
         }
      }
      
      private function onUnseenAchievementsCountUpdate(param1:UnseenAchievementsCountUpdateEvent) : void
      {
         if(var_1631 != null)
         {
            var_1631.unseenAchievementCount = param1.count;
            var_1631.memenu.unseenAchievementsCount = param1.count;
            setUnseenItemCount("HTIE_ICON_MEMENU",var_1631.unseenMeMenuCount);
         }
      }
      
      private function onUnseenForumsCountUpdate(param1:UnseenForumsCountUpdatedEvent) : void
      {
         if(var_1631 != null)
         {
            var_1631.unseenForumsCount = param1.unseenForumsCount;
            var_1631.memenu.unseenForumsCount = param1.unseenForumsCount;
            setUnseenItemCount("HTIE_ICON_MEMENU",var_1631.unseenMeMenuCount);
         }
      }
      
      public function set onDuty(param1:Boolean) : void
      {
         if(var_1631 != null)
         {
            var_1631.onDuty = param1;
         }
      }
      
      private function onUnseenItemsUpdate(param1:HabboUnseenItemsUpdatedEvent) : void
      {
         setUnseenItemCount("HTIE_ICON_INVENTORY",param1.inventoryCount);
         setUnseenItemCount("HTIE_ICON_GAMES",param1.getCategoryCount(6));
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(var_2095 != null)
         {
            var_2095.getClubArea().onClubChanged(param1);
         }
         if(var_2934 != null)
         {
            var_2934.onClubChanged(param1);
         }
         if(var_2689 != null)
         {
            var_2689.onClubChanged(param1);
         }
         if(var_2943 != null)
         {
            var_2943.onClubChanged(param1);
         }
      }
      
      public function get toolBarAreaWidth() : int
      {
         if(var_1631)
         {
            return var_1631.getToolbarAreaWidth();
         }
         return 0;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get connection() : IConnection
      {
         return var_26;
      }
      
      public function get navigator() : IHabboNavigator
      {
         if(_newNavigator != null)
         {
            return _newNavigator.legacyNavigator;
         }
         return null;
      }
      
      public function get questEngine() : class_2197
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : class_1809
      {
         return _freeFlowChat;
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get inventory() : class_1814
      {
         return _inventory;
      }
      
      public function get localization() : ICoreLocalizationManager
      {
         return _localization;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get messenger() : IHabboMessenger
      {
         return _messenger;
      }
      
      public function get roomEvents() : IHabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function reboot() : void
      {
         (context as CoreComponentContext).reboot();
      }
   }
}
