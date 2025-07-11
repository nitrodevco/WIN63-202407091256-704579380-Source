package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   
   public class WindowMessage extends WindowEvent
   {
      
      private static const WINDOW_EVENT_MESSAGE:String = "WE_MESSAGE";
      
      private static const const_422:Array = [];
       
      
      public var message:String;
      
      public function WindowMessage()
      {
         super();
         var_329 = "WE_MESSAGE";
      }
      
      public static function allocate(param1:String, param2:IWindow, param3:IWindow, param4:Boolean = false) : WindowEvent
      {
         var _loc5_:WindowMessage;
         (_loc5_ = const_422.length > 0 ? const_422.pop() : new WindowMessage()).message = param1;
         _loc5_._window = param2;
         _loc5_.var_2724 = param3;
         _loc5_.var_2351 = param4;
         _loc5_.var_1708 = false;
         _loc5_.var_2969 = const_422;
         return _loc5_;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(message,window,related,cancelable);
      }
      
      override public function toString() : String
      {
         return "WindowLinkEvent { type: " + var_329 + " message: " + message + " cancelable: " + var_2351 + " window: " + _window + " }";
      }
   }
}
