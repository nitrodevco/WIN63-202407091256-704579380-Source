package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetBreedingEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_765:int = 0;
      
      public static const const_744:int = 1;
      
      public static const TYPE_ACCEPT:int = 2;
      
      public static const TYPE_REQUEST:int = 3;
      
      public static const PET_BREEDING:String = "RWPPBE_PET_BREEDING_";
       
      
      private var var_149:int;
      
      private var var_1401:int;
      
      private var var_879:int;
      
      public function RoomWidgetPetBreedingEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("RWPPBE_PET_BREEDING_",param1,param2);
      }
      
      public function get state() : int
      {
         return var_149;
      }
      
      public function set state(param1:int) : void
      {
         var_149 = param1;
      }
      
      public function get ownPetId() : int
      {
         return var_1401;
      }
      
      public function set ownPetId(param1:int) : void
      {
         var_1401 = param1;
      }
      
      public function get otherPetId() : int
      {
         return var_879;
      }
      
      public function set otherPetId(param1:int) : void
      {
         var_879 = param1;
      }
   }
}
