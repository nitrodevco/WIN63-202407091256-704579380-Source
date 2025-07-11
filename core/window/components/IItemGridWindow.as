package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.utils.IIterable;
   
   public interface IItemGridWindow extends IWindow, IScrollableWindow, IIterable
   {
       
      
      function get spacing() : int;
      
      function set spacing(param1:int) : void;
      
      function set verticalSpacing(param1:int) : void;
      
      function get scaleToFitItems() : Boolean;
      
      function set scaleToFitItems(param1:Boolean) : void;
      
      function get autoArrangeItems() : Boolean;
      
      function set autoArrangeItems(param1:Boolean) : void;
      
      function get resizeOnItemUpdate() : Boolean;
      
      function set resizeOnItemUpdate(param1:Boolean) : void;
      
      function get numColumns() : uint;
      
      function get numRows() : uint;
      
      function get numGridItems() : uint;
      
      function addGridItem(param1:IWindow) : IWindow;
      
      function addGridItemAt(param1:IWindow, param2:uint) : IWindow;
      
      function getGridItemAt(param1:uint) : IWindow;
      
      function getGridItemByID(param1:uint) : IWindow;
      
      function getGridItemByName(param1:String) : IWindow;
      
      function getGridItemByTag(param1:String) : IWindow;
      
      function getGridItemIndex(param1:IWindow) : int;
      
      function removeGridItem(param1:IWindow) : IWindow;
      
      function removeGridItemAt(param1:int) : IWindow;
      
      function setGridItemIndex(param1:IWindow, param2:int) : void;
      
      function swapGridItems(param1:IWindow, param2:IWindow) : void;
      
      function swapGridItemsAt(param1:int, param2:int) : void;
      
      function removeGridItems() : void;
      
      function destroyGridItems() : void;
      
      function set shouldRebuildGridOnResize(param1:Boolean) : void;
      
      function get shouldRebuildGridOnResize() : Boolean;
      
      function rebuildGridStructure() : void;
      
      function set containerResizeToColumns(param1:Boolean) : void;
      
      function get containerResizeToColumns() : Boolean;
      
      function populate(param1:Array) : void;
   }
}
