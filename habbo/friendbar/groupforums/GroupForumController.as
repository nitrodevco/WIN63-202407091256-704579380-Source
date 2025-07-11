package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1281;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1436;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1481;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1482;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1511;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1563;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1627;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1666;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1740;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1754;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1755;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_1002;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_1013;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_1036;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_153;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_171;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_472;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_539;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_569;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_614;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_650;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.UpdateForumSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.class_917;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_281;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_299;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_334;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_339;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_495;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_573;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_624;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_782;
   import com.sulake.habbo.communication.messages.incoming.groupforums.class_988;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   
   public class GroupForumController extends Component implements class_3505, ILinkEventTracker
   {
      
      public static const FORUMS_LIST_CODE_ACTIVE:int = 0;
      
      public static const FORUMS_LIST_CODE_POPULAR:int = 1;
      
      public static const FORUMS_LIST_CODE_MY_FORUMS:int = 2;
      
      public static const NO_ID:int = -1;
       
      
      private var _configurationManager:ICoreConfiguration;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _help:IHabboHelp;
      
      private var _notifications:IHabboNotifications;
      
      private var _soundManager:class_2240;
      
      private var _habboTracking:IHabboTracking;
      
      private var var_1747:GroupForumView;
      
      private var var_3020:ComposeMessageView;
      
      private var var_4334:ForumSettingsView;
      
      private var var_3192:int = -1;
      
      private var var_2651:int = -1;
      
      private var var_513:class_1755;
      
      private var var_3231:int;
      
      private var var_2018:int = 0;
      
      private var var_1918:ForumsListData;
      
      private var var_2223:ThreadsListData;
      
      private var var_2652:MessagesListData;
      
      private var _lastReadMessageIndexByThread:Dictionary;
      
      private var var_3942:int = -1;
      
      private var var_3955:int;
      
      private var _lastPostTime:int = -30000;
      
      private var var_1200:int = 0;
      
      private var var_2829:Timer;
      
      public function GroupForumController(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         _lastReadMessageIndexByThread = new Dictionary();
         super(param1,param2,param3);
      }
      
      public function get composeMessageView() : ComposeMessageView
      {
         return var_3020;
      }
      
      public function set composeMessageView(param1:ComposeMessageView) : void
      {
         var_3020 = param1;
      }
      
      public function get forumSettingsView() : ForumSettingsView
      {
         return var_4334;
      }
      
      public function set forumSettingsView(param1:ForumSettingsView) : void
      {
         var_4334 = param1;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get lastPostTime() : int
      {
         return _lastPostTime;
      }
      
      public function get unreadForumsCount() : int
      {
         return var_1200;
      }
      
      public function get tracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:ICoreConfiguration):void
         {
            _configurationManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _help = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_2240):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),null)]);
      }
      
      override protected function initComponent() : void
      {
         _communicationManager.addHabboConnectionMessageEvent(new class_988(onPostMessageMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_299(onUpdateThread));
         _communicationManager.addHabboConnectionMessageEvent(new class_624(onUnreadForumsCountMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_334(onUpdateMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_339(onForumsList));
         _communicationManager.addHabboConnectionMessageEvent(new class_782(onPostThreadMessage));
         _communicationManager.addHabboConnectionMessageEvent(new class_281(onThreadMessageList));
         _communicationManager.addHabboConnectionMessageEvent(new class_573(onThreadList));
         _communicationManager.addHabboConnectionMessageEvent(new class_495(onForumData));
         context.addLinkEventTracker(this);
         startPollingForUnreadForumsCount();
      }
      
      override public function dispose() : void
      {
         if(var_2829 != null)
         {
            var_2829.stop();
            var_2829 = null;
         }
         super.dispose();
      }
      
      private function startPollingForUnreadForumsCount() : void
      {
         var _loc1_:int = int(_configurationManager.getInteger("groupforum.poll.period",300));
         var_2829 = new Timer(_loc1_ * 1000,0);
         var_2829.addEventListener("timer",onUnreadForumsCountUpdateTimerEvent);
         var_2829.start();
         onUnreadForumsCountUpdateTimerEvent(null);
      }
      
      public function openGroupForum(param1:int) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         initForum(param1);
         requestThreadList(param1,0);
      }
      
      public function get linkPattern() : String
      {
         return "groupforum/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(!_communicationManager)
         {
            return;
         }
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 2)
         {
            return;
         }
         if(_loc3_[1] == "list")
         {
            if(_loc3_.length == 3)
            {
               switch(_loc3_[2])
               {
                  case "active":
                     _loc5_ = 0;
                     break;
                  case "popular":
                     _loc5_ = 1;
                     break;
                  case "my":
                     _loc5_ = 2;
                     break;
                  default:
                     return;
               }
               openForumsList(_loc5_);
            }
         }
         else
         {
            if((_loc6_ = int(_loc3_[1])) == 0)
            {
               return;
            }
            var_1918 = null;
            if(_loc3_.length == 2)
            {
               openGroupForum(_loc6_);
            }
            else
            {
               _loc2_ = int(_loc3_[2]);
               _loc4_ = 0;
               if(_loc3_.length > 3)
               {
                  _loc4_ = int(_loc3_[3]);
               }
               initForum(_loc6_);
               _communicationManager.connection.send(new class_917(_loc6_,_loc2_));
               goToMessageIndex(_loc6_,_loc2_,_loc4_);
            }
         }
      }
      
      public function openForumsList(param1:int, param2:int = 0) : void
      {
         markForumAsRead();
         var_3192 = param1;
         var_2651 = -1;
         _communicationManager.connection.send(new class_539(param1,param2,20));
      }
      
      private function onForumsList(param1:class_339) : void
      {
         var _loc3_:class_1563 = param1.getParser();
         var _loc2_:ForumsListData = new ForumsListData(_loc3_);
         if(var_513 != null && var_2018 > 0)
         {
            _loc2_.updateUnreadMessages(var_513,var_2018);
         }
         if(_loc2_.listCode == 2)
         {
            updateUnreadForumsCount(_loc2_.unreadForumsCount);
         }
         if(var_3192 != _loc2_.listCode)
         {
            return;
         }
         var_1918 = _loc2_;
         if(!var_1747)
         {
            var_1747 = new GroupForumView(this);
         }
         var_1747.openForumsList(var_1918);
      }
      
      private function initForum(param1:int) : void
      {
         markForumAsRead();
         var_3192 = -1;
         var_2651 = param1;
         var_2018 = 0;
         _communicationManager.connection.send(new class_1002(param1));
      }
      
      private function onForumData(param1:class_495) : void
      {
         var _loc2_:Map = null;
         var _loc3_:String = null;
         var _loc4_:class_1755 = param1.getParser().forumData;
         if(var_2651 != _loc4_.groupId)
         {
            return;
         }
         if(!_loc4_.canRead)
         {
            if(var_1747 != null)
            {
               var_1747.dispose();
            }
            var_513 = null;
            var_2651 = 0;
            _loc2_ = new Map();
            _loc3_ = String(localizationManager.getLocalization("groupforum.view.error.operation_read"));
            _loc2_.add("message",localizationManager.getLocalizationWithParams("groupforum.view.error." + _loc4_.readPermissionError,"","operation",_loc3_));
            notifications.showNotification("forums.error.access_denied",_loc2_);
            return;
         }
         var_513 = _loc4_;
         var_2018 = _loc4_.lastReadMessageId;
      }
      
      public function requestThreadList(param1:int, param2:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_153(param1,param2,20));
         }
      }
      
      private function onThreadList(param1:class_573) : void
      {
         var _loc2_:class_1436 = param1.getParser();
         if(var_513 == null || var_513.groupId != _loc2_.groupId)
         {
            return;
         }
         var_2223 = new ThreadsListData(var_513.totalThreads,_loc2_.startIndex,_loc2_.threads);
         if(!var_1747)
         {
            var_1747 = new GroupForumView(this);
         }
         var_1747.openThreadList(var_1918,var_513,var_2223);
      }
      
      public function requestThreadMessageList(param1:int, param2:int, param3:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_1013(param1,param2,param3,20));
         }
      }
      
      private function onThreadMessageList(param1:class_281) : void
      {
         var _loc6_:class_1666 = null;
         var _loc3_:class_1511 = param1.getParser();
         if(var_513 == null || var_513.groupId != _loc3_.groupId || var_2223 == null)
         {
            return;
         }
         var_3231 = _loc3_.threadId;
         var _loc2_:class_1740 = var_2223.threadsById[var_3231];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _loc3_.startIndex;
         var _loc5_:int = _loc2_.nMessages;
         var_2652 = new MessagesListData(var_3231,_loc5_,_loc4_,_loc3_.messages);
         if(!var_1747)
         {
            var_1747 = new GroupForumView(this);
         }
         var_1747.openMessagesList(var_1918,var_513,var_2223,var_2652);
         if(_loc3_.messages.length > 0)
         {
            if(_loc6_ = class_1666(_loc3_.messages[_loc3_.messages.length - 1]))
            {
               updateUnreadMessageCounts(_loc6_.messageId,_loc6_.threadId,_loc6_.messageIndex);
            }
         }
      }
      
      public function updateForumSettings(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new UpdateForumSettingsMessageComposer(param1,param2,param3,param4,param5));
         }
      }
      
      public function postNewThread(param1:int, param2:String, param3:String) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_472(param1,0,param2,param3));
            _lastPostTime = getTimer();
         }
      }
      
      private function onPostThreadMessage(param1:class_782) : void
      {
         var _loc3_:class_1754 = null;
         var _loc2_:class_1481 = class_1481(param1.getParser());
         if(var_3020)
         {
            var_3020.dispose();
         }
         if(var_513 != null && var_513.groupId == _loc2_.groupId)
         {
            updateUnreadMessageCounts(_loc2_.thread.lastMessageId,_loc2_.thread.threadId,_loc2_.thread.nMessages - 1);
         }
         if(var_1918 != null)
         {
            _loc3_ = var_1918.getForumData(_loc2_.groupId);
            if(_loc3_ != null)
            {
               _loc3_.addNewThread(_loc2_.thread);
            }
         }
         if(var_1747 == null)
         {
            return;
         }
         if(var_513 == null || _loc2_.groupId != var_513.groupId)
         {
            return;
         }
         requestThreadList(var_513.groupId,0);
      }
      
      public function postNewMessage(param1:int, param2:int, param3:String) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_472(param1,param2,"",param3));
            _lastPostTime = getTimer();
         }
      }
      
      private function onPostMessageMessage(param1:class_988) : void
      {
         if(var_3020)
         {
            var_3020.dispose();
         }
         if(var_1747 == null)
         {
            return;
         }
         var _loc2_:class_1482 = class_1482(param1.getParser());
         if(var_513 == null || _loc2_.groupId != var_513.groupId || _loc2_.threadId != var_3231)
         {
            return;
         }
         var _loc3_:int = _loc2_.message.messageIndex - _loc2_.message.messageIndex % 20;
         requestThreadMessageList(var_513.groupId,var_3231,_loc3_);
      }
      
      public function deleteThread(param1:class_1755, param2:int) : void
      {
         var _loc3_:int = 0;
         if(_communicationManager)
         {
            if(param1.canModerate)
            {
               _loc3_ = 10;
            }
            if(param1.isStaff)
            {
               _loc3_ = 20;
            }
            _communicationManager.connection.send(new class_1036(param1.groupId,param2,_loc3_));
         }
      }
      
      public function unDeleteThread(param1:class_1754, param2:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_1036(param1.groupId,param2,1));
         }
      }
      
      public function lockThread(param1:class_1754, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_569(param1.groupId,param2,param3,param4));
         }
      }
      
      public function stickThread(param1:class_1754, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_569(param1.groupId,param2,param3,param4));
         }
      }
      
      public function reportThread(param1:class_1754, param2:int) : void
      {
         if(_help)
         {
            _help.reportThread(param1.groupId,param2);
         }
      }
      
      private function onUpdateThread(param1:class_299) : void
      {
         var _loc2_:class_1281 = param1.getParser();
         if(var_513 == null || var_513.groupId != _loc2_.groupId)
         {
            return;
         }
         var _loc3_:class_1740 = _loc2_.thread;
         if(var_2223 && var_1747)
         {
            if(var_2223.updateThread(_loc3_))
            {
               var_1747.updateThread(_loc3_);
               return;
            }
         }
         var_2223 = new ThreadsListData(1,0,[_loc3_]);
      }
      
      public function deleteMessage(param1:class_1755, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         if(_communicationManager)
         {
            _loc4_ = 10;
            if(param1.isStaff)
            {
               _loc4_ = 20;
            }
            _communicationManager.connection.send(new class_650(var_513.groupId,param2,param3,_loc4_));
         }
      }
      
      public function unDeleteMessage(param1:class_1754, param2:int, param3:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_650(param1.groupId,param2,param3,1));
         }
      }
      
      public function reportMessage(param1:class_1754, param2:int, param3:int) : void
      {
         if(_help)
         {
            _help.reportMessage(param1.groupId,param2,param3);
         }
      }
      
      private function onUpdateMessage(param1:class_334) : void
      {
         var _loc5_:int = 0;
         var _loc6_:class_1666 = null;
         var _loc3_:class_1627 = param1.getParser();
         if(var_513 == null || var_513.groupId != _loc3_.groupId || var_3231 != _loc3_.threadId)
         {
            return;
         }
         var _loc2_:class_1666 = _loc3_.message;
         var _loc4_:Array = var_2652["messages"];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if((_loc6_ = _loc4_[_loc5_]).messageId == _loc2_.messageId)
            {
               _loc4_[_loc5_] = _loc2_;
               if(var_1747)
               {
                  var_1747.updateMessage(_loc2_);
               }
               return;
            }
            _loc5_++;
         }
      }
      
      public function goToMessageIndex(param1:int, param2:int, param3:int) : void
      {
         var_3942 = param2;
         var _loc4_:int = Math.floor(param3 / 20);
         var_3955 = param3 % 20;
         requestThreadMessageList(param1,param2,_loc4_ * 20);
      }
      
      public function getUserInfo(param1:int) : void
      {
         if(_communicationManager)
         {
            _communicationManager.connection.send(new class_322(param1));
         }
      }
      
      public function closeMainView() : void
      {
         markForumAsRead();
         var_1747 = null;
         var_513 = null;
         var_3192 = -1;
         var_2651 = -1;
      }
      
      public function markForumAsRead(param1:Boolean = false) : void
      {
         var _loc2_:class_614 = null;
         if(_communicationManager && var_513)
         {
            if(param1 || var_2018 > var_513.lastReadMessageId)
            {
               _loc2_ = new class_614();
               if(param1)
               {
                  _loc2_.add(var_513.groupId,Math.max(var_513.totalMessages,var_2018),var_2018 == 0);
               }
               else
               {
                  _loc2_.add(var_513.groupId,var_2018,false);
               }
               _communicationManager.connection.send(_loc2_);
            }
         }
         var_2018 = 0;
         _lastReadMessageIndexByThread = new Dictionary();
      }
      
      public function markForumsAsRead() : void
      {
         var _loc1_:class_614 = null;
         if(_communicationManager && var_1918)
         {
            _loc1_ = new class_614();
            for each(var _loc2_ in var_1918.forums)
            {
               if(_loc2_.unreadMessages > 0)
               {
                  _loc1_.add(_loc2_.groupId,_loc2_.totalMessages,true);
               }
            }
            if(_loc1_.size > 0)
            {
               _communicationManager.connection.send(_loc1_);
               updateUnreadForumsCount(0);
            }
         }
      }
      
      public function getThreadLastReadMessageIndex(param1:int) : int
      {
         var _loc3_:class_1740 = null;
         var _loc2_:* = _lastReadMessageIndexByThread[param1];
         if(_loc2_ != null)
         {
            return int(_loc2_);
         }
         if(var_2223)
         {
            _loc3_ = var_2223.threadsById[param1];
            if(_loc3_)
            {
               return _loc3_.nMessages - _loc3_.nUnreadMessages - 1;
            }
         }
         return -1;
      }
      
      public function updateUnreadMessageCounts(param1:int, param2:int, param3:int) : void
      {
         if(param1 > var_2018)
         {
            var_2018 = param1;
            if(var_1918)
            {
               var_1918.updateUnreadMessages(var_513,param1);
               if(var_1918.listCode == 2)
               {
                  updateUnreadForumsCount(var_1918.unreadForumsCount);
               }
            }
         }
         _lastReadMessageIndexByThread[param2] = param3;
      }
      
      public function getGoToMessageIndex() : int
      {
         return var_3955;
      }
      
      public function getGoToThreadId() : int
      {
         return var_3942;
      }
      
      public function resetGoTo() : void
      {
         var_3942 = -1;
         var_3955 = -1;
      }
      
      public function updateUnreadForumsCount(param1:int) : void
      {
         if(var_1200 == param1)
         {
            return;
         }
         if(param1 > var_1200)
         {
            if(_soundManager != null)
            {
            }
         }
         var_1200 = param1;
         events.dispatchEvent(new UnseenForumsCountUpdatedEvent("UNSEEN_FORUMS_COUNT",param1));
         if(var_1747 != null)
         {
            var_1747.updateUnreadForumsCount(param1);
         }
      }
      
      private function onUnreadForumsCountUpdateTimerEvent(param1:TimerEvent) : void
      {
         if(var_1747 != null)
         {
            _communicationManager.connection.send(new class_539(2,0,20));
         }
         else
         {
            _communicationManager.connection.send(new class_171());
         }
      }
      
      private function onUnreadForumsCountMessage(param1:class_624) : void
      {
         updateUnreadForumsCount(param1.getParser().unreadForumsCount);
      }
   }
}
