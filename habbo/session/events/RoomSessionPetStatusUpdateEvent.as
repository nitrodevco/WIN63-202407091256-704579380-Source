package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetStatusUpdateEvent extends RoomSessionEvent
   {
      
      public static const PET_STATUS_UPDATE:String = "RSPFUE_PET_STATUS_UPDATE";
       
      
      private var var_393:int;
      
      private var var_786:Boolean;
      
      private var var_1002:Boolean;
      
      private var var_910:Boolean;
      
      private var var_807:Boolean;
      
      public function RoomSessionPetStatusUpdateEvent(param1:IRoomSession, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super("RSPFUE_PET_STATUS_UPDATE",param1,param7,param8);
         var_393 = param2;
         var_786 = param3;
         var_1002 = param4;
         var_910 = param5;
         var_807 = param6;
      }
      
      public function get petId() : int
      {
         return var_393;
      }
      
      public function get canBreed() : Boolean
      {
         return var_786;
      }
      
      public function get canHarvest() : Boolean
      {
         return var_1002;
      }
      
      public function get canRevive() : Boolean
      {
         return var_910;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_807;
      }
   }
}
