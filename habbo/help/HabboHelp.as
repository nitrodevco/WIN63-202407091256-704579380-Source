package com.sulake.habbo.help
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.parser.help.class_1230;
   import com.sulake.habbo.communication.messages.parser.help.class_1312;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.help.cfh.registry.chat.ChatEventHandler;
   import com.sulake.habbo.help.cfh.registry.chat.ChatRegistry;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageEventHandler;
   import com.sulake.habbo.help.cfh.registry.instantmessage.InstantMessageRegistry;
   import com.sulake.habbo.help.cfh.registry.user.UserRegistry;
   import com.sulake.habbo.help.namechange.NameChangeController;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import com.sulake.habbo.communication.messages.incoming.room.session.class_899;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_898;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.class_1407;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomSettingsDataEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.class_1207;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1333;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1339;
   import com.sulake.habbo.communication.messages.parser.callforhelp.class_1245;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1668;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_510;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_558;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.RemoveFriendMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_1746;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_177;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.class_642;
   import com.sulake.habbo.communication.messages.incoming.help.CallForHelpPendingCallsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.class_182;
   import com.sulake.habbo.communication.messages.incoming.help.class_509;
   import com.sulake.habbo.communication.messages.incoming.help.class_953;
   import com.sulake.habbo.communication.messages.incoming.game.snowwar.arena.class_679;
   import com.sulake.habbo.communication.messages.outgoing.help.class_275;
   import com.sulake.habbo.communication.messages.outgoing.help.class_531;
   import com.sulake.habbo.communication.messages.outgoing.help.class_561;
   import com.sulake.habbo.communication.messages.outgoing.users.class_352;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_639;
   
   public class HabboHelp extends Component implements IHabboHelp, ILinkEventTracker
   {
      
      public static const REPORT_TYPE_EMERGENCY:int = 1;
      
      public static const REPORT_TYPE_GUIDE:int = 2;
      
      public static const REPORT_TYPE_IM:int = 3;
      
      public static const REPORT_TYPE_ROOM:int = 4;
      
      public static const REPORT_TYPE_BULLY:int = 6;
      
      public static const REPORT_TYPE_THREAD:int = 7;
      
      public static const REPORT_TYPE_MESSAGE:int = 8;
      
      public static const REPORT_TYPE_PHOTO:int = 9;
       
      
      private var _toolbar:IHabboToolbar;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _navigator:IHabboNavigator;
      
      private var _tracking:IHabboTracking;
      
      private var _soundManager:class_2240;
      
      private var _friendList:IHabboFriendList;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_3049:ChatEventHandler;
      
      private var var_4916:InstantMessageEventHandler;
      
      private var var_2056:GuideHelpManager;
      
      private var _userRegistry:UserRegistry;
      
      private var _chatRegistry:ChatRegistry;
      
      private var _instantMessageRegistry:InstantMessageRegistry;
      
      private var var_2542:NameChangeController;
      
      private var var_1649:CallForHelpManager;
      
      private var var_2385:WelcomeScreenController;
      
      private var var_2469:HabboWayController;
      
      private var var_2046:HabboWayQuizController;
      
      private var var_2475:SafetyBookletController;
      
      private var _outsideRoom:Boolean;
      
      private var var_1864:int;
      
      private var _reportMessage:IMessageComposer;
      
      private var var_2579:int = -1;
      
      private var var_1632:int;
      
      private var var_217:Vector.<class_1746>;
      
      private var var_1972:TopicsFlowHelpController;
      
      private var _sanctionInfo:SanctionInfo;
      
      public function HabboHelp(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         _userRegistry = new UserRegistry();
         _chatRegistry = new ChatRegistry();
         _instantMessageRegistry = new InstantMessageRegistry();
         super(param1,param2,param3);
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get navigator() : IHabboNavigator
      {
         return _navigator;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _tracking;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function get newUserTourEnabled() : Boolean
      {
         return getBoolean("guide.help.new.user.tour.enabled");
      }
      
      public function get newIdentity() : Boolean
      {
         return getInteger("new.identity",0) > 0;
      }
      
      public function get citizenshipEnabled() : Boolean
      {
         return getBoolean("talent.track.citizenship.enabled");
      }
      
      public function get safetyQuizDisabled() : Boolean
      {
         return getBoolean("safety_quiz.disabled");
      }
      
      public function requestGuide() : void
      {
         if(getBoolean("guides.enabled"))
         {
            var_2056.createHelpRequest(0);
         }
      }
      
      public function reportBully(param1:int) : void
      {
         if(var_1649 != null)
         {
            var_1649.reportBully(param1,var_1632);
         }
      }
      
      public function startPhotoReportingInNewCfhFlow(param1:int, param2:String, param3:String, param4:int) : void
      {
         if(var_1649 != null)
         {
            var_1649.reportedRoomId = var_1632;
            var_1649.reportedUserId = param1;
            var_1649.reportedUserName = param2;
            var_1649.reportedRoomObjectId = param4;
            var_1649.reportedExtraDataId = param3;
            var_1972.openReportingContentReasonCategory(9);
         }
      }
      
      public function reportUser(param1:int, param2:int, param3:String) : void
      {
         var_1649.reportedUserId = param1;
         var_1972.openReportingChatLineSelection();
      }
      
      public function reportUserName(param1:int, param2:String) : void
      {
         var_1649.reportedUserId = param1;
         var_1649.reportedUserName = param2;
         var_1649.reportedRoomId = -1;
         var_1972.openReportingUserName();
      }
      
      public function reportUserFromIM(param1:int) : void
      {
         if(var_1649 != null)
         {
            var_1649.reportedUserId = param1;
            var_1972.openReportingIMSelection();
         }
      }
      
      public function reportRoom(param1:int, param2:String, param3:String) : void
      {
         if(var_1649 != null)
         {
            var_1649.reportedRoomId = param1;
            var_1649.reportedRoomName = param2;
            var_1649.reportedUserId = -1;
            var_1649.reportedUserName = "";
            var_1972.openReportingContentReasonCategory(4);
         }
      }
      
      public function reportThread(param1:int, param2:int) : void
      {
         if(var_1649 != null)
         {
            var_1649.reportedGroupId = param1;
            var_1649.reportedThreadId = param2;
            var_1972.openReportingContentReasonCategory(7);
         }
      }
      
      public function reportSelfie(param1:String, param2:String, param3:int, param4:int, param5:int) : Boolean
      {
         if(var_1649 != null)
         {
            if(param2.length < getInteger("help.cfh.length.minimum",15))
            {
               windowManager.alert("${generic.alert.title}","${help.cfh.error.msgtooshort}",0,null);
               return false;
            }
            var_1649.reportSelfie(param1,param2,param3,param4,param5);
            return true;
         }
         return false;
      }
      
      public function reportPhoto(param1:String, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         if(var_1649 != null)
         {
            if(param2 == 0)
            {
               windowManager.alert("${generic.alert.title}","${help.cfh.error.notopic}",0,null);
               return false;
            }
            var_1649.reportPhoto(param1,param2,param3,param4,param5);
            return true;
         }
         return false;
      }
      
      public function reportMessage(param1:int, param2:int, param3:int) : void
      {
         if(var_1649 != null)
         {
            var_1649.reportedGroupId = param1;
            var_1649.reportedThreadId = param2;
            var_1649.reportedMessageId = param3;
            var_1972.openReportingContentReasonCategory(8);
         }
      }
      
      public function startNameChange() : void
      {
         if(var_2542 != null)
         {
            var_2542.showView();
         }
      }
      
      public function startEmergencyRequest() : void
      {
         if(var_1649 != null)
         {
            var_1649.openEmergencyHelpRequest();
         }
      }
      
      public function showWelcomeScreen(param1:String, param2:String, param3:int, param4:String = null) : void
      {
         if(var_2385 == null || var_2385.disposed)
         {
            var_2385 = new WelcomeScreenController(this);
         }
         var_2385.showWelcomeScreen(param1,param2,param3,param4);
      }
      
      public function showHabboWay() : void
      {
         if(!var_2469)
         {
            var_2469 = new HabboWayController(this);
         }
         var_2469.showHabboWay();
      }
      
      public function closeHabboWay() : void
      {
         if(var_2469 != null)
         {
            var_2469.closeWindow();
         }
      }
      
      public function showSafetyBooklet() : void
      {
         if(!var_2475)
         {
            var_2475 = new SafetyBookletController(this);
         }
         var_2475.openSafetyBooklet();
      }
      
      public function closeSafetyBooklet() : void
      {
         if(var_2475 != null)
         {
            var_2475.closeWindow();
         }
      }
      
      public function showHabboWayQuiz() : void
      {
         if(var_2046 == null || var_2046.disposed)
         {
            var_2046 = new HabboWayQuizController(this);
         }
         var_2046.showHabboWayQuiz();
      }
      
      public function showSafetyQuiz() : void
      {
         if(var_2046 == null || var_2046.disposed)
         {
            var_2046 = new HabboWayQuizController(this);
         }
         var_2046.showSafetyQuiz();
      }
      
      public function showTourPopup() : void
      {
         var_2056.openTourPopup();
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },false),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },true,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         },{
            "type":"HTE_GROUP_ROOM_INFO_CLICK",
            "callback":onHabboToolbarEvent
         },{
            "type":"HTE_RESIZED",
            "callback":onHabboToolbarEvent
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },true),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         },false),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         },false),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_2240):void
         {
            _soundManager = param1;
         },false),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_182(onCallForHelpDisabledNotify));
         addMessageEvent(new class_898(onGuestRoomResult));
         addMessageEvent(new class_177(onCfhTopics));
         addMessageEvent(new class_558(onUsers));
         addMessageEvent(new class_899(onRoomReady));
         addMessageEvent(new class_642(onSanctionStatusEvent));
         addMessageEvent(new class_509(onGuideReportingStatus));
         addMessageEvent(new CallForHelpPendingCallsMessageEvent(onPendingCallsForHelp));
         addMessageEvent(new class_953(onPendingCallsForHelpDeleted));
         addMessageEvent(new class_679(onGameStageStarting));
         addMessageEvent(new class_510(onRoomEnter));
         var_3049 = new ChatEventHandler(this);
         var_2056 = new GuideHelpManager(this);
         var_1649 = new CallForHelpManager(this);
         var_2542 = new NameChangeController(this);
         var_4916 = new InstantMessageEventHandler(this);
         var_1972 = new TopicsFlowHelpController(this);
         _sanctionInfo = new SanctionInfo(this);
         context.addLinkEventTracker(this);
         if(getBoolean("show.sanction.info.on.login") && Math.random() < 0.2)
         {
            requestSanctionInfo(true);
         }
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         if(var_2475 != null)
         {
            var_2475.dispose();
            var_2475 = null;
         }
         if(var_2469 != null)
         {
            var_2469.dispose();
            var_2469 = null;
         }
         if(var_2385 != null)
         {
            var_2385.dispose();
            var_2385 = null;
         }
         if(var_2542 != null)
         {
            var_2542.dispose();
            var_2542 = null;
         }
         if(var_2056)
         {
            var_2056.dispose();
            var_2056 = null;
         }
         if(var_1649)
         {
            var_1649.dispose();
            var_1649 = null;
         }
         if(var_2046)
         {
            var_2046.dispose();
            var_2046 = null;
         }
         if(var_1972)
         {
            var_1972.dispose();
            var_1972 = null;
         }
         if(_sanctionInfo)
         {
            _sanctionInfo.dispose();
            _sanctionInfo = null;
         }
         super.dispose();
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : IWindow
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:IWindow = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = _windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      public function getModalXmlWindow(param1:String) : IModalDialog
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IModalDialog = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1 + "_xml");
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildModalDialogFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc4_ + ", " + _windowManager + "!");
            throw e;
         }
         return _loc3_;
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_tracking)
         {
            _tracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function setReportMessage(param1:IMessageComposer) : void
      {
         _reportMessage = param1;
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         if(_communicationManager != null && param1 != null)
         {
            _communicationManager.connection.send(param1);
         }
      }
      
      public function get ownUserName() : String
      {
         return var_2542.ownUserName;
      }
      
      public function get ownUserId() : int
      {
         return var_2542.ownUserId;
      }
      
      public function get outsideRoom() : Boolean
      {
         return _outsideRoom;
      }
      
      public function set outsideRoom(param1:Boolean) : void
      {
         _outsideRoom = param1;
      }
      
      public function queryForPendingCallsForHelp(param1:int) : void
      {
         var_1864 = param1;
         sendMessage(new class_531());
      }
      
      public function queryForGuideReportingStatus(param1:int) : void
      {
         var_2579 = param1;
         sendMessage(new class_639());
         sendMessage(new class_561());
      }
      
      private function onPendingCallsForHelp(param1:IMessageEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc2_:class_1230 = CallForHelpPendingCallsMessageEvent(param1).getParser();
         if(_loc2_.callCount == 0 || var_1864 == 9 && _loc2_.callCount < 3)
         {
            proceedWithReporting();
         }
         else
         {
            _loc4_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc2_.callArray.length && _loc3_ < 10)
            {
               _loc4_ += _loc2_.callArray[_loc3_].message;
               if(_loc3_ < _loc2_.callArray.length - 1 && _loc3_ < 9)
               {
                  _loc4_ += "\n";
               }
               _loc3_++;
            }
            var_1649.showPendingRequest(_loc4_);
         }
      }
      
      private function onPendingCallsForHelpDeleted(param1:IMessageEvent) : void
      {
         var_1972.submitCallForHelp(false);
      }
      
      private function onGuideReportingStatus(param1:class_509) : void
      {
         var _loc2_:class_1312 = param1.getParser();
         switch(_loc2_.statusCode)
         {
            case 0:
               toggleNewHelpWindow();
               break;
            case 1:
               var_2056.showPendingTicket(_loc2_.pendingTicket);
               break;
            default:
               var_2056.showFeedback(_loc2_.localizationCode);
         }
      }
      
      private function proceedWithReporting() : void
      {
         switch(var_1864 - 1)
         {
            case 0:
            case 2:
            case 3:
            case 6:
            case 7:
               var_1649.showEmergencyHelpRequest(var_1864);
               break;
            case 1:
               var_2056.openReportWindow();
               break;
            case 8:
               if(_reportMessage != null)
               {
                  sendMessage(_reportMessage);
                  _reportMessage = null;
                  break;
               }
         }
         var_1864 = 0;
      }
      
      private function onCallForHelpDisabledNotify(param1:class_182) : void
      {
         _windowManager.simpleAlert("${help.emergency.global_mute.caption}","${help.emergency.global_mute.subtitle}","${help.emergency.global_mute.message}","${help.emergency.global_mute.link}",param1.getParser().infoUrl);
      }
      
      public function get friendList() : IHabboFriendList
      {
         return _friendList;
      }
      
      public function ignoreAndUnfriendReportedUser() : void
      {
         var _loc1_:RemoveFriendMessageComposer = null;
         if(var_1649.reportedUserId > 0)
         {
            sendMessage(new class_352(var_1649.reportedUserId));
            if(_friendList.getFriend(var_1649.reportedUserId) != null)
            {
               _loc1_ = new RemoveFriendMessageComposer();
               _loc1_.addRemovedFriend(var_1649.reportedUserId);
               sendMessage(_loc1_);
            }
         }
      }
      
      private function onUsers(param1:IMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1668 = null;
         var _loc2_:class_1333 = class_558(param1).getParser();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.getUserCount())
         {
            if((_loc4_ = _loc2_.getUser(_loc3_)).webID != ownUserId && _loc4_.userType == 1)
            {
               _userRegistry.registerUser(_loc4_.webID,_loc4_.name,_loc4_.figure);
            }
            _loc3_++;
         }
      }
      
      private function onGameStageStarting(param1:class_679) : void
      {
         var _loc6_:HumanGameObjectData = null;
         var _loc2_:class_1407 = param1.getParser();
         var _loc5_:Array = _loc2_.gameObjects.gameObjects;
         var _loc4_:int = _userRegistry.roomId;
         var _loc3_:String = _userRegistry.roomName;
         _userRegistry.registerRoom(-1,"SnowStorm");
         for each(var _loc7_ in _loc5_)
         {
            if((_loc6_ = _loc7_ as HumanGameObjectData) != null && _loc6_.userId != ownUserId)
            {
               _userRegistry.registerUser(_loc6_.userId,_loc6_.name,_loc6_.figure);
            }
         }
         _userRegistry.registerRoom(_loc4_,_loc3_);
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         var _loc2_:class_1207 = class_899(param1).getParser();
         _userRegistry.registerRoom(_loc2_.roomId,"");
      }
      
      private function onGuestRoomResult(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsDataEvent = class_898(param1).getParser();
         _userRegistry.registerRoom(_loc2_.data.flatId,_loc2_.data.roomName);
      }
      
      public function get userRegistry() : UserRegistry
      {
         return _userRegistry;
      }
      
      public function get chatRegistry() : ChatRegistry
      {
         return _chatRegistry;
      }
      
      public function get instantMessageRegistry() : InstantMessageRegistry
      {
         return _instantMessageRegistry;
      }
      
      private function onRoomEnter(param1:class_510) : void
      {
         var _loc2_:class_1339 = class_510(param1).getParser();
         var_1632 = _loc2_.guestRoomId;
      }
      
      private function onCfhTopics(param1:class_177) : void
      {
         var _loc2_:class_1245 = param1.getParser();
         var_217 = _loc2_.callForHelpCategories;
      }
      
      public function get callForHelpCategories() : Vector.<class_1746>
      {
         return var_217;
      }
      
      public function get guardiansEnabled() : Boolean
      {
         return getBoolean("guardians.enabled");
      }
      
      public function get linkPattern() : String
      {
         return "help/";
      }
      
      public function get reportedUserId() : int
      {
         return var_1649.reportedUserId;
      }
      
      public function get reportedUserName() : String
      {
         return var_1649.reportedUserName;
      }
      
      public function get reportedRoomId() : int
      {
         return var_1649.reportedRoomId;
      }
      
      public function get reportedExtraDataId() : String
      {
         return var_1649.reportedExtraDataId;
      }
      
      public function get reportedRoomObjectId() : int
      {
         return var_1649.reportedRoomObjectId;
      }
      
      public function set reportedUserId(param1:int) : void
      {
         var_1649.reportedUserId = param1;
      }
      
      public function set reportedRoomId(param1:int) : void
      {
         var_1649.reportedRoomId = param1;
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(param1 == "help/tour")
         {
            requestGuide();
         }
         if(param1.indexOf("help/report/room/") == 0)
         {
            _loc2_ = param1.split("/");
            if(_loc2_.length >= 5)
            {
               _loc3_ = parseInt(_loc2_[3]);
               _loc4_ = unescape(_loc2_.splice(4).join("/"));
               reportRoom(_loc3_,_loc4_,"");
            }
         }
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(var_2385 != null)
         {
            var_2385.onHabboToolbarEvent(param1);
         }
         if(var_2056 != null)
         {
            var_2056.onHabboToolbarEvent(param1);
         }
      }
      
      public function get callForHelpManager() : CallForHelpManager
      {
         return var_1649;
      }
      
      public function toggleNewHelpWindow() : void
      {
         var_1972.toggleWindow();
      }
      
      public function requestSanctionInfo(param1:Boolean) : void
      {
         sendMessage(new class_275(param1));
      }
      
      private function onSanctionStatusEvent(param1:class_642) : void
      {
         _sanctionInfo.openWindow(param1);
      }
      
      public function openCfhFaq() : void
      {
         var _loc1_:String = String(context.configuration.getProperty("cfh.faq.url"));
         if(!StringUtil.isEmpty(_loc1_))
         {
            navigateToURL(new URLRequest(_loc1_));
         }
      }
      
      public function get guideHelpManager() : GuideHelpManager
      {
         return var_2056;
      }
   }
}
