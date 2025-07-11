package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class WindowKeyboardEvent extends WindowEvent
   {
      
      public static const const_814:String = "WKE_KEY_UP";
      
      public static const const_741:String = "WKE_KEY_DOWN";
      
      private static const const_422:Array = [];
       
      
      private var var_2779:KeyboardEvent;
      
      public function WindowKeyboardEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:Event, param3:IWindow, param4:IWindow, param5:Boolean = false) : WindowKeyboardEvent
      {
         var _loc6_:WindowKeyboardEvent;
         (_loc6_ = const_422.length > 0 ? const_422.pop() : new WindowKeyboardEvent()).var_329 = param1;
         _loc6_.var_2779 = param2 as KeyboardEvent;
         _loc6_._window = param3;
         _loc6_.var_2724 = param4;
         _loc6_.var_1708 = false;
         _loc6_.var_2351 = param5;
         _loc6_.var_2969 = const_422;
         return _loc6_;
      }
      
      public function get charCode() : uint
      {
         return var_2779.charCode;
      }
      
      public function get keyCode() : uint
      {
         return var_2779.keyCode;
      }
      
      public function get keyLocation() : uint
      {
         return var_2779.keyLocation;
      }
      
      public function get altKey() : Boolean
      {
         return var_2779.altKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return var_2779.shiftKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return var_2779.ctrlKey;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(var_329,var_2779,window,related,cancelable);
      }
      
      override public function toString() : String
      {
         return "WindowKeyboardEvent { type: " + var_329 + " cancelable: " + var_2351 + " window: " + _window + " charCode: " + charCode + " }";
      }
   }
}
