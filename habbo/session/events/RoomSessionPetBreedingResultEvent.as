package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_1638;
   
   public class RoomSessionPetBreedingResultEvent extends RoomSessionEvent
   {
      
      public static const PET_BREEDING_RESULT:String = "RSPFUE_PET_BREEDING_RESULT";
       
      
      private var var_1123:class_1638;
      
      private var var_1284:class_1638;
      
      public function RoomSessionPetBreedingResultEvent(param1:IRoomSession, param2:class_1638, param3:class_1638, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_PET_BREEDING_RESULT",param1,param4,param5);
         var_1123 = param2;
         var_1284 = param3;
      }
      
      public function get resultData() : class_1638
      {
         return var_1123;
      }
      
      public function get otherResultData() : class_1638
      {
         return var_1284;
      }
   }
}
