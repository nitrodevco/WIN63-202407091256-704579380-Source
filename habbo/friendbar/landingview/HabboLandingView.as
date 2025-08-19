package com.sulake.habbo.friendbar.landingview
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.class_1881;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.friendbar.onBoardingHc.OnBoardingHcFlow;
   import com.sulake.habbo.friendbar.view.AbstractView;
   import com.sulake.habbo.game.class_1805;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.quest.class_2197;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboAvatarEditor;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboGameManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboQuestEngine;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDRoomEngine;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.landingview.votes.CommunityGoalVoteMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_491;
   import com.sulake.habbo.communication.messages.outgoing.room.session.class_325;
   import com.sulake.habbo.communication.messages.outgoing.navigator.ForwardToARandomPromotedRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.class_1062;
   
   public class HabboLandingView extends AbstractView implements IHabboLandingView
   {
       
      
      private var _landingViewLayout:WidgetContainerLayout;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _catalog:IHabboCatalog;
      
      private var _navigator:IHabboNavigator;
      
      private var _questEngine:class_2197;
      
      private var _toolbar:IHabboToolbar;
      
      private var _habboHelp:IHabboHelp;
      
      private var _avatarEditor:class_1881;
      
      private var _gameManager:class_1805;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _errorLayout:IWindow;
      
      private var _roomEngine:IRoomEngine;
      
      private var var_1996:OnBoardingHcFlow;
      
      private var var_1618:Boolean = false;
      
      private var var_4435:Boolean = false;
      
      public function HabboLandingView(param1:IContext, param2:uint, param3:IAssetLibrary)
      {
         super(param1,param2,param3);
      }
      
      public static function positionAfterAndStretch(param1:IWindowContainer, param2:String, param3:String) : void
      {
         var _loc5_:IWindow = param1.findChildByName(param2);
         var _loc6_:IWindow;
         var _loc4_:int = (_loc6_ = param1.findChildByName(param3)).x;
         _loc6_.x = _loc5_.x + _loc5_.width + 5;
         _loc6_.width += _loc4_ - _loc6_.x;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get navigator() : IHabboNavigator
      {
         return _navigator;
      }
      
      public function get questEngine() : class_2197
      {
         return _questEngine;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _tracking;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_2197):void
         {
            _questEngine = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_1805):void
         {
            _gameManager = param1;
         },false),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_1881):void
         {
            _avatarEditor = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },true,[{
            "type":"AVATAR_RENDER_READY",
            "callback":onAvatarRendererReady
         }]),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         })]);
      }
      
      private function onAvatarRendererReady(param1:Event = null) : void
      {
         if(isOnboardingRequired(_communicationManager.suggestedLoginActions))
         {
            var_1996 = new OnBoardingHcFlow(_avatarRenderManager,_localizationManager,_communicationManager);
            var_1996.addEventListener("NewUserFlowFinished",onNewUserReceptionFinished);
            var_1996.setHcVisibility(false);
            context.displayObjectContainer.addChild(var_1996);
            var_1996.init(_communicationManager.suggestedLoginActions);
         }
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_1618 = false;
            if(_landingViewLayout)
            {
               _landingViewLayout.dispose();
               _landingViewLayout = null;
            }
            if(var_1996)
            {
               var_1996.removeEventListener("NewUserFlowFinished",onNewUserReceptionFinished);
               var_1996.dispose();
               var_1996 = null;
            }
            if(_toolbar != null && _toolbar.events != null)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
            }
            if(_errorLayout)
            {
               _errorLayout.dispose();
               _errorLayout = null;
            }
            super.dispose();
         }
      }
      
      public function initialize() : void
      {
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:String = null;
         var_1618 = true;
         var _loc2_:class_3460 = _windowManager.getDesktop(0);
         var _loc1_:IWindow = _loc2_.getChildByName("hotel_view_welcome_window");
         if(_loc1_ != null)
         {
            _loc2_.removeChild(_loc1_);
            _loc1_.dispose();
         }
         if(newIdentity && getBoolean("landing.view.new_identity_override_enabled"))
         {
            _loc3_ = getProperty("landing.view.new_identity_widgets").split(",");
            _loc5_ = 1;
            while(_loc5_ <= 6)
            {
               _loc4_ = "landing.view.dynamic.slot." + _loc5_ + ".";
               if(_loc5_ == 1 || _loc5_ == 6)
               {
                  setProperty(_loc4_ + "widget","");
               }
               else
               {
                  setProperty(_loc4_ + "widget","widgetcontainer");
                  setProperty(_loc4_ + "conf","2001-01-01 00:00," + _loc3_[_loc5_ - 2]);
               }
               _loc5_++;
            }
            setProperty("landing.view.dynamic.leftPaneWidth","400");
            setProperty("landing.view.dynamic.rightPaneWidth","400");
         }
         _landingViewLayout = new WidgetContainerLayout(this);
         activate();
      }
      
      private function isOnboardingRequired(param1:Array) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(var_4435)
         {
            return false;
         }
         return param1.indexOf(0) >= 0 || param1.indexOf(1) >= 0;
      }
      
      public function activate() : void
      {
         if(isOnboardingRequired(_communicationManager.suggestedLoginActions))
         {
            if(_toolbar)
            {
               _toolbar.setToolbarState("HTE_STATE_HIDDEN");
            }
            return;
         }
         if(!var_1618)
         {
            tryInitialize();
         }
         if(_toolbar)
         {
            _toolbar.setToolbarState("HTE_STATE_HOTEL_VIEW");
         }
         if(_landingViewLayout != null)
         {
            _landingViewLayout.activate();
         }
         else
         {
            class_14.log("ERROR - Landing view layout is not initialized and cannot be activated - See caught errors in tryInitialize()");
         }
      }
      
      public function disable() : void
      {
         if(_landingViewLayout != null)
         {
            _landingViewLayout.disable();
            toolbarExtensionExtraMargin = false;
         }
      }
      
      public function get isLandingViewVisible() : Boolean
      {
         return _landingViewLayout != null && _landingViewLayout.window != null && Boolean(_landingViewLayout.window.visible);
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         switch(param1.iconId)
         {
            case "HTIE_ICON_RECEPTION":
               if(_roomSessionManager.getSession(-1))
               {
                  send(new class_325());
                  _roomSessionManager.disposeSession(-1);
               }
               break;
            case "HTIE_ICON_GAMES":
               if(getBoolean("game.center.enabled"))
               {
                  disable();
               }
         }
      }
      
      override protected function initComponent() : void
      {
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         _catalog.events.addEventListener("CATALOG_INVISIBLE_PAGE_VISITED",onExpiredLinkClick);
         _communicationManager.addHabboConnectionMessageEvent(new class_491(onNavigatorSettings));
      }
      
      private function onExpiredLinkClick(param1:CatalogEvent) : void
      {
         if(var_1618 && _landingViewLayout != null && _landingViewLayout.window != null && Boolean(_landingViewLayout.window.visible))
         {
            activate();
         }
      }
      
      private function onNavigatorSettings(param1:class_491) : void
      {
         if(param1.getParser().roomIdToEnter <= 0)
         {
            tryInitialize();
         }
      }
      
      private function onNewUserReceptionFinished(param1:Event) : void
      {
         var_4435 = true;
         if(var_1996)
         {
            var_1996.dispose();
            var_1996 = null;
         }
         _communicationManager.suggestedLoginActions = [];
         activate();
      }
      
      private function tryInitialize() : void
      {
         _errorLayout = getXmlWindow("initialization_error");
         _errorLayout.visible = false;
         try
         {
            initialize();
            IWindowContainer(_errorLayout.parent).removeChild(_errorLayout);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboLandingView","Landing view layout initialization failed!");
            _landingViewLayout.dispose();
            _landingViewLayout = null;
            windowManager.getDesktop(0).addChild(_errorLayout);
            _errorLayout.center();
            _errorLayout.visible = true;
            context.root.error(e.message + " Landing view initialization failed because of a Flash Error. Landing view removed and disposed!",false,e.errorID);
         }
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindow
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindow = null;
         try
         {
            _loc5_ = this.findAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            if(_loc5_ == null || _loc3_ == null)
            {
               return null;
            }
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboLandingView","Failed to build window " + param1 + "_xml!");
            throw e;
         }
         return _loc4_;
      }
      
      public function goToRoom(param1:String = null) : void
      {
         if(param1 == null)
         {
            param1 = getProperty("landing.view.roomcategory");
         }
         if(param1 != null)
         {
            send(new ForwardToARandomPromotedRoomMessageComposer(param1));
         }
      }
      
      public function getProductData(param1:String, param2:class_1812) : class_3423
      {
         if(_sessionDataManager.loadProductData(param2))
         {
            return _sessionDataManager.getProductData(param1);
         }
         return null;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function requestBadge(param1:String) : void
      {
         send(new class_1062(param1));
      }
      
      public function communityGoalVote(param1:int) : void
      {
         send(new CommunityGoalVoteMessageComposer(param1));
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function set toolbarExtensionExtraMargin(param1:Boolean) : void
      {
         if(_toolbar && _toolbar.extensionView)
         {
            _toolbar.extensionView.extraMargin = param1 ? 10 : 0;
         }
      }
      
      public function get newIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function get dynamicLayoutLeftPaneWidth() : int
      {
         return getInteger("landing.view.dynamic.leftPaneWidth",500);
      }
      
      public function get dynamicLayoutRightPaneWidth() : int
      {
         return getInteger("landing.view.dynamic.rightPaneWidth",250);
      }
      
      public function get avatarEditor() : class_1881
      {
         return _avatarEditor;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
   }
}
