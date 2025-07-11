package com.sulake.habbo.inventory.purse
{
   import flash.utils.getTimer;
   
   public class Purse
   {
       
      
      private var _isExpiring:Boolean = false;
      
      private var _isCitizenshipVipExpiring:Boolean = false;
      
      private var var_4066:int = 0;
      
      private var var_4040:int = 0;
      
      private var var_4600:int = 0;
      
      private var var_4417:Boolean = false;
      
      private var var_1460:Boolean = false;
      
      private var var_1476:int = 0;
      
      private var var_1050:int = -1;
      
      private var var_1861:int;
      
      public function Purse()
      {
         super();
      }
      
      public function get clubDays() : int
      {
         return var_4066;
      }
      
      public function set clubDays(param1:int) : void
      {
         var_1861 = getTimer();
         var_4066 = Math.max(0,param1);
      }
      
      public function get clubPeriods() : int
      {
         return var_4040;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_1861 = getTimer();
         var_4040 = Math.max(0,param1);
      }
      
      public function get clubPastPeriods() : int
      {
         return var_4600;
      }
      
      public function set clubPastPeriods(param1:int) : void
      {
         var_1861 = getTimer();
         var_4600 = Math.max(0,param1);
      }
      
      public function get clubHasEverBeenMember() : Boolean
      {
         return var_4417;
      }
      
      public function set clubHasEverBeenMember(param1:Boolean) : void
      {
         var_1861 = getTimer();
         var_4417 = param1;
      }
      
      public function get isVIP() : Boolean
      {
         return var_1460;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         var_1861 = getTimer();
         var_1460 = param1;
      }
      
      public function get minutesUntilExpiration() : int
      {
         var _loc1_:int = (getTimer() - var_1861) / 60000;
         var _loc2_:int = var_1476 - _loc1_;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      public function set minutesUntilExpiration(param1:int) : void
      {
         var_1861 = getTimer();
         var_1476 = param1;
      }
      
      public function get clubIsExpiring() : Boolean
      {
         return _isExpiring;
      }
      
      public function set clubIsExpiring(param1:Boolean) : void
      {
         _isExpiring = param1;
      }
      
      public function get citizenshipVipIsExpiring() : Boolean
      {
         return _isCitizenshipVipExpiring;
      }
      
      public function set citizenshipVipIsExpiring(param1:Boolean) : void
      {
         _isCitizenshipVipExpiring = param1;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return var_1050;
      }
      
      public function set minutesSinceLastModified(param1:int) : void
      {
         var_1861 = getTimer();
         var_1050 = param1;
      }
   }
}
