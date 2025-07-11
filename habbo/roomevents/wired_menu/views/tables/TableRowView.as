package com.sulake.habbo.roomevents.wired_menu.views.tables
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.class_3402;
   
   public class TableRowView implements IDisposable
   {
      
      private static var var_4940:uint = 12116732;
      
      private static var var_4970:uint = 13750737;
      
      private static var var_4923:uint = 15395562;
      
      private static var var_4957:uint = 16382457;
       
      
      private var _disposed:Boolean = false;
      
      private var var_3173:TableView;
      
      private var var_2060:ITableObject;
      
      private var _container:IItemListWindow;
      
      private var var_2483:Vector.<TableCellView>;
      
      private var var_3215:int;
      
      private var _selected:Boolean = false;
      
      private var _hasFocus:Boolean = false;
      
      public function TableRowView(param1:TableView, param2:ITableObject, param3:int)
      {
         var _loc6_:TableCell = null;
         var _loc4_:TableCellView = null;
         super();
         var_3173 = param1;
         var_2060 = param2;
         _container = param1.rowTemplate.clone() as IItemListWindow;
         var_2483 = new Vector.<TableCellView>();
         var_3215 = param3;
         updateWidth();
         for each(var _loc5_ in param1.columns)
         {
            _loc6_ = param2.getTableCell(_loc5_.id);
            _loc4_ = new TableCellView(param1,this,_loc5_.id,_loc6_);
            var_2483.push(_loc4_);
            _container.addListItem(_loc4_.container);
         }
         updateColor();
         _container.addEventListener("WME_DOWN",onDown);
         _container.addEventListener("WME_CLICK_AWAY",onClickAway);
      }
      
      private static function windowIsChild(param1:IWindow, param2:IWindow) : Boolean
      {
         var _loc3_:IWindowContainer = null;
         var _loc4_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         if(param1 is IWindowContainer || param1 is IItemListWindow || param1 is ISelectorWindow)
         {
            if(param1 is class_3402)
            {
               for each(var _loc5_ in (param1 as class_3402).children)
               {
                  if(windowIsChild(_loc5_,param2))
                  {
                     return true;
                  }
               }
            }
            else if(param1 is IWindowContainer)
            {
               _loc3_ = param1 as IWindowContainer;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.numChildren)
               {
                  if(windowIsChild(_loc3_.getChildAt(_loc4_),param2))
                  {
                     return true;
                  }
                  _loc4_++;
               }
            }
         }
         return false;
      }
      
      public function set index(param1:int) : void
      {
         var_3215 = param1;
         updateColor();
      }
      
      public function update(param1:ITableObject) : void
      {
         var _loc5_:TableCell = null;
         var _loc2_:TableCellView = null;
         if(!param1.isUpdated(var_2060))
         {
            var_2060 = param1;
            return;
         }
         var _loc4_:int = 0;
         for each(var _loc3_ in var_3173.columns)
         {
            if(param1.isPropertyUpdated(_loc3_.id,var_2060))
            {
               _loc5_ = param1.getTableCell(_loc3_.id);
               _loc2_ = var_2483[_loc4_];
               _loc2_.update(_loc5_);
            }
            _loc4_ += 1;
         }
         var_2060 = param1;
      }
      
      public function reuse(param1:ITableObject, param2:int) : void
      {
         var _loc6_:TableCell = null;
         var _loc3_:TableCellView = null;
         var_2060 = param1;
         var_3215 = param2;
         var _loc5_:int = 0;
         for each(var _loc4_ in var_3173.columns)
         {
            _loc6_ = param1.getTableCell(_loc4_.id);
            _loc3_ = var_2483[_loc5_];
            _loc3_.reuse(_loc6_);
            _loc5_ += 1;
         }
         updateColor();
      }
      
      public function updateWidth() : void
      {
         container.width = var_3173.rowWidth;
         for each(var _loc1_ in var_2483)
         {
            _loc1_.updateWidth();
         }
      }
      
      private function updateColor() : void
      {
         var _loc1_:* = 0;
         if(_selected)
         {
            if(_hasFocus)
            {
               _loc1_ = var_4940;
            }
            else
            {
               _loc1_ = var_4970;
            }
         }
         else
         {
            _loc1_ = var_3215 % 2 == 0 ? var_4923 : var_4957;
         }
         _container.color = 4278190080 ^ _loc1_;
      }
      
      internal function onDown(param1:WindowMouseEvent) : void
      {
         _hasFocus = true;
         var_3173.trySelect(object);
         updateColor();
      }
      
      internal function onClickAway(param1:WindowMouseEvent) : void
      {
         _hasFocus = windowIsChild(_container,param1.related);
         updateColor();
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         updateColor();
      }
      
      public function get object() : ITableObject
      {
         return var_2060;
      }
      
      public function get container() : IItemListWindow
      {
         return _container;
      }
      
      public function recycle() : void
      {
         for each(var _loc1_ in var_2483)
         {
            _loc1_.recycle();
         }
         _selected = false;
         _hasFocus = false;
         var_2060 = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in var_2483)
         {
            _loc1_.dispose();
         }
         var_2483 = null;
         _container.dispose();
         _container = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
