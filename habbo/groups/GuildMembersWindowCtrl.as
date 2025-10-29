package com.sulake.habbo.groups
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.InfoText;
   import com.sulake.habbo.utils.LoadingIcon;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.users.class_1631;
   import com.sulake.habbo.communication.messages.incoming.users.class_1212;
   import com.sulake.habbo.communication.messages.incoming.users.class_1251;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.RejectMembershipRequestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.AddAdminRightsToMemberMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.class_224;
   import com.sulake.habbo.communication.messages.outgoing.users.class_312;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   import com.sulake.habbo.communication.messages.outgoing.users.class_585;
   import com.sulake.habbo.communication.messages.outgoing.users.class_915;
   
   public class GuildMembersWindowCtrl implements IDisposable
   {
      
      private static const MEMBER_SPACING:Point = new Point(5,5);
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:class_3514;
      
      private var _groupId:int;
      
      private var var_2159:Timer;
      
      private var var_47:class_1212;
      
      private var var_784:InfoText;
      
      private var _loadingIcon:LoadingIcon;
      
      public function GuildMembersWindowCtrl(param1:HabboGroupsManager)
      {
         var_2159 = new Timer(1000,1);
         super();
         var_480 = param1;
         var_2159.addEventListener("timer",onSearchTimer);
         _loadingIcon = new LoadingIcon();
      }
      
      public function dispose() : void
      {
         var_480 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_784 != null)
         {
            var_784.dispose();
            var_784 = null;
         }
         if(var_2159)
         {
            var_2159.removeEventListener("timer",onSearchTimer);
            var_2159.stop();
            var_2159 = null;
         }
         if(_loadingIcon)
         {
            _loadingIcon.dispose();
            _loadingIcon = null;
         }
      }
      
      private function setSearchingIcon(param1:Boolean) : void
      {
         if(_window)
         {
            _loadingIcon.setVisible(IIconWindow(_window.findChildByName("searching_icon")),param1);
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      public function onGuildMembers(param1:IMessageEvent) : void
      {
         var_47 = GuildMembersMessageEvent(param1).data;
         show();
         populateSearchTypes();
         populateUserNameFilter();
      }
      
      public function onGuildMembershipUpdated(param1:IMessageEvent) : void
      {
         var _loc2_:GuildMembershipUpdatedMessageEvent = GuildMembershipUpdatedMessageEvent(param1);
         if(var_47 != null && var_47.groupId == _loc2_.guildId)
         {
            var_47.update(_loc2_.data);
            reload();
         }
      }
      
      public function onGuildMemberMgmtFailed(param1:IMessageEvent) : void
      {
         var _loc2_:GuildMemberMgmtFailedMessageEvent = GuildMemberMgmtFailedMessageEvent(param1);
         var _loc3_:int = _loc2_.reason;
         var _loc4_:String = "group.membermgmt.fail." + _loc3_;
         var _loc5_:String = String(var_480.localization.getLocalization(_loc4_,_loc4_));
         var_480.windowManager.alert("${group.membermgmt.fail.title}",_loc5_,0,null);
         if(var_47 != null && var_47.groupId == _loc2_.guildId && _window != null && Boolean(_window.visible))
         {
            doSearch(var_47.pageIndex);
         }
      }
      
      public function onGuildMembershipRejected(param1:IMessageEvent) : void
      {
         var _loc2_:GuildMembershipRejectedMessageEvent = GuildMembershipRejectedMessageEvent(param1);
         if(_window && _window.visible && var_47 != null && var_47.groupId == _loc2_.getParser().guildId)
         {
            doSearch(var_47.pageIndex);
         }
      }
      
      public function onMembershipRequested(param1:IMessageEvent) : void
      {
         var _loc2_:class_1631 = GroupMembershipRequestedMessageEvent(param1).getParser();
         if(_window && _window.visible && var_47 != null && var_47.groupId == _loc2_.groupId)
         {
            doSearch(var_47.pageIndex);
         }
      }
      
      public function onMembersClick(param1:int, param2:int) : void
      {
         if(!var_480.getBoolean("groupMembers.enabled"))
         {
            return;
         }
         if(_window != null && Boolean(_window.visible) && _groupId == param1)
         {
            close();
         }
         else
         {
            if(var_784)
            {
               var_784.goBackToInitialState();
            }
            _groupId = param1;
            var_480.send(new GetGuildMembersMessageComposer(param1,0,"",param2));
         }
      }
      
      public function show() : void
      {
         prepareWindow();
         refresh();
         _window.visible = true;
         _window.activate();
      }
      
      public function reload() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            refresh();
         }
      }
      
      private function refresh() : void
      {
         var _loc2_:int = 0;
         var_480.localization.registerParameter("group.members.title","groupName",var_47.groupName);
         var _loc3_:IWindowContainer = IWindowContainer(_window.findChildByName("members_cont"));
         var _loc4_:Array = var_47.entries;
         _loc2_ = 0;
         while(_loc2_ < var_47.pageSize)
         {
            refreshEntry(_loc3_,_loc2_,_loc4_[_loc2_]);
            _loc2_++;
         }
         var _loc1_:IBadgeImageWidget = IWidgetWindow(_window.findChildByName("group_logo")).widget as IBadgeImageWidget;
         _loc1_.badgeId = var_47.badgeCode;
         _loc1_.groupId = var_47.groupId;
         var_480.localization.registerParameter("group.members.pageinfo","amount","" + var_47.totalEntries);
         var_480.localization.registerParameter("group.members.pageinfo","page","" + (var_47.pageIndex + 1));
         var_480.localization.registerParameter("group.members.pageinfo","totalPages","" + var_47.totalPages);
         _window.findChildByName("previous_page_button").visible = hasPreviousPage();
         _window.findChildByName("next_page_button").visible = hasNextPage();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(var_480.getXmlWindow("guild_members_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("previous_page_button").procedure = onPreviousPage;
         _window.findChildByName("next_page_button").procedure = onNextPage;
         var_784 = new InfoText(ITextFieldWindow(_window.findChildByName("filter_members_input")),var_480.localization.getLocalization("group.members.searchinfo"));
         _window.center();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _groupId = 0;
            _window.visible = false;
         }
      }
      
      private function refreshEntry(param1:IWindowContainer, param2:int, param3:class_1251) : void
      {
         var _loc4_:IWindowContainer;
         if((_loc4_ = IWindowContainer(param1.getChildAt(param2))) == null)
         {
            if(param3 == null)
            {
               return;
            }
            (_loc4_ = getListEntry()).tags[0] = "" + param2;
            param1.addChild(_loc4_);
            _loc4_.x = param2 % 2 == 0 ? 0 : _loc4_.width + MEMBER_SPACING.x;
            _loc4_.y = Math.floor(param2 / 2) * (_loc4_.height + MEMBER_SPACING.y);
         }
         if(param3 != null)
         {
            refreshUserEntry(_loc4_,param3);
            _loc4_.visible = true;
         }
         else
         {
            _loc4_.visible = false;
         }
      }
      
      public function refreshUserEntry(param1:IWindowContainer, param2:class_1251) : void
      {
         var _loc8_:* = false;
         param1.findChildByName("user_name_txt").caption = param2.userName;
         param1.findChildByName("icon_owner").visible = param2.owner;
         this.setAdminState(param2.member,param2.admin,param1);
         var _loc5_:IWindow;
         (_loc5_ = param1.findChildByName("admin_container")).visible = !_loc8_ && (param2.admin || var_47.allowedToManage);
         var _loc9_:IRegionWindow;
         (_loc9_ = IRegionWindow(param1.findChildByName("bg_region"))).id = param2.userId;
         this.setRemoveState(false,param1);
         this.setActionLinkState(false,param1);
         _loc8_ = param2.userId == var_480.avatarId;
         var _loc11_:IRegionWindow;
         (_loc11_ = IRegionWindow(param1.findChildByName("remove_region"))).toolTipCaption = var_480.localization.getLocalization(param2.member ? "group.members.kick" : "group.members.reject");
         _loc11_.visible = !param2.owner && !_loc8_ && var_47.allowedToManage && !param2.blocked;
         _loc11_.id = param2.userId;
         var _loc6_:Boolean = param2.member && !param2.owner && !_loc8_ && var_47.allowedToManage && var_480.getBoolean("group.blocking.enabled") && !param2.blocked;
         var _loc3_:IRegionWindow = IRegionWindow(param1.findChildByName("block_region"));
         _loc3_.toolTipCaption = var_480.localization.getLocalization("group.members.block");
         _loc3_.visible = _loc6_;
         _loc3_.id = param2.userId;
         var _loc4_:Boolean = !_loc8_ && var_47.allowedToManage;
         var _loc10_:IRegionWindow;
         (_loc10_ = IRegionWindow(param1.findChildByName("action_link_region"))).visible = _loc4_;
         _loc10_.id = param2.userId;
         var _loc7_:ITextWindow;
         (_loc7_ = ITextWindow(param1.findChildByName("member_since_txt"))).visible = !_loc4_ && param2.memberSince != "";
         var_480.localization.registerParameter("group.members.since","date",param2.memberSince);
         _loc7_.caption = var_480.localization.getLocalization("group.members.since");
         IAvatarImageWidget(IWidgetWindow(param1.findChildByName("avatar_image")).widget).figure = param2.figure;
         if(param2.blocked)
         {
            setActionLink(param1,"group.members.unblock",false);
         }
         else if(param2.owner)
         {
            setActionLink(param1,"group.members.owner",false);
         }
         else if(param2.admin)
         {
            setActionLink(param1,"group.members.removerights",true);
         }
         else if(param2.member)
         {
            setActionLink(param1,"group.members.giverights",true);
         }
         else
         {
            setActionLink(param1,"group.members.accept",true);
         }
      }
      
      public function getListEntry() : IWindowContainer
      {
         var _loc1_:IWindowContainer = IWindowContainer(var_480.getXmlWindow("member_entry"));
         var _loc3_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("bg_region"));
         _loc3_.procedure = onBg;
         var _loc2_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("block_region"));
         _loc2_.addEventListener("WME_OVER",onRemoveMouseOver);
         _loc2_.addEventListener("WME_OUT",onRemoveMouseOut);
         _loc2_.addEventListener("WME_CLICK",onBlockMouseClick);
         var _loc5_:IRegionWindow;
         (_loc5_ = IRegionWindow(_loc1_.findChildByName("remove_region"))).addEventListener("WME_OVER",onRemoveMouseOver);
         _loc5_.addEventListener("WME_OUT",onRemoveMouseOut);
         _loc5_.addEventListener("WME_CLICK",onRemoveMouseClick);
         var _loc4_:IRegionWindow;
         (_loc4_ = IRegionWindow(_loc1_.findChildByName("action_link_region"))).addEventListener("WME_OVER",onActionLinkMouseOver);
         _loc4_.addEventListener("WME_OUT",onActionLinkMouseOut);
         _loc4_.addEventListener("WME_CLICK",onActionLinkClick);
         return _loc1_;
      }
      
      private function onRemoveMouseOver(param1:WindowEvent) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setRemoveState(true,_loc2_);
      }
      
      private function onRemoveMouseOut(param1:WindowEvent) : void
      {
         var _loc2_:IRegionWindow = IRegionWindow(param1.target);
         setRemoveState(false,_loc2_);
      }
      
      private function onRemoveMouseClick(param1:WindowEvent) : void
      {
         var _loc3_:IWindow = param1.target;
         var _loc2_:class_1251 = var_47.getUser(_loc3_.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         if(_loc2_.member)
         {
            var_480.handleUserKick(_loc3_.id,var_47.groupId);
         }
         else
         {
            var_480.send(new RejectMembershipRequestMessageComposer(var_47.groupId,_loc2_.userId));
         }
      }
      
      private function onBlockMouseClick(param1:WindowEvent) : void
      {
         var _loc3_:IWindow = param1.target;
         var _loc2_:class_1251 = var_47.getUser(_loc3_.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         if(_loc2_.member)
         {
            var_480.handleUserBlock(_loc3_.id,var_47.groupId);
         }
      }
      
      private function setActionLink(param1:IWindowContainer, param2:String, param3:Boolean) : void
      {
         var _loc4_:ITextWindow;
         (_loc4_ = ITextWindow(param1.findChildByName("action_link"))).text = var_480.localization.getLocalization(param2,param2);
         _loc4_.underline = param3;
      }
      
      private function setRemoveState(param1:Boolean, param2:IWindowContainer) : void
      {
         param2.findChildByName("icon_close_off").visible = !param1;
         param2.findChildByName("icon_close_over").visible = param1;
         param2.findChildByName("icon_close_down").visible = false;
      }
      
      private function setActionLinkState(param1:Boolean, param2:IWindowContainer) : void
      {
         var _loc3_:ITextWindow = ITextWindow(param2.findChildByName("action_link"));
         _loc3_.textColor = param1 ? 4280984060 : 4285492837;
      }
      
      private function onActionLinkMouseOver(param1:WindowEvent) : void
      {
         var _loc3_:IRegionWindow = IRegionWindow(param1.target);
         var _loc2_:class_1251 = var_47.getUser(param1.target.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         setActionLinkState(true,_loc3_);
         setAdminState(_loc2_.member,!_loc2_.admin,IWindowContainer(_loc3_.parent));
      }
      
      private function onActionLinkMouseOut(param1:WindowEvent) : void
      {
         var _loc3_:IRegionWindow = IRegionWindow(param1.target);
         setActionLinkState(false,_loc3_);
         var _loc2_:class_1251 = var_47.getUser(param1.target.id);
         if(_loc2_ != null)
         {
            setAdminState(_loc2_.member,_loc2_.admin,IWindowContainer(_loc3_.parent));
         }
      }
      
      private function onActionLinkClick(param1:WindowEvent) : void
      {
         var _loc2_:class_1251 = var_47.getUser(param1.target.id);
         if(_loc2_ == null || _loc2_.owner)
         {
            return;
         }
         if(_loc2_.blocked)
         {
            var_480.send(new class_915(var_47.groupId,_loc2_.userId));
         }
         else if(_loc2_.admin)
         {
            var_480.send(new class_585(var_47.groupId,_loc2_.userId));
         }
         else if(_loc2_.member)
         {
            var_480.send(new AddAdminRightsToMemberMessageComposer(var_47.groupId,_loc2_.userId));
         }
         else
         {
            var_480.send(new class_224(var_47.groupId,_loc2_.userId));
         }
      }
      
      private function setAdminState(param1:Boolean, param2:Boolean, param3:IWindowContainer) : void
      {
         param3.findChildByName("icon_admin_off").visible = param1 && param2;
         param3.findChildByName("icon_admin_over").visible = param1 && !param2;
      }
      
      private function onBg(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_480.send(new class_322(param2.id));
         }
      }
      
      private function onFilterMembers(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_CHANGE")
         {
            var_2159.reset();
            var_2159.start();
            setSearchingIcon(true);
         }
      }
      
      private function onTypeDropmenu(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_SELECTED")
         {
            doSearch(0);
         }
      }
      
      private function doSearch(param1:int) : void
      {
         var_2159.stop();
         var_2159.reset();
         setSearchingIcon(true);
         var _loc2_:class_1212 = var_47;
         var _loc3_:String = var_784.getText();
         var _loc4_:int = getTypeDropMenu().selection;
         var_480.send(new GetGuildMembersMessageComposer(_loc2_.groupId,param1,_loc3_,_loc4_));
      }
      
      private function onAcceptAll(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_480.send(new class_312(var_47.groupId));
      }
      
      private function getTypeDropMenu() : class_3520
      {
         return class_3520(_window.findChildByName("type_drop_menu"));
      }
      
      private function onSearchTimer(param1:Event) : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            doSearch(0);
         }
      }
      
      private function onNextPage(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         doSearch(limitPageIndex(var_47.pageIndex + 1));
      }
      
      private function onPreviousPage(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         doSearch(limitPageIndex(var_47.pageIndex - 1));
      }
      
      private function hasPreviousPage() : Boolean
      {
         return var_47.pageIndex != limitPageIndex(var_47.pageIndex - 1);
      }
      
      private function hasNextPage() : Boolean
      {
         return var_47.pageIndex != limitPageIndex(var_47.pageIndex + 1);
      }
      
      private function limitPageIndex(param1:int) : int
      {
         var _loc2_:int = Math.ceil(var_47.totalEntries / var_47.pageSize);
         return Math.max(0,Math.min(param1,_loc2_ - 1));
      }
      
      public function get data() : class_1212
      {
         return var_47;
      }
      
      private function populateSearchTypes() : void
      {
         var _loc2_:Array = [];
         _loc2_.push("${group.members.search.all}");
         _loc2_.push("${group.members.search.admins}");
         if(var_47.allowedToManage)
         {
            _loc2_.push("${group.members.search.pending}");
            if(var_480.getBoolean("group.blocking.enabled"))
            {
               _loc2_.push("${group.members.search.blocked}");
            }
         }
         var _loc1_:class_3520 = getTypeDropMenu();
         _loc1_.procedure = null;
         _loc1_.populate(_loc2_);
         _loc1_.selection = var_47.allowedToManage ? var_47.searchType : Math.min(var_47.searchType,1);
         _loc1_.procedure = onTypeDropmenu;
      }
      
      private function populateUserNameFilter() : void
      {
         var _loc1_:ITextFieldWindow = var_784.input;
         _loc1_.procedure = null;
         if(var_784.getText() != var_47.userNameFilter)
         {
            var_784.setText(var_47.userNameFilter);
         }
         _loc1_.procedure = onFilterMembers;
         var_2159.stop();
         setSearchingIcon(false);
      }
   }
}
