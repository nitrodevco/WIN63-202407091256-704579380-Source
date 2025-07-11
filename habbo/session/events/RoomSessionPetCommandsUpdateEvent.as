package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetCommandsUpdateEvent extends RoomSessionEvent
   {
      
      public static const PET_COMMANDS:String = "RSPIUE_ENABLED_PET_COMMANDS";
       
      
      private var var_393:int;
      
      private var var_4483:Array;
      
      private var var_4517:Array;
      
      public function RoomSessionPetCommandsUpdateEvent(param1:IRoomSession, param2:int, param3:Array, param4:Array, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSPIUE_ENABLED_PET_COMMANDS",param1,param5,param6);
         var_393 = param2;
         var_4483 = param3;
         var_4517 = param4;
      }
      
      public function get petId() : int
      {
         return var_393;
      }
      
      public function get allCommands() : Array
      {
         return var_4483;
      }
      
      public function get enabledCommands() : Array
      {
         return var_4517;
      }
   }
}
