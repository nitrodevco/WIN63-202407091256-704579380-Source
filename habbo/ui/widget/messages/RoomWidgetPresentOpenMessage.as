package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetPresentOpenMessage extends RoomWidgetMessage
   {
      
      public static const const_882:String = "RWPOM_OPEN_PRESENT";
       
      
      private var var_455:int;
      
      public function RoomWidgetPresentOpenMessage(param1:String, param2:int)
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
