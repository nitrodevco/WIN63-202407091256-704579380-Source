package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import assets.class_14

    import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1735;
   
   public class RoomsTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1462:class_3520;
      
      private var var_3558:Boolean = false;
      
      public function RoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc2_:String = "rooms_header";
         var _loc3_:IWindowContainer = param1.getChildByName(_loc2_) as IWindowContainer;
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            var_1462 = class_3520(_loc3_.findChildByName("roomCtgFilter"));
            prepareRoomCategories();
            var_1462.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc3_.visible = true;
      }
      
      public function prepareRoomCategories() : void
      {
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            return;
         }
         var _loc1_:Array = [_navigator.getText("navigator.navisel.popularrooms"),_navigator.getText("navigator.navisel.highestscore")];
         var_3558 = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
         if(var_3558)
         {
            _loc1_.push(_navigator.getText("navigator.navisel.recommendedrooms"));
         }
         for each(var _loc2_ in _navigator.data.visibleCategories)
         {
            _loc1_.push(_loc2_.nodeName);
         }
         var_1462.populate(_loc1_);
         var_1462.selection = defaultSelection;
      }
      
      private function get defaultSelection() : int
      {
         return var_3558 ? 2 : 0;
      }
      
      public function tabSelected() : void
      {
         if(var_1462 != null && !var_1462.disposed)
         {
            var_1462.removeEventListener("WE_SELECTED",onFilterSelected);
            var_1462.selection = defaultSelection;
            var_1462.addEventListener("WE_SELECTED",onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:IWindowContainer) : void
      {
         _navigator.officialRoomEntryManager.refreshAdFooter(param1);
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function onFilterSelected(param1:WindowEvent) : void
      {
         startSearch();
      }
      
      private function startSearch() : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_1735 = null;
         var _loc1_:int = 0;
         var _loc2_:int = var_1462 && !var_1462.disposed ? var_1462.selection : defaultSelection;
         class_14.log("Room filter changed: " + _loc2_);
         if(_loc2_ == 0)
         {
            _navigator.mainViewCtrl.startSearch(2,1);
         }
         else if(_loc2_ == 1)
         {
            _navigator.mainViewCtrl.startSearch(2,2);
         }
         else if(_loc2_ == 2 && var_3558)
         {
            _navigator.mainViewCtrl.startSearch(2,22);
         }
         else
         {
            _loc3_ = 2;
            if(var_3558)
            {
               _loc3_++;
            }
            if((_loc4_ = _navigator.data.visibleCategories[_loc2_ - _loc3_]) == null)
            {
               class_14.log("No fc found: " + _loc2_ + ", " + _navigator.data.visibleCategories.length);
               return;
            }
            _loc1_ = _loc4_.nodeId;
            class_14.log("Searching with catId: " + _loc1_);
            _navigator.mainViewCtrl.startSearch(2,1,"" + _loc1_);
         }
         if(var_1462 && !var_1462.disposed)
         {
            _navigator.trackNavigationDataPoint(var_1462.enumerateSelection()[var_1462.selection],"category.view");
         }
      }
      
      public function get filterCategory() : String
      {
         return var_1462 && !var_1462.disposed ? var_1462.enumerateSelection()[var_1462.selection] : null;
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
