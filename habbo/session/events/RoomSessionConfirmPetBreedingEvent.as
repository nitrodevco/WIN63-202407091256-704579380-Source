package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_1683;
   
   public class RoomSessionConfirmPetBreedingEvent extends RoomSessionEvent
   {
      
      public static const CONFIRM_PET_BREEDING:String = "RSPFUE_CONFIRM_PET_BREEDING";
       
      
      private var var_596:int;
      
      private var _pet1:class_1683;
      
      private var _pet2:class_1683;
      
      private var var_446:Array;
      
      private var var_4274:int;
      
      public function RoomSessionConfirmPetBreedingEvent(param1:IRoomSession, param2:int, param3:class_1683, param4:class_1683, param5:Array, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super("RSPFUE_CONFIRM_PET_BREEDING",param1,param7,param8);
         var_596 = param2;
         _pet1 = param3;
         _pet2 = param4;
         var_446 = param5;
         var_4274 = param6;
      }
      
      public function get rarityCategories() : Array
      {
         return var_446;
      }
      
      public function get nestId() : int
      {
         return var_596;
      }
      
      public function get pet1() : class_1683
      {
         return _pet1;
      }
      
      public function get pet2() : class_1683
      {
         return _pet2;
      }
      
      public function get resultPetTypeId() : int
      {
         return var_4274;
      }
   }
}
