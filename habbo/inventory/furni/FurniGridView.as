package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   
   public class FurniGridView
   {
      
      private static const PLACEMENT_ANYWHERE:int = 0;
      
      private static const PLACEMENT_IN_ROOM:int = 1;
      
      private static const PLACEMENT_NOT_IN_ROOM:int = 2;
       
      
      private var var_2176:IItemGridWindow;
      
      private var _items:Vector.<GroupItem>;
      
      private var _showFloorItems:Boolean = true;
      
      private var _showWallItems:Boolean = true;
      
      private var var_4221:int;
      
      private var _showingRentedItems:Boolean = false;
      
      private var _passedItems:Vector.<GroupItem>;
      
      private var var_2295:IItemListWindow;
      
      private var var_4490:IRegionWindow;
      
      private var var_4266:int = 200;
      
      private var var_1824:int = -1;
      
      private var _currentPageItems:Vector.<GroupItem>;
      
      private var var_1462:String = "";
      
      public function FurniGridView(param1:IItemGridWindow, param2:IItemListWindow)
      {
         super();
         var_2176 = param1;
         var_2176.shouldRebuildGridOnResize = false;
         _items = new Vector.<GroupItem>(0);
         _passedItems = new Vector.<GroupItem>(0);
         var_2295 = param2;
         if(var_2295)
         {
            var_4490 = var_2295.removeListItemAt(0) as IRegionWindow;
         }
      }
      
      public function get visibleCount() : int
      {
         return var_2176.numGridItems;
      }
      
      public function get currentPageItems() : Vector.<GroupItem>
      {
         return _currentPageItems;
      }
      
      private function get pageCount() : int
      {
         return _passedItems.length / var_4266 + 1;
      }
      
      public function dispose() : void
      {
         var_2176 = null;
         _items = null;
      }
      
      public function clearGrid() : void
      {
         if(var_2176 != null)
         {
            var_2176.removeGridItems();
         }
         var_2176.destroyGridItems();
      }
      
      public function setFilter(param1:int, param2:String, param3:Boolean, param4:String, param5:int) : void
      {
         _showFloorItems = param1 == 0 || param1 == 1;
         _showWallItems = param1 == 0 || param1 == 2;
         _showingRentedItems = param3;
         var_4221 = param5;
         var_1462 = param4.toLowerCase();
         update();
      }
      
      public function itemWasUpdated(param1:GroupItem) : void
      {
         if(passFilter(param1))
         {
            update();
         }
      }
      
      public function getFirstThumb() : IWindowContainer
      {
         if(var_2176.numGridItems == 0)
         {
            return null;
         }
         return var_2176.getGridItemAt(0) as IWindowContainer;
      }
      
      public function setItems(param1:Vector.<GroupItem>) : void
      {
         _items = param1;
         update();
      }
      
      private function update() : void
      {
         var item:GroupItem;
         var changes:Boolean;
         var i:int;
         var currentItems:Vector.<GroupItem> = new Vector.<GroupItem>(0);
         for each(item in _items)
         {
            if(passFilter(item))
            {
               currentItems.push(item);
            }
         }
         if(_showingRentedItems)
         {
            currentItems = currentItems.sort(function(param1:GroupItem, param2:GroupItem):Number
            {
               var _loc5_:FurnitureItem = param1.peek();
               var _loc4_:FurnitureItem;
               var _loc3_:int = int((_loc4_ = param2.peek()).hasRentPeriodStarted) - int(_loc5_.hasRentPeriodStarted);
               return _loc3_ != 0 ? _loc3_ : _loc5_.secondsToExpiration - _loc4_.secondsToExpiration;
            });
         }
         if(currentItems.length == _passedItems.length)
         {
            changes = false;
            i = 0;
            while(i < currentItems.length)
            {
               if(currentItems[i] != _passedItems[i])
               {
                  changes = true;
                  break;
               }
               i++;
            }
            if(!changes)
            {
               return;
            }
         }
         _passedItems = currentItems;
         changeToPage(var_1824,true);
         updatePaging();
      }
      
      private function changeToPage(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:* = 0;
         if(param1 > -1)
         {
            if(var_1824 == param1 && !param2)
            {
               return;
            }
         }
         else
         {
            param1 = 0;
         }
         var_1824 = param1;
         if(var_1824 >= pageCount)
         {
            var_1824 = pageCount - 1;
         }
         var_1824 = Math.max(var_1824,0);
         _currentPageItems = new Vector.<GroupItem>(0);
         clearGrid();
         var _loc3_:int = var_1824 * var_4266;
         var _loc4_:int = _loc3_ + var_4266;
         _loc4_ = Math.min(_loc4_,_passedItems.length);
         _loc5_ = _loc3_;
         while(_loc5_ < _loc4_)
         {
            var_2176.addGridItem(_passedItems[_loc5_].window);
            _currentPageItems.push(_passedItems[_loc5_]);
            _loc5_++;
         }
      }
      
      private function updatePassedItems(param1:GroupItem) : void
      {
      }
      
      private function updatePaging() : void
      {
         var _loc4_:IRegionWindow = null;
         var _loc3_:int = 0;
         var _loc2_:ITextWindow = null;
         if(!var_2295)
         {
            return;
         }
         var _loc1_:int = pageCount;
         var_2295.visible = _loc1_ > 1;
         if(var_1824 >= _loc1_)
         {
            var_1824 = _loc1_ - 1;
         }
         var_1824 = Math.max(var_1824,0);
         if(pageCount != var_2295.numListItems)
         {
            for each(_loc4_ in var_2295)
            {
               _loc4_.removeEventListener("WME_CLICK",onPageEventProc);
            }
            var_2295.destroyListItems();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               (_loc4_ = var_4490.clone() as IRegionWindow).addEventListener("WME_CLICK",onPageEventProc);
               _loc4_.addEventListener("WME_OVER",onPageEventProc);
               _loc4_.addEventListener("WME_OUT",onPageEventProc);
               _loc4_.id = _loc3_;
               _loc4_.name = "page_" + _loc3_;
               var_2295.addListItem(_loc4_);
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = (_loc4_ = var_2295.getListItemAt(_loc3_) as IRegionWindow).findChildByTag("PAGE") as ITextWindow;
            _loc2_.caption = _loc3_.toString();
            if(_loc3_ == var_1824)
            {
               _loc2_.underline = true;
               _loc2_.textColor = 16711680;
            }
            else
            {
               _loc2_.underline = false;
               _loc2_.textColor = 0;
            }
            _loc3_++;
         }
      }
      
      private function onPageEventProc(param1:WindowMouseEvent) : void
      {
         var _loc3_:int = param1.window.id;
         var _loc2_:ITextWindow = (param1.target as IWindowContainer).findChildByTag("PAGE") as ITextWindow;
         switch(param1.type)
         {
            case "WME_CLICK":
               changeToPage(_loc3_);
               updatePaging();
               break;
            case "WME_OVER":
               _loc2_.textColor = 16711680;
               break;
            case "WME_OUT":
               if(_loc3_ != var_1824)
               {
                  _loc2_.textColor = 0;
               }
         }
      }
      
      private function passFilter(param1:GroupItem) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!_showFloorItems && !param1.isWallItem)
         {
            return false;
         }
         if(!_showWallItems && param1.isWallItem)
         {
            return false;
         }
         if(_showingRentedItems != param1.isRented)
         {
            return false;
         }
         if(var_4221 == 1 && param1.flatId == -1)
         {
            return false;
         }
         if(var_4221 == 2 && param1.flatId > -1)
         {
            return false;
         }
         if(var_1462.length > 0)
         {
            _loc2_ = param1.name.toLowerCase();
            _loc3_ = param1.description.toLowerCase();
            if(_loc2_.indexOf(var_1462) == -1 && _loc3_.indexOf(var_1462) == -1)
            {
               return false;
            }
         }
         return true;
      }
   }
}
