package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_803:String = "RWROUE_OBJECT_SELECTED";
      
      public static const const_796:String = "RWROUE_OBJECT_DESELECTED";
      
      public static const USER_REMOVED:String = "RWROUE_USER_REMOVED";
      
      public static const const_610:String = "RWROUE_FURNI_REMOVED";
      
      public static const const_840:String = "RWROUE_FURNI_ADDED";
      
      public static const USER_ADDED:String = "RWROUE_USER_ADDED";
      
      public static const OBJECT_ROLL_OVER:String = "RWROUE_OBJECT_ROLL_OVER";
      
      public static const const_1117:String = "RWROUE_OBJECT_ROLL_OUT";
       
      
      private var var_280:int = 0;
      
      private var var_638:int = 0;
      
      private var var_369:int = 0;
      
      public function RoomWidgetRoomObjectUpdateEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_280 = param2;
         var_638 = param3;
         var_369 = param4;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
   }
}
