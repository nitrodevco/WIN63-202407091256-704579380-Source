package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetFloodControlEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_1092:String = "RWFCE_FLOOD_CONTROL";
       
      
      private var var_484:int = 0;
      
      public function RoomWidgetFloodControlEvent(param1:int)
      {
         super("RWFCE_FLOOD_CONTROL",false,false);
         var_484 = param1;
      }
      
      public function get seconds() : int
      {
         return var_484;
      }
   }
}
