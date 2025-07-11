package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetStatusUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_STATUS_UPDATE:String = "RWPIUE_PET_STATUS_UPDATE";
       
      
      private var var_393:int;
      
      private var var_786:Boolean;
      
      private var var_1002:Boolean;
      
      private var var_910:Boolean;
      
      private var var_807:Boolean;
      
      public function RoomWidgetPetStatusUpdateEvent(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWPIUE_PET_STATUS_UPDATE",param6,param7);
         var_393 = param1;
         var_786 = param2;
         var_1002 = param3;
         var_910 = param4;
         var_807 = param5;
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
