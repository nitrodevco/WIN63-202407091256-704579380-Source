package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1666;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1740;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1754;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1755;
   
   public class GroupForumView
   {
      
      private static const const_1205:int = 100;
       
      
      private var var_319:GroupForumController;
      
      private var var_2335:ForumsListView;
      
      private var var_2146:ThreadListView;
      
      private var var_2062:MessageListView;
      
      private var _window:class_3514;
      
      private var var_3196:IScrollableListWindow;
      
      private var var_4035:IWindow;
      
      private var var_4239:IWindow;
      
      private var var_4061:IWindow;
      
      private var var_4138:IWindow;
      
      private var _txtElement:IWindow;
      
      private var var_2837:class_3489;
      
      private var var_2264:class_3489;
      
      private var var_4583:IWindow;
      
      private var var_3810:IWindow;
      
      private var var_4029:ITextWindow;
      
      private var var_1918:ForumsListData;
      
      private var var_513:class_1755;
      
      private var var_2223:ThreadsListData;
      
      private var var_2652:MessagesListData;
      
      private var var_1824:int = 1;
      
      private var var_2269:int = 1;
      
      private var var_749:int;
      
      public function GroupForumView(param1:GroupForumController)
      {
         super();
         var_319 = param1;
         var_749 = 20;
      }
      
      private static function enable(param1:IWindow, param2:Boolean) : void
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
      
      internal static function initTopAreaForForum(param1:class_3514, param2:class_1754) : IRegionWindow
      {
         var _loc4_:IWindowContainer = param1.findChildByName("top_part") as IWindowContainer;
         var _loc6_:IWidgetWindow;
         (_loc6_ = IWidgetWindow(_loc4_.findChildByName("group_icon"))).visible = true;
         var _loc3_:IBadgeImageWidget = _loc6_.widget as IBadgeImageWidget;
         _loc3_.badgeId = param2.icon;
         _loc3_.groupId = param2.groupId;
         _loc3_.type = "group";
         var _loc8_:IStaticBitmapWrapperWindow;
         if((_loc8_ = _loc4_.findChildByName("header_icon") as IStaticBitmapWrapperWindow) != null)
         {
            _loc8_.visible = false;
         }
         var _loc7_:ITextWindow;
         (_loc7_ = _loc4_.findChildByName("top_header_text") as ITextWindow).text = param2.name;
         var _loc5_:ITextWindow;
         (_loc5_ = _loc4_.findChildByName("top_text") as ITextWindow).text = param2.description;
         return _loc4_.findChildByName("top_click_area") as IRegionWindow;
      }
      
      public function dispose() : void
      {
         if(var_319)
         {
            var_319.closeMainView();
         }
         if(_window != null)
         {
            _window.removeEventListener("click",onClickButton);
            _window.dispose();
            _window = null;
            var_319 = null;
         }
      }
      
      private function initCommonControls() : void
      {
         var _loc2_:IWindow = _window.findChildByName("settings_button");
         if(var_513 != null && var_513.canChangeSettings)
         {
            _loc2_.removeEventListener("WME_CLICK",onSettingsButtonClick);
            _loc2_.addEventListener("WME_CLICK",onSettingsButtonClick);
            _loc2_.visible = true;
         }
         else
         {
            _loc2_.visible = false;
         }
         var _loc1_:ILabelWindow = var_2837.findChildByName("back_button_label") as ILabelWindow;
         if(var_2146 != null)
         {
            var_2837.visible = true;
            _loc1_.text = var_319.localizationManager.getLocalization("groupforum.view.mark_read");
         }
         else if(var_2062 != null)
         {
            var_2837.visible = true;
            _loc1_.text = var_319.localizationManager.getLocalization("groupforum.view.back");
         }
         else if(var_2335 != null)
         {
            var_2837.visible = true;
            _loc1_.text = var_319.localizationManager.getLocalization("groupforum.view.mark_read");
         }
         else
         {
            var_2837.visible = false;
         }
         var _loc3_:ILabelWindow = var_2264.findChildByName("post_button_label") as ILabelWindow;
         if(var_2146 != null)
         {
            var_2264.visible = true;
            _loc3_.text = var_319.localizationManager.getLocalization("groupforum.view.start_thread");
         }
         else if(var_2062 != null)
         {
            var_2264.visible = true;
            _loc3_.text = var_319.localizationManager.getLocalization("groupforum.view.reply");
         }
         else
         {
            var_2264.visible = false;
         }
         var _loc4_:int = var_1824 + 1;
         _txtElement.caption = _loc4_ + " / " + var_2269;
         _window.scaler.enable();
         _window.scaler.visible = true;
         enable(var_4061,var_1824 > 0);
         enable(var_4035,var_1824 > 0);
         enable(var_4239,var_1824 < var_2269 - 1);
         enable(var_4138,var_1824 < var_2269 - 1);
         updateUnreadForumsCount(var_319.unreadForumsCount);
      }
      
      private function resetWindow() : void
      {
         if(_window != null)
         {
            var_3196.destroyListItems();
            var_2335 = null;
            var_2146 = null;
            var_2062 = null;
         }
         else
         {
            _window = var_319.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_main_view_xml())) as class_3514;
            var_3196 = _window.findChildByName("scrollable_message_list") as IScrollableListWindow;
            var_3196.scrollableWindow.addEventListener("WE_RESIZED",onResized,100);
            _window.center();
            _window.y = 100;
            _txtElement = _window.findChildByName("page_info");
            var_4035 = _window.findChildByName("show_previous");
            var_4035.addEventListener("WME_CLICK",onClickButton);
            var_4239 = _window.findChildByName("show_next");
            var_4239.addEventListener("WME_CLICK",onClickButton);
            var_4138 = _window.findChildByName("show_last");
            var_4138.addEventListener("WME_CLICK",onClickButton);
            var_4061 = _window.findChildByName("show_first");
            var_4061.addEventListener("WME_CLICK",onClickButton);
            var_2837 = class_3489(_window.findChildByName("back_button"));
            var_2837.addEventListener("WME_CLICK",onClickButton);
            var_2264 = class_3489(_window.findChildByName("post_button"));
            var_2264.addEventListener("WME_CLICK",onClickButton);
            var_4583 = _window.findChildByTag("close");
            var_4583.addEventListener("WME_CLICK",onClickButton);
            var_3810 = _window.findChildByName("list_header");
            var_4029 = ITextWindow(IItemListWindow(_window.findChildByName("shortcuts")).getListItemByName("my"));
         }
      }
      
      private function setStatusTextError(param1:String, param2:String) : void
      {
         var _loc3_:ITextWindow = ITextWindow(_window.findChildByName("status"));
         if(param2 == null || param2.length == 0)
         {
            _loc3_.caption = "";
         }
         else
         {
            param1 = String(var_319.localizationManager.getLocalization("groupforum.view.error.operation_" + param1));
            _loc3_.text = var_319.localizationManager.getLocalizationWithParams("groupforum.view.error." + param2,"","operation",param1);
         }
      }
      
      private function onSettingsButtonClick(param1:WindowMouseEvent) : void
      {
         openForumSettingsView();
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         if(var_513 != null)
         {
            var_319.context.createLinkEvent("group/" + var_513.groupId);
         }
      }
      
      public function openForumsList(param1:ForumsListData) : void
      {
         resetWindow();
         var_1918 = param1;
         var_513 = null;
         var_2223 = null;
         var_2652 = null;
         var_2269 = calculateNumOfPagesAvailable(var_1918.totalAmount);
         var_1824 = Math.ceil(var_1918.startIndex / 20);
         var_2335 = new ForumsListView(this,var_3196,var_1918.forums);
         var_2335.update();
         var_3810.caption = var_319.localizationManager.getLocalization("groupforum.view.forums_list." + var_1918.listCode);
         var _loc3_:IWindowContainer = _window.findChildByName("top_part") as IWindowContainer;
         var _loc6_:IWidgetWindow;
         (_loc6_ = IWidgetWindow(_loc3_.findChildByName("group_icon"))).visible = false;
         var _loc8_:IStaticBitmapWrapperWindow;
         (_loc8_ = _loc3_.findChildByName("header_icon") as IStaticBitmapWrapperWindow).visible = true;
         _loc8_.assetUri = "forum_forum_list" + var_1918.listCode;
         var _loc7_:ITextWindow;
         (_loc7_ = _loc3_.findChildByName("top_header_text") as ITextWindow).text = var_319.localizationManager.getLocalization("groupforum.view.forums_header." + var_1918.listCode);
         var _loc4_:ITextWindow;
         (_loc4_ = _loc3_.findChildByName("top_text") as ITextWindow).text = var_319.localizationManager.getLocalization("groupforum.view.forums_description." + var_1918.listCode);
         var _loc2_:IRegionWindow = _loc3_.findChildByName("top_click_area") as IRegionWindow;
         _loc2_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc2_.disable();
         initCommonControls();
         var _loc5_:ITextWindow;
         (_loc5_ = ITextWindow(_window.findChildByName("status"))).text = var_319.localizationManager.getLocalization("groupforum.view.forums_list.status");
      }
      
      public function get isForumsListOpened() : Boolean
      {
         return var_2335 != null;
      }
      
      public function openThreadList(param1:ForumsListData, param2:class_1755, param3:ThreadsListData) : void
      {
         resetWindow();
         var_1918 = param1;
         var_513 = param2;
         var_2223 = param3;
         var_2652 = null;
         var_2269 = calculateNumOfPagesAvailable(var_2223.totalThreads);
         var_1824 = Math.ceil(var_2223.startIndex / 20);
         var_2146 = new ThreadListView(this,var_3196,var_513,var_2223);
         var_2146.update();
         var_3810.caption = var_319.localizationManager.getLocalization("groupforum.view.all_threads");
         if(var_513.canPostThread)
         {
            var_2264.enable();
            setStatusTextError("post_thread",null);
         }
         else
         {
            var_2264.disable();
            setStatusTextError("post_thread",var_513.postThreadPermissionError);
         }
         var _loc4_:IRegionWindow;
         (_loc4_ = GroupForumView.initTopAreaForForum(_window,var_513)).removeEventListener("WME_CLICK",onTopAreaClick);
         _loc4_.addEventListener("WME_CLICK",onTopAreaClick);
         _loc4_.enable();
         initCommonControls();
      }
      
      public function updateThread(param1:class_1740) : void
      {
         if(var_2146 != null)
         {
            var_2146.updateElement(param1);
         }
      }
      
      public function updateMessage(param1:class_1666) : void
      {
         if(var_2062 != null)
         {
            var_2062.updateElement(param1);
         }
      }
      
      public function openMessagesList(param1:ForumsListData, param2:class_1755, param3:ThreadsListData, param4:MessagesListData) : void
      {
         resetWindow();
         var_1918 = param1;
         var_513 = param2;
         var_2223 = param3;
         var_2652 = param4;
         var _loc7_:int = param4.threadId;
         var _loc5_:class_1740 = var_2223.threadsById[_loc7_];
         var_2269 = calculateNumOfPagesAvailable(param4.totalMessages);
         var _loc8_:int = param4.startIndex;
         var_1824 = Math.ceil(_loc8_ / 20);
         var_3810.caption = _loc5_.header;
         var_2062 = new MessageListView(this,var_3196,var_513,_loc5_,param4);
         var_2062.update();
         if(var_319.getGoToMessageIndex() > 0 && var_319.getGoToThreadId() == _loc7_)
         {
            var_2062.scrollToSpecificElement(var_319.getGoToMessageIndex(),true);
            var_319.resetGoTo();
         }
         if(var_513.canPostMessage)
         {
            if(var_513.canModerate || !_loc5_.isLocked)
            {
               var_2264.enable();
               setStatusTextError("post_message",null);
            }
            else
            {
               var_2264.disable();
               setStatusTextError("post_in_locked",var_513.moderatePermissionError);
            }
         }
         else
         {
            var_2264.disable();
            setStatusTextError("post_message",var_513.postMessagePermissionError);
         }
         var _loc6_:IRegionWindow;
         (_loc6_ = GroupForumView.initTopAreaForForum(_window,var_513)).removeEventListener("WME_CLICK",onTopAreaClick);
         _loc6_.addEventListener("WME_CLICK",onTopAreaClick);
         _loc6_.enable();
         initCommonControls();
      }
      
      public function get controller() : GroupForumController
      {
         return var_319;
      }
      
      private function calculateNumOfPagesAvailable(param1:int) : int
      {
         return Math.ceil(param1 / var_749);
      }
      
      private function getPreviousPageData() : void
      {
         var _loc1_:int = var_1824 - 1;
         if(_loc1_ >= 0)
         {
            requestNewPageData(_loc1_);
         }
      }
      
      private function getNextPageData() : void
      {
         var _loc1_:int = var_1824 + 1;
         if(_loc1_ <= var_2269)
         {
            requestNewPageData(_loc1_);
         }
      }
      
      private function getFirstPageData() : void
      {
         if(var_1824 == 0)
         {
            return;
         }
         requestNewPageData(0);
      }
      
      private function getLastPageData() : void
      {
         if(var_1824 >= var_2269)
         {
            return;
         }
         requestNewPageData(var_2269 - 1);
      }
      
      private function requestNewPageData(param1:int) : void
      {
         var _loc2_:int = param1 * var_749;
         if(var_2335 != null)
         {
            var_319.openForumsList(var_1918.listCode,_loc2_);
         }
         else if(var_2146 != null)
         {
            var_319.requestThreadList(var_513.groupId,_loc2_);
         }
         else if(var_2062 != null)
         {
            var_319.requestThreadMessageList(var_513.groupId,var_2652.threadId,_loc2_);
         }
         var_1824 = param1;
      }
      
      public function getAsDaysHoursMinutes(param1:int) : String
      {
         return FriendlyTime.getFriendlyTime(var_319.localizationManager,param1,".ago",1);
      }
      
      private function onResized(param1:WindowEvent = null) : void
      {
         if(var_2335 != null)
         {
            var_2335.updateItemWidths();
         }
         if(var_2146 != null)
         {
            var_2146.updateItemWidths();
         }
         if(var_2062 != null)
         {
            var_2062.updateItemSizes();
         }
      }
      
      private function onClickButton(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "back_button":
               if(var_2062 != null)
               {
                  var_319.requestThreadList(var_513.groupId,var_2223.startIndex);
               }
               else if(var_2146 != null)
               {
                  var_319.markForumAsRead(true);
                  if(var_1918 != null)
                  {
                     var_319.openForumsList(var_1918.listCode,var_1918.startIndex);
                  }
                  else
                  {
                     dispose();
                  }
               }
               else if(var_2335 != null)
               {
                  var_319.markForumsAsRead();
                  dispose();
               }
               break;
            case "show_previous":
               getPreviousPageData();
               break;
            case "show_next":
               getNextPageData();
               break;
            case "show_last":
               getLastPageData();
               break;
            case "show_first":
               getFirstPageData();
               break;
            case "header_button_close":
               _window.visible = false;
               dispose();
               break;
            case "post_button":
               openComposeMessageView(var_2652 != null ? var_2223.threadsById[var_2652.threadId] : null);
         }
      }
      
      public function openComposeMessageView(param1:class_1740, param2:class_1666 = null) : void
      {
         if(var_319.composeMessageView != null)
         {
            var_319.composeMessageView.focus(var_513,param1,param2);
         }
         else
         {
            var_319.composeMessageView = new ComposeMessageView(this,_window.x + _window.width,_window.y,var_513,param1,param2);
         }
      }
      
      public function openForumSettingsView() : void
      {
         if(var_319.forumSettingsView != null)
         {
            var_319.forumSettingsView.focus(var_513);
         }
         else
         {
            var_319.forumSettingsView = new ForumSettingsView(this,_window.x + _window.width,_window.y,var_513);
         }
      }
      
      public function updateUnreadForumsCount(param1:int) : void
      {
         if(param1 > 0)
         {
            var_4029.htmlText = var_319.localizationManager.getLocalizationWithParams("groupforum.view.shortcuts.my.unread","","unread_count",param1);
         }
         else
         {
            var_4029.htmlText = var_319.localizationManager.getLocalization("groupforum.view.shortcuts.my","");
         }
      }
   }
}
