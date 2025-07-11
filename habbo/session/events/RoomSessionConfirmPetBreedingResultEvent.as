package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionConfirmPetBreedingResultEvent extends RoomSessionEvent
   {
      
      public static const CONFIRM_PET_BREEDING_RESULT:String = "RSPFUE_CONFIRM_PET_BREEDING_RESULT";
       
      
      private var var_497:int;
      
      private var var_152:int;
      
      public function RoomSessionConfirmPetBreedingResultEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_CONFIRM_PET_BREEDING_RESULT",param1,param4,param5);
         var_497 = param2;
         var_152 = param3;
      }
      
      public function get breedingNestStuffId() : int
      {
         return var_497;
      }
      
      public function get result() : int
      {
         return var_152;
      }
   }
}
