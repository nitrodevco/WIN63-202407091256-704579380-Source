package com.sulake.habbo.catalog.purse
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class Purse implements class_3378
   {
       
      
      private var var_4816:int = 0;
      
      private var var_3323:Dictionary;
      
      private var var_4066:int = 0;
      
      private var var_4040:int = 0;
      
      private var var_1460:Boolean = false;
      
      private var var_808:int = 0;
      
      private var var_1230:int = 0;
      
      private var _isExpiring:Boolean = false;
      
      private var var_1476:int = 0;
      
      private var var_1050:int;
      
      private var var_1861:int;
      
      private var var_478:int = 0;
      
      private var var_630:int = 0;
      
      public function Purse()
      {
         var_3323 = new Dictionary();
         super();
      }
      
      public function get credits() : int
      {
         return var_4816;
      }
      
      public function set credits(param1:int) : void
      {
         var_1861 = getTimer();
         var_4816 = param1;
      }
      
      public function get clubDays() : int
      {
         return var_4066;
      }
      
      public function set clubDays(param1:int) : void
      {
         var_1861 = getTimer();
         var_4066 = param1;
      }
      
      public function get clubPeriods() : int
      {
         return var_4040;
      }
      
      public function set clubPeriods(param1:int) : void
      {
         var_1861 = getTimer();
         var_4040 = param1;
      }
      
      public function get hasClubLeft() : Boolean
      {
         return var_4066 > 0 || var_4040 > 0;
      }
      
      public function get isVIP() : Boolean
      {
         return var_1460;
      }
      
      public function get isExpiring() : Boolean
      {
         return _isExpiring;
      }
      
      public function set isExpiring(param1:Boolean) : void
      {
         _isExpiring = param1;
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         var_1460 = param1;
      }
      
      public function get pastClubDays() : int
      {
         return var_808;
      }
      
      public function set pastClubDays(param1:int) : void
      {
         var_1861 = getTimer();
         var_808 = param1;
      }
      
      public function get pastVipDays() : int
      {
         return var_1230;
      }
      
      public function set pastVipDays(param1:int) : void
      {
         var_1861 = getTimer();
         var_1230 = param1;
      }
      
      public function get activityPoints() : Dictionary
      {
         return var_3323;
      }
      
      public function set activityPoints(param1:Dictionary) : void
      {
         var_1861 = getTimer();
         var_3323 = param1;
      }
      
      public function getActivityPointsForType(param1:int) : int
      {
         return var_3323[param1];
      }
      
      public function set minutesUntilExpiration(param1:int) : void
      {
         var_1861 = getTimer();
         var_1476 = param1;
      }
      
      public function get minutesUntilExpiration() : int
      {
         var _loc1_:int = (getTimer() - var_1861) / 60000;
         var _loc2_:int = var_1476 - _loc1_;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      public function set minutesSinceLastModified(param1:int) : void
      {
         var_1861 = getTimer();
         var_1050 = param1;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return var_1050;
      }
      
      public function get lastUpdated() : int
      {
         return var_1861;
      }
      
      public function get emeraldBalance() : int
      {
         return var_478;
      }
      
      public function set emeraldBalance(param1:int) : void
      {
         var_478 = param1;
      }
      
      public function get silverBalance() : int
      {
         return var_630;
      }
      
      public function set silverBalance(param1:int) : void
      {
         var_630 = param1;
      }
   }
}
