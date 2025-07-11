package com.sulake.habbo.notifications.feed
{
   public class StateController
   {
       
      
      private var var_1479:Boolean;
      
      private var var_3050:Boolean;
      
      private var var_3249:int = 0;
      
      private var var_3041:int = 1;
      
      public function StateController()
      {
         super();
      }
      
      private function isActive() : Boolean
      {
         return var_1479 && !var_3050;
      }
      
      public function setEnabled(param1:Boolean) : int
      {
         var_1479 = param1;
         if(!isActive())
         {
            return requestState(0);
         }
         return setVisible();
      }
      
      public function setGameMode(param1:Boolean) : int
      {
         var_3050 = param1;
         if(!isActive())
         {
            return requestState(0);
         }
         return setVisible();
      }
      
      public function currentState() : int
      {
         return var_3249;
      }
      
      public function requestState(param1:int) : int
      {
         if(!isActive())
         {
            var_3041 = param1;
            return var_3249;
         }
         var_3249 = param1;
         var_3041 = param1;
         return var_3249;
      }
      
      private function setVisible() : int
      {
         var _loc1_:int = var_3041;
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         var_3249 = _loc1_;
         var_3041 = _loc1_;
         return _loc1_;
      }
   }
}
