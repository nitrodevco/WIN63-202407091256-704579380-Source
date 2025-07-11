package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotForceOpenContextMenuEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_804:String = "RWRBFOCME_OPEN";
       
      
      private var var_536:int;
      
      public function RoomWidgetRentableBotForceOpenContextMenuEvent(param1:int)
      {
         var_536 = param1;
         super("RWRBFOCME_OPEN");
      }
      
      public function get botId() : int
      {
         return var_536;
      }
   }
}
