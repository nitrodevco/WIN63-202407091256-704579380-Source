package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1754;
   
   public class ForumsListView
   {
       
      
      private var var_319:GroupForumController;
      
      private var var_1747:GroupForumView;
      
      private var var_19:IScrollableListWindow;
      
      private var var_4120:IWindowContainer;
      
      private var _forums:Array;
      
      public function ForumsListView(param1:GroupForumView, param2:IScrollableListWindow, param3:Array)
      {
         super();
         var_1747 = param1;
         var_319 = var_1747.controller;
         var_19 = param2;
         var_4120 = var_319.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_list_item_xml())) as IWindowContainer;
         _forums = param3;
      }
      
      public function update() : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindowContainer = null;
         var _loc1_:class_1754 = null;
         var_19.invalidate();
         _loc3_ = 0;
         while(_loc3_ < _forums.length)
         {
            _loc1_ = _forums[_loc3_];
            _loc2_ = var_4120.clone() as IWindowContainer;
            _loc2_.name = "forum_" + _loc1_.groupId;
            updateListItem(_loc2_,_loc1_,_loc3_);
            var_19.addListItem(_loc2_);
            _loc3_++;
         }
         updateItemWidths();
      }
      
      private function updateListItem(param1:IWindowContainer, param2:class_1754, param3:int) : void
      {
         var _loc5_:IWindowContainer;
         (_loc5_ = param1 as IWindowContainer).color = !!((param3 + 1) % 2) ? 4293852927 : 4289914618;
         var _loc6_:int = param2.unreadMessages;
         var _loc9_:IWindow;
         (_loc9_ = _loc5_.findChildByName("texts_container")).id = param2.groupId;
         var _loc8_:ITextWindow;
         (_loc8_ = _loc5_.findChildByName("header") as ITextWindow).bold = _loc6_ > 0;
         _loc8_.text = param2.name;
         (_loc9_ = _loc5_.findChildByName("header_region")).id = param2.groupId;
         _loc9_.removeEventListener("WME_CLICK",onOpenForum);
         _loc9_.addEventListener("WME_CLICK",onOpenForum);
         (_loc9_ = _loc5_.findChildByName("details")).caption = var_319.localizationManager.getLocalizationWithParams("groupforum.view.forum_details","","rating",param2.leaderboardScore,"last_author_id",param2.lastMessageAuthorId,"last_author_name",param2.lastMessageAuthorName,"update_time",var_1747.getAsDaysHoursMinutes(param2.lastMessageTimeAsSecondsAgo));
         (_loc9_ = _loc5_.findChildByName("unread_texts_container")).id = param2.groupId;
         (_loc9_ = _loc5_.findChildByName("unread_region")).id = param2.groupId;
         _loc9_.removeEventListener("WME_CLICK",onOpenForum);
         _loc9_.addEventListener("WME_CLICK",onOpenForum);
         (_loc8_ = _loc5_.findChildByName("messages1") as ITextWindow).bold = _loc6_ > 0;
         _loc8_.text = var_319.localizationManager.getLocalizationWithParams("groupforum.view.thread_details1","","total_messages",param2.totalMessages,"new_messages",_loc6_);
         (_loc8_ = _loc5_.findChildByName("messages2") as ITextWindow).bold = _loc6_ > 0;
         _loc8_.text = var_319.localizationManager.getLocalizationWithParams("groupforum.view.thread_details2","","total_messages",param2.totalMessages,"new_messages",_loc6_);
         var _loc4_:IBadgeImageWidget;
         var _loc7_:IWidgetWindow;
         (_loc4_ = (_loc7_ = IWidgetWindow(_loc5_.findChildByName("group_icon"))).widget as IBadgeImageWidget).badgeId = param2.icon;
         _loc4_.groupId = param2.groupId;
         _loc4_.type = "group";
      }
      
      public function updateItemWidths() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < var_19.numListItems)
         {
            var_19.getListItemAt(_loc1_).width = var_19.scrollableWindow.width - 2;
            _loc1_++;
         }
      }
      
      private function onOpenForum(param1:WindowMouseEvent) : void
      {
         var_319.openGroupForum(param1.target.id);
      }
   }
}
