package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.configuration.enum.HabboComponentFlags;
   import com.sulake.habbo.friendbar.IHabboFriendBar;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendBar;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1762;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746;
   
   public class ModerationManager extends Component implements IHabboModeration
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _navigator:IHabboNavigator;
      
      private var _soundManager:class_2240;
      
      private var _tracking:IHabboTracking;
      
      private var _friendBar:IHabboFriendBar;
      
      private var var_4740:ModerationMessageHandler;
      
      private var var_3118:IssueManager;
      
      private var var_2888:StartPanelCtrl;
      
      private var var_4848:WindowTracker;
      
      private var _initMsg:class_1762;
      
      private var var_4855:int;
      
      public function ModerationManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_2888 = new StartPanelCtrl(this);
         var_4848 = new WindowTracker();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_2240):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            class_3472.setLocalizationManager(param1);
         }),new ComponentDependency(new IIDHabboFriendBar(),function(param1:IHabboFriendBar):void
         {
            _friendBar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(HabboComponentFlags.isRoomViewerMode(flags))
         {
            return;
         }
         var_4740 = new ModerationMessageHandler(this);
         var_3118 = new IssueManager(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_2888 != null)
         {
            var_2888.dispose();
            var_2888 = null;
         }
         super.dispose();
      }
      
      public function userSelected(param1:int, param2:String) : void
      {
         class_14.log("USER SELECTED: " + param1 + ", " + param2);
         this.var_2888.userSelected(param1,param2);
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get issueManager() : IssueManager
      {
         return var_3118;
      }
      
      public function get connection() : IConnection
      {
         return _communication.connection;
      }
      
      public function get startPanel() : StartPanelCtrl
      {
         return var_2888;
      }
      
      public function get initMsg() : class_1762
      {
         return _initMsg;
      }
      
      public function get messageHandler() : ModerationMessageHandler
      {
         return var_4740;
      }
      
      public function get windowTracker() : WindowTracker
      {
         return var_4848;
      }
      
      public function get currentFlatId() : int
      {
         return var_4855;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function set initMsg(param1:class_1762) : void
      {
         _initMsg = param1;
      }
      
      public function set currentFlatId(param1:int) : void
      {
         var_4855 = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return _sessionDataManager.hasSecurity(5);
      }
      
      public function getXmlWindow(param1:String, param2:String = "_xml", param3:int = 1) : IWindow
      {
         var _loc6_:IAsset = null;
         var _loc4_:XmlAsset = null;
         var _loc5_:IWindow = null;
         try
         {
            _loc6_ = this.findAssetByName(param1 + param2);
            _loc4_ = XmlAsset(_loc6_);
            _loc5_ = _windowManager.buildFromXML(XML(_loc4_.content),param3);
         }
         catch(e:Error)
         {
         }
         return _loc5_;
      }
      
      public function openHkPage(param1:String, param2:String) : void
      {
         var _loc4_:String;
         var _loc5_:String = (_loc4_ = getProperty(param1)) + param2;
         var _loc3_:String = "housekeeping";
         HabboWebTools.navigateToURL(_loc5_,_loc3_);
      }
      
      public function goToRoom(param1:int) : void
      {
         _navigator.goToPrivateRoom(param1);
      }
      
      public function openThread(param1:int, param2:int) : void
      {
         context.createLinkEvent("groupforum/" + param1 + "/" + param2);
      }
      
      public function openThreadMessage(param1:int, param2:int, param3:int) : void
      {
         context.createLinkEvent("groupforum/" + param1 + "/" + param2 + "/" + param3);
      }
      
      internal function logEvent(param1:String, param2:String) : void
      {
         if(_tracking != null)
         {
            _tracking.trackEventLog("Moderation",param2,param1);
         }
      }
      
      internal function trackGoogle(param1:String, param2:int = -1) : void
      {
         if(_tracking != null)
         {
            _tracking.trackGoogle("moderationManager",param1,param2);
         }
      }
      
      public function set cfhTopics(param1:Vector.<class_1746>) : void
      {
         var_3118.setCfhTopics(param1);
      }
   }
}
