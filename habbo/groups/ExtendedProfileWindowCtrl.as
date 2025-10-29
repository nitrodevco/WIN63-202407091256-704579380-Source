package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.friendlist.RelationshipStatusEnum;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   import com.sulake.habbo.communication.messages.incoming.users.class_1581;
   import com.sulake.habbo.communication.messages.incoming.users.class_1745;
   import com.sulake.habbo.communication.messages.incoming.users.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.users.SelectFavouriteHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetRelationshipStatusInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.DeselectFavouriteHabboGroupMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetSelectedBadgesMessageComposer;
   
   public class ExtendedProfileWindowCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:IWindowContainer;
      
      private var var_2597:IItemListWindow;
      
      private var var_3972:IWindowContainer;
      
      private var var_1895:int;
      
      private var var_3145:GroupDetailsCtrl;
      
      private var var_3287:IWindowContainer;
      
      private var var_47:class_1581;
      
      private var var_3650:Boolean;
      
      private var var_4419:Boolean = false;
      
      private var var_163:Map;
      
      private var var_4839:Boolean = false;
      
      public function ExtendedProfileWindowCtrl(param1:HabboGroupsManager)
      {
         var_163 = new Map();
         super();
         var_480 = param1;
         var_3145 = new GroupDetailsCtrl(param1,false);
      }
      
      public function dispose() : void
      {
         var_480 = null;
         var_2597 = null;
         var_47 = null;
         if(var_163)
         {
            var_163.dispose();
            var_163 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_3145)
         {
            var_3145.dispose();
            var_3145 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         if(var_3972 == null)
         {
            var_3972 = IWindowContainer(var_480.getXmlWindow("group_entry"));
         }
         if(var_3287 == null)
         {
            var_3287 = IWindowContainer(var_480.getXmlWindow("no_groups"));
            var_3287.findChildByName("view_groups_button").procedure = onViewGroups;
         }
         _window = class_3514(var_480.getXmlWindow("new_extended_profile"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("addasfriend_button").procedure = onAddAsFriend;
         _window.findChildByName("rooms_button").procedure = onRooms;
         var_2597 = IItemListWindow(_window.findChildByName("groups_list"));
         _window.center();
         _window.findChildByName("change_looks").procedure = onChangeLooks;
         _window.findChildByName("change_badges").procedure = onChangeBadges;
         _window.findChildByName("user_activity_points").visible = var_480.isActivityDisplayEnabled;
         for each(var _loc1_ in RelationshipStatusEnum.displayableStatuses)
         {
            _window.findChildByName(RelationshipStatusEnum.statusAsString(_loc1_) + "_friend_name_link_region").procedure = onRelationshipLink;
         }
      }
      
      public function onProfileChanged(param1:int) : void
      {
         if(var_47 != null && var_47.userId == param1 && _window != null && Boolean(_window.visible))
         {
            var_480.send(new GetExtendedProfileMessageComposer(param1));
            var_3650 = true;
         }
      }
      
      public function onProfile(param1:class_1581) : void
      {
         var_47 = param1;
         var _loc2_:class_1745 = getSelectedGroup();
         if(_loc2_ == null)
         {
            if(var_47.guilds.length > 0)
            {
               var_1895 = var_47.guilds[0].groupId;
               _loc2_ = var_47.guilds[0];
            }
            else
            {
               var_1895 = 0;
            }
         }
         if(var_1895 > 0)
         {
            var_480.send(new GetHabboGroupDetailsMessageComposer(var_1895,false));
         }
         refresh();
         _window.visible = true;
         if(!var_3650)
         {
            _window.activate();
         }
         var_3650 = false;
      }
      
      private function getSelectedGroup() : class_1745
      {
         for each(var _loc1_ in var_47.guilds)
         {
            if(_loc1_.groupId == var_1895)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function refresh() : void
      {
         var_480.send(new GetRelationshipStatusInfoMessageComposer(var_47.userId));
         var_480.send(new GetSelectedBadgesMessageComposer(var_47.userId));
         prepareWindow();
         refreshHeader();
         refreshGroupList();
      }
      
      private function refreshGroupList() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc2_:IBadgeImageWidget = null;
         var _loc4_:IWindowContainer = null;
         var _loc3_:* = var_47.userId == var_480.avatarId;
         var_2597.visible = var_47.guilds.length > 0;
         var_2597.destroyListItems();
         for each(var _loc5_ in var_47.guilds)
         {
            _loc1_ = IWindowContainer(var_3972.clone());
            _loc1_.id = _loc5_.groupId;
            _loc1_.findChildByName("bg_region").procedure = onSelectGroup;
            _loc1_.findChildByName("bg_region").id = _loc5_.groupId;
            _loc1_.findChildByName("clear_favourite").procedure = onClearFavourite;
            _loc1_.findChildByName("clear_favourite").visible = _loc5_.favourite && _loc3_;
            _loc1_.findChildByName("clear_favourite").id = _loc5_.groupId;
            _loc1_.findChildByName("make_favourite").procedure = onMakeFavourite;
            _loc1_.findChildByName("make_favourite").visible = !_loc5_.favourite && _loc3_;
            _loc1_.findChildByName("make_favourite").id = _loc5_.groupId;
            _loc2_ = IBadgeImageWidget(IWidgetWindow(_loc1_.findChildByName("group_pic_bitmap")).widget);
            _loc2_.type = "group";
            _loc2_.badgeId = _loc5_.badgeCode;
            _loc2_.groupId = _loc5_.groupId;
            var_2597.addListItem(_loc1_);
         }
         refreshGroupListSelection();
         var_480.localization.registerParameter("extendedprofile.groups.count","count",var_47.guilds.length.toString());
         if(var_47.guilds.length < 1)
         {
            (_loc4_ = IWindowContainer(_window.findChildByName("group_cont"))).removeChildAt(0);
            _loc4_.addChild(var_3287);
            var_3287.findChildByName("no_groups_caption").caption = var_480.localization.getLocalization(_loc3_ ? "extendedprofile.nogroups.me" : "extendedprofile.nogroups.user");
            var_3287.findChildByName("view_groups_button").visible = true;
         }
      }
      
      private function refreshGroupListSelection() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowContainer = null;
         _loc2_ = 0;
         while(_loc2_ < var_2597.numListItems)
         {
            _loc1_ = IWindowContainer(var_2597.getListItemAt(_loc2_));
            _loc1_.findChildByName("bg_selected_bitmap").visible = var_1895 == _loc1_.id;
            _loc1_.findChildByName("bg_unselected_bitmap").visible = var_1895 != _loc1_.id;
            _loc2_++;
         }
      }
      
      private function refreshHeader() : void
      {
         var _loc1_:* = var_47.userId == var_480.avatarId;
         _window.findChildByName("motto_txt").caption = var_47.motto;
         _window.findChildByName("status_txt").visible = var_47.isFriend || _loc1_;
         _window.findChildByName("friend_request_sent_txt").visible = var_47.isFriendRequestSent;
         _window.findChildByName("offline_icon").visible = !var_47.isOnline;
         _window.findChildByName("online_icon").visible = var_47.isOnline;
         _window.findChildByName("status").invalidate();
         var_480.localization.registerParameter("extendedprofile.username","username",var_47.userName);
         var_480.localization.registerParameter("extendedprofile.created","created",var_47.creationDate);
         var_480.localization.registerParameter("extendedprofile.activitypoints","activitypoints",var_47.achievementScore.toString());
         var_480.localization.registerParameter("extendedprofile.last.login","lastlogin",FriendlyTime.getFriendlyTime(var_480.localization,var_47.lastAccessSinceInSeconds,".ago"));
         _window.findChildByName("user_last_login").visible = var_47.lastAccessSinceInSeconds > -1;
         refreshAvatarImage();
         var _loc2_:* = var_47.friendCount > -1;
         var _loc3_:Boolean = var_47.isFriend && _loc2_ || _loc1_;
         _window.findChildByName("addasfriend_button").visible = !var_47.isFriend && !var_47.isFriendRequestSent && !_loc1_ && var_480.friendlist.canBeAskedForAFriend(var_47.userId) && _loc2_;
         _window.findChildByName("ok_icon").visible = _loc3_;
         _window.findChildByName("status_txt").visible = _loc3_;
         _window.findChildByName("top_right").visible = _loc2_;
         _window.findChildByName("status_txt").caption = var_480.localization.getLocalization(var_47.isFriend ? "extendedprofile.friend" : "extendedprofile.me");
         _window.findChildByName("change_own_attributes").visible = _loc1_;
         _window.findChildByName("levelValue").caption = var_47.accountLevel.toString();
         _window.findChildByName("starGemCount").caption = var_47.starGemCount.toString();
      }
      
      private function refreshRelationships() : void
      {
         var _loc1_:Boolean = var_480.getBoolean("relationship.status.enabled");
         if(_loc1_ && _window)
         {
            _window.findChildByName("rel_status_label_txt").visible = true;
            for each(var _loc2_ in RelationshipStatusEnum.displayableStatuses)
            {
               setRelationshipDetails(_loc2_);
            }
         }
         var_480.localization.registerParameter("extendedprofile.friends.count","count",var_47.friendCount.toString());
      }
      
      private function setRelationshipDetails(param1:int) : void
      {
         var _loc4_:class_1758 = var_163.getValue(param1);
         var _loc5_:String = RelationshipStatusEnum.statusAsString(param1);
         var _loc6_:IWindow = _window.findChildByName(_loc5_ + "_txt");
         var _loc3_:IWindow = _window.findChildByName(_loc5_ + "_friend_name_link_text");
         var _loc2_:IWidgetWindow = IWidgetWindow(_window.findChildByName(_loc5_ + "_head"));
         if(_loc4_ && _loc4_.friendCount > 0)
         {
            _loc3_.caption = _loc4_.randomFriendName;
            _loc2_.visible = true;
            IAvatarImageWidget(_loc2_.widget).figure = _loc4_.randomFriendFigure;
            if(_loc4_.friendCount > 1)
            {
               _loc6_.visible = true;
               _loc6_.invalidate();
               _loc6_.caption = var_480.localization.getLocalizationWithParams("extendedprofile.relstatus.others." + _loc5_,"","count","" + (_loc4_.friendCount - 1));
            }
            else
            {
               _loc6_.visible = false;
            }
         }
         else
         {
            _loc2_.visible = false;
            _loc3_.caption = "${extendedprofile.add.friends}";
            _loc6_.caption = "${extendedprofile.no.friends.in.this.category}";
            _loc6_.visible = true;
         }
      }
      
      public function onGroupDetails(param1:class_1199) : void
      {
         var _loc2_:IWindowContainer = null;
         if(var_1895 == param1.groupId)
         {
            _loc2_ = IWindowContainer(_window.findChildByName("group_cont"));
            _loc2_.removeChildAt(0);
            _loc2_.invalidate();
            var_3145.onGroupDetails(_loc2_,param1);
         }
      }
      
      public function onRelationshipStatusInfo(param1:int, param2:Map) : void
      {
         if(var_47 && relationshipUpdateExpected)
         {
            var_163 = param2.clone();
            refreshRelationships();
            relationshipUpdateExpected = false;
         }
      }
      
      public function onUserBadges(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:IBadgeImageWidget = null;
         if(var_47 && badgeUpdateExpected && _window != null)
         {
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               _loc3_ = IBadgeImageWidget(IWidgetWindow(_window.findChildByName("badge_" + _loc4_)).widget);
               _loc3_.type = "normal";
               _loc3_.badgeId = _loc4_ < param2.length ? param2[_loc4_] : "";
               _loc4_++;
            }
            badgeUpdateExpected = false;
         }
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         var _loc3_:IWindow = _window.findChildByName(param1);
         _loc3_.mouseThreshold = 0;
         _loc3_.procedure = param2;
      }
      
      private function onAddAsFriend(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.friendlist.askForAFriend(var_47.userId,var_47.userName);
         var_47.isFriendRequestSent = true;
         refresh();
      }
      
      private function onRooms(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.newNavigator.performSearch("hotel_view","owner:" + var_47.userName);
      }
      
      private function onRelationshipLink(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:String = null;
         var _loc3_:class_1758 = null;
         var _loc5_:int = 0;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param1.target != null && param2.name != null && var_163 != null)
         {
            _loc4_ = param2.name.substr(0,param2.name.indexOf("_"));
            _loc3_ = var_163.getValue(RelationshipStatusEnum.stringAsStatus(_loc4_));
            if(_loc3_ != null)
            {
               if(_loc5_ = _loc3_.randomFriendId)
               {
                  var_480.showExtendedProfile(_loc5_);
               }
            }
            else
            {
               var_480.windowManager.alert("${extendedprofile.add.friends.alert.title}","${extendedprofile.add.friends.alert.body}",0,addFriendsAlertCallback);
            }
         }
      }
      
      private function onViewGroups(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.navigator.performGuildBaseSearch();
      }
      
      private function onSelectGroup(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_1895 = param2.id;
         var_480.send(new GetHabboGroupDetailsMessageComposer(var_1895,false));
         var_480.send(new EventLogMessageComposer("HabboGroups","" + param2.id,"select"));
         this.refreshGroupListSelection();
      }
      
      private function onMakeFavourite(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.send(new SelectFavouriteHabboGroupMessageComposer(param2.id));
         var_480.send(new EventLogMessageComposer("HabboGroups","" + param2.parent.id,"make favourite"));
         var_1895 = param2.id;
      }
      
      private function onClearFavourite(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.send(new DeselectFavouriteHabboGroupMessageComposer(param2.id));
         var_480.send(new EventLogMessageComposer("HabboGroups","" + param2.parent.id,"clear favourite"));
         var_1895 = param2.id;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      private function onChangeLooks(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.context.createLinkEvent("avatareditor/open");
      }
      
      private function onChangeBadges(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.context.createLinkEvent("inventory/open/badges");
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function refreshAvatarImage(param1:Boolean = false) : void
      {
         var _loc2_:IWidgetWindow = IWidgetWindow(_window.findChildByName("avatar_image"));
         var _loc3_:IAvatarImageWidget = IAvatarImageWidget(_loc2_.widget);
         _loc3_.figure = var_47.figure;
      }
      
      public function updateVisibleExtendedProfile(param1:int) : void
      {
         if(_window != null && Boolean(_window.visible) && var_47 != null && var_47.userId != param1)
         {
            var_480.send(new GetExtendedProfileMessageComposer(param1));
         }
      }
      
      public function get badgeUpdateExpected() : Boolean
      {
         return var_4419;
      }
      
      public function set badgeUpdateExpected(param1:Boolean) : void
      {
         var_4419 = param1;
      }
      
      public function set relationshipUpdateExpected(param1:Boolean) : void
      {
         var_4839 = param1;
      }
      
      public function get relationshipUpdateExpected() : Boolean
      {
         return var_4839;
      }
      
      private function addFriendsAlertCallback(param1:class_3348, param2:WindowEvent) : void
      {
         if(param2.type == "WE_OK")
         {
            var_480.context.createLinkEvent("friendbar/findfriends");
            close();
         }
         param1.dispose();
      }
   }
}
