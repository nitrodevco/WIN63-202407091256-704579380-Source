package com.sulake.habbo.roomevents.wired_menu.views.tables
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.class_3463;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import flash.utils.Dictionary;
   
   public class TableView implements IDisposable
   {
       
      
      private var TABLE_MARGIN:int = 5;
      
      private var SCROLLBAR_OFFSET:int = 21;
      
      private var var_3701:Vector.<TableRowView>;
      
      private var _disposed:Boolean;
      
      private var var_78:Boolean;
      
      private var var_4174:WiredMenuController;
      
      private var _parent:IWindowContainer;
      
      private var _container:IWindowContainer;
      
      private var var_2169:IItemListWindow;
      
      private var var_2727:class_3463;
      
      private var var_3446:ITextWindow;
      
      private var var_3277:IItemListWindow;
      
      private var var_4804:IWindowContainer;
      
      private var var_2000:Vector.<TableColumn>;
      
      private var var_2053:Vector.<TableRowView>;
      
      private var var_2823:Dictionary;
      
      private var _canSelect:Boolean;
      
      private var _onRowSelectedCallback:Function = null;
      
      private var _onCellEditCallback:Function = null;
      
      private var var_3861:Boolean = false;
      
      private var var_1881:TableRowView = null;
      
      public function TableView(param1:WiredMenuController, param2:IWindowContainer)
      {
         super();
         var_4174 = param1;
         _parent = param2;
         _container = IWindowContainer(param1.roomEvents.getXmlWindow("wired_menu_table_view"));
         param2.addChild(_container);
         var_2169 = _container.findChildByName("table_titlerow") as IItemListWindow;
         var_2727 = _container.findChildByName("splitter") as class_3463;
         tableContents.removeListItem(var_2169);
         tableContents.removeListItem(var_2727);
         var_3446 = var_2169.removeListItemAt(0) as ITextWindow;
         var_3277 = tableItems.removeListItemAt(0) as IItemListWindow;
         var_4804 = var_3277.removeListItemAt(0) as IWindowContainer;
         _container.width = param2.width;
         _container.height = param2.height;
         tableItems.height = tableContents.height - (var_2169.height + var_2727.height);
         resizeHorizontally();
         updateEmptyText();
      }
      
      public function initialize(param1:Vector.<TableColumn>, param2:Boolean = true, param3:Boolean = true) : void
      {
         if(var_78)
         {
            return;
         }
         _canSelect = param3;
         var_3701 = new Vector.<TableRowView>();
         var_2053 = new Vector.<TableRowView>();
         var_2823 = new Dictionary();
         if(param2)
         {
            tableContents.addListItemAt(var_2169,0);
            tableContents.addListItemAt(var_2727,1);
         }
         else
         {
            tableItems.height += var_2169.height + var_2727.height;
         }
         initializeColumns(param1);
         var_78 = true;
      }
      
      private function initializeColumns(param1:Vector.<TableColumn>) : void
      {
         var _loc3_:ITextWindow = null;
         var _loc2_:int = 0;
         var_2000 = param1;
         for each(var _loc4_ in param1)
         {
            _loc3_ = var_3446.clone() as ITextWindow;
            _loc3_.text = _loc4_.columnName;
            _loc2_ = getCellWidth(_loc4_.id);
            _loc3_.width = _loc2_;
            _loc3_.autoSize = _loc4_.alignment;
            var_2169.addListItem(_loc3_);
         }
      }
      
      public function setObjects(param1:Vector.<ITableObject>) : void
      {
         var _loc10_:ITableObject = null;
         var _loc5_:int = 0;
         var _loc2_:TableRowView = null;
         var _loc7_:TableRowView = null;
         if(!var_78)
         {
            return;
         }
         var _loc8_:int = int(tableItems.numListItems);
         var _loc9_:Boolean = false;
         var _loc4_:Dictionary = new Dictionary();
         var _loc3_:Vector.<TableRowView> = new Vector.<TableRowView>();
         for each(_loc10_ in param1)
         {
            _loc2_ = getRowForObject(_loc10_);
            if(_loc2_ != null)
            {
               _loc2_.update(_loc10_);
               _loc4_[_loc2_] = true;
               _loc3_.push(_loc2_);
            }
            else
            {
               _loc3_.push(null);
            }
         }
         for each(var _loc6_ in var_2053)
         {
            if(!(_loc6_ in _loc4_))
            {
               if(var_1881 == _loc6_)
               {
                  var_1881 = null;
                  if(_onRowSelectedCallback != null)
                  {
                     _onRowSelectedCallback(null);
                  }
               }
               tableItems.removeListItem(_loc6_.container);
               recycleRowView(_loc6_);
               _loc9_ = true;
            }
         }
         var_2823 = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc10_ = param1[_loc5_];
            if((_loc7_ = _loc3_[_loc5_]) == null)
            {
               _loc7_ = createOrReuseTableRowView(_loc10_,_loc5_);
               _loc3_[_loc5_] = _loc7_;
               tableItems.addListItemAt(_loc7_.container,_loc5_);
               _loc9_ = true;
            }
            var_2823[_loc10_.identifier] = _loc7_;
            _loc7_.index = _loc5_;
            _loc5_ += 1;
         }
         var_2053 = _loc3_;
         if(_loc8_ != tableItems.numListItems)
         {
            itemListAmountChanged();
         }
         if(_loc9_)
         {
            _loc5_ = 0;
            while(_loc5_ < var_2053.length)
            {
               var_2053[_loc5_].index = _loc5_;
               _loc5_ += 1;
            }
         }
      }
      
      public function clear() : void
      {
         if(!var_78)
         {
            return;
         }
         tableItems.removeListItems();
         for each(var _loc1_ in var_2053)
         {
            recycleRowView(_loc1_);
         }
         var_2053 = new Vector.<TableRowView>();
         var_2823 = new Dictionary();
         if(var_1881 != null)
         {
            var_1881 = null;
            if(_onRowSelectedCallback != null)
            {
               _onRowSelectedCallback(null);
            }
         }
         itemListAmountChanged();
      }
      
      private function recycleRowView(param1:TableRowView) : void
      {
         param1.recycle();
         var_3701.push(param1);
      }
      
      private function createOrReuseTableRowView(param1:ITableObject, param2:int) : TableRowView
      {
         var _loc3_:TableRowView = null;
         if(var_3701.length > 0)
         {
            _loc3_ = var_3701.pop();
            _loc3_.reuse(param1,param2);
            _loc3_.updateWidth();
         }
         else
         {
            _loc3_ = new TableRowView(this,param1,tableItems.numListItems);
         }
         return _loc3_;
      }
      
      private function itemListAmountChanged() : void
      {
         var _loc1_:Boolean = var_3861;
         var_3861 = tableItems.isScrollBarVisible;
         if(_loc1_ != var_3861)
         {
            resizeHorizontally();
         }
         updateEmptyText();
      }
      
      private function updateEmptyText() : void
      {
         emptyText.visible = var_2053 == null || var_2053.length == 0;
         var _loc1_:int = TABLE_MARGIN + tableItems.y + (tableItems.height / 2 - 9);
         emptyText.y = _loc1_;
      }
      
      private function resizeHorizontally() : void
      {
         var _loc2_:int = 0;
         var _loc4_:ITextWindow = null;
         var_2169.width = rowWidth;
         var_2727.width = rowWidth;
         var _loc1_:int = var_2169.numListItems;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            (_loc4_ = var_2169.getListItemAt(_loc2_) as ITextWindow).width = getCellWidth(var_2000[_loc2_].id);
            _loc2_++;
         }
         for each(var _loc3_ in var_2053)
         {
            _loc3_.updateWidth();
         }
      }
      
      public function getColumnById(param1:String) : TableColumn
      {
         for each(var _loc2_ in var_2000)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getRowForObject(param1:ITableObject) : TableRowView
      {
         return var_2823[param1.identifier];
      }
      
      public function trySelect(param1:ITableObject) : void
      {
         var _loc3_:TableRowView = null;
         if(!_canSelect)
         {
            return;
         }
         if(var_1881 != null && param1 != null && var_1881.object == param1)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(var_1881 != null)
         {
            var_1881.selected = false;
            var_1881 = null;
            _loc2_ = true;
         }
         if(param1 != null)
         {
            _loc3_ = getRowForObject(param1);
            if(_loc3_ != null)
            {
               _loc3_.selected = true;
               var_1881 = _loc3_;
               _loc2_ = true;
            }
         }
         if(_loc2_ && _onRowSelectedCallback != null)
         {
            _onRowSelectedCallback(var_1881 == null ? null : var_1881.object);
         }
      }
      
      public function get selected() : ITableObject
      {
         if(var_1881 == null)
         {
            return null;
         }
         return var_1881.object;
      }
      
      public function get size() : int
      {
         return var_2053.length;
      }
      
      internal function onEnterNewCellValue(param1:String, param2:ITableObject, param3:String) : void
      {
         if(_onCellEditCallback != null)
         {
            _onCellEditCallback(param2,param3,param1);
         }
      }
      
      public function get rowWidth() : int
      {
         return tableContents.width - (var_3861 ? SCROLLBAR_OFFSET : 0);
      }
      
      public function getCellWidth(param1:String) : int
      {
         return rowWidth * getColumnById(param1).widthFactor;
      }
      
      public function get columns() : Vector.<TableColumn>
      {
         return var_2000;
      }
      
      public function get rowTemplate() : IItemListWindow
      {
         return var_3277;
      }
      
      public function get cellTemplate() : IWindowContainer
      {
         return var_4804;
      }
      
      public function set onRowSelectedCallback(param1:Function) : void
      {
         _onRowSelectedCallback = param1;
      }
      
      public function set onCellEditCallback(param1:Function) : void
      {
         _onCellEditCallback = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clear();
         _container.dispose();
         var_4174 = null;
         _parent = null;
         var_2169 = null;
         var_2727 = null;
         var_3446.dispose();
         var_3446 = null;
         var_3277.dispose();
         var_3277 = null;
         var_2000 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get border() : class_3437
      {
         return _container.findChildByName("table_border") as class_3437;
      }
      
      private function get tableContents() : IItemListWindow
      {
         return _container.findChildByName("table_contents") as IItemListWindow;
      }
      
      private function get tableItems() : IScrollableListWindow
      {
         return _container.findChildByName("table_items") as IScrollableListWindow;
      }
      
      private function get emptyText() : ITextWindow
      {
         return _container.findChildByName("nothing_to_display_text") as ITextWindow;
      }
   }
}
