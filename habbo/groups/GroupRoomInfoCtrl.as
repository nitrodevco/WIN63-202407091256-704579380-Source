package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1199;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
   
   public class GroupRoomInfoCtrl implements IDisposable
   {
      
      private static const TOOLBAR_EXTENSION_ID:String = "room_group_info";
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:IWindowContainer;
      
      private var _expanded:Boolean = true;
      
      private var _group:class_1199;
      
      private var var_2536:int;
      
      public function GroupRoomInfoCtrl(param1:HabboGroupsManager)
      {
         super();
         var_480 = param1;
      }
      
      public function dispose() : void
      {
         if(toolbarAttachAllowed())
         {
            var_480.toolbar.extensionView.detachExtension("room_group_info");
         }
         var_480 = null;
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
      
      public function onRoomInfo(param1:class_1675) : void
      {
         if(!var_480.groupRoomInfoEnabled)
         {
            return;
         }
         if(param1.habboGroupId > 0)
         {
            var_2536 = param1.habboGroupId;
            var_480.send(new GetHabboGroupDetailsMessageComposer(param1.habboGroupId,false));
         }
         else
         {
            var_2536 = 0;
            close();
         }
      }
      
      public function onGroupDeactivated(param1:int) : void
      {
         if(param1 == _group.groupId || param1 == var_2536)
         {
            expectedGroupId = 0;
            close();
         }
      }
      
      public function onGroupDetails(param1:class_1199) : void
      {
         if(!var_480.groupRoomInfoEnabled)
         {
            return;
         }
         if(param1.groupId == var_2536)
         {
            _expanded = true;
            _group = param1;
            refresh();
         }
      }
      
      public function isDisplayingGroup(param1:int) : Boolean
      {
         return _window != null && _group != null && param1 == _group.groupId;
      }
      
      private function refresh() : void
      {
         if(!_group.isGuild)
         {
            return;
         }
         prepareWindow();
         _window.findChildByName("bg_expanded").visible = _expanded;
         _window.findChildByName("bg_contracted").visible = !_expanded;
         _window.findChildByName("group_name_txt").visible = _expanded;
         _window.findChildByName("join_button").visible = _expanded && _group.joiningAllowed;
         _window.findChildByName("join_button").enable();
         _window.findChildByName("request_membership_button").visible = _expanded && _group.requestMembershipAllowed;
         _window.findChildByName("manage_button").visible = _expanded && _group.isOwner;
         _window.findChildByName("group_logo").visible = _expanded;
         _window.findChildByName("group_name_txt").caption = _group.groupName;
         _window.findChildByName("info_region").visible = _expanded;
         var _loc1_:IBadgeImageWidget = IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget;
         _loc1_.badgeId = _group.badgeCode;
         _loc1_.groupId = _group.groupId;
         _window.x = 0;
         _window.y = 0;
         _window.height = _expanded ? _window.findChildByName("bg_expanded").height : int(_window.findChildByName("bg_contracted").height);
         if(toolbarAttachAllowed())
         {
            var_480.toolbar.extensionView.attachExtension("room_group_info",_window,-1,["next_quest_timer","quest_tracker","event_info_window"]);
         }
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowContainer(var_480.getXmlWindow("group_room_info"));
         _window.findChildByName("join_button").procedure = onJoin;
         _window.findChildByName("request_membership_button").procedure = onJoin;
         _window.findChildByName("manage_button").procedure = onManage;
         _window.findChildByName("title_region").procedure = onTitleClick;
         _window.findChildByName("info_region").procedure = onInfoClick;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            if(toolbarAttachAllowed())
            {
               var_480.toolbar.extensionView.detachExtension("room_group_info");
            }
            var_2536 = 0;
            _group = null;
         }
      }
      
      private function onTitleClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _expanded = !_expanded;
         refresh();
         var_480.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
      }
      
      private function onInfoClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_480.trackGoogle("groupRoomInfo","groupInfo");
            var_480.send(new GetHabboGroupDetailsMessageComposer(_group.groupId,true));
            var_480.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      private function onManage(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_480.trackGoogle("groupRoomInfo","manageGroup");
            var_480.send(new GetGuildEditInfoMessageComposer(_group.groupId));
            var_480.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      private function onJoin(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_480.trackGoogle("groupRoomInfo","joinGroup");
            _window.findChildByName("join_button").disable();
            var_480.send(new JoinHabboGroupMessageComposer(_group.groupId));
            var_480.send(new EventLogMessageComposer("HabboGroups","" + _group.groupId,"join"));
            var_480.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      public function set expectedGroupId(param1:int) : void
      {
         var_2536 = param1;
      }
      
      private function toolbarAttachAllowed() : Boolean
      {
         return var_480 != null && var_480.toolbar != null && var_480.toolbar.extensionView != null && var_480.toolbarAttachEnabled;
      }
   }
}
