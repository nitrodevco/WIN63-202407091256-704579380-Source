package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandPetData
   {
       
      
      private var var_360:int;
      
      private var var_4595:int;
      
      private var var_1365:int;
      
      private var var_4459:int;
      
      private var var_883:int;
      
      private var var_4570:int;
      
      private var var_1428:int;
      
      private var var_4492:int;
      
      private var var_4296:int;
      
      private var _name:String = "";
      
      private var var_393:int = -1;
      
      private var var_329:int;
      
      private var var_4526:int;
      
      private var var_859:BitmapData;
      
      private var var_4666:Boolean;
      
      private var var_876:int;
      
      private var _ownerName:String;
      
      private var var_4287:Boolean;
      
      private var var_871:int;
      
      private var var_1427:int;
      
      private var var_1204:int;
      
      private var var_581:Array;
      
      private var var_1280:int;
      
      private var var_806:int;
      
      private var var_807:Boolean;
      
      private var var_1308:int;
      
      private var var_800:int;
      
      private var var_1147:int;
      
      public function InfoStandPetData()
      {
         super();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return var_393;
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function get race() : int
      {
         return var_4526;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
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
      
      public function get age() : int
      {
         return var_1427;
      }
      
      public function get breedId() : int
      {
         return var_1204;
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
      
      public function get petRespect() : int
      {
         return var_4296;
      }
      
      public function get roomIndex() : int
      {
         return var_871;
      }
      
      public function get rarityLevel() : int
      {
         return var_806;
      }
      
      public function get maxWellBeingSeconds() : int
      {
         return var_1308;
      }
      
      public function get remainingWellBeingSeconds() : int
      {
         return var_800;
      }
      
      public function get remainingGrowingSeconds() : int
      {
         return var_1147;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_807;
      }
      
      public function setData(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         _name = param1.name;
         var_393 = param1.id;
         var_329 = param1.petType;
         var_4526 = param1.petRace;
         var_859 = param1.image;
         var_4666 = param1.isOwnPet;
         var_876 = param1.ownerId;
         _ownerName = param1.ownerName;
         var_4287 = param1.canRemovePet;
         var_360 = param1.level;
         var_4595 = param1.levelMax;
         var_1365 = param1.experience;
         var_4459 = param1.experienceMax;
         var_883 = param1.energy;
         var_4570 = param1.energyMax;
         var_1428 = param1.nutrition;
         var_4492 = param1.nutritionMax;
         var_4296 = param1.petRespect;
         var_871 = param1.roomIndex;
         var_1427 = param1.age;
         var_1204 = param1.breedId;
         var_581 = param1.skillTresholds;
         var_1280 = param1.accessRights;
         var_1308 = param1.maxWellBeingSeconds;
         var_800 = param1.remainingWellBeingSeconds;
         var_1147 = param1.remainingGrowingSeconds;
         var_806 = param1.rarityLevel;
         var_807 = param1.hasBreedingPermission;
      }
   }
}
