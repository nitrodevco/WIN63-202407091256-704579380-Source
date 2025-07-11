package com.sulake.room.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomShakingEffect
   {
      
      public static const STATE_NOT_INITIALIZED:int = 0;
      
      public static const STATE_START_DELAY:int = 1;
      
      public static const STATE_RUNNING:int = 2;
      
      public static const STATE_OVER:int = 3;
      
      private static var var_149:int = 0;
      
      private static var var_3697:Boolean = false;
      
      private static var var_3905:Number;
      
      private static var var_4453:int = 0;
      
      private static var var_3492:int = 20000;
      
      private static var var_3657:int = 5000;
      
      private static var var_2410:Timer;
       
      
      public function RoomShakingEffect()
      {
         super();
      }
      
      public static function init(param1:int, param2:int) : void
      {
         var_3905 = 0;
         var_3492 = param1;
         var_3657 = param2;
         var_4453 = getTimer();
         var_149 = 1;
      }
      
      public static function turnVisualizationOn() : void
      {
         if(var_149 == 0 || var_149 == 3)
         {
            return;
         }
         if(var_2410 == null || !var_2410.running)
         {
            var_2410 = new Timer(var_3657,1);
            var_2410.addEventListener("timerComplete",turnVisualizationOff);
            var_2410.start();
         }
         var _loc1_:int = getTimer() - var_4453;
         if(_loc1_ > var_3492 + var_3657)
         {
            var_149 = 3;
            return;
         }
         var_3697 = true;
         if(_loc1_ < var_3492)
         {
            var_149 = 1;
            return;
         }
         var_149 = 2;
         var_3905 = (_loc1_ - var_3492) / var_3657;
      }
      
      public static function turnVisualizationOff(param1:TimerEvent) : void
      {
         var_3697 = false;
         var_2410.stop();
         var_2410.removeEventListener("timerComplete",turnVisualizationOff);
         var_2410 = null;
      }
      
      public static function isVisualizationOn() : Boolean
      {
         return var_3697 && isRunning();
      }
      
      private static function isRunning() : Boolean
      {
         if(var_149 == 1 || var_149 == 2)
         {
            return true;
         }
         return false;
      }
   }
}
