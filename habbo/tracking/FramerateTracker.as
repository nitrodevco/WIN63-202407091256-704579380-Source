package com.sulake.habbo.tracking
{
   public class FramerateTracker
   {
       
      
      private var var_3895:int;
      
      private var var_2624:int;
      
      private var var_2182:Number;
      
      private var var_4050:int;
      
      private var _habboTracking:HabboTracking;
      
      public function FramerateTracker(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function get frameRate() : int
      {
         return Math.round(1000 / var_2182);
      }
      
      public function trackUpdate(param1:uint, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var_2624++;
         if(var_2624 == 1)
         {
            var_2182 = param1;
            var_3895 = param2;
         }
         else
         {
            _loc3_ = var_2624;
            var_2182 = var_2182 * (_loc3_ - 1) / _loc3_ + param1 / _loc3_;
         }
         if(param2 - var_3895 >= _habboTracking.getInteger("tracking.framerate.reportInterval.seconds",300) * 1000)
         {
            var_2624 = 0;
            if(var_4050 < _habboTracking.getInteger("tracking.framerate.maximumEvents",5))
            {
               _habboTracking.trackGoogle("performance","averageFramerate",frameRate);
               var_4050++;
               var_3895 = param2;
            }
         }
      }
   }
}
