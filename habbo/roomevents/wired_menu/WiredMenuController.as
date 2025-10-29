package com.sulake.habbo.roomevents.wired_menu
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.WiredVariablesSynchronizer;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfigs;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_inspection.WiredMenuInspectionTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview.WiredMenuOverviewTab;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_1577;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredPermissionsEvent;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   
   public class WiredMenuController extends Component implements ILinkEventTracker, class_3352, IDisposable
   {
       
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1631:WiredMenuView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_646:Boolean;
      
      private var var_463:Boolean;
      
      private var var_434:Boolean;
      
      private var var_611:Boolean;
      
      private var var_397:Boolean;
      
      private var var_481:int;
      
      private var var_318:Boolean = false;
      
      public function WiredMenuController(param1:HabboUserDefinedRoomEvents, param2:IContext, param3:uint = 0, param4:IAssetLibrary = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredPermissionsEvent(onWiredPermissions));
         _messageEvents.push(new AccountPreferencesEvent(onAccountPreferences));
         _messageEvents.push(new YouAreControllerMessageEvent(onControllerMessageEvent));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "wiredmenu/";
      }
      
      public function linkReceived(param1:String) : void
      {
         if(!isEnabled || !hasReadPermission)
         {
            return;
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showView();
            if(_loc2_.length >= 3)
            {
               view.selectTab(_loc2_[2]);
               if(_loc2_[2] == WiredMenuTabConfigs.TAB_INSPECTION_ID)
               {
                  routeInspectionLink(param1);
               }
               else if(_loc2_[2] == WiredMenuTabConfigs.TAB_OVERVIEW_ID)
               {
                  routeOverviewLink(param1);
               }
            }
         }
      }
      
      public function routeInspectionLink(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 5)
         {
            return;
         }
         var _loc3_:WiredMenuInspectionTab = view.activeTab as WiredMenuInspectionTab;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = parseInt(_loc2_[4]);
         if(_loc2_[3] == String(WiredInputSourcePicker.var_1736))
         {
            _loc3_.inspectFurni(_loc4_,true);
         }
         else if(_loc2_[3] == String(WiredInputSourcePicker.USER_SOURCE))
         {
            _loc3_.inspectUser(_loc4_,true);
         }
      }
      
      public function routeOverviewLink(param1:String) : void
      {
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 4)
         {
            return;
         }
         var _loc2_:WiredMenuOverviewTab = view.activeTab as WiredMenuOverviewTab;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:String = String(_loc3_[3]);
         _loc2_.jumpToVariableByName(_loc4_);
      }
      
      public function toggleView() : void
      {
         if(isShowing())
         {
            hideView();
         }
         else
         {
            showView();
         }
      }
      
      private function showView() : void
      {
         if(!isEnabled || !hasReadPermission)
         {
            return;
         }
         if(!var_1631 || var_1631.disposed)
         {
            var_1631 = new WiredMenuView(this,_windowManager);
            var_1631.initialize();
         }
         var_1631.show();
      }
      
      private function hideView() : void
      {
         if(!var_1631 || var_1631.disposed)
         {
            return;
         }
         var_1631.hide();
      }
      
      private function isShowing() : Boolean
      {
         return var_1631 != null && !var_1631.disposed && var_1631.isShowing();
      }
      
      public function get isEnabled() : Boolean
      {
         return getBoolean("wired.menu.enabled");
      }
      
      public function isRoomOwnerOrStaff() : Boolean
      {
         var _loc3_:IRoomSession = _roomEvents.roomSession;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Boolean = _sessionDataManager.hasSecurity(4);
         var _loc1_:Boolean = _roomEvents.roomSession.isRoomOwner;
         return _loc2_ || _loc1_;
      }
      
      public function get hasReadPermission() : Boolean
      {
         if(isRoomOwnerOrStaff())
         {
            return true;
         }
         return var_463;
      }
      
      public function get hasWritePermission() : Boolean
      {
         if(isRoomOwnerOrStaff())
         {
            return true;
         }
         return var_646;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:* = param1.type;
         if("REE_DISPOSED" === _loc2_)
         {
            if(var_1631 != null)
            {
               var_1631.dispose();
               var_1631 = null;
            }
         }
      }
      
      private function onWiredPermissions(param1:WiredPermissionsEvent) : void
      {
         var _loc2_:class_1577 = param1.getParser();
         var_646 = _loc2_.canModify;
         var_463 = _loc2_.canRead;
         if(var_1631 != null && !var_1631.disposed)
         {
            if(!var_463)
            {
               var_1631.dispose();
               var_1631 = null;
            }
            else
            {
               var_1631.permissionsUpdated();
            }
         }
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         var_434 = param1.getParser().wiredMenuButton;
         var_611 = param1.getParser().wiredInspectButton;
         playTestMode = param1.getParser().playTestMode;
         var_481 = param1.getParser().variableSyntaxMode;
      }
      
      private function onControllerMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:IRoomSession = roomEvents.roomSession;
         if(_loc2_ != null && var_397)
         {
            roomEvents.notifications.addItem(localizationManager.getLocalization("wiredmenu.settings.preferences.notification.playtest"),"info","icon_wired_notification_png");
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         if(param1.type != "RSE_STARTED")
         {
            return;
         }
         param1.session.playTestMode = var_397;
      }
      
      public function get wiredMenuButton() : Boolean
      {
         return var_434;
      }
      
      public function set wiredMenuButton(param1:Boolean) : void
      {
         var_434 = param1;
         roomEvents.events.dispatchEvent(new WiredMenuEvent("WIRED_MENU_BUTTON_PREFERENCE_CHANGED"));
      }
      
      public function get variableSyntaxMode() : int
      {
         return var_481;
      }
      
      public function set variableSyntaxMode(param1:int) : void
      {
         var_481 = param1;
      }
      
      public function get wiredInspectButton() : Boolean
      {
         return var_611;
      }
      
      public function set wiredInspectButton(param1:Boolean) : void
      {
         var_611 = param1;
      }
      
      public function get playTestMode() : Boolean
      {
         return var_397;
      }
      
      public function set playTestMode(param1:Boolean) : void
      {
         var _loc2_:IRoomSession = roomEvents.roomSession;
         if(_loc2_ != null)
         {
            _loc2_.playTestMode = param1;
         }
         var_397 = param1;
      }
      
      public function furniSelected(param1:int) : void
      {
         if(!isEnabled || var_1631 == null || var_1631.disposed)
         {
            return;
         }
         if(var_1631.activeTabId == WiredMenuTabConfigs.TAB_INSPECTION_ID)
         {
            (var_1631.activeTab as WiredMenuInspectionTab).inspectFurni(param1);
         }
      }
      
      public function userSelected(param1:int) : void
      {
         if(!isEnabled || var_1631 == null || var_1631.disposed)
         {
            return;
         }
         if(var_1631.activeTabId == WiredMenuTabConfigs.TAB_INSPECTION_ID)
         {
            (var_1631.activeTab as WiredMenuInspectionTab).inspectUser(param1);
         }
      }
      
      override public function dispose() : void
      {
         if(var_318)
         {
            return;
         }
         var_318 = true;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _communicationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _localizationManager = null;
         _roomEngine = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get view() : WiredMenuView
      {
         return var_1631;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function get variablesSynchronizer() : WiredVariablesSynchronizer
      {
         return _roomEvents.variablesSynchronizer;
      }
   }
}
