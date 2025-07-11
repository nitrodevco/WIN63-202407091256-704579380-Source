package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetEcotronBoxOpenMessage extends RoomWidgetMessage
   {
      
      public static const const_779:String = "RWEBOM_OPEN_ECOTRONBOX";
       
      
      private var var_455:int;
      
      public function RoomWidgetEcotronBoxOpenMessage(param1:String, param2:int)
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
