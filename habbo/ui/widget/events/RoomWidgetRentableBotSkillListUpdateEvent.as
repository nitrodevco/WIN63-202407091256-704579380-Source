package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotSkillListUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const SKILL_LIST:String = "RWRBSLUE_SKILL_LIST";
       
      
      private var var_536:int;
      
      private var var_2591:Array;
      
      public function RoomWidgetRentableBotSkillListUpdateEvent(param1:int, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWRBSLUE_SKILL_LIST",param3,param4);
         var_536 = param1;
         var_2591 = param2;
      }
      
      public function get botSkillsWithCommands() : Array
      {
         return var_2591;
      }
      
      public function get botId() : int
      {
         return var_536;
      }
   }
}
