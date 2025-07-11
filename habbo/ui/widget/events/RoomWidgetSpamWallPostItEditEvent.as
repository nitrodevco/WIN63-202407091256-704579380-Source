package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_496:String = "RWSWPUE_OPEN_EDITOR";
       
      
      private var var_455:int;
      
      private var var_587:String;
      
      private var var_3402:String;
      
      public function RoomWidgetSpamWallPostItEditEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_455 = param2;
         var_587 = param3;
         var_3402 = param4;
      }
      
      public function get location() : String
      {
         return var_587;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get objectType() : String
      {
         return var_3402;
      }
   }
}
