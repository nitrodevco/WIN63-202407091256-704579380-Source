package com.sulake.habbo.session
{
   public class UserData implements class_3490
   {
       
      
      private var var_4574:int = -1;
      
      private var _name:String = "";
      
      private var var_329:int = 0;
      
      private var var_139:String = "";
      
      private var var_426:String = "";
      
      private var var_1435:String = "";
      
      private var _achievementScore:int;
      
      private var var_1241:int = 0;
      
      private var var_860:String = "";
      
      private var _groupStatus:int = 0;
      
      private var _groupName:String = "";
      
      private var var_876:int = 0;
      
      private var _ownerName:String = "";
      
      private var var_1411:int = 0;
      
      private var var_806:int = 0;
      
      private var var_887:Boolean;
      
      private var var_768:Boolean;
      
      private var var_786:Boolean;
      
      private var var_1002:Boolean;
      
      private var var_910:Boolean;
      
      private var var_807:Boolean;
      
      private var _botSkills:Array;
      
      private var var_4769:Array;
      
      private var var_976:Boolean;
      
      public function UserData(param1:int)
      {
         super();
         var_4574 = param1;
      }
      
      public function get roomObjectId() : int
      {
         return var_4574;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function set achievementScore(param1:int) : void
      {
         _achievementScore = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function set type(param1:int) : void
      {
         var_329 = param1;
      }
      
      public function get sex() : String
      {
         return var_139;
      }
      
      public function set sex(param1:String) : void
      {
         var_139 = param1;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function set figure(param1:String) : void
      {
         var_426 = param1;
      }
      
      public function get custom() : String
      {
         return var_1435;
      }
      
      public function set custom(param1:String) : void
      {
         var_1435 = param1;
      }
      
      public function get webID() : int
      {
         return var_1241;
      }
      
      public function set webID(param1:int) : void
      {
         var_1241 = param1;
      }
      
      public function get groupID() : String
      {
         return var_860;
      }
      
      public function set groupID(param1:String) : void
      {
         var_860 = param1;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function get groupStatus() : int
      {
         return _groupStatus;
      }
      
      public function set groupStatus(param1:int) : void
      {
         _groupStatus = param1;
      }
      
      public function get ownerId() : int
      {
         return var_876;
      }
      
      public function set ownerId(param1:int) : void
      {
         var_876 = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get rarityLevel() : int
      {
         return var_806;
      }
      
      public function set rarityLevel(param1:int) : void
      {
         var_806 = param1;
      }
      
      public function get hasSaddle() : Boolean
      {
         return var_887;
      }
      
      public function set hasSaddle(param1:Boolean) : void
      {
         var_887 = param1;
      }
      
      public function get isRiding() : Boolean
      {
         return var_768;
      }
      
      public function set isRiding(param1:Boolean) : void
      {
         var_768 = param1;
      }
      
      public function get canBreed() : Boolean
      {
         return var_786;
      }
      
      public function set canBreed(param1:Boolean) : void
      {
         var_786 = param1;
      }
      
      public function get canHarvest() : Boolean
      {
         return var_1002;
      }
      
      public function set canHarvest(param1:Boolean) : void
      {
         var_1002 = param1;
      }
      
      public function get canRevive() : Boolean
      {
         return var_910;
      }
      
      public function set canRevive(param1:Boolean) : void
      {
         var_910 = param1;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_807;
      }
      
      public function set hasBreedingPermission(param1:Boolean) : void
      {
         var_807 = param1;
      }
      
      public function get petLevel() : int
      {
         return var_1411;
      }
      
      public function set petLevel(param1:int) : void
      {
         var_1411 = param1;
      }
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
      
      public function get botSkillData() : Array
      {
         return var_4769;
      }
      
      public function set botSkillData(param1:Array) : void
      {
         var_4769 = param1;
      }
      
      public function get isModerator() : Boolean
      {
         return var_976;
      }
      
      public function set isModerator(param1:Boolean) : void
      {
         var_976 = param1;
      }
   }
}
