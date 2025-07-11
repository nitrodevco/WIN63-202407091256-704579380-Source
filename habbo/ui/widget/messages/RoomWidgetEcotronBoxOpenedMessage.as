package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage
   {
      
      public static const const_586:String = "RWEBOM_ECOTRONBOX_OPENED";
       
      
      private var var_125:String;
      
      private var var_390:int;
      
      public function RoomWidgetEcotronBoxOpenedMessage(param1:String, param2:String, param3:int)
      {
         super(param1);
         var_125 = param2;
         var_390 = param3;
      }
      
      public function get itemType() : String
      {
         return var_125;
      }
      
      public function get classId() : int
      {
         return var_390;
      }
   }
}
