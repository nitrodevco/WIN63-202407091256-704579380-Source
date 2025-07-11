package com.sulake.habbo.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.components.IIconWindow;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class LoadingIcon implements IDisposable
   {
      
      private static const FRAMES:Array = [23,24,25,26];
       
      
      private var var_1883:Timer;
      
      private var _icon:IIconWindow;
      
      private var var_2910:int;
      
      public function LoadingIcon()
      {
         var_1883 = new Timer(160);
         super();
         var_1883.addEventListener("timer",onTimer);
      }
      
      public function dispose() : void
      {
         if(var_1883)
         {
            var_1883.removeEventListener("timer",onTimer);
            var_1883.stop();
            var_1883 = null;
         }
         _icon = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1883 == null;
      }
      
      public function setVisible(param1:IIconWindow, param2:Boolean) : void
      {
         _icon = param1;
         _icon.visible = param2;
         if(param2)
         {
            _icon.style = FRAMES[var_2910];
            var_1883.start();
         }
         else
         {
            var_1883.stop();
         }
      }
      
      private function onTimer(param1:Event) : void
      {
         if(_icon == null)
         {
            return;
         }
         var_2910++;
         if(var_2910 >= FRAMES.length)
         {
            var_2910 = 0;
         }
         _icon.style = FRAMES[var_2910];
      }
   }
}
