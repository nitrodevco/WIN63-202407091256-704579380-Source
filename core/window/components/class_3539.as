package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.utils.IIterable;
   
   public interface class_3539 extends IInteractiveWindow, IIterable
   {
       
      
      function get selection() : int;
      
      function set selection(param1:int) : void;
      
      function get numMenuItems() : int;
      
      function addMenuItem(param1:IWindow) : IWindow;
      
      function addMenuItemAt(param1:IWindow, param2:int) : IWindow;
      
      function getMenuItemIndex(param1:IWindow) : int;
      
      function getMenuItemAt(param1:int) : IWindow;
      
      function removeMenuItem(param1:IWindow) : IWindow;
      
      function removeMenuItemAt(param1:int) : IWindow;
   }
}
