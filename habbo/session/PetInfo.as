package com.sulake.habbo.session
{
   public class PetInfo implements IPetInfo
   {
       
      
      private var var_393:int;
      
      private var var_360:int;
      
      private var var_4595:int;
      
      private var var_1365:int;
      
      private var var_4459:int;
      
      private var var_883:int;
      
      private var var_4570:int;
      
      private var var_1428:int;
      
      private var var_4492:int;
      
      private var var_876:int;
      
      private var _ownerName:String;
      
      private var var_1196:int;
      
      private var var_1427:int;
      
      private var var_1204:int;
      
      private var var_1116:Boolean;
      
      private var var_768:Boolean;
      
      private var var_786:Boolean;
      
      private var var_581:Array;
      
      private var var_1280:int;
      
      private var var_1002:Boolean;
      
      private var var_910:Boolean;
      
      private var var_1308:int;
      
      private var var_800:int;
      
      private var var_1147:int;
      
      private var var_806:int;
      
      private var var_807:Boolean;
      
      private var var_4942:int = 7;
      
      public function PetInfo()
      {
         super();
      }
      
      public function get petId() : int
      {
         return var_393;
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
      
      public function get ownerId() : int
      {
         return var_876;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get respect() : int
      {
         return var_1196;
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
      
      public function get skillTresholds() : Array
      {
         return var_581;
      }
      
      public function get accessRights() : int
      {
         return var_1280;
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
      
      public function set petId(param1:int) : void
      {
         var_393 = param1;
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
      
      public function set ownerId(param1:int) : void
      {
         var_876 = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set respect(param1:int) : void
      {
         var_1196 = param1;
      }
      
      public function set age(param1:int) : void
      {
         var_1427 = param1;
      }
      
      public function set breedId(param1:int) : void
      {
         var_1204 = param1;
      }
      
      public function set hasFreeSaddle(param1:Boolean) : void
      {
         var_1116 = param1;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         var_768 = param1;
      }
      
      public function set skillTresholds(param1:Array) : void
      {
         var_581 = param1;
      }
      
      public function set accessRights(param1:int) : void
      {
         var_1280 = param1;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         var_786 = param1;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         var_1002 = param1;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         var_910 = param1;
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
      
      public function set rarityLevel(param1:int) : void
      {
         var_806 = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_807;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         var_807 = param1;
      }
      
      public function get adultLevel() : int
      {
         return var_4942;
      }
   }
}
