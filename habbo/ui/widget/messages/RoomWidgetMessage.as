package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_TEST:String = "RWM_MESSAGE_TEST";
       
      
      private var var_329:String = "";
      
      public function RoomWidgetMessage(param1:String)
      {
         super();
         var_329 = param1;
      }
      
      public function get type() : String
      {
         return var_329;
      }
   }
}
