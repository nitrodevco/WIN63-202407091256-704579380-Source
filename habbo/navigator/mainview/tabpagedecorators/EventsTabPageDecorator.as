package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import assets.class_14

    import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class EventsTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1462:class_3520;
      
      public function EventsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc2_:IWindowContainer = param1.getChildByName("room_ad_header") as IWindowContainer;
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            var_1462 = _loc2_.getChildByName("roomAdFilter") as class_3520;
            prepareFilter();
            var_1462.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc2_.visible = true;
      }
      
      public function tabSelected() : void
      {
         if(var_1462 != null && !var_1462.disposed)
         {
            var_1462.removeEventListener("WE_SELECTED",onFilterSelected);
            var_1462.selection = 0;
            var_1462.addEventListener("WE_SELECTED",onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
         var _loc2_:IWindowContainer = param1.getChildByName("room_ads_footer") as IWindowContainer;
         var _loc3_:IWindow = _loc2_.findChildByName("get_event_but");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGetEventClick);
         }
         _loc2_.visible = true;
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function prepareFilter() : void
      {
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            return;
         }
         var _loc1_:Array = [];
         _loc1_.push(_navigator.getText("navigator.roomad.topads"));
         _loc1_.push(_navigator.getText("navigator.roomad.newads"));
         var_1462.populate(_loc1_);
         var_1462.selection = 0;
      }
      
      private function onFilterSelected(param1:WindowEvent) : void
      {
         startSearch();
      }
      
      private function onGetEventClick(param1:WindowEvent) : void
      {
         _navigator.openCatalogRoomAdsPage();
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = 16;
         if(var_1462 != null && !var_1462.disposed)
         {
            _loc1_ = getSearchType(var_1462.selection);
         }
         _navigator.mainViewCtrl.startSearch(1,_loc1_);
      }
      
      private function getSearchType(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 16;
            case 1:
               return 17;
            default:
               class_14.log("Invalid index when searching Room ad search type: " + param1);
               return 0;
         }
      }
      
      public function get filterCategory() : String
      {
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            return null;
         }
         return var_1462.enumerateSelection()[var_1462.selection];
      }
      
      public function setSubSelection(param1:int) : void
      {
      }
      
      public function processSearchParam(param1:String) : String
      {
         return param1;
      }
   }
}
