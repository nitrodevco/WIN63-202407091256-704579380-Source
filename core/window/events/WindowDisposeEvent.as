package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   
   public class WindowDisposeEvent extends WindowEvent
   {
      
      public static const const_651:String = "WINDOW_DISPOSE_EVENT";
      
      private static const const_422:Array = [];
       
      
      public function WindowDisposeEvent()
      {
         super();
         var_329 = "WINDOW_DISPOSE_EVENT";
      }
      
      public static function allocate(param1:IWindow) : WindowDisposeEvent
      {
         var _loc2_:WindowDisposeEvent = const_422.length > 0 ? const_422.pop() : new WindowDisposeEvent();
         _loc2_._window = param1;
         _loc2_.var_1708 = false;
         _loc2_.var_2969 = const_422;
         return _loc2_;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(window);
      }
      
      override public function toString() : String
      {
         return "WindowDisposeEvent { type: " + var_329 + " window: " + _window + " }";
      }
   }
}
