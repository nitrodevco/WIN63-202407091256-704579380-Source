package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.class_3400;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface class_3354 extends IDisposable
   {
       
      
      function set debug(param1:Boolean) : void;
      
      function render() : void;
      
      function addToRenderQueue(param1:IWindow, param2:Rectangle, param3:uint) : void;
      
      function flushRenderQueue() : void;
      
      function invalidate(param1:class_3400, param2:Rectangle) : void;
      
      function getDrawBufferForRenderable(param1:IWindow) : BitmapData;
      
      function purge(param1:IWindow = null, param2:Boolean = true) : void;
   }
}
