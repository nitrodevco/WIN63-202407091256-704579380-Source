package com.sulake.habbo.friendlist
{
    import assets.class_14

    import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendlist.domain.Friend;
   import com.sulake.habbo.friendlist.domain.FriendCategory;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.class_3527;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.class_322;
   
   public class FriendsView implements ITabView, IFriendsView
   {
      
      public static const BG_NAME:String = "bg";
      
      private static const VIP_ICON_STYLE:int = 14;
      
      public static const ROOM_INVITATION_DELAY:int = 60000;
       
      
      private var _friendList:HabboFriendList;
      
      private var var_4458:class_3489;
      
      private var var_4309:class_3489;
      
      private var var_4578:class_3489;
      
      private var var_4289:class_3489;
      
      private var var_19:IItemListWindow;
      
      private var var_2424:RelationshipStatusSelector;
      
      public function FriendsView()
      {
         super();
      }
      
      public function init(param1:HabboFriendList) : void
      {
         _friendList = param1;
      }
      
      public function getEntryCount() : int
      {
         return _friendList.categories.getFriendCount(true);
      }
      
      public function fillFooter(param1:IWindowContainer) : void
      {
         var_4458 = initButton("open_minimail",onMinimailButtonClick,param1);
         var_4309 = initButton("open_homepage",onHomeButtonClick,param1);
         var_4578 = initButton("room_invite",onInviteButtonClick,param1);
         var_4289 = initButton("remove_friend",onRemoveButtonClick,param1);
         refreshButtons();
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         var_19 = param1;
         this.refreshList();
      }
      
      public function tabClicked(param1:int) : void
      {
         if(var_2424)
         {
            var_2424.disappear();
         }
      }
      
      public function setNewMessageArrived() : void
      {
         _friendList.tabs.findTab(1).setNewMessageArrived(true);
      }
      
      public function refreshList() : void
      {
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = 0;
         var _loc2_:Boolean = false;
         if(var_19 == null)
         {
            return;
         }
         if(!var_2424)
         {
            var_2424 = new RelationshipStatusSelector(_friendList);
         }
         var_2424.disappear();
         var_19.autoArrangeItems = false;
         var _loc6_:int = 0;
         for each(var _loc4_ in _friendList.categories.getCategories())
         {
            refreshEntry(true,_loc6_,_loc4_,null);
            _loc6_++;
            if(_loc4_.open)
            {
               _loc1_ = _loc4_.getStartFriendIndex();
               _loc5_ = _loc4_.getEndFriendIndex();
               _loc3_ = _loc1_;
               while(_loc3_ < _loc5_)
               {
                  refreshEntry(true,_loc6_,_loc4_,_loc4_.friends[_loc3_]);
                  _loc6_++;
                  _loc3_++;
               }
            }
         }
         while(true)
         {
            _loc2_ = refreshEntry(false,_loc6_,null,null);
            if(_loc2_)
            {
               break;
            }
            _loc6_++;
         }
         var_19.autoArrangeItems = true;
         refreshButtons();
      }
      
      public function refreshed() : void
      {
         if(var_2424)
         {
            var_2424.disappear();
         }
      }
      
      private function initButton(param1:String, param2:Function, param3:IWindowContainer) : class_3489
      {
         var _loc4_:class_3489;
         (_loc4_ = class_3489(param3.findChildByName("button_" + param1))).procedure = param2;
         var _loc5_:IBitmapWrapperWindow;
         (_loc5_ = IBitmapWrapperWindow(_loc4_.findChildByName("icon"))).bitmap = _friendList.getButtonImage(param1);
         _loc5_.width = _loc5_.bitmap.width;
         _loc5_.height = _loc5_.bitmap.height;
         return _loc4_;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:FriendCategory, param4:Friend) : Boolean
      {
         var _loc6_:* = param2 % 2 == 1;
         var _loc5_:IWindowContainer;
         if((_loc5_ = var_19.getListItemAt(param2) as IWindowContainer) == null)
         {
            if(!param1)
            {
               return true;
            }
            (_loc5_ = IWindowContainer(_friendList.getXmlWindow("friend_entry"))).findChildByName("user_info_region").procedure = onUserInfo;
            var_19.addListItem(_loc5_);
         }
         Util.hideChildren(_loc5_);
         if(!param1)
         {
            _loc5_.height = 0;
            _loc5_.visible = false;
            return false;
         }
         _loc5_.height = 20;
         _loc5_.visible = true;
         _loc5_.color = _friendList.laf.getRowShadingColor(1,_loc6_);
         if(param4 == null)
         {
            param3.view = _loc5_;
            this.refreshCategoryEntry(param3,_loc6_);
         }
         else
         {
            param4.view = _loc5_;
            this.refreshFriendEntry(param3,param4,_loc6_);
         }
         return false;
      }
      
      public function refreshCategoryEntry(param1:FriendCategory, param2:Boolean) : void
      {
         if(this.var_19 == null)
         {
            return;
         }
         var _loc3_:IWindowContainer = param1.view;
         _loc3_.tags.splice(0,_loc3_.tags.length);
         _loc3_.tags.push(param1.id);
         _friendList.refreshText(_loc3_,"caption",true,param1.name + " (" + param1.friends.length + ")");
         refreshCatIcon(_loc3_,"arrow_down_black",param1.open,param1.id,6);
         refreshCatIcon(_loc3_,"arrow_right_black",!param1.open,param1.id,9);
         _loc3_.procedure = onCategoryClick;
         _loc3_.visible = false;
         refreshPager(param1,param2);
         _loc3_.height = Math.max(Util.getLowestPoint(_loc3_),20);
         _loc3_.visible = true;
      }
      
      private function refreshFriendEntry(param1:FriendCategory, param2:Friend, param3:Boolean = false) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = param2.view) == null)
         {
            return;
         }
         _loc4_.id = param2.id;
         _loc4_.procedure = onFriendClick;
         _loc4_.visible = true;
         if(param2.selected)
         {
            _loc4_.color = _friendList.laf.getSelectedEntryBgColor();
         }
         else if(param3)
         {
            _loc4_.color = _friendList.laf.getRowShadingColor(1,true);
         }
         ILabelWindow(param2.view.findChildByName("name")).textColor = _friendList.laf.getFriendTextColor(param2.selected);
         var _loc5_:String = param2.name;
         if(param2.realName != null && param2.realName != "")
         {
            _loc5_ = _loc5_ + " (" + param2.realName + ")";
         }
         _friendList.refreshText(_loc4_,"name",true,_loc5_);
         var _loc6_:Boolean = _friendList.isMessagesPersisted() && (param2.persistedMessageUser || param2.pocketHabboUser);
         _friendList.refreshButton(_loc4_,"start_chat",param2.online || _loc6_,onChatButtonClick,param2.id);
         _friendList.refreshButton(_loc4_,"follow_friend",param2.followingAllowed,onFollowButtonClick,param2.id);
         _friendList.refreshRelationshipRegion(_loc4_,"relationship_status",param2.relationshipStatus,onRelationshipStatusRegion,param2.id);
         refreshFigure(_loc4_,param2);
         _loc4_.findChildByName("user_info_region").visible = true;
         _loc4_.findChildByName("user_info_region").id = param2.id;
         class_3527.setUserInfoState(false,_loc4_);
      }
      
      private function refreshCatIcon(param1:IWindowContainer, param2:String, param3:Boolean, param4:int, param5:int) : void
      {
         var _loc6_:ILabelWindow = null;
         var _loc7_:IWindow = null;
         _friendList.refreshButton(param1,param2,param3,onCategoryClick,param4);
         if(param3)
         {
            _loc6_ = ILabelWindow(param1.findChildByName("caption"));
            (_loc7_ = param1.findChildByName(param2)).x = _loc6_.textWidth + param5;
         }
      }
      
      private function refreshFigure(param1:IWindowContainer, param2:Friend) : void
      {
         var _loc3_:BitmapData = null;
         if(!param1)
         {
            ErrorReportStorage.addDebugData("FriendsView","refreshFigure: e is null!");
         }
         if(!param2)
         {
            ErrorReportStorage.addDebugData("FriendsView","refreshFigure: f is null!");
         }
         var _loc4_:IBitmapWrapperWindow;
         if(!(_loc4_ = param1.getChildByName("face") as IBitmapWrapperWindow))
         {
            ErrorReportStorage.addDebugData("FriendsView","refreshFigure: child is null!");
         }
         if(!_friendList)
         {
            ErrorReportStorage.addDebugData("FriendsView","refreshFigure: _friendList is null!");
         }
         if(param2.figure == null || param2.figure == "")
         {
            _loc4_.visible = false;
         }
         else
         {
            if(param2.face == null)
            {
               if(param2.isGroupFriend())
               {
                  param2.face = _friendList.getSmallGroupBadgeBitmap(param2.figure);
               }
               else
               {
                  param2.face = _friendList.getAvatarFaceBitmap(param2.figure);
               }
            }
            if(_loc4_.bitmap == null)
            {
               _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height);
            }
            if(_loc4_.tags[0] != param2.figure)
            {
               _loc4_.tags.splice(0,_loc4_.tags.length);
               _loc4_.tags.push(param2.figure);
               _loc4_.bitmap.fillRect(_loc4_.bitmap.rect,0);
               _loc3_ = param2.face;
               if(_loc3_)
               {
                  _loc4_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0),null,null,true);
               }
            }
            else
            {
               class_14.log("Figure unchanged: " + _loc4_.tags[0]);
            }
            _loc4_.visible = true;
         }
      }
      
      private function getBgColor(param1:Boolean) : uint
      {
         return _friendList.laf.getRowShadingColor(1,param1);
      }
      
      private function refreshButtons() : void
      {
         var _loc1_:Array = _friendList.categories.getSelectedFriends();
         setEnabled(var_4458,isEnableMinimailButton(_loc1_));
         setEnabled(var_4309,isEnableHomeButton(_loc1_));
         setEnabled(var_4578,isEnableInviteButton(_loc1_));
         setEnabled(var_4289,isEnableRemoveButton(_loc1_));
      }
      
      private function setEnabled(param1:class_3489, param2:Boolean) : void
      {
         if(param2)
         {
            param1.enable();
         }
         else
         {
            param1.disable();
         }
      }
      
      private function isEnableMinimailButton(param1:Array) : Boolean
      {
         return _friendList.isEmbeddedMinimailEnabled() || param1.length == 1;
      }
      
      private function isEnableHomeButton(param1:Array) : Boolean
      {
         return param1.length == 1;
      }
      
      private function isEnableInviteButton(param1:Array) : Boolean
      {
         if(param1.length < 1)
         {
            return false;
         }
         for each(var _loc2_ in param1)
         {
            if(_loc2_.online)
            {
               return true;
            }
         }
         return true;
      }
      
      private function isEnableRemoveButton(param1:Array) : Boolean
      {
         return param1.length > 0;
      }
      
      private function onCategoryClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_14.log("Category clicked: " + param2.name + ", " + param2.tags[0]);
         if(param2.tags.length == 0)
         {
            param2 = param2.parent;
         }
         class_14.log("Category id: " + param2.name + ", " + param2.tags[0]);
         var _loc3_:int = int(param2.tags[0]);
         class_14.log("Cat id: " + _loc3_);
         var _loc4_:FriendCategory = _friendList.categories.findCategory(_loc3_);
         _loc4_.setOpen(!_loc4_.open);
         this.refreshList();
         this._friendList.view.refresh("Cat open/closed");
      }
      
      private function onFriendClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Friend = null;
         if(param2 == null)
         {
            return;
         }
         if(param2.id == 0)
         {
            param2 = param2.parent;
            if(param2 == null)
            {
               return;
            }
         }
         if(param1.type == "WME_CLICK" || param1.type == "WME_DOUBLE_CLICK")
         {
            _loc3_ = _friendList.categories.findFriend(param2.id);
            if(_loc3_.id > 0)
            {
               _loc3_.selected = _loc3_ != null && !_loc3_.selected;
               refreshButtons();
               refreshList();
            }
            if(param1.type == "WME_DOUBLE_CLICK" && _loc3_ != null && _loc3_.online)
            {
               _friendList.messenger.startConversation(_loc3_.id);
            }
         }
      }
      
      private function onChatButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.im}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         class_14.log("chat clicked: " + param2.name + ", " + param2.id);
         _friendList.messenger.startConversation(param2.id);
      }
      
      private function onFollowButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.follow}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _friendList.send(new FollowFriendMessageComposer(param2.id));
         _friendList.send(new EventLogMessageComposer("Navigation","Friend List","go.friendlist"));
      }
      
      private function onRelationshipStatusRegion(param1:WindowEvent, param2:IWindow) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param2.id == 0)
         {
            param2 = param2.parent;
            if(param2 == null)
            {
               return;
            }
         }
         _friendList.view.showInfo(param1,"${friendlist.tip.relationship}");
         if(param1.type == "WME_CLICK")
         {
            var_2424.friendId = param2.id;
            var_2424.appearAt(param2,_friendList.view.mainWindow);
         }
      }
      
      private function onUserInfo(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${infostand.profile.link.tooltip}");
         if(param1.type == "WME_OVER")
         {
            class_3527.setUserInfoState(true,IWindowContainer(param2));
         }
         else if(param1.type == "WME_OUT")
         {
            class_3527.setUserInfoState(false,IWindowContainer(param2));
         }
         else if(param1.type == "WME_CLICK")
         {
            _friendList.trackGoogle("extendedProfile","friendList_friendsView");
            _friendList.send(new class_322(param2.parent.id));
         }
      }
      
      private function onMinimailButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc5_:int = 0;
         _friendList.view.showInfo(param1,"${friendlist.tip.compose}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc4_:Array;
         if((_loc4_ = _friendList.categories.getSelectedFriends()).length == 0)
         {
            class_14.log("No friend found when minimail clicked");
            if(_friendList.isEmbeddedMinimailEnabled())
            {
               HabboWebTools.openMinimail("#mail/inbox/");
            }
            return;
         }
         var _loc6_:Dictionary = new Dictionary();
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length && _loc5_ < 50)
         {
            _loc3_.push(_loc4_[_loc5_].id);
            _loc5_++;
         }
         _loc6_["recipientid"] = _loc3_.join(",");
         _loc6_["random"] = "" + Math.round(Math.random() * 100000000);
         var _loc7_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_friendList.isEmbeddedMinimailEnabled())
         {
            HabboWebTools.openMinimail("#mail/compose/" + _loc6_["recipientid"] + "/" + _loc6_["random"] + "/");
         }
         else
         {
            _friendList.openHabboWebPage("link.format.mail.compose",_loc6_,_loc7_.stageX,_loc7_.stageY);
         }
      }
      
      private function onHomeButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.home}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:Friend = _friendList.categories.getSelectedFriend();
         if(_loc3_ == null)
         {
            class_14.log("No friend found when home clicked");
            return;
         }
         var _loc4_:Dictionary;
         (_loc4_ = new Dictionary())["ID"] = "" + _loc3_.id;
         _loc4_["username"] = _loc3_.name;
         var _loc5_:WindowMouseEvent = param1 as WindowMouseEvent;
         _friendList.openHabboWebPage("link.format.userpage",_loc4_,_loc5_.stageX,_loc5_.stageY);
      }
      
      private function onInviteButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.invite}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(getTimer() - _friendList.lastRoomInvitationTime < 60000)
         {
            _friendList.simpleAlert("${friendlist.invite.frequentalert.title}","${friendlist.invite.frequentalert.text}");
            return;
         }
         new RoomInviteView(_friendList).show();
      }
      
      private function onRemoveButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.remove}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         new FriendRemoveView(_friendList).show();
      }
      
      private function refreshPager(param1:FriendCategory, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IWindowContainer = IWindowContainer(param1.view.findChildByName("pager"));
         if(param1.getPageCount() < 2 || !param1.open)
         {
            class_14.log("PAGER NOT VISIBLE: " + param1.open + ", " + param1.getPageCount());
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         Util.hideChildren(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < param1.getPageCount())
         {
            refreshPageLink(_loc4_,_loc3_,param1.pageIndex,param2);
            _loc3_++;
         }
         Util.layoutChildrenInArea(_loc4_,_loc4_.width,15);
         _loc4_.height = Util.getLowestPoint(_loc4_);
      }
      
      private function refreshPageLink(param1:IWindowContainer, param2:int, param3:int, param4:Boolean) : void
      {
         var _loc5_:String = "page." + param2;
         var _loc6_:ITextWindow;
         if((_loc6_ = ITextWindow(param1.getChildByName(_loc5_))) == null)
         {
            (_loc6_ = ITextWindow(_friendList.getXmlWindow("pagelink"))).name = _loc5_;
            param1.addChild(_loc6_);
         }
         _loc6_.underline = param2 != param3;
         _loc6_.text = "" + (param2 * 100 + 1) + "-" + ("" + (param2 + 1) * 100);
         _loc6_.id = param2;
         _loc6_.procedure = onPageLinkClick;
         _loc6_.width = _loc6_.textWidth + 5;
         _loc6_.color = _friendList.laf.getRowShadingColor(1,param4);
         _loc6_.visible = true;
      }
      
      private function onPageLinkClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc6_:ITextWindow;
         var _loc3_:int = int((_loc6_ = ITextWindow(param2)).parent.parent.tags[0]);
         var _loc5_:int = int(_loc6_.id);
         class_14.log("Page link clicked: " + _loc3_ + ", " + _loc5_);
         var _loc4_:FriendCategory;
         (_loc4_ = _friendList.categories.findCategory(_loc3_)).pageIndex = _loc5_;
         this.refreshList();
      }
   }
}
