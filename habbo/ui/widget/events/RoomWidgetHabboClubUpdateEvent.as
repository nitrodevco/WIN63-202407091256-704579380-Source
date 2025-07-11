package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_458:String = "RWBIUE_HABBO_CLUB";
       
      
      private var var_4612:int = 0;
      
      private var var_4538:int = 0;
      
      private var var_4836:int = 0;
      
      private var var_4403:Boolean = false;
      
      private var var_842:int;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWBIUE_HABBO_CLUB",param6,param7);
         var_4612 = param1;
         var_4538 = param2;
         var_4836 = param3;
         var_4403 = param4;
         var_842 = param5;
      }
      
      public function get daysLeft() : int
      {
         return var_4612;
      }
      
      public function get periodsLeft() : int
      {
         return var_4538;
      }
      
      public function get pastPeriods() : int
      {
         return var_4836;
      }
      
      public function get allowClubDances() : Boolean
      {
         return var_4403;
      }
      
      public function get clubLevel() : int
      {
         return var_842;
      }
   }
}
