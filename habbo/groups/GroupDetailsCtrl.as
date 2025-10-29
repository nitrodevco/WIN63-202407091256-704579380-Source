package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   import com.sulake.habbo.communication.messages.outgoing.users.DeactivateGuildMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
   
   public class GroupDetailsCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:IWindowContainer;
      
      private var _selectedGroup:class_1199;
      
      public function GroupDetailsCtrl(param1:HabboGroupsManager, param2:Boolean)
      {
         super();
         var_480 = param1;
      }
      
      public function dispose() : void
      {
         var_480 = null;
         _selectedGroup = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      private function prepareWindow(param1:IWindowContainer) : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IWindowContainer(var_480.getXmlWindow("group"));
         setProc("group_room_link_region",onRoomLink);
         setProc("manage_guild_region",onManageGuild);
         setProc("delete_guild_region",onDeleteGuild);
         setProc("members_region",onMembers);
         setProc("pending_members_region",onPendingMembers);
         setProc("show_groups_link_region",onShowGroups);
         setProc("buy_furni_link_region",onBuyFurni);
         _window.findChildByName("leave_button").procedure = onLeave;
         _window.findChildByName("join_button").procedure = onJoin;
         _window.findChildByName("request_membership_button").procedure = onJoin;
      }
      
      private function attachWindow(param1:IWindowContainer) : void
      {
         if(param1.getChildIndex(_window) == -1)
         {
            param1.addChild(_window);
         }
      }
      
      public function onGroupDetails(param1:IWindowContainer, param2:class_1199) : void
      {
         _selectedGroup = param2;
         prepareWindow(param1);
         attachWindow(param1);
         var _loc10_:IWindow = _window.findChildByName("group_decorate_icon_region");
         var _loc9_:IWindow;
         (_loc9_ = _window.findChildByName("group_name")).caption = param2.groupName;
         _loc10_.visible = param2.membersCanDecorate;
         _loc9_.x = param2.membersCanDecorate ? _loc10_.x + _loc10_.width : _loc10_.x;
         var _loc6_:ITextWindow;
         (_loc6_ = ITextWindow(_window.findChildByName("group_description"))).caption = param2.description;
         _loc6_.height = _loc6_.textHeight + 5;
         _window.findChildByName("group_description_scrollbar").visible = _loc6_.height > _window.findChildByName("group_description_item_list").height;
         var _loc8_:Boolean = _selectedGroup.hasBoard;
         _window.findChildByName("show_forum_link_region").visible = _loc8_;
         _window.findChildByName("show_forum_link").visible = _loc8_;
         if(_loc8_)
         {
            setProc("show_forum_link_region",onForumLink);
         }
         var_480.windowManager.registerLocalizationParameter("group.created","date","" + param2.creationDate);
         var_480.windowManager.registerLocalizationParameter("group.created","owner","" + param2.ownerName);
         _window.findChildByName("created_txt").caption = var_480.localization.getLocalization("group.created");
         var_480.windowManager.registerLocalizationParameter("group.membercount","totalMembers","" + param2.totalMembers);
         _window.findChildByName("members_txt").caption = var_480.localization.getLocalization("group.membercount");
         _window.findChildByName("group_room_link_region").visible = param2.roomId > -1;
         var_480.windowManager.registerLocalizationParameter("group.linktobase","room_name",param2.roomName);
         _window.findChildByName("group_room_link").caption = var_480.localization.getLocalization("group.linktobase");
         var _loc4_:IBadgeImageWidget;
         (_loc4_ = IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget).badgeId = _selectedGroup.badgeCode;
         _loc4_.groupId = _selectedGroup.groupId;
         _window.findChildByName("join_button").visible = param2.joiningAllowed;
         _window.findChildByName("join_button").enable();
         _window.findChildByName("request_membership_button").visible = param2.requestMembershipAllowed;
         _window.findChildByName("leave_button").visible = param2.leaveAllowed;
         _window.findChildByName("membership_pending_txt").visible = param2.status == 2;
         _window.findChildByName("youaremember_txt").visible = !_selectedGroup.isGuild && param2.status == 1;
         _window.findChildByName("youaremember_icon").visible = !_selectedGroup.isGuild && param2.status == 1;
         var _loc5_:IWindow;
         (_loc5_ = _window.findChildByName("pending_members_region")).visible = _selectedGroup.pendingMemberCount > 0;
         if(_selectedGroup.pendingMemberCount > 0)
         {
            var_480.windowManager.registerLocalizationParameter("group.pendingmembercount","amount","" + param2.pendingMemberCount);
            _window.findChildByName("pending_members_txt").caption = var_480.localization.getLocalization("group.pendingmembercount");
         }
         var _loc3_:IWindow = _window.findChildByName("manage_guild_region");
         _loc3_.visible = _selectedGroup.isOwner && _selectedGroup.isGuild;
         _loc3_.y = _loc5_.visible ? _loc5_.y + 16 : _loc5_.y;
         var _loc7_:IWindow;
         (_loc7_ = _window.findChildByName("delete_guild_region")).visible = _selectedGroup.isGuild && var_480.groupDeletionEnabled && (_selectedGroup.isOwner || var_480.sessionDataManager.hasSecurity(5));
         _loc7_.y = _loc3_.visible ? _loc3_.y + 16 : _loc5_.y;
         _window.findChildByName("you_are_owner_region").visible = _selectedGroup.isGuild && _selectedGroup.isOwner;
         _window.findChildByName("you_are_admin_region").visible = _selectedGroup.isGuild && _selectedGroup.isAdmin && !_selectedGroup.isOwner;
         _window.findChildByName("you_are_member_region").visible = _selectedGroup.isGuild && (_selectedGroup.status == 1 && !(_selectedGroup.isAdmin || _selectedGroup.isOwner));
         getGroupTypeRegion(0).visible = false;
         getGroupTypeRegion(1).visible = false;
         getGroupTypeRegion(2).visible = false;
         if(getGroupTypeRegion(param2.type) != null)
         {
            getGroupTypeRegion(param2.type).visible = true;
         }
      }
      
      private function getGroupTypeRegion(param1:int) : IWindow
      {
         return _window.findChildByName("grouptype_region_" + param1);
      }
      
      private function getGroupTypeIcon(param1:int) : IWindow
      {
         return _window.findChildByName("grouptype_icon_" + param1);
      }
      
      private function setProc(param1:String, param2:Function) : void
      {
         var _loc3_:IWindow = _window.findChildByName(param1);
         _loc3_.mouseThreshold = 0;
         _loc3_.procedure = param2;
      }
      
      private function onLeave(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","leaveGroup");
         var_480.handleUserKick(var_480.avatarId,_selectedGroup.groupId);
      }
      
      private function onJoin(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","joinGroup");
         _window.findChildByName("join_button").disable();
         var_480.send(new JoinHabboGroupMessageComposer(_selectedGroup.groupId));
         var_480.send(new EventLogMessageComposer("HabboGroups","" + _selectedGroup.groupId,"join"));
      }
      
      private function onRoomLink(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","groupBaseRoom");
         var_480.navigator.goToPrivateRoom(_selectedGroup.roomId);
         var_480.send(new EventLogMessageComposer("HabboGroups","" + _selectedGroup.groupId,"base"));
      }
      
      private function onForumLink(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.openGroupForum(_selectedGroup.groupId);
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            var_480.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            HabboWebTools.navigateToURL(param1,"_empty");
         }
      }
      
      private function onExternalLink(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function onManageGuild(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","groupManage");
         var_480.send(new GetGuildEditInfoMessageComposer(_selectedGroup.groupId));
      }
      
      private function onDeleteGuild(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.windowManager.confirm("${group.deleteconfirm.title}","${group.deleteconfirm.desc}",0,onDeleteGuildConfirmation);
      }
      
      private function onDeleteGuildConfirmation(param1:class_3441, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            var_480.trackGoogle("groupDetails","groupDelete");
            var_480.send(new DeactivateGuildMessageComposer(_selectedGroup.groupId));
         }
      }
      
      private function onMembers(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","groupMembers");
         var_480.guildMembersWindowCtrl.onMembersClick(_selectedGroup.groupId,0);
      }
      
      private function onPendingMembers(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","groupPendingMembers");
         var_480.guildMembersWindowCtrl.onMembersClick(_selectedGroup.groupId,2);
      }
      
      private function onShowGroups(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","hottestGroups");
         var_480.navigator.performGuildBaseSearch();
      }
      
      private function onBuyFurni(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.trackGoogle("groupDetails","groupFurni");
         var_480.openCatalog("guild_custom_furni");
      }
   }
}
