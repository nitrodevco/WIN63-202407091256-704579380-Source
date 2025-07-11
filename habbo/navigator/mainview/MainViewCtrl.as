package com.sulake.habbo.navigator.mainview
{
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.IViewCtrl;
   import com.sulake.habbo.navigator.TextSearchInputs;
   import com.sulake.habbo.navigator.Util;
   import com.sulake.habbo.navigator.domain.Tab;
   import com.sulake.habbo.utils.WindowToggle;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1665;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomAdEventTabViewedComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_136;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_194;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_202;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_244;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_260;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_305;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_359;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_413;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_458;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_546;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_560;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_646;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_648;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_764;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_804;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_864;
   import com.sulake.habbo.communication.messages.outgoing.navigator.RoomsWhereMyFriendsAreSearchMessageComposer;
   
   public class MainViewCtrl implements ITransitionalMainViewCtrl, IUpdateReceiver, IDisposable
   {
      
      public static const SEARCHMSG_SEARCH:int = 1;
      
      public static const const_1132:int = 2;
      
      public static const SEARCHMSG_OFFICIALROOMS:int = 4;
      
      public static const const_704:int = 5;
      
      private static const BLEND_STAGE_BLENDING_OUT:int = 1;
      
      private static const BLEND_STAGE_LOADING:int = 2;
      
      private static const BLEND_STAGE_REFRESHING:int = 3;
      
      private static const BLEND_STAGE_BLENDING_IN:int = 4;
      
      private static const SCROLLBAR_WIDTH:int = 22;
      
      private static const PANIC_BUTTON_HEIGHT:int = 60;
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1641:class_3514;
      
      private var _content:IWindowContainer;
      
      private var var_1914:IWindowContainer;
      
      private var _footer:IWindowContainer;
      
      private var var_1865:IWindowContainer;
      
      private var var_2671:PopularTagsListCtrl;
      
      private var _guestRooms:GuestRoomListCtrl;
      
      private var _officialRooms:OfficialRoomListCtrl;
      
      private var var_2642:RoomAdListCtrl;
      
      private var var_4105:CategoryListCtrl;
      
      private var _tabContext:ITabContextWindow;
      
      private var var_3601:Boolean;
      
      private var var_2275:int;
      
      private var var_3739:Boolean = true;
      
      private var var_3663:int = 0;
      
      private var _loadingText:IWindow;
      
      private var var_3750:int = 0;
      
      private var var_2245:TextSearchInputs;
      
      private var var_2303:Timer;
      
      private var _disposed:Boolean = false;
      
      private var var_2167:WindowToggle;
      
      private var var_4115:Boolean = false;
      
      private const DEFAULT_VIEW_LOCATION:Point = new Point(100,10);
      
      public function MainViewCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_2671 = new PopularTagsListCtrl(_navigator);
         _guestRooms = new GuestRoomListCtrl(_navigator,0,false);
         _officialRooms = new OfficialRoomListCtrl(_navigator);
         var_2642 = new RoomAdListCtrl(_navigator,0,false);
         var_4105 = new CategoryListCtrl(_navigator);
         var_2303 = new Timer(300,1);
         var_2303.addEventListener("timer",onResizeTimer);
      }
      
      private static function refreshScrollbar(param1:IViewCtrl, param2:Boolean) : void
      {
         var _loc4_:IItemListWindow = null;
         var _loc5_:IWindow = null;
         if(param1.content == null || !param1.content.visible)
         {
            return;
         }
         _loc4_ = IItemListWindow(param1.content.findChildByName("item_list"));
         _loc5_ = param1.content.findChildByName("scroller");
         var _loc3_:* = _loc4_.scrollableRegion.height > _loc4_.height;
         if(_loc5_.visible)
         {
            if(!_loc3_)
            {
               _loc5_.visible = false;
               _loc4_.width += 22;
            }
         }
         else if(_loc3_)
         {
            _loc5_.visible = true;
            _loc4_.width -= 22;
         }
      }
      
      public static function stretchNewEntryIfNeeded(param1:IViewCtrl, param2:IWindowContainer) : void
      {
         var _loc3_:IWindow = param1.content.findChildByName("scroller");
         if(_loc3_ == null || _loc3_.visible)
         {
            return;
         }
         param2.width += 22;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function onNavigatorToolBarIconClick() : void
      {
         if(!var_1641)
         {
            reloadData();
            return;
         }
         if(!var_2167 || var_2167.disposed)
         {
            var_2167 = new WindowToggle(var_1641,var_1641.desktop,reloadData,close);
         }
         var_2167.toggle();
      }
      
      private function reloadData() : void
      {
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.navigatorOpenedWhileInTab();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _navigator = null;
            if(var_1641)
            {
               var_1641.dispose();
               var_1641 = null;
            }
            if(var_2167)
            {
               var_2167.dispose();
               var_2167 = null;
            }
            if(_content)
            {
               _content.dispose();
               _content = null;
            }
            if(var_2303)
            {
               var_2303.removeEventListener("timer",onResizeTimer);
               var_2303.reset();
               var_2303 = null;
            }
            if(var_2671)
            {
               var_2671.dispose();
               var_2671 = null;
            }
            if(_guestRooms)
            {
               _guestRooms.dispose();
               _guestRooms = null;
            }
            if(_officialRooms)
            {
               _officialRooms.dispose();
               _officialRooms = null;
            }
            if(var_2642)
            {
               var_2642.dispose();
               var_2642 = null;
            }
            if(var_2245)
            {
               var_2245.dispose();
               var_2245 = null;
            }
         }
      }
      
      public function open() : void
      {
         if(var_1641 == null)
         {
            prepare();
         }
         refresh();
         var_1641.visible = true;
         var_1641.y = Math.max(var_1641.y,60);
         var_1641.activate();
      }
      
      public function isOpen() : Boolean
      {
         return var_1641 != null && Boolean(var_1641.visible);
      }
      
      public function close() : void
      {
         if(var_1641 != null)
         {
            if(var_2245)
            {
               var_2245.dispose();
               var_2245 = null;
            }
            if(var_2167)
            {
               var_2167.dispose();
               var_2167 = null;
            }
            var_1641.dispose();
            var_1641 = null;
            _tabContext = null;
            _content = null;
            var_1914 = null;
            var_1865 = null;
            _footer = null;
            _loadingText = null;
            var_2671.content = null;
            _guestRooms.content = null;
            _officialRooms.content = null;
            var_4105.content = null;
            var_2642.content = null;
            var_3750 = 0;
         }
      }
      
      public function get mainWindow() : class_3514
      {
         return var_1641;
      }
      
      private function prepare() : void
      {
         var _loc4_:Array = null;
         var _loc7_:ITabButtonWindow = null;
         var _loc5_:ITabButtonWindow = null;
         var _loc2_:Boolean = _navigator.getBoolean("eventinfo.enabled");
         var _loc6_:Boolean = false;
         var_1641 = class_3514(_navigator.getXmlWindow("grs_main_window_new"));
         _tabContext = ITabContextWindow(var_1641.findChildByName("tab_context"));
         _content = IWindowContainer(var_1641.findChildByName("tab_content"));
         var_1914 = IWindowContainer(var_1641.findChildByName("custom_content"));
         var_1865 = IWindowContainer(var_1641.findChildByName("list_content"));
         _footer = IWindowContainer(var_1641.findChildByName("custom_footer"));
         _loadingText = var_1641.findChildByName("loading_text");
         var _loc3_:IWindow = var_1641.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onWindowClose);
         }
         var_1641.addEventListener("WE_RESIZED",onWindowResized);
         if(!_loc2_ || !var_4115)
         {
            _loc4_ = [];
            while(_tabContext.numTabItems > 0)
            {
               _loc7_ = _tabContext.getTabItemAt(0);
               _loc4_.push(_loc7_);
               _tabContext.removeTabItem(_loc7_);
            }
            for each(_loc7_ in _loc4_)
            {
               if(!(_loc7_.id == 1 && !_loc2_ || _loc7_.id == 6 && !_loc6_))
               {
                  _tabContext.addTabItem(_loc7_);
               }
            }
         }
         for each(var _loc1_ in _navigator.tabs.tabs)
         {
            if((_loc5_ = _tabContext.getTabItemByID(_loc1_.id)) != null)
            {
               _loc5_.addEventListener("WE_SELECTED",onTabSelected);
               _loc1_.button = _loc5_;
            }
         }
         var_1641.scaler.setParamFlag(12288,false);
         var_1641.scaler.setParamFlag(8192,true);
         var_1641.position = DEFAULT_VIEW_LOCATION;
         createSearchInput();
      }
      
      private function createSearchInput() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc2_:String = "search_header";
         if(var_2245 == null)
         {
            _loc1_ = var_1641.findChildByName(_loc2_) as IWindowContainer;
            var_2245 = new TextSearchInputs(_navigator,_loc1_);
         }
         var _loc3_:IWindowContainer = var_1641.findChildByName(_loc2_) as IWindowContainer;
         _loc3_.visible = true;
      }
      
      public function refresh() : void
      {
         if(var_1641 == null)
         {
            return;
         }
         refreshTab();
         refreshCustomContent();
         refreshListContent(true);
         refreshFooter();
         var_1914.height = Util.getLowestPoint(var_1914);
         _footer.height = Util.getLowestPoint(_footer);
         var _loc1_:int = int(var_1865.y);
         Util.moveChildrenToColumn(_content,["custom_content","list_content"],var_1914.y,8);
         var_1865.height = var_1865.height + _loc1_ - var_1865.y - _footer.height + var_3750;
         Util.moveChildrenToColumn(_content,["list_content","custom_footer"],var_1865.y,0);
         var_3750 = _footer.height;
         onResizeTimer(null);
      }
      
      private function refreshTab() : void
      {
         var _loc2_:Tab = _navigator.tabs.getSelected();
         var _loc1_:ISelectableWindow = _tabContext.selector.getSelected();
         if(_loc2_.button != _loc1_)
         {
            var_3601 = true;
            _tabContext.selector.setSelected(_loc2_.button);
         }
      }
      
      private function refreshCustomContent() : void
      {
         Util.hideChildren(var_1914);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshCustomContent(var_1914);
         if(Util.hasVisibleChildren(var_1914))
         {
            var_1914.visible = true;
         }
         else
         {
            var_1914.visible = false;
            var_1914.blend = 1;
         }
      }
      
      private function refreshFooter() : void
      {
         Util.hideChildren(_footer);
         var _loc1_:Tab = _navigator.tabs.getSelected();
         _loc1_.tabPageDecorator.refreshFooter(_footer);
         _footer.visible = Util.hasVisibleChildren(_footer);
      }
      
      private function refreshListContent(param1:Boolean) : void
      {
         Util.hideChildren(var_1865);
         var _loc2_:Tab = _navigator.tabs.getSelected();
         var _loc3_:Boolean = _navigator.data.guestRoomSearchArrived && _loc2_.defaultSearchType == 16;
         refreshRoomAds(param1,_loc3_);
         refreshGuestRooms(param1,!_loc3_);
         refreshPopularTags(param1,_navigator.data.popularTagsArrived);
         refreshOfficialRooms(param1,_navigator.data.officialRoomsArrived);
      }
      
      private function refreshGuestRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,_guestRooms,"guest_rooms");
      }
      
      private function refreshPopularTags(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_2671,"popular_tags");
      }
      
      private function refreshOfficialRooms(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,_officialRooms,"official_rooms");
      }
      
      private function refreshRoomAds(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_2642,"room_ads");
      }
      
      private function refreshCategoryList(param1:Boolean, param2:Boolean) : void
      {
         refreshList(param1,param2,var_4105,"categories_container");
      }
      
      private function refreshList(param1:Boolean, param2:Boolean, param3:IViewCtrl, param4:String) : void
      {
         var _loc5_:IWindow = null;
         if(param2)
         {
            if(param3.content == null)
            {
               _loc5_ = var_1865.findChildByName(param4);
               param3.content = IWindowContainer(_loc5_);
            }
            if(param1)
            {
               param3.refresh();
            }
            param3.content.visible = true;
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         class_14.log("Close navigator window");
         this.close();
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         var _loc4_:IWindow;
         var _loc2_:int = (_loc4_ = param1.target).id;
         if(var_3601)
         {
            var_3601 = false;
            return;
         }
         var _loc3_:Tab = _navigator.tabs.getTab(_loc2_);
         _loc3_.sendSearchRequest();
         switch(_loc3_.id - 1)
         {
            case 0:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS"));
               _navigator.send(new RoomAdEventTabViewedComposer());
               break;
            case 1:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS"));
               break;
            case 2:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_ME"));
               break;
            case 3:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL"));
               break;
            case 4:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH"));
               break;
            case 5:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_CATEGORIES"));
         }
      }
      
      public function reloadRoomList(param1:int) : Boolean
      {
         ErrorReportStorage.addDebugData("MainViewCtrl","Reloading RoomList");
         if(this.isOpen() && this._navigator.data.guestRoomSearchResults != null && this._navigator.data.guestRoomSearchResults.searchType == param1)
         {
            startSearch(_navigator.tabs.getSelected().id,param1,"");
            return true;
         }
         return false;
      }
      
      public function startSearch(param1:int, param2:int, param3:String = "-1", param4:int = 1) : void
      {
         var _loc5_:Tab = _navigator.tabs.getSelected();
         _navigator.tabs.setSelectedTab(param1);
         var _loc6_:Tab = _navigator.tabs.getSelected();
         ErrorReportStorage.addDebugData("StartSearch","Start search " + _loc5_.id + " => " + _loc6_.id);
         if(var_4115)
         {
            if(param3.substr(0,1) == "#")
            {
               param2 = 9;
               param3 = param3.substr(1,param3.length - 1);
            }
         }
         this.var_3739 = _loc5_ != _loc6_;
         if(_loc5_ != _loc6_)
         {
            _loc6_.tabPageDecorator.tabSelected();
         }
         _navigator.data.startLoading();
         if(param4 == 1)
         {
            _navigator.send(getSearchMsg(param2,param3));
         }
         else if(param4 == 2)
         {
            _navigator.send(new class_136());
         }
         else if(param4 != 5)
         {
            _navigator.send(new class_359(_navigator.data.adIndex));
         }
         if(!isOpen())
         {
            open();
            this.var_2275 = 2;
            this.var_1865.blend = 0;
            if(this.var_1914.visible)
            {
               this.var_1914.blend = 0;
               this._footer.blend = 0;
            }
         }
         else
         {
            this.var_2275 = 1;
         }
         this.var_3663 = 0;
         _navigator.registerUpdateReceiver(this,2);
         sendTrackingEvent(param2);
         _navigator.data.competitionRoomsData = null;
         if(var_4115)
         {
            if(searchInput != null && param3 != "-1")
            {
               if(param2 != 1)
               {
                  searchInput.setText(param3,param2);
               }
            }
         }
      }
      
      private function sendTrackingEvent(param1:int) : void
      {
         switch(param1)
         {
            case 6:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES"));
               break;
            case 3:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS"));
               break;
            case 7:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY"));
               break;
            case 5:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS"));
               break;
            case 11:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS"));
               break;
            case 1:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS"));
               break;
            case 4:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE"));
               break;
            case 2:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE"));
               break;
            case 9:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH"));
               break;
            case 8:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH"));
               break;
            case 23:
               _navigator.events.dispatchEvent(new Event("HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FREQUENT_HISTORY"));
         }
      }
      
      private function getSearchMsg(param1:int, param2:String) : IMessageComposer
      {
         var _loc3_:class_1665 = null;
         switch(param1)
         {
            case 6:
               return new class_458();
            case 3:
               return new class_804();
            case 7:
               return new class_560();
            case 5:
               return new class_646();
            case 1:
               return new class_546(param2,_navigator.data.adIndex);
            case 4:
               return new RoomsWhereMyFriendsAreSearchMessageComposer();
            case 2:
               return new class_194(_navigator.data.adIndex);
            case 9:
               return new class_648("tag:" + param2);
            case 8:
               return new class_648(param2);
            case 13:
               return new class_648("group:" + param2);
            case 10:
               return new class_648("roomname:" + param2);
            case 14:
               return new class_305(_navigator.data.adIndex);
            case 15:
               _loc3_ = _navigator.data.competitionRoomsData;
               return new class_202(_loc3_.goalId,_loc3_.pageIndex);
            case 16:
            case 17:
               break;
            case 18:
               return new class_244();
            case 19:
               return new class_764();
            case 20:
               return new class_648("owner:" + param2);
            case 22:
               return new class_260();
            case 23:
               return new class_864();
            default:
               class_14.log("No message for searchType: " + param1);
               return null;
         }
         return new class_413(_navigator.data.adIndex,param1);
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         if(this.var_1865 == null)
         {
            return;
         }
         var _loc2_:Number = param1 / 150;
         if(var_2275 == 1)
         {
            _loc3_ = Math.min(1,Math.max(0,this.var_1865.blend - _loc2_));
            this.var_1865.blend = _loc3_;
            this.var_1914.blend = var_3739 ? _loc3_ : 1;
            this._footer.blend = var_3739 ? _loc3_ : 1;
            if(_loc3_ == 0)
            {
               var_2275 = 2;
            }
         }
         else if(var_2275 == 2)
         {
            if(var_3663 % 10 == 1)
            {
               _loadingText.visible = !_loadingText.visible;
            }
            var_3663++;
            if(!_navigator.data.isLoading())
            {
               var_2275 = 3;
            }
         }
         else if(var_2275 == 3)
         {
            this.refresh();
            var_2275 = 4;
         }
         else
         {
            _loadingText.visible = false;
            _loc3_ = Math.min(1,Math.max(0,this.var_1865.blend + _loc2_));
            this.var_1865.blend = _loc3_;
            this.var_1914.blend = var_3739 ? _loc3_ : 1;
            this._footer.blend = var_3739 ? _loc3_ : 1;
            if(var_1865.blend >= 1)
            {
               _navigator.removeUpdateReceiver(this);
            }
         }
      }
      
      private function onWindowResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindow = param1.target;
         if(_loc2_ != var_1641)
         {
            return;
         }
         if(!this.var_2303.running)
         {
            this.var_2303.reset();
            this.var_2303.start();
         }
      }
      
      private function onResizeTimer(param1:TimerEvent) : void
      {
         refreshScrollbar(var_2671,false);
         refreshScrollbar(_guestRooms,false);
         refreshScrollbar(var_2642,false);
         if(_navigator.isPerkAllowed("NAVIGATOR_PHASE_ONE_2014"))
         {
         }
      }
      
      public function get searchInput() : TextSearchInputs
      {
         return var_2245;
      }
      
      public function openAtPosition(param1:Point) : void
      {
         reloadData();
         if(param1 != null)
         {
            var_1641.position = param1;
         }
         else if(var_1641.position.x == 0)
         {
            var_1641.position = DEFAULT_VIEW_LOCATION;
         }
      }
      
      public function get isPhaseOneNavigator() : Boolean
      {
         return var_4115;
      }
   }
}
