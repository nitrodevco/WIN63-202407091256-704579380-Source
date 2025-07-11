package com.sulake.habbo.navigator.view
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.view.search.SearchView;
   import com.sulake.habbo.navigator.view.search.ViewMode;
   import com.sulake.habbo.navigator.view.search.results.BlockResultsView;
   import com.sulake.habbo.navigator.view.search.results.CategoryElementFactory;
   import com.sulake.habbo.navigator.view.search.results.RoomEntryElementFactory;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_1706;
   import com.sulake.habbo.communication.messages.incoming.newnavigator.class_3439;
   
   public class NavigatorView implements IUpdateReceiver
   {
      
      private static const POPUP_HIDE_DELAY_MS:uint = 4000;
      
      private static const MAX_WINDOW_WIDTH:int = 578;
      
      private static const STARTING_TAB_POSITION:int = 115;
      
      private static const const_590:int = 7;
      
      private static const const_1172:int = 7;
       
      
      private var _navigator:HabboNewNavigator;
      
      private var var_4489:LiftView;
      
      private var var_2919:QuickLinksView;
      
      private var var_2989:SearchView;
      
      private var var_1929:BlockResultsView;
      
      private var var_2655:RoomEntryElementFactory;
      
      private var var_2839:CategoryElementFactory;
      
      private var var_2605:TopViewSelector;
      
      private var _roomInfoPopup:RoomInfoPopup;
      
      private var var_4891:class_3437;
      
      private var var_4875:class_3437;
      
      private var var_4879:class_3437;
      
      private var _window:IWindowContainer;
      
      private var var_4022:Boolean;
      
      private var var_3282:uint;
      
      private var var_2534:int = -1;
      
      private var var_2453:int = -1;
      
      private var _lastWindowWidth:int = -1;
      
      private var var_2707:int = -1;
      
      private var _lastLeftPaneHidden:Boolean = false;
      
      private var _waitingForGroupDetails:int = -1;
      
      private var var_3390:int = 4000;
      
      private var var_4896:Boolean = false;
      
      private var var_3133:int;
      
      private var var_4152:int;
      
      private var var_2150:IWindow;
      
      private var _leftPaneMargin:int;
      
      private var roomInfoGlobalRectangle:Rectangle;
      
      public function NavigatorView(param1:HabboNewNavigator)
      {
         var_3282 = getTimer();
         roomInfoGlobalRectangle = new Rectangle();
         super();
         _navigator = param1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(param1 && _navigator.isReady)
         {
            if(var_2655 == null)
            {
               var_2655 = new RoomEntryElementFactory(_navigator);
            }
            if(var_2839 == null)
            {
               var_2839 = new CategoryElementFactory(_navigator,var_2655);
            }
            createSubViews();
            if(_window == null)
            {
               createMainWindow();
               _navigator.registerUpdateReceiver(this,1000);
               var_2919.setQuickLinks(_navigator.contextContainer.savedSearches);
            }
            if(_navigator.currentResults != null)
            {
               this.onSearchResults(_navigator.currentResults);
            }
            else if(!var_4022)
            {
               _navigator.performSearch("official_view");
            }
            _window.activate();
         }
         else if(_roomInfoPopup)
         {
            _roomInfoPopup.show(false);
         }
         if(_window)
         {
            _window.visible = param1;
         }
      }
      
      public function get visible() : Boolean
      {
         if(_window)
         {
            return _window.visible;
         }
         return false;
      }
      
      public function setInitialWindowDimensions(param1:int, param2:int, param3:int, param4:Boolean, param5:int) : void
      {
         if(_window)
         {
            setLeftPaneVisibility(!param4);
            _window.x = param1;
            _window.y = param2;
            _window.height = param3;
         }
         else
         {
            var_2534 = param1;
            var_2453 = param2;
            var_2707 = param3;
            _lastLeftPaneHidden = param4;
         }
      }
      
      public function onSavedSearches(param1:Vector.<class_1706>) : void
      {
         if(var_2919)
         {
            var_2919.setQuickLinks(param1);
         }
      }
      
      private function createSubViews() : void
      {
         if(var_1929 == null)
         {
            var_1929 = new BlockResultsView(_navigator);
            var_1929.categoryElementFactory = var_2839;
            var_2839.blockResultsView = var_1929;
         }
         if(var_2989 == null)
         {
            var_2989 = new SearchView(_navigator);
         }
         if(var_2919 == null)
         {
            var_2919 = new QuickLinksView(_navigator);
         }
         if(var_4489 == null)
         {
         }
         if(var_2605 == null)
         {
            var_2605 = new TopViewSelector(_navigator);
         }
      }
      
      public function onSearchResults(param1:class_3439, param2:String = "") : void
      {
         var _loc3_:int = 0;
         if(_navigator.newResultsRendered)
         {
            return;
         }
         if(!var_2655 || !var_1929)
         {
            return;
         }
         var_2655.viewMode = ViewMode.getViewMode(param1.searchCodeOriginal);
         var_1929.displayCurrentResults();
         if(_navigator.contextContainer.hasContextFor(param1.searchCodeOriginal))
         {
            _loc3_ = _navigator.contextContainer.getTopLevelSearches().indexOf(param1.searchCodeOriginal);
            if(_loc3_ != -1)
            {
               var_2605.selectTabByIndex(_loc3_);
            }
         }
         _window.findChildByName("create_room").procedure = createRoomProcedure;
         _window.findChildByName("random_room_border").visible = false;
         _window.findChildByName("promote_room_border").visible = false;
         if(param1.searchCodeOriginal == "roomads_view" || param1.searchCodeOriginal == "myworld_view")
         {
            _window.findChildByName("promote_room_border").visible = true;
            _window.findChildByName("promote_room").procedure = promoteRoomProcedure;
         }
         else
         {
            _window.findChildByName("random_room_border").visible = true;
            _window.findChildByName("random_room").procedure = randomRoomProcedure;
         }
         var_2989.setTextAndSearchModeFromFilter(param1.filteringData,param2);
         _navigator.newResultsRendered = true;
         isBusy = false;
         if(_roomInfoPopup)
         {
            _roomInfoPopup.show(false);
         }
      }
      
      public function currentFilterText() : String
      {
         if(var_2989 != null)
         {
            return var_2989.currentInput;
         }
         return null;
      }
      
      public function refreshLiftedRooms() : void
      {
         if(var_4489)
         {
            var_4489.refresh();
         }
      }
      
      public function showRoomInfoBubbleAt(param1:class_1675, param2:int, param3:int, param4:Boolean = false) : void
      {
         var_4896 = true;
         if(!_window)
         {
            return;
         }
         if(!_roomInfoPopup)
         {
            _roomInfoPopup = new RoomInfoPopup(_navigator);
         }
         if(_roomInfoPopup.visible && !param4)
         {
            _roomInfoPopup.show(false);
         }
         else
         {
            _roomInfoPopup.setData(param1);
            if(param1.habboGroupId != 0 && _navigator.getCachedGroupDetails(param1.habboGroupId) == null)
            {
               _navigator.getGuildInfo(param1.habboGroupId,false);
               _waitingForGroupDetails = param1.habboGroupId;
            }
            _roomInfoPopup.showAt(true,param2,param3);
            _navigator.trackEventLog("browse.openroominfo","Results",param1.roomName,param1.flatId);
            var_3390 = 4000;
         }
      }
      
      public function get mainWindow() : class_3514
      {
         return _window as class_3514;
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         if(_window)
         {
            _window.caption = param1 ? "${navigator.title.is.busy}" : "${navigator.title}";
            _window.findChildByName("search_waiting_for_results_mask").visible = param1;
         }
         var_4022 = param1;
      }
      
      public function get isBusy() : Boolean
      {
         return var_4022;
      }
      
      private function createMainWindow() : void
      {
         var _loc8_:IWindowContainer = IWindowContainer(_navigator.windowManager.buildFromXML(XML(_navigator.assets.getAssetByName("navigator_frame_2_xml").content)));
         IScrollableListWindow(_loc8_.findChildByName("block_results")).autoHideScrollBar = false;
         var _loc10_:IWindowContainer = IWindowContainer(_loc8_.findChildByName("navigator_entry_row_container"));
         var_2655.rowEntryTemplate = IWindowContainer(_loc10_.clone());
         _loc10_.destroy();
         var _loc4_:IItemListWindow = IItemListWindow(_loc8_.findChildByName("navigator_entry_tile_container").clone());
         var _loc5_:IWindowContainer = IWindowContainer(_loc4_.getListItemByName("navigator_entry_tile").clone());
         var_2655.tileEntryTemplate = _loc5_;
         _loc4_.destroyListItems();
         var_2655.tileContainerTemplate = _loc4_;
         IItemListWindow(_loc8_.findChildByName("category_content")).destroyListItems();
         var _loc9_:IWindowContainer = IWindowContainer(_loc8_.findChildByName("category_container"));
         var_2839.categoryTemplate = IWindowContainer(_loc9_.clone());
         IItemListWindow(_loc8_.findChildByName("block_results")).removeListItemAt(0);
         _loc9_.destroy();
         var _loc1_:IWindowContainer = IWindowContainer(_loc8_.findChildByName("category_container_collapsed"));
         var_2839.collapsedCategoryTemplate = IWindowContainer(_loc1_.clone());
         IItemListWindow(_loc8_.findChildByName("block_results")).removeListItemAt(0);
         _loc1_.destroy();
         var _loc6_:IWindowContainer = IWindowContainer(_loc8_.findChildByName("no_results_container"));
         var_2839.noResultsTemplate = IWindowContainer(_loc6_.clone());
         IItemListWindow(_loc8_.findChildByName("block_results")).removeListItemAt(0);
         _loc6_.destroy();
         var_1929.itemList = IItemListWindow(_loc8_.findChildByName("block_results"));
         var_2989.container = IWindowContainer(_loc8_.findChildByName("search_tools"));
         var _loc3_:IRegionWindow = IRegionWindow(_loc8_.findChildByName("quick_link"));
         _loc3_.findChildByName("quick_link_text").caption = "";
         var_2919.template = IRegionWindow(_loc3_.clone());
         var_2919.itemList = IItemListWindow(_loc8_.findChildByName("quicklinks_list"));
         IItemListWindow(_loc8_.findChildByName("quicklinks_list")).removeListItems();
         _loc3_.destroy();
         var _loc2_:ITabContextWindow = ITabContextWindow(_loc8_.findChildByName("top_view_select_tab_context"));
         var _loc7_:ITabButtonWindow = ITabButtonWindow(_loc2_.getTabItemAt(0).clone());
         var_2605.template = _loc7_;
         var_2605.tabContext = _loc2_;
         _loc2_.removeTabItem(_loc7_);
         var_2605.refresh();
         var_4891 = class_3437(_loc8_.findChildByName("create_room_border").clone());
         IItemListWindow(_loc8_.findChildByName("left_pane")).removeListItem(_loc8_.findChildByName("create_room_border"));
         var_4875 = class_3437(_loc8_.findChildByName("promote_room_border").clone());
         IItemListWindow(_loc8_.findChildByName("left_pane")).removeListItem(_loc8_.findChildByName("promote_room_border"));
         var_4879 = class_3437(_loc8_.findChildByName("random_room_border").clone());
         IItemListWindow(_loc8_.findChildByName("left_pane")).removeListItem(_loc8_.findChildByName("random_room_border"));
         _leftPaneMargin = _loc8_.findChildByName("left_pane").x;
         _loc8_.findChildByName("refreshButton").procedure = refreshSearchResults;
         _loc8_.findChildByName("header_button_close").procedure = headerProcedure;
         var_3133 = 7;
         _loc8_.findChildByName("temp_back").procedure = leftPaneShowHideProcedure;
         var_2150 = _loc8_.findChildByName("right_pane");
         var_4152 = var_2150.x;
         _window = _loc8_;
         setLeftPaneVisibility(false);
         if(var_2534 == -1 && var_2453 == -1)
         {
            var_2534 = _window.x;
            var_2453 = _window.y;
            _lastWindowWidth = _window.width;
            var_2707 = _window.height;
         }
         else
         {
            if(_lastLeftPaneHidden)
            {
               setLeftPaneVisibility(true);
            }
            _window.x = var_2534;
            _window.y = var_2453;
            _window.height = var_2707;
         }
         var_3282 = getTimer();
      }
      
      private function refreshSearchResults(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "refreshButton")
         {
            _navigator.performLastSearch();
         }
      }
      
      private function headerProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "header_button_close")
            {
               visible = false;
            }
         }
      }
      
      private function createRoomProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.createRoom();
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      private function promoteRoomProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.context.createLinkEvent("catalog/open/room_ad");
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      private function randomRoomProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _navigator.context.createLinkEvent("navigator/goto/random_friending_room");
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
            visible = false;
         }
      }
      
      private function leftPaneShowHideProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:IWindow = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _window.findChildByName("left_pane");
            setLeftPaneVisibility(!_loc3_.visible);
            if(_roomInfoPopup)
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      public function setLeftPaneVisibility(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IWindow = _window.findChildByName("left_pane");
         var _loc5_:int = var_4152 - _leftPaneMargin + 7;
         var_2150.setParamFlag(0,true);
         var_2150.setParamFlag(128,false);
         if(!param1)
         {
            _loc2_.visible = false;
            var_2150.x = var_3133;
            _window.limits.minWidth = _window.width - _loc5_ + var_3133;
            _window.limits.maxWidth = _window.width - _loc5_ + var_3133;
            _window.width = _window.width - _loc5_ + var_3133;
         }
         else
         {
            _loc2_.visible = true;
            var_2150.x = var_4152;
            _loc3_ = _window.width + _loc5_ - var_3133;
            _window.limits.minWidth = _loc3_ > 578 ? 578 : _loc3_;
            _window.limits.maxWidth = _loc3_ > 578 ? 578 : _loc3_;
            _window.width = _loc3_ > 578 ? 578 : _loc3_;
         }
         var_2150.setParamFlag(0,false);
         var_2150.setParamFlag(128,true);
         _window.findChildByName("left_hide_container").visible = param1;
         _window.findChildByName("left_show_container").visible = !param1;
         var _loc4_:int = int(param1 ? 115 : 115 - _loc5_ / 2);
         _window.findChildByName("top_view_select_tab_context").x = _loc4_;
      }
      
      private function keepWindowInsideScreenRegion() : void
      {
         _window.x = Math.max(0,_window.x);
         _window.y = Math.max(0,_window.y);
         if(_window.desktop)
         {
            _window.x = Math.min(_window.desktop.width - _window.width,_window.x);
            _window.y = Math.min(_window.desktop.height - _window.height,_window.y);
         }
      }
      
      private function sendWindowPreferences() : void
      {
         var_2534 = _window.x;
         var_2453 = _window.y;
         _lastWindowWidth = _window.width;
         var_2707 = _window.height;
         _lastLeftPaneHidden = _window.findChildByName("left_pane").visible;
         var_3282 = getTimer();
         _navigator.sendWindowPreferences(var_2534,var_2453,_lastWindowWidth,var_2707,_lastLeftPaneHidden,0);
         _navigator.trackEventLog("windowsettings","Interface",_window.width + " x " + _window.height);
      }
      
      private function get windowPreferencesChanged() : Boolean
      {
         if(_lastLeftPaneHidden != _window.findChildByName("left_pane").visible)
         {
            return true;
         }
         if(var_2534 != _window.x)
         {
            return true;
         }
         if(var_2453 != _window.y)
         {
            return true;
         }
         if(var_2707 != _window.height)
         {
            return true;
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(windowPreferencesChanged && _loc2_ - var_3282 > 5000)
         {
            sendWindowPreferences();
         }
         keepWindowInsideScreenRegion();
         var_3390 -= param1;
         if(isRoomInfoBubbleVisible && var_3390 < 0)
         {
            _roomInfoPopup.getGlobalRectangle(roomInfoGlobalRectangle);
            if(!roomInfoGlobalRectangle.contains(_window.desktop.mouseX,_window.desktop.mouseY))
            {
               _roomInfoPopup.show(false);
            }
         }
      }
      
      public function dispose() : void
      {
         _navigator.removeUpdateReceiver(this);
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function onGroupDetailsArrived(param1:int) : void
      {
         if(_waitingForGroupDetails == param1)
         {
            _waitingForGroupDetails = -1;
         }
      }
      
      public function get isRoomInfoBubbleVisible() : Boolean
      {
         if(_roomInfoPopup)
         {
            return _roomInfoPopup.visible;
         }
         return false;
      }
   }
}
