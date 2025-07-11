package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const VISITOR_QUEUE_STATUS:String = "RWRQUE_VISITOR_QUEUE_STATUS";
      
      public static const SPECTATOR_QUEUE_STATUS:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";
       
      
      private var var_810:int;
      
      private var var_4292:Boolean;
      
      private var var_2341:Boolean;
      
      private var var_4099:Boolean;
      
      public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_810 = param2;
         var_4292 = param3;
         var_2341 = param4;
         var_4099 = param5;
      }
      
      public function get position() : int
      {
         return var_810;
      }
      
      public function get hasHabboClub() : Boolean
      {
         return var_4292;
      }
      
      public function get isActive() : Boolean
      {
         return var_2341;
      }
      
      public function get isClubQueue() : Boolean
      {
         return var_4099;
      }
   }
}
