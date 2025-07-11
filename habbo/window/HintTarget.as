package com.sulake.habbo.window
{
   import com.sulake.core.window.IWindow;
   
   public class HintTarget
   {
       
      
      private var _key:String;
      
      private var _window:IWindow;
      
      private var _style:int;
      
      public function HintTarget(param1:IWindow, param2:String, param3:int)
      {
         super();
         _window = param1;
         _key = param2;
         _style = param3;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function set window(param1:IWindow) : void
      {
         _window = param1;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function set key(param1:String) : void
      {
         _key = param1;
      }
      
      public function get style() : int
      {
         return _style;
      }
      
      public function set style(param1:int) : void
      {
         _style = param1;
      }
   }
}
