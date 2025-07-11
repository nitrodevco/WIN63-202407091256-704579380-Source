package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetPetInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_INFO:String = "RWPIUE_PET_INFO";
       
      
      private var var_360:int;
      
      private var var_4595:int;
      
      private var var_1365:int;
      
      private var var_4459:int;
      
      private var var_883:int;
      
      private var var_4570:int;
      
      private var var_1428:int;
      
      private var var_4492:int;
      
      private var var_1569:int;
      
      private var var_4296:int;
      
      private var var_1427:int;
      
      private var _name:String;
      
      private var var_280:int;
      
      private var var_859:BitmapData;
      
      private var var_4276:int;
      
      private var var_4372:int;
      
      private var var_4666:Boolean;
      
      private var var_876:int;
      
      private var _ownerName:String;
      
      private var var_4287:Boolean;
      
      private var var_871:int;
      
      private var var_1204:int;
      
      private var var_1116:Boolean;
      
      private var var_768:Boolean;
      
      private var var_786:Boolean;
      
      private var var_581:Array;
      
      private var var_1280:int;
      
      private var var_1002:Boolean;
      
      private var var_910:Boolean;
      
      private var var_806:int;
      
      private var var_1308:int;
      
      private var var_800:int;
      
      private var var_1147:int;
      
      private var var_807:Boolean;
      
      public function RoomWidgetPetInfoUpdateEvent(param1:int, param2:int, param3:String, param4:int, param5:BitmapData, param6:Boolean, param7:int, param8:String, param9:int, param10:int, param11:Boolean = false, param12:Boolean = false)
      {
         super("RWPIUE_PET_INFO",param11,param12);
         var_4276 = param1;
         var_4372 = param2;
         _name = param3;
         var_280 = param4;
         var_859 = param5;
         var_4666 = param6;
         var_876 = param7;
         _ownerName = param8;
         var_871 = param9;
         var_1204 = param10;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get petType() : int
      {
         return var_4276;
      }
      
      public function get petRace() : int
      {
         return var_4372;
      }
      
      public function get isOwnPet() : Boolean
      {
         return var_4666;
      }
      
      public function get ownerId() : int
      {
         return var_876;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get canRemovePet() : Boolean
      {
         return var_4287;
      }
      
      public function get roomIndex() : int
      {
         return var_871;
      }
      
      public function get age() : int
      {
         return var_1427;
      }
      
      public function get breedId() : int
      {
         return var_1204;
      }
      
      public function get hasFreeSaddle() : Boolean
      {
         return var_1116;
      }
      
      public function get isRiding() : Boolean
      {
         return var_768;
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
      
      public function get rarityLevel() : int
      {
         return var_806;
      }
      
      public function get skillTresholds() : Array
      {
         return var_581;
      }
      
      public function get accessRights() : int
      {
         return var_1280;
      }
      
      public function get level() : int
      {
         return var_360;
      }
      
      public function get levelMax() : int
      {
         return var_4595;
      }
      
      public function get experience() : int
      {
         return var_1365;
      }
      
      public function get experienceMax() : int
      {
         return var_4459;
      }
      
      public function get energy() : int
      {
         return var_883;
      }
      
      public function get energyMax() : int
      {
         return var_4570;
      }
      
      public function get nutrition() : int
      {
         return var_1428;
      }
      
      public function get nutritionMax() : int
      {
         return var_4492;
      }
      
      public function get petRespectLeft() : int
      {
         return var_1569;
      }
      
      public function get petRespect() : int
      {
         return var_4296;
      }
      
      public function set level(param1:int) : void
      {
         var_360 = param1;
      }
      
      public function set levelMax(param1:int) : void
      {
         var_4595 = param1;
      }
      
      public function set experience(param1:int) : void
      {
         var_1365 = param1;
      }
      
      public function set experienceMax(param1:int) : void
      {
         var_4459 = param1;
      }
      
      public function set energy(param1:int) : void
      {
         var_883 = param1;
      }
      
      public function set energyMax(param1:int) : void
      {
         var_4570 = param1;
      }
      
      public function set nutrition(param1:int) : void
      {
         var_1428 = param1;
      }
      
      public function set nutritionMax(param1:int) : void
      {
         var_4492 = param1;
      }
      
      public function set petRespectLeft(param1:int) : void
      {
         var_1569 = param1;
      }
      
      public function set canRemovePet(param1:Boolean) : void
      {
         var_4287 = param1;
      }
      
      public function set petRespect(param1:int) : void
      {
         var_4296 = param1;
      }
      
      public function set age(param1:int) : void
      {
         var_1427 = param1;
      }
      
      public function set hasFreeSaddle(param1:Boolean) : void
      {
         var_1116 = param1;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         var_768 = param1;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         var_786 = param1;
      }
      
      public function set skillTresholds(param1:Array) : void
      {
         var_581 = param1;
      }
      
      public function set accessRights(param1:int) : void
      {
         var_1280 = param1;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         var_1002 = param1;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         var_910 = param1;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_806 = param1;
      }
      
      public function get maxWellBeingSeconds() : int
      {
         return var_1308;
      }
      
      public function set maxWellBeingSeconds(param1:int) : void
      {
         var_1308 = param1;
      }
      
      public function get remainingWellBeingSeconds() : int
      {
         return var_800;
      }
      
      public function set remainingWellBeingSeconds(param1:int) : void
      {
         var_800 = param1;
      }
      
      public function get remainingGrowingSeconds() : int
      {
         return var_1147;
      }
      
      public function set remainingGrowingSeconds(param1:int) : void
      {
         var_1147 = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_807;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         var_807 = param1;
      }
   }
}
