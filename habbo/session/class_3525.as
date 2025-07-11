package com.sulake.habbo.session
{
   public interface class_3525
   {
       
      
      function setUserData(param1:class_3490) : void;
      
      function getUserData(param1:int) : class_3490;
      
      function getUserDataByType(param1:int, param2:int) : class_3490;
      
      function getUserDataByIndex(param1:int) : class_3490;
      
      function getUserDataByName(param1:String) : class_3490;
      
      function getUserBadges(param1:int) : Array;
      
      function removeUserDataByRoomIndex(param1:int) : void;
      
      function setUserBadges(param1:int, param2:Array) : void;
      
      function updateFigure(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean) : void;
      
      function updatePetLevel(param1:int, param2:int) : void;
      
      function updatePetBreedingStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void;
      
      function updateCustom(param1:int, param2:String) : void;
      
      function updateAchievementScore(param1:int, param2:int) : void;
      
      function updateNameByIndex(param1:int, param2:String) : void;
      
      function getPetUserData(param1:int) : class_3490;
      
      function getRentableBotUserData(param1:int) : class_3490;
      
      function requestPetInfo(param1:int) : void;
      
      function getAllUserIds() : Array;
   }
}
