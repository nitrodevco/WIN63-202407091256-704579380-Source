package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetGetObjectLocationMessage extends RoomWidgetMessage
   {
      
      public static const const_551:String = "RWGOI_MESSAGE_GET_OBJECT_LOCATION";
      
      public static const const_630:String = "RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION";
       
      
      private var var_455:int;
      
      private var var_3402:int;
      
      public function RoomWidgetGetObjectLocationMessage(param1:String, param2:int, param3:int)
      {
         super(param1);
         var_455 = param2;
         var_3402 = param3;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get objectType() : int
      {
         return var_3402;
      }
   }
}
