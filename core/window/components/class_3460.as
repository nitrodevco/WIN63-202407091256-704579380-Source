package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import flash.geom.Point;
   
   public interface class_3460 extends IWindowContainer, class_3431
   {
       
      
      function get mouseX() : int;
      
      function get mouseY() : int;
      
      function getActiveWindow() : IWindow;
      
      function setActiveWindow(param1:IWindow) : IWindow;
      
      function groupParameterFilteredChildrenUnderPoint(param1:Point, param2:Array, param3:uint = 0) : void;
   }
}
