package com.sulake.core.window
{
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.services.IInternalWindowServices;
   import com.sulake.core.window.utils.class_3577;
   import flash.geom.Rectangle;
   
   public interface class_3400
   {
       
      
      function getWindowServices() : IInternalWindowServices;
      
      function getWindowParser() : class_3577;
      
      function getDesktopWindow() : class_3460;
      
      function registerLocalizationListener(param1:String, param2:IWindow) : void;
      
      function removeLocalizationListener(param1:String, param2:IWindow) : void;
      
      function findWindowByName(param1:String) : IWindow;
      
      function findWindowByTag(param1:String) : IWindow;
      
      function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindow, param9:uint, param10:Array = null, param11:String = "", param12:Array = null) : IWindow;
      
      function destroy(param1:IWindow) : Boolean;
      
      function invalidate(param1:IWindow, param2:Rectangle, param3:uint) : void;
      
      function getLastError() : Error;
      
      function getLastErrorCode() : int;
      
      function flushError() : void;
      
      function addMouseEventTracker(param1:IInputEventTracker) : void;
      
      function removeMouseEventTracker(param1:IInputEventTracker) : void;
   }
}
