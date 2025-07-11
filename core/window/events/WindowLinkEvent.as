package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindow;
   
   public class WindowLinkEvent extends WindowEvent
   {
      
      public static const const_996:String = "WE_LINK";
      
      private static const const_422:Array = [];
       
      
      private var var_445:String;
      
      public function WindowLinkEvent()
      {
         super();
         var_329 = "WE_LINK";
      }
      
      public static function allocate(param1:String, param2:IWindow, param3:IWindow) : WindowEvent
      {
         var _loc4_:WindowLinkEvent;
         (_loc4_ = const_422.length > 0 ? const_422.pop() : new WindowLinkEvent()).var_445 = param1;
         _loc4_._window = param2;
         _loc4_.var_2724 = param3;
         _loc4_.var_1708 = false;
         _loc4_.var_2969 = const_422;
         return _loc4_;
      }
      
      public function get link() : String
      {
         return var_445;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(var_445,window,related);
      }
      
      override public function toString() : String
      {
         return "WindowLinkEvent { type: " + var_329 + " link: " + link + " cancelable: " + var_2351 + " window: " + _window + " }";
      }
   }
}
