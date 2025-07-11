package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetBreedingEvent extends RoomSessionEvent
   {
      
      public static const PET_BREEDING:String = "RSPFUE_PET_BREEDING";
       
      
      private var var_149:int;
      
      private var var_1401:int;
      
      private var var_879:int;
      
      public function RoomSessionPetBreedingEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSPFUE_PET_BREEDING",param1,param5,param6);
         var_149 = param2;
         var_1401 = param3;
         var_879 = param4;
      }
      
      public function get state() : int
      {
         return var_149;
      }
      
      public function get ownPetId() : int
      {
         return var_1401;
      }
      
      public function get otherPetId() : int
      {
         return var_879;
      }
   }
}
