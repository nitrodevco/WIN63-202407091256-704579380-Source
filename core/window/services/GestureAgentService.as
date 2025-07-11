package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GestureAgentService implements class_3739, IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      protected var var_2669:Boolean;
      
      protected var _window:IWindow;
      
      protected var var_1883:Timer;
      
      protected var var_626:uint = 0;
      
      protected var _callback:Function;
      
      protected var var_3002:int;
      
      protected var var_3101:int;
      
      public function GestureAgentService()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         end(_window);
         _disposed = true;
      }
      
      public function begin(param1:IWindow, param2:Function, param3:uint, param4:int, param5:int) : IWindow
      {
         var_626 = param3;
         var _loc6_:IWindow = _window;
         if(_window != null)
         {
            end(_window);
         }
         if(param1 && !param1.disposed)
         {
            _window = param1;
            _window.addEventListener("WE_DESTROYED",clientWindowDestroyed);
            _callback = param2;
            var_2669 = true;
            var_3002 = param4;
            var_3101 = param5;
            var_1883 = new Timer(40,0);
            var_1883.addEventListener("timer",operate);
            var_1883.start();
         }
         return _loc6_;
      }
      
      protected function operate(param1:TimerEvent) : void
      {
         var_3002 *= 0.75;
         var_3101 *= 0.75;
         if(Math.abs(var_3002) <= 1 && Math.abs(var_3101) <= 1)
         {
            end(_window);
         }
         else if(_callback != null)
         {
            _callback(var_3002,var_3101);
         }
      }
      
      public function end(param1:IWindow) : IWindow
      {
         var _loc2_:IWindow = _window;
         if(var_1883)
         {
            var_1883.stop();
            var_1883.removeEventListener("timer",operate);
            var_1883 = null;
         }
         if(var_2669)
         {
            if(_window == param1)
            {
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
      
      private function clientWindowDestroyed(param1:WindowEvent) : void
      {
         end(_window);
      }
   }
}
