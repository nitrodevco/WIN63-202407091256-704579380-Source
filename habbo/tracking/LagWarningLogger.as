package com.sulake.habbo.tracking
{
   import com.sulake.habbo.communication.messages.outgoing.tracking.class_253;
   
   public class LagWarningLogger
   {
       
      
      private var var_1484:int;
      
      private var var_1073:int;
      
      private var _habboTracking:HabboTracking;
      
      public function LagWarningLogger(param1:HabboTracking)
      {
         super();
         _habboTracking = param1;
      }
      
      public function chatLagDetected(param1:int) : void
      {
         if(!enabled || warningInterval <= 0)
         {
            return;
         }
         var_1073++;
         reportWarningsAsNeeded(param1);
      }
      
      public function update(param1:int) : void
      {
         reportWarningsAsNeeded(param1);
      }
      
      private function reportWarningsAsNeeded(param1:int) : void
      {
         var _loc2_:class_253 = null;
         if(var_1073 == 0)
         {
            return;
         }
         if(var_1484 == 0 || param1 - var_1484 > warningInterval)
         {
            _loc2_ = new class_253(var_1073);
            _habboTracking.send(_loc2_);
            var_1484 = param1;
            var_1073 = 0;
         }
      }
      
      private function get enabled() : Boolean
      {
         return _habboTracking.getBoolean("lagWarningLog.enabled");
      }
      
      private function get warningInterval() : int
      {
         return _habboTracking.getInteger("lagWarningLog.interval.seconds",10) * 1000;
      }
   }
}
