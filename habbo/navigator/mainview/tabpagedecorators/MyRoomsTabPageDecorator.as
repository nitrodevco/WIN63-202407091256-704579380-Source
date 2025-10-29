package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
   
   public class MyRoomsTabPageDecorator implements ITabPageDecorator
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var var_1462:class_3520;
      
      private const SUB_ITEMS:Array = [[5,"navigator.navisel.myrooms"],[4,"navigator.navisel.wherearemyfriends"],[3,"navigator.navisel.myfriendsrooms"],[18,"navigator.navisel.roomswithrights"],[19,"navigator.navisel.mygroups"],[6,"navigator.navisel.myfavourites"],[7,"navigator.navisel.visitedrooms"],[23,""]];
      
      public function MyRoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:IWindowContainer) : void
      {
         var _loc2_:String = "me_header";
         var _loc3_:IWindowContainer = param1.getChildByName(_loc2_) as IWindowContainer;
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            var_1462 = class_3520(_loc3_.findChildByName("meSubNavi"));
            prepareSubNavi();
            var_1462.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc3_.visible = true;
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
         var _loc2_:IWindowContainer = param1.getChildByName("me_footer") as IWindowContainer;
         var _loc3_:IWindow = _loc2_.findChildByName("create_room_but");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onCreateRoomClick);
         }
         _navigator.refreshButton(_loc2_,"create_room",true,null,0);
         _loc2_.visible = true;
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function onCreateRoomClick(param1:WindowEvent) : void
      {
         _navigator.send(new CanCreateRoomMessageComposer());
      }
      
      private function prepareSubNavi() : void
      {
         if(var_1462 == null || Boolean(var_1462.disposed))
         {
            return;
         }
         var _loc2_:Array = [];
         for each(var _loc1_ in SUB_ITEMS)
         {
            _loc2_.push(_navigator.getText(_loc1_[1]));
         }
         var_1462.populate(_loc2_);
         var_1462.selection = 0;
      }
      
      private function onFilterSelected(param1:WindowEvent) : void
      {
         startSearch();
         var _loc2_:IWindow = param1.target;
         if(_loc2_ is class_3520)
         {
            _navigator.trackNavigationDataPoint(class_3520(_loc2_).enumerateSelection()[class_3520(_loc2_).selection],"category.view");
         }
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = int(var_1462 == null || Boolean(var_1462.disposed) ? 0 : var_1462.selection);
         _navigator.mainViewCtrl.startSearch(3,getSearchTypeForIndex(_loc1_));
      }
      
      private function getSearchTypeForIndex(param1:int) : int
      {
         if(param1 <= SUB_ITEMS.length)
         {
            return SUB_ITEMS[param1][0];
         }
         return SUB_ITEMS[0][0];
      }
      
      public function get filterCategory() : String
      {
         return var_1462 && !var_1462.disposed ? var_1462.enumerateSelection()[var_1462.selection] : null;
      }
      
      public function setSubSelection(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         if(!var_1462 || Boolean(var_1462.disposed))
         {
            return;
         }
         var _loc4_:int = var_1462.numMenuItems;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = SUB_ITEMS[_loc3_];
            if(_loc2_[0] == param1)
            {
               var_1462.selection = _loc3_;
               return;
            }
            _loc3_++;
         }
         var_1462.selection = 0;
      }
      
      public function processSearchParam(param1:String) : String
      {
         return param1;
      }
   }
}
