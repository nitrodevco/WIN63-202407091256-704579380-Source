package com.sulake.core.window
{
   import com.sulake.core.window.utils.IIterable;
   import flash.geom.Point;
   
   public interface IWindowContainer extends IWindow, IIterable
   {
       
      
      function get numChildren() : int;
      
      function addChild(param1:IWindow) : IWindow;
      
      function addChildAt(param1:IWindow, param2:int) : IWindow;
      
      function removeChild(param1:IWindow) : IWindow;
      
      function removeChildAt(param1:int) : IWindow;
      
      function setChildIndex(param1:IWindow, param2:int) : void;
      
      function swapChildren(param1:IWindow, param2:IWindow) : void;
      
      function swapChildrenAt(param1:int, param2:int) : void;
      
      function groupChildrenWithID(param1:uint, param2:Array, param3:int = 0) : uint;
      
      function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function getChildUnderPoint(param1:Point) : IWindow;
      
      function groupChildrenUnderPoint(param1:Point, param2:Array) : void;
   }
}
