package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetCommandsUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_COMMANDS:String = "RWPCUE_PET_COMMANDS";
      
      public static const OPEN_PET_TRAINING:String = "RWPCUE_OPEN_PET_TRAINING";
      
      public static const CLOSE_PET_TRAINING:String = "RWPCUE_CLOSE_PET_TRAINING";
       
      
      private var var_280:int;
      
      private var var_338:Array;
      
      private var var_269:Array;
      
      public function RoomWidgetPetCommandsUpdateEvent(param1:int, param2:Array, param3:Array, param4:Boolean = false, param5:Boolean = false)
      {
         super("RWPCUE_PET_COMMANDS",param4,param5);
         var_280 = param1;
         var_338 = param2;
         var_269 = param3;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get allCommands() : Array
      {
         return var_338;
      }
      
      public function get enabledCommands() : Array
      {
         return var_269;
      }
   }
}
