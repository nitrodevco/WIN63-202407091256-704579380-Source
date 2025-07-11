package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.PetInfo;
   import com.sulake.habbo.session.UserData;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionConfirmPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionDanceEvent;
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
   import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
   import com.sulake.habbo.session.events.RoomSessionNestBreedingSuccessEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingEvent;
   import com.sulake.habbo.session.events.RoomSessionPetBreedingResultEvent;
   import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetFigureUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetLevelUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionPetStatusUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
   import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
   import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
   import com.sulake.room.utils.RoomShakingEffect;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_837;
   import com.sulake.habbo.communication.messages.incoming.room.action.class_313;
   import com.sulake.habbo.communication.messages.parser.users.class_1297;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1134;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1225;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1310;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1384;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1456;
   import com.sulake.habbo.communication.messages.parser.room.pets.class_1496;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewFriendRequestMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.action.class_1140;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1272;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1321;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1421;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_140;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_292;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_399;
   import com.sulake.habbo.communication.messages.incoming.inventory.pets.class_615;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1226;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1333;
   import com.sulake.habbo.communication.messages.parser.room.engine.class_1626;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_1668;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_337;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_447;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_492;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_558;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
   import com.sulake.habbo.communication.messages.incoming.room.bots.class_792;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_189;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_263;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_608;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_613;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_751;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_863;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_920;
   import com.sulake.habbo.communication.messages.incoming.users.class_210;
   import com.sulake.habbo.communication.messages.incoming.users.class_846;
   
   public class RoomUsersHandler extends BaseHandler
   {
       
      
      public function RoomUsersHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new class_558(onUsers));
         param1.addMessageEvent(new class_492(onUserRemove));
         param1.addMessageEvent(new class_846(onUserBadges));
         param1.addMessageEvent(new class_837(onDoorbell));
         param1.addMessageEvent(new class_337(onUserChange));
         param1.addMessageEvent(new class_210(onUserNameChange));
         param1.addMessageEvent(new class_613(onPetInfo));
         param1.addMessageEvent(new class_189(onEnabledPetCommands));
         param1.addMessageEvent(new class_920(onPetPlacingError));
         param1.addMessageEvent(new class_608(onPetFigureUpdate));
         param1.addMessageEvent(new class_751(onPetBreedingResult));
         param1.addMessageEvent(new class_292(onPetBreedingEvent));
         param1.addMessageEvent(new class_863(onPetStatusUpdate));
         param1.addMessageEvent(new class_263(onPetLevelUpdate));
         param1.addMessageEvent(new class_615(onConfirmPetBreeding));
         param1.addMessageEvent(new class_140(onConfirmPetBreedingResult));
         param1.addMessageEvent(new class_399(onNestBreedingSuccess));
         param1.addMessageEvent(new class_792(onBotError));
         param1.addMessageEvent(new NewFriendRequestEvent(onFriendRequest));
         param1.addMessageEvent(new class_313(onDance));
         param1.addMessageEvent(new class_447(onFavoriteMembershipUpdate));
      }
      
      private function onFavoriteMembershipUpdate(param1:IMessageEvent) : void
      {
         var _loc5_:RoomSessionFavouriteGroupUpdateEvent = null;
         var _loc3_:class_1626 = class_447(param1).getParser();
         var _loc4_:IRoomSession;
         if((_loc4_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc2_:class_3490 = _loc4_.userDataManager.getUserDataByIndex(_loc3_.roomIndex);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.groupID = "" + _loc3_.habboGroupId;
         _loc2_.groupName = _loc3_.habboGroupName;
         if(listener && listener.events)
         {
            _loc5_ = new RoomSessionFavouriteGroupUpdateEvent(_loc4_,_loc3_.roomIndex,_loc3_.habboGroupId,_loc3_.status,_loc3_.habboGroupName);
            listener.events.dispatchEvent(_loc5_);
         }
      }
      
      private function onUsers(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc8_:class_1668 = null;
         var _loc2_:UserData = null;
         var _loc9_:class_558;
         if((_loc9_ = param1 as class_558) == null)
         {
            return;
         }
         var _loc3_:class_1333 = _loc9_.getParser();
         var _loc5_:IRoomSession;
         if((_loc5_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc6_:Boolean = false;
         var _loc7_:Vector.<class_3490> = new Vector.<class_3490>(0);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.getUserCount())
         {
            _loc8_ = _loc3_.getUser(_loc4_);
            _loc2_ = new UserData(_loc8_.roomIndex);
            _loc2_.name = _loc8_.name;
            _loc2_.custom = _loc8_.custom;
            _loc2_.achievementScore = _loc8_.achievementScore;
            _loc2_.figure = _loc8_.figure;
            _loc2_.type = _loc8_.userType;
            _loc2_.webID = _loc8_.webID;
            _loc2_.groupID = _loc8_.groupID;
            _loc2_.groupName = _loc8_.groupName;
            _loc2_.groupStatus = _loc8_.groupStatus;
            _loc2_.sex = _loc8_.sex;
            _loc2_.ownerId = _loc8_.ownerId;
            _loc2_.ownerName = _loc8_.ownerName;
            _loc2_.rarityLevel = _loc8_.rarityLevel;
            _loc2_.hasSaddle = _loc8_.hasSaddle;
            _loc2_.isRiding = _loc8_.isRiding;
            _loc2_.canBreed = _loc8_.canBreed;
            _loc2_.canHarvest = _loc8_.canHarvest;
            _loc2_.canRevive = _loc8_.canRevive;
            _loc2_.hasBreedingPermission = _loc8_.hasBreedingPermission;
            _loc2_.petLevel = _loc8_.petLevel;
            _loc2_.botSkills = _loc8_.botSkills;
            _loc2_.isModerator = _loc8_.isModerator;
            if(_loc8_.userType == 4 && _loc8_.ownerId == -1 && _loc8_.name == "Macklebee")
            {
               _loc6_ = true;
            }
            if(_loc5_.userDataManager.getUserData(_loc8_.roomIndex) == null)
            {
               _loc7_.push(_loc2_);
            }
            _loc5_.userDataManager.setUserData(_loc2_);
            _loc4_++;
         }
         if(_loc6_)
         {
            RoomShakingEffect.init(250,5000);
            RoomShakingEffect.turnVisualizationOn();
         }
         listener.events.dispatchEvent(new RoomSessionUserDataUpdateEvent(_loc5_,_loc7_));
      }
      
      private function onUserRemove(param1:IMessageEvent) : void
      {
         var _loc4_:class_492;
         if((_loc4_ = param1 as class_492) == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.getParser() as class_1226).id;
         _loc3_.userDataManager.removeUserDataByRoomIndex(_loc2_);
      }
      
      private function onUserBadges(param1:IMessageEvent) : void
      {
         var _loc2_:class_846 = param1 as class_846;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.userDataManager.setUserBadges(_loc2_.userId,_loc2_.badges);
         listener.events.dispatchEvent(new RoomSessionUserBadgesEvent(_loc3_,_loc2_.userId,_loc2_.badges));
      }
      
      private function onDoorbell(param1:IMessageEvent) : void
      {
         var _loc2_:class_837 = param1 as class_837;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.userName == "")
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_DOORBELL",_loc3_,_loc2_.userName));
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc3_:class_337 = param1 as class_337;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_1662);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc3_.id >= 0)
         {
            _loc2_.userDataManager.updateFigure(_loc3_.id,_loc3_.figure,_loc3_.sex,false,false);
            _loc2_.userDataManager.updateCustom(_loc3_.id,_loc3_.customInfo);
            _loc2_.userDataManager.updateAchievementScore(_loc3_.id,_loc3_.achievementScore);
            listener.events.dispatchEvent(new RoomSessionUserFigureUpdateEvent(_loc2_,_loc3_.id,_loc3_.figure,_loc3_.sex,_loc3_.customInfo,_loc3_.achievementScore));
         }
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_210 = param1 as class_210;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_1297 = _loc2_.getParser();
         var _loc4_:IRoomSession;
         if((_loc4_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         _loc4_.userDataManager.updateNameByIndex(_loc3_.id,_loc3_.newName);
      }
      
      private function onPetInfo(param1:IMessageEvent) : void
      {
         var _loc5_:IRoomSession;
         if((_loc5_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc3_:class_613 = param1 as class_613;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1225 = _loc3_.getParser();
         var _loc4_:PetInfo;
         (_loc4_ = new PetInfo()).petId = _loc2_.petId;
         _loc4_.level = _loc2_.level;
         _loc4_.levelMax = _loc2_.maxLevel;
         _loc4_.experience = _loc2_.experience;
         _loc4_.experienceMax = _loc2_.experienceRequiredToLevel;
         _loc4_.energy = _loc2_.energy;
         _loc4_.energyMax = _loc2_.maxEnergy;
         _loc4_.nutrition = _loc2_.nutrition;
         _loc4_.nutritionMax = _loc2_.maxNutrition;
         _loc4_.ownerId = _loc2_.ownerId;
         _loc4_.ownerName = _loc2_.ownerName;
         _loc4_.respect = _loc2_.respect;
         _loc4_.age = _loc2_.age;
         _loc4_.breedId = _loc2_.breedId;
         _loc4_.hasFreeSaddle = _loc2_.hasFreeSaddle;
         _loc4_.isRiding = _loc2_.isRiding;
         _loc4_.canBreed = _loc2_.canBreed;
         _loc4_.canHarvest = _loc2_.canHarvest;
         _loc4_.rarityLevel = _loc2_.rarityLevel;
         _loc4_.canRevive = _loc2_.canRevive;
         _loc4_.skillTresholds = _loc2_.skillTresholds;
         _loc4_.accessRights = _loc2_.accessRights;
         _loc4_.maxWellBeingSeconds = _loc2_.maxWellBeingSeconds;
         _loc4_.remainingWellBeingSeconds = _loc2_.remainingWellBeingSeconds;
         _loc4_.remainingGrowingSeconds = _loc2_.remainingGrowingSeconds;
         _loc4_.hasBreedingPermission = _loc2_.hasBreedingPermission;
         listener.events.dispatchEvent(new RoomSessionPetInfoUpdateEvent(_loc5_,_loc4_));
      }
      
      private function onPetFigureUpdate(param1:IMessageEvent) : void
      {
         var _loc7_:class_608;
         if((_loc7_ = param1 as class_608) == null)
         {
            return;
         }
         var _loc5_:class_1310 = _loc7_.getParser();
         var _loc6_:IRoomSession;
         if((_loc6_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc8_:String = _loc5_.figureData.figureString;
         var _loc9_:int = _loc5_.roomIndex;
         var _loc3_:int = _loc5_.petId;
         var _loc2_:Boolean = _loc5_.hasSaddle;
         var _loc4_:Boolean = _loc5_.isRiding;
         _loc6_.userDataManager.updateFigure(_loc9_,_loc8_,"",_loc2_,_loc4_);
         listener.events.dispatchEvent(new RoomSessionPetFigureUpdateEvent(_loc6_,_loc3_,_loc8_));
      }
      
      private function onPetBreedingResult(param1:IMessageEvent) : void
      {
         var _loc2_:class_751 = param1 as class_751;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_1134 = _loc2_.getParser();
         var _loc4_:IRoomSession;
         if((_loc4_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionPetBreedingResultEvent(_loc4_,_loc3_.resultData,_loc3_.otherResultData));
      }
      
      private function onConfirmPetBreeding(param1:class_615) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1321 = param1.parser as class_1321;
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionConfirmPetBreedingEvent(_loc3_,_loc2_.nestId,_loc2_.pet1,_loc2_.pet2,_loc2_.rarityCategories,_loc2_.resultPetType));
      }
      
      private function onConfirmPetBreedingResult(param1:class_140) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1272 = param1.parser as class_1272;
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionConfirmPetBreedingResultEvent(_loc3_,_loc2_.breedingNestStuffId,_loc2_.result));
      }
      
      private function onNestBreedingSuccess(param1:class_399) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_1662);
         if(_loc2_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionNestBreedingSuccessEvent(_loc2_,param1.getParser().petId,param1.getParser().rarityCategory));
      }
      
      private function onPetBreedingEvent(param1:IMessageEvent) : void
      {
         var _loc4_:class_292;
         if((_loc4_ = param1 as class_292) == null)
         {
            return;
         }
         var _loc2_:class_1421 = _loc4_.getParser();
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         if(_loc3_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionPetBreedingEvent(_loc3_,_loc2_.state,_loc2_.ownPetId,_loc2_.otherPetId));
      }
      
      private function onPetStatusUpdate(param1:IMessageEvent) : void
      {
         var _loc8_:class_863;
         if((_loc8_ = param1 as class_863) == null)
         {
            return;
         }
         var _loc4_:class_1384 = _loc8_.getParser();
         var _loc5_:IRoomSession;
         if((_loc5_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc9_:int = _loc4_.roomIndex;
         var _loc2_:int = _loc4_.petId;
         var _loc3_:Boolean = _loc4_.canHarvest;
         var _loc10_:Boolean = _loc4_.canRevive;
         var _loc7_:Boolean = _loc4_.canBreed;
         var _loc6_:Boolean = _loc4_.hasBreedingPermission;
         _loc5_.userDataManager.updatePetBreedingStatus(_loc9_,_loc7_,_loc3_,_loc10_,_loc6_);
         listener.events.dispatchEvent(new RoomSessionPetStatusUpdateEvent(_loc5_,_loc2_,_loc7_,_loc3_,_loc10_,_loc6_));
      }
      
      private function onPetLevelUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:class_263 = param1 as class_263;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:class_1456 = _loc2_.getParser();
         var _loc6_:IRoomSession;
         if((_loc6_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc7_:int = _loc4_.roomIndex;
         var _loc3_:int = _loc4_.petId;
         var _loc5_:int = _loc4_.level;
         _loc6_.userDataManager.updatePetLevel(_loc7_,_loc5_);
         listener.events.dispatchEvent(new RoomSessionPetLevelUpdateEvent(_loc6_,_loc3_,_loc5_));
      }
      
      private function onEnabledPetCommands(param1:IMessageEvent) : void
      {
         var _loc4_:IRoomSession;
         if((_loc4_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc2_:class_189 = param1 as class_189;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_1496 = _loc2_.getParser();
         if(_loc3_ != null)
         {
            listener.events.dispatchEvent(new RoomSessionPetCommandsUpdateEvent(_loc4_,_loc3_.petId,_loc3_.allCommands,_loc3_.enabledCommands));
         }
      }
      
      private function onPetPlacingError(param1:class_920) : void
      {
         var _loc3_:String = null;
         if(param1 == null || param1.getParser() == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_1662);
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.getParser().errorCode)
         {
            case 0:
               _loc3_ = "RSEME_PETS_FORBIDDEN_IN_HOTEL";
               break;
            case 1:
               _loc3_ = "RSEME_PETS_FORBIDDEN_IN_FLAT";
               break;
            case 2:
               _loc3_ = "RSEME_MAX_PETS";
               break;
            case 3:
               _loc3_ = "RSEME_NO_FREE_TILES_FOR_PET";
               break;
            case 4:
               _loc3_ = "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET";
               break;
            case 5:
               _loc3_ = "RSEME_MAX_NUMBER_OF_OWN_PETS";
         }
         if(_loc3_ != null)
         {
            listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc3_,_loc2_));
         }
      }
      
      private function onBotError(param1:class_792) : void
      {
         var _loc3_:String = null;
         if(param1 == null || param1.getParser() == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_1662);
         if(_loc2_ == null)
         {
            return;
         }
         switch(param1.getParser().errorCode)
         {
            case 0:
               _loc3_ = "RSEME_BOTS_FORBIDDEN_IN_HOTEL";
               break;
            case 1:
               _loc3_ = "RSEME_BOTS_FORBIDDEN_IN_FLAT";
               break;
            case 2:
               _loc3_ = "RSEME_BOT_LIMIT_REACHED";
               break;
            case 3:
               _loc3_ = "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT";
               break;
            case 4:
               _loc3_ = "RSEME_BOT_NAME_NOT_ACCEPTED";
         }
         if(_loc3_ != null)
         {
            listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_loc3_,_loc2_));
         }
      }
      
      private function onFriendRequest(param1:NewFriendRequestEvent) : void
      {
         if(!param1 || !listener || !listener.events)
         {
            return;
         }
         var _loc2_:NewFriendRequestMessageParser = param1.getParser();
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:IRoomSession;
         if(!(_loc4_ = listener.getSession(var_1662)))
         {
            return;
         }
         var _loc3_:FriendRequestData = _loc2_.req;
         if(!_loc3_)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionFriendRequestEvent(_loc4_,_loc3_.requestId,_loc3_.requestId,_loc3_.requesterName));
      }
      
      private function onDance(param1:class_313) : void
      {
         var _loc2_:class_1140 = param1.getParser();
         var _loc3_:IRoomSession = listener.getSession(var_1662);
         listener.events.dispatchEvent(new RoomSessionDanceEvent(_loc3_,_loc2_.userId,_loc2_.danceStyle));
      }
   }
}
