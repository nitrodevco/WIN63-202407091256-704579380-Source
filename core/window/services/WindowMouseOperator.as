package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class WindowMouseOperator implements IDisposable
   {
       
      
      protected var var_509:DisplayObject;
      
      protected var _window:WindowController;
      
      protected var var_2669:Boolean;
      
      protected var _offset:Point;
      
      protected var _mouse:Point;
      
      protected var var_1893:Point;
      
      protected var var_626:uint;
      
      private var _disposed:Boolean = false;
      
      public function WindowMouseOperator(param1:DisplayObject)
      {
         super();
         var_509 = param1;
         var_1893 = new Point();
         _mouse = new Point();
         _offset = new Point();
         var_2669 = false;
         var_626 = 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         end(_window);
         _offset = null;
         _mouse = null;
         var_1893 = null;
         var_509 = null;
         _disposed = true;
      }
      
      public function begin(param1:IWindow, param2:uint = 0) : IWindow
      {
         var_626 = param2;
         var _loc3_:IWindow = _window;
         if(_window != null)
         {
            end(_window);
         }
         if(param1 && !param1.disposed)
         {
            var_509.addEventListener("mouseDown",handler,false);
            var_509.addEventListener("mouseUp",handler,false);
            var_509.addEventListener("enterFrame",handler);
            _mouse.x = var_509.mouseX;
            _mouse.y = var_509.mouseY;
            _window = WindowController(param1);
            getMousePositionRelativeTo(param1,_mouse,_offset);
            _window.addEventListener("WE_DESTROYED",clientWindowDestroyed);
            var_2669 = true;
         }
         return _loc3_;
      }
      
      public function end(param1:IWindow) : IWindow
      {
         var _loc2_:IWindow = _window;
         if(var_2669)
         {
            if(_window == param1)
            {
               var_509.removeEventListener("mouseDown",handler,false);
               var_509.removeEventListener("mouseUp",handler,false);
               var_509.removeEventListener("enterFrame",handler);
               if(!_window.disposed)
               {
                  _window.removeEventListener("WE_DESTROYED",clientWindowDestroyed);
               }
               _window = null;
               var_2669 = false;
            }
         }
         return _loc2_;
      }
      
      protected function handler(param1:Event) : void
      {
         var _loc2_:MouseEvent = null;
         if(var_2669)
         {
            if(param1.type == "enterFrame")
            {
               if(_window.disposed)
               {
                  end(_window);
               }
               else if(_mouse.x != var_509.mouseX || _mouse.y != var_509.mouseY)
               {
                  operate(var_509.mouseX,var_509.mouseY);
                  _mouse.x = var_509.mouseX;
                  _mouse.y = var_509.mouseY;
               }
               return;
            }
            _loc2_ = param1 as MouseEvent;
            if(_loc2_ != null)
            {
               var _loc3_:* = _loc2_.type;
               if("mouseUp" === _loc3_)
               {
                  end(_window);
               }
            }
         }
      }
      
      public function operate(param1:int, param2:int) : void
      {
         _mouse.x = param1;
         _mouse.y = param2;
         getMousePositionRelativeTo(_window,_mouse,var_1893);
         _window.offset(var_1893.x - _offset.x,var_1893.y - _offset.y);
      }
      
      private function clientWindowDestroyed(param1:WindowEvent) : void
      {
         end(_window);
      }
      
      protected function getMousePositionRelativeTo(param1:IWindow, param2:Point, param3:Point) : void
      {
         param1.getGlobalPosition(param3);
         param3.x = param2.x - param3.x;
         param3.y = param2.y - param3.y;
      }
   }
}
