package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage
   {
      
      public static const const_1037:String = "RWFCRM_REDEEM";
       
      
      private var var_455:int;
      
      public function RoomWidgetCreditFurniRedeemMessage(param1:String, param2:int)
      {
         super(param1);
         var_455 = param2;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
   }
}
