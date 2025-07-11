package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3460;
   import flash.geom.Rectangle;
   
   public class WindowToggle implements IDisposable
   {
      
      public static const RESULT_SHOW:int = 0;
      
      public static const RESULT_ACTIVATE:int = 1;
      
      public static const RESULT_HIDE:int = 2;
       
      
      private var _window:IWindow;
      
      private var var_2894:class_3460;
      
      private var _disposed:Boolean;
      
      private var var_3498:Function;
      
      private var _hideFunction:Function;
      
      public function WindowToggle(param1:IWindow, param2:class_3460, param3:Function = null, param4:Function = null)
      {
         super();
         _window = param1;
         var_2894 = param2;
         var_3498 = param3;
         _hideFunction = param4;
      }
      
      public static function isHiddenByOtherWindows(param1:IWindow) : Boolean
      {
         var _loc8_:IWindow = null;
         var _loc7_:int = 0;
         var _loc3_:class_3460 = param1.desktop;
         var _loc5_:int = int(_loc3_.numChildren);
         var _loc6_:int;
         if((_loc6_ = int(_loc3_.getChildIndex(param1))) < 0)
         {
            throw new Error("Window must be contained by the desktop!");
         }
         var _loc2_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc2_);
         var _loc4_:Rectangle = new Rectangle();
         _loc7_ = _loc6_ + 1;
         while(_loc7_ < _loc5_)
         {
            if((_loc8_ = _loc3_.getChildAt(_loc7_)).visible)
            {
               _loc8_.getGlobalRectangle(_loc4_);
               if(_loc2_.intersects(_loc4_))
               {
                  return true;
               }
            }
            _loc7_++;
         }
         return false;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function get visible() : Boolean
      {
         return _window && _window.visible && _window.parent;
      }
      
      public function get active() : Boolean
      {
         return visible && _window.getStateFlag(1);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            var_2894 = null;
            _disposed = true;
            var_3498 = null;
            _hideFunction = null;
         }
      }
      
      public function show() : void
      {
         if(!_window.disposed)
         {
            if(_window.parent != var_2894)
            {
               var_2894.addChild(_window);
            }
            if(!_window.visible)
            {
               _window.visible = true;
            }
            _window.activate();
         }
      }
      
      public function hide() : void
      {
         if(!_window.disposed)
         {
            if(_window.parent == var_2894)
            {
               var_2894.removeChild(_window);
            }
            if(_window.visible)
            {
               _window.visible = false;
            }
            _window.deactivate();
         }
      }
      
      public function toggle() : void
      {
         if(visible)
         {
            if(active)
            {
               _hideFunction == null ? hide() : _hideFunction.call();
            }
            else if(isHiddenByOtherWindows(_window))
            {
               _window.activate();
            }
            else
            {
               _hideFunction == null ? hide() : _hideFunction.call();
            }
         }
         else
         {
            var_3498 == null ? show() : var_3498.call();
         }
      }
   }
}
