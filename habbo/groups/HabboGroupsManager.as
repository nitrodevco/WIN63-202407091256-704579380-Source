package com.sulake.habbo.groups
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IContext;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.groups.events.HabboGroupsEditorData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.IHabboNavigator;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.room.session.class_640;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_795;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_898;
   import com.sulake.habbo.communication.messages.parser.users.class_1359;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomSettingsDataEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.class_1616;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1267;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1339;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_510;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1057;
   import com.sulake.habbo.communication.messages.incoming.users.class_1184;
   import com.sulake.habbo.communication.messages.incoming.users.class_1197;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   import com.sulake.habbo.communication.messages.incoming.users.class_1212;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_1251;
   import com.sulake.habbo.communication.messages.incoming.users.class_1300;
   import com.sulake.habbo.communication.messages.incoming.users.class_132;
   import com.sulake.habbo.communication.messages.incoming.users.class_150;
   import com.sulake.habbo.communication.messages.incoming.users.class_1581;
   import com.sulake.habbo.communication.messages.incoming.users.class_172;
   import com.sulake.habbo.communication.messages.incoming.users.class_226;
   import com.sulake.habbo.communication.messages.incoming.users.class_232;
   import com.sulake.habbo.communication.messages.incoming.users.class_238;
   import com.sulake.habbo.communication.messages.incoming.users.class_246;
   import com.sulake.habbo.communication.messages.incoming.users.class_266;
   import com.sulake.habbo.communication.messages.incoming.users.class_315;
   import com.sulake.habbo.communication.messages.incoming.users.class_402;
   import com.sulake.habbo.communication.messages.incoming.users.class_438;
   import com.sulake.habbo.communication.messages.incoming.users.class_668;
   import com.sulake.habbo.communication.messages.incoming.users.class_787;
   import com.sulake.habbo.communication.messages.incoming.users.class_830;
   import com.sulake.habbo.communication.messages.incoming.users.class_835;
   import com.sulake.habbo.communication.messages.incoming.users.class_846;
   import com.sulake.habbo.communication.messages.incoming.users.class_908;
   import com.sulake.habbo.communication.messages.incoming.users.class_996;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_556;
   import com.sulake.habbo.communication.messages.outgoing.users.class_142;
   import com.sulake.habbo.communication.messages.outgoing.users.class_201;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   import com.sulake.habbo.communication.messages.outgoing.users.class_911;
   import com.sulake.habbo.communication.messages.outgoing.users.GetMemberGuildItemCountMessageComposer;
   
   public class HabboGroupsManager extends Component implements class_1880, ILinkEventTracker
   {
      
      public static const GROUPS_TRACKING_CATEGORY:String = "HabboGroups";
       
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _navigator:IHabboNavigator;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _friendlist:IHabboFriendList;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var _habboTracking:IHabboTracking;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var var_2315:DetailsWindowCtrl;
      
      private var var_2154:GuildMembersWindowCtrl;
      
      private var var_2208:GuildManagementWindowCtrl;
      
      private var var_2061:ExtendedProfileWindowCtrl;
      
      private var var_2918:HcRequiredWindowCtrl;
      
      private var var_3007:GroupCreatedWindowCtrl;
      
      private var var_2050:GroupRoomInfoCtrl;
      
      private var var_4245:class_1300;
      
      private var var_894:int;
      
      private var var_369:int;
      
      private var var_4456:Boolean;
      
      private var var_2104:GuildKickData;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function HabboGroupsManager(param1:IContext, param2:uint = 0, param3:IAssetLibrary = null)
      {
         super(param1,param2,param3);
         var_2315 = new DetailsWindowCtrl(this);
         var_2154 = new GuildMembersWindowCtrl(this);
         var_2208 = new GuildManagementWindowCtrl(this);
         var_2061 = new ExtendedProfileWindowCtrl(this);
         var_2918 = new HcRequiredWindowCtrl(this);
         var_3007 = new GroupCreatedWindowCtrl(this);
         var_2050 = new GroupRoomInfoCtrl(this);
         class_14.log("HabboGroupsManager initialized: " + param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManager):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendlist = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new class_132(onExtendedProfileChanged));
         addMessageEvent(new class_830(onGuildEditFailed));
         addMessageEvent(new class_172(var_2154.onGuildMembershipRejected));
         addMessageEvent(new class_246(onGroupDeactivated));
         addMessageEvent(new class_898(onRoomInfo));
         addMessageEvent(new class_1057(onSubscriptionInfo));
         addMessageEvent(new class_556(onUserObject));
         addMessageEvent(new class_640(onRoomLeave));
         addMessageEvent(new GuildEditorDataMessageEvent(onGuildEditorData));
         addMessageEvent(new class_266(onGuildCreationInfo));
         addMessageEvent(new class_232(onJoinFailed));
         addMessageEvent(new class_795(onFlatCreated));
         addMessageEvent(new class_150(onGroupDetailsChanged));
         addMessageEvent(new class_846(onUserBadgesMessage));
         addMessageEvent(new class_510(onRoomEnter));
         addMessageEvent(new class_402(onKickConfirmation));
         addMessageEvent(new class_908(var_2154.onMembershipRequested));
         addMessageEvent(new class_996(onExtendedProfile));
         addMessageEvent(new class_315(var_2154.onGuildMembershipUpdated));
         addMessageEvent(new class_835(onGroupDetails));
         addMessageEvent(new class_787(onGuildCreated));
         addMessageEvent(new class_438(onRelationshipStatusInfo));
         addMessageEvent(new class_226(var_2154.onGuildMembers));
         addMessageEvent(new class_668(var_2154.onGuildMemberMgmtFailed));
         addMessageEvent(new class_238(onGuildEditInfo));
         context.addLinkEventTracker(this);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
            _messageEvents = null;
         }
         if(var_2315)
         {
            var_2315.dispose();
            var_2315 = null;
         }
         if(var_2154)
         {
            var_2154.dispose();
            var_2154 = null;
         }
         if(var_2208)
         {
            var_2208.dispose();
            var_2208 = null;
         }
         if(var_2061)
         {
            var_2061.dispose();
            var_2061 = null;
         }
         if(var_2918)
         {
            var_2918.dispose();
            var_2918 = null;
         }
         if(var_3007)
         {
            var_3007.dispose();
            var_3007 = null;
         }
         if(var_2050)
         {
            var_2050.dispose();
            var_2050 = null;
         }
         super.dispose();
      }
      
      public function get linkPattern() : String
      {
         return "group/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length != 2)
         {
            return;
         }
         var _loc3_:int = int(_loc2_[1]);
         openGroupInfo(_loc3_);
      }
      
      public function showGroupBadgeInfo(param1:Boolean, param2:int) : void
      {
         openGroupInfo(param2);
         send(new EventLogMessageComposer("HabboGroups","" + param2,"badge clicked"));
      }
      
      public function openGroupInfo(param1:int) : void
      {
         send(new class_201(param1,true));
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String) : IWindow
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IWindow = null;
         try
         {
            _loc4_ = this.findAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function getButtonImage(param1:String) : BitmapData
      {
         var _loc3_:* = param1;
         var _loc6_:IAsset = this.findAssetByName(_loc3_);
         var _loc4_:BitmapDataAsset = BitmapDataAsset(_loc6_);
         var _loc2_:BitmapData = BitmapData(_loc4_.content);
         var _loc5_:BitmapData;
         (_loc5_ = new BitmapData(_loc2_.width,_loc2_.height,true,0)).draw(_loc2_);
         return _loc5_;
      }
      
      public function openGroupForum(param1:int) : void
      {
         context.createLinkEvent("groupforum/" + param1);
      }
      
      private function onGroupDeactivated(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(class_246(param1).groupId);
         var_2315.onGroupDeactivated(_loc2_);
         var_2050.onGroupDeactivated(_loc2_);
      }
      
      private function onGroupDetails(param1:IMessageEvent) : void
      {
         var _loc2_:class_1199 = class_835(param1).data;
         var_2315.onGroupDetails(_loc2_);
         var_2061.onGroupDetails(_loc2_);
         var_2050.onGroupDetails(_loc2_);
      }
      
      private function onExtendedProfile(param1:IMessageEvent) : void
      {
         var _loc2_:class_1581 = class_996(param1).data;
         if(_loc2_.openProfileWindow)
         {
            var_2061.badgeUpdateExpected = true;
            var_2061.relationshipUpdateExpected = true;
            var_2061.onProfile(_loc2_);
         }
      }
      
      private function onExtendedProfileChanged(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(class_132(param1).userId);
         var_2061.onProfileChanged(_loc2_);
      }
      
      private function onGroupDetailsChanged(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(class_150(param1).groupId);
         if(var_2315.isDisplayingGroup(_loc2_) || var_2050.isDisplayingGroup(_loc2_))
         {
            send(new class_201(_loc2_,false));
         }
      }
      
      private function onJoinFailed(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = int(class_232(param1).reason);
         if(_loc2_ == 4)
         {
            var_2918.show(false);
         }
         else
         {
            _loc3_ = "group.joinfail." + _loc2_;
            _loc4_ = String(_localization.getLocalization(_loc3_,_loc3_));
            _windowManager.alert("${group.joinfail.title}",_loc4_,0,onAlertClose);
         }
      }
      
      private function onGuildCreationInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_1197 = class_266(param1).data;
         var_2208.onGuildCreationInfo(_loc2_);
         requestGuildEditorData();
      }
      
      private function onGuildEditInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_1184 = class_238(param1).data;
         var_2208.onGuildEditInfo(_loc2_);
         requestGuildEditorData();
      }
      
      private function onRoomLeave(param1:IMessageEvent) : void
      {
         var_2315.close();
         var_2050.close();
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var_2315.close();
         var_2050.close();
         var _loc2_:class_1339 = class_510(param1).getParser();
         var_369 = _loc2_.guestRoomId;
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function onGuildEditorData(param1:IMessageEvent) : void
      {
         var_4245 = GuildEditorDataMessageEvent(param1).data;
         events.dispatchEvent(new HabboGroupsEditorData());
      }
      
      private function onGuildEditFailed(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = int(class_830(param1).reason);
         if(_loc2_ == 2)
         {
            var_2918.show(true);
         }
         else
         {
            _loc3_ = "group.edit.fail." + _loc2_;
            _loc4_ = String(_localization.getLocalization(_loc3_,_loc3_));
            _windowManager.alert("${group.edit.fail.title}",_loc4_,0,onAlertClose);
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:class_1267 = class_556(param1).getParser();
         var_894 = _loc2_.id;
      }
      
      private function onFlatCreated(param1:IMessageEvent) : void
      {
         var _loc2_:class_1616 = class_795(param1).getParser();
         var_2208.onFlatCreated(_loc2_.flatId,_loc2_.flatName);
      }
      
      private function onGuildCreated(param1:IMessageEvent) : void
      {
         var _loc2_:class_787 = class_787(param1);
         var_3007.show(_loc2_.groupId);
         var_2208.close();
         var_2050.expectedGroupId = _loc2_.groupId;
         if(var_369 != _loc2_.baseRoomId)
         {
            _navigator.goToPrivateRoom(_loc2_.baseRoomId);
         }
      }
      
      private function onKickConfirmation(param1:IMessageEvent) : void
      {
         var _loc4_:int = int(class_402(param1).userId());
         var _loc6_:int = int(class_402(param1).furniCount());
         var _loc5_:class_1251 = null;
         var _loc2_:class_1212 = var_2154.data;
         var _loc3_:String = var_2104.targetBlocked ? "group.block" : "group.kick";
         if(_loc6_ > 0)
         {
            if(_loc4_ == var_894)
            {
               localization.registerParameter("group.leaveconfirm.desc","amount",_loc6_.toString());
               _windowManager.confirm("${group.leaveconfirm.title}","${group.leaveconfirm.desc}",0,onKickConfirmationClose);
            }
            else
            {
               _loc5_ = _loc2_.getUser(_loc4_);
               localization.registerParameter(_loc3_ + "confirm.desc","amount",_loc6_.toString());
               localization.registerParameter(_loc3_ + "confirm.desc","user",_loc5_.userName);
               _windowManager.confirm("${" + _loc3_ + "confirm.title}","${" + _loc3_ + "confirm.desc}",0,onKickConfirmationClose);
            }
         }
         else if(_loc4_ == var_894)
         {
            _windowManager.confirm("${group.leaveconfirm.title}","${group.leaveconfirm_nofurni.desc}",0,onKickConfirmationClose);
         }
         else if(_loc2_)
         {
            _loc5_ = _loc2_.getUser(_loc4_);
            localization.registerParameter(_loc3_ + "confirm_nofurni.desc","user",_loc5_.userName);
            _windowManager.confirm("${" + _loc3_ + "confirm.title}","${" + _loc3_ + "confirm_nofurni.desc}",0,onKickConfirmationClose);
         }
      }
      
      private function onKickConfirmationClose(param1:class_3441, param2:WindowEvent) : void
      {
         if(param1 == null || Boolean(param1.disposed) || var_2104 == null)
         {
            var_2104 = null;
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            send(new class_911(var_2104.kickGuildId,var_2104.kickTargetId,var_2104.targetBlocked));
         }
         var_2104 = null;
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_1359 = class_1057(param1).getParser();
         var_4456 = _loc2_.isVIP && _loc2_.minutesUntilExpiration > 0;
         var_2208.onSubscriptionChange();
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc2_:RoomSettingsDataEvent = class_898(param1).getParser();
         if(_loc2_.enterRoom)
         {
            var_2050.onRoomInfo(_loc2_.data);
         }
      }
      
      private function onRelationshipStatusInfo(param1:IMessageEvent) : void
      {
         var _loc2_:class_438 = class_438(param1);
         var_2061.onRelationshipStatusInfo(_loc2_.userId,_loc2_.relationshipStatusMap);
      }
      
      private function onUserBadgesMessage(param1:class_846) : void
      {
         var_2061.onUserBadges(param1.userId,param1.badges);
      }
      
      private function requestGuildEditorData() : void
      {
         if(var_4245 == null)
         {
            send(new class_142());
         }
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return _windowManager;
      }
      
      public function get guildManagementWindowCtrl() : GuildManagementWindowCtrl
      {
         return var_2208;
      }
      
      public function get groupRoomInfoCtrl() : GroupRoomInfoCtrl
      {
         return var_2050;
      }
      
      public function get groupRoomInfoEnabled() : Boolean
      {
         return getBoolean("groupRoomInfo.enabled");
      }
      
      public function get groupDeletionEnabled() : Boolean
      {
         return getBoolean("group.deletion.enabled");
      }
      
      public function get groupRoomInfoBadgeEnabled() : Boolean
      {
         return groupRoomInfoEnabled && getBoolean("groupRoomInfo.badge.enabled");
      }
      
      public function get toolbarAttachEnabled() : Boolean
      {
         return groupRoomInfoEnabled && getBoolean("groupRoomInfo.attach.enabled");
      }
      
      public function get isActivityDisplayEnabled() : Boolean
      {
         return getBoolean("activity.point.display.enabled");
      }
      
      public function get guildEditorData() : class_1300
      {
         return var_4245;
      }
      
      public function get avatarId() : int
      {
         return var_894;
      }
      
      public function get navigator() : IHabboNavigator
      {
         return _newNavigator.legacyNavigator;
      }
      
      public function get friendlist() : IHabboFriendList
      {
         return _friendlist;
      }
      
      public function get guildMembersWindowCtrl() : GuildMembersWindowCtrl
      {
         return var_2154;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_habboTracking != null)
         {
            _habboTracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function updateVisibleExtendedProfile(param1:int) : void
      {
         var_2061.updateVisibleExtendedProfile(param1);
      }
      
      public function showExtendedProfile(param1:int) : void
      {
         send(new class_322(param1));
      }
      
      public function openCatalog(param1:String) : void
      {
         _catalog.openCatalogPage(param1);
      }
      
      public function openVipPurchase(param1:String) : void
      {
         _catalog.openClubCenter();
      }
      
      public function get hasVip() : Boolean
      {
         return var_4456;
      }
      
      public function handleUserKick(param1:int, param2:int) : void
      {
         var_2104 = new GuildKickData(param1,param2);
         send(new GetMemberGuildItemCountMessageComposer(param2,param1));
      }
      
      public function handleUserBlock(param1:int, param2:int) : void
      {
         var_2104 = new GuildKickData(param1,param2,true);
         send(new GetMemberGuildItemCountMessageComposer(param2,param1));
      }
      
      public function get newNavigator() : IHabboNewNavigator
      {
         return _newNavigator;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
   }
}
