package com.sulake.habbo.campaign.calendar
{
   import com.sulake.core.window.IWindow;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CalendarItemWiggle
   {
      
      private static const TIMER_INTERVAL:int = 80;
      
      private static const const_624:int = 10;
      
      private static const const_960:int = 40;
      
      private static const const_1054:int = 7;
       
      
      private var _window:IWindow;
      
      private var var_1883:Timer;
      
      private var var_1210:int;
      
      private var var_1461:int;
      
      private var var_2987:int;
      
      public function CalendarItemWiggle(param1:IWindow)
      {
         super();
         if(!param1)
         {
            return;
         }
         _window = param1;
         var_2987 = param1.y;
         param1.y -= 10;
         var_1210 = 1;
         var_1883 = new Timer(80);
         var_1883.addEventListener("timer",onTimerEvent);
         var_1883.start();
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         if(!_window)
         {
            dispose();
         }
         var _loc3_:Number = 10 * ((7 - var_1461) / 7);
         var _loc4_:Number = Math.abs(_window.y - var_2987) / _loc3_;
         var _loc2_:Number = Math.max(2,Math.sin(_loc4_) * 40) * var_1210;
         _window.y += _loc2_;
         if(var_1210 > 0)
         {
            if(_window.y > var_2987)
            {
               var_1210 *= -1;
               _window.y = var_2987;
               var_1461++;
            }
         }
         else if(_window.y <= var_2987 - _loc3_)
         {
            var_1210 *= -1;
            _window.y = var_2987 - _loc3_;
            var_1461++;
         }
         if(var_1461 >= 7)
         {
            dispose();
         }
      }
      
      private function dispose() : void
      {
         _window.y = var_2987;
         _window = null;
         var_1883.reset();
         var_1883 = null;
      }
   }
}
