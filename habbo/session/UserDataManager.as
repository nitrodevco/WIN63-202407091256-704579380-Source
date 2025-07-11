package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.outgoing.users.class_896;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.class_666;
   
   public class UserDataManager implements class_3525
   {
      
      private static const TYPE_USER:int = 1;
      
      private static const TYPE_PET:int = 2;
      
      private static const const_1197:int = 3;
      
      private static const const_983:int = 4;
       
      
      private var var_2562:Map;
      
      private var var_2527:Map;
      
      private var var_2768:Map;
      
      private var var_26:IConnection;
      
      public function UserDataManager()
      {
         super();
         var_2562 = new Map();
         var_2527 = new Map();
         var_2768 = new Map();
      }
      
      public function dispose() : void
      {
         var_26 = null;
         var_2562.dispose();
         var_2562 = null;
         var_2527.dispose();
         var_2527 = null;
         var_2768.dispose();
         var_2768 = null;
      }
      
      public function set connection(param1:IConnection) : void
      {
         var_26 = param1;
      }
      
      public function getUserData(param1:int) : class_3490
      {
         return getUserDataByType(param1,1);
      }
      
      public function getUserDataByType(param1:int, param2:int) : class_3490
      {
         var _loc3_:class_3490 = null;
         var _loc4_:Map;
         if((_loc4_ = var_2562.getValue(param2)) != null)
         {
            _loc3_ = _loc4_.getValue(param1);
         }
         return _loc3_;
      }
      
      public function getUserDataByIndex(param1:int) : class_3490
      {
         return var_2527.getValue(param1);
      }
      
      public function getUserDataByName(param1:String) : class_3490
      {
         for each(var _loc2_ in var_2527)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getUserBadges(param1:int) : Array
      {
         if(var_26 != null)
         {
            var_26.send(new class_896(param1));
         }
         var _loc2_:Array = var_2768.getValue(param1) as Array;
         if(_loc2_ == null)
         {
            _loc2_ = [];
         }
         return _loc2_;
      }
      
      public function setUserData(param1:class_3490) : void
      {
         if(param1 == null)
         {
            return;
         }
         removeUserDataByRoomIndex(param1.roomObjectId);
         var _loc2_:Map = var_2562.getValue(param1.type);
         if(_loc2_ == null)
         {
            _loc2_ = new Map();
            var_2562.add(param1.type,_loc2_);
         }
         _loc2_.add(param1.webID,param1);
         var_2527.add(param1.roomObjectId,param1);
      }
      
      public function removeUserDataByRoomIndex(param1:int) : void
      {
         var _loc4_:Map = null;
         var _loc3_:class_3490 = null;
         var _loc2_:class_3490 = var_2527.remove(param1);
         if(_loc2_ != null)
         {
            if((_loc4_ = var_2562.getValue(_loc2_.type)) != null)
            {
               _loc3_ = _loc4_.remove(_loc2_.webID);
               if(_loc3_ != null)
               {
               }
            }
         }
      }
      
      public function setUserBadges(param1:int, param2:Array) : void
      {
         var_2768.remove(param1);
         var_2768.add(param1,param2);
      }
      
      public function updateFigure(param1:int, param2:String, param3:String, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:class_3490;
         if((_loc6_ = getUserDataByIndex(param1)) != null)
         {
            _loc6_.figure = param2;
            _loc6_.sex = param3;
            _loc6_.hasSaddle = param4;
            _loc6_.isRiding = param5;
         }
      }
      
      public function updatePetLevel(param1:int, param2:int) : void
      {
         var _loc3_:class_3490 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.petLevel = param2;
         }
      }
      
      public function updatePetBreedingStatus(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var _loc6_:class_3490;
         if((_loc6_ = getUserDataByIndex(param1)) != null)
         {
            _loc6_.canBreed = param2;
            _loc6_.canHarvest = param3;
            _loc6_.canRevive = param4;
            _loc6_.hasBreedingPermission = param5;
         }
      }
      
      public function updateCustom(param1:int, param2:String) : void
      {
         var _loc3_:class_3490 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.custom = param2;
         }
      }
      
      public function updateAchievementScore(param1:int, param2:int) : void
      {
         var _loc3_:class_3490 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.achievementScore = param2;
         }
      }
      
      public function updateNameByIndex(param1:int, param2:String) : void
      {
         var _loc3_:class_3490 = getUserDataByIndex(param1);
         if(_loc3_ != null)
         {
            _loc3_.name = param2;
         }
      }
      
      public function getPetUserData(param1:int) : class_3490
      {
         return getUserDataByType(param1,2);
      }
      
      public function getRentableBotUserData(param1:int) : class_3490
      {
         return getUserDataByType(param1,4);
      }
      
      public function requestPetInfo(param1:int) : void
      {
         var _loc2_:class_3490 = getPetUserData(param1);
         if(_loc2_ != null && var_26 != null)
         {
            var_26.send(new class_666(_loc2_.webID));
         }
      }
      
      public function getAllUserIds() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in var_2527)
         {
            _loc2_.push(_loc1_.webID);
         }
         return _loc2_;
      }
   }
}
