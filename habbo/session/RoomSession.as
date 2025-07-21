package com.sulake.habbo.session
{
    import assets.class_14

    import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.tracking.IHabboTracking;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.class_698;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.class_817;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.class_838;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.class_847;
   import com.sulake.habbo.communication.messages.outgoing.room.chat.class_993;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1028;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_1047;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.HarvestPetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_146;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_191;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_417;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_508;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_513;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.class_956;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_1059;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_383;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_571;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_665;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_768;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.RoomDimmerSavePresetMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.class_155;
   import com.sulake.habbo.communication.messages.outgoing.room.session.class_325;
   import com.sulake.habbo.communication.messages.outgoing.room.session.class_974;
   import com.sulake.habbo.communication.messages.outgoing.poll.class_163;
   import com.sulake.habbo.communication.messages.outgoing.poll.PollStartComposer;
   import com.sulake.habbo.communication.messages.outgoing.poll.class_753;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.VisitUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_1053;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_582;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_724;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.class_739;
   import com.sulake.habbo.communication.messages.outgoing.room.avatar.ChangePostureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nux.class_805;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2GameChatMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.class_1041;
   import com.sulake.habbo.communication.messages.outgoing.room.action.class_234;
   import com.sulake.habbo.communication.messages.outgoing.room.action.LetUserInMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.class_482;
   import com.sulake.habbo.communication.messages.outgoing.room.action.UnmuteUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.class_595;
   import com.sulake.habbo.communication.messages.outgoing.room.action.BanUserWithDurationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.pets.CustomizePetWithFurniComposer;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1731;
   import com.sulake.habbo.communication.messages.outgoing.userclassification.class_368;
   import com.sulake.habbo.communication.messages.outgoing.userclassification.class_942;
   
   public class RoomSession implements IRoomSession
   {
       
      
      private const CHAT_LAG_WARNING_LIMIT:int = 2500;
      
      private var var_26:IConnection;
      
      private var var_369:int = 0;
      
      private var var_937:String = "";
      
      private var var_4398:String = "";
      
      private var var_2337:IMessageComposer = null;
      
      private var var_149:String = "RSE_CREATED";
      
      private var var_2711:UserDataManager;
      
      private var var_4330:int = -1;
      
      private var var_3421:Boolean = false;
      
      private var var_1518:int = 0;
      
      private var var_397:Boolean = false;
      
      private var var_870:int = 0;
      
      private var _isGuildRoom:Boolean = false;
      
      private var var_3914:Boolean = false;
      
      private var var_4280:Boolean = false;
      
      private var var_1194:int;
      
      private var var_2870:Map;
      
      private var var_1291:int = 0;
      
      private var _habboTracking:IHabboTracking = null;
      
      private var var_4786:Boolean = false;
      
      private var var_4175:Boolean = false;
      
      private var var_4580:Boolean = false;
      
      private var var_454:class_1731 = null;
      
      public function RoomSession()
      {
         var_2870 = new Map();
         super();
         var_2711 = new UserDataManager();
      }
      
      public function set connection(param1:IConnection) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_26 = param1;
         if(var_2711 != null)
         {
            var_2711.connection = param1;
         }
      }
      
      public function dispose() : void
      {
         var_26 = null;
         if(var_2711 != null)
         {
            var_2711.dispose();
            var_2711 = null;
         }
         if(var_2870 != null)
         {
            var_2870.dispose();
            var_2870 = null;
         }
         if(var_2337)
         {
            var_2337.dispose();
            var_2337 = null;
         }
         if(var_454 != null)
         {
            var_454 = null;
         }
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function set roomId(param1:int) : void
      {
         var_369 = param1;
      }
      
      public function get roomPassword() : String
      {
         return var_937;
      }
      
      public function set roomPassword(param1:String) : void
      {
         var_937 = param1;
      }
      
      public function get roomResources() : String
      {
         return var_4398;
      }
      
      public function set roomResources(param1:String) : void
      {
         var_4398 = param1;
      }
      
      public function get openConnectionComposer() : IMessageComposer
      {
         return var_2337;
      }
      
      public function set openConnectionComposer(param1:IMessageComposer) : void
      {
         var_2337 = param1;
      }
      
      public function get state() : String
      {
         return var_149;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function set habboTracking(param1:IHabboTracking) : void
      {
         _habboTracking = param1;
      }
      
      public function get isGameSession() : Boolean
      {
         return var_4175;
      }
      
      public function set isGameSession(param1:Boolean) : void
      {
         var_4175 = param1;
      }
      
      public function get roomModerationSettings() : class_1731
      {
         return var_454;
      }
      
      public function set roomModerationSettings(param1:class_1731) : void
      {
         var_454 = param1;
      }
      
      public function get playTestMode() : Boolean
      {
         return var_397;
      }
      
      public function set playTestMode(param1:Boolean) : void
      {
         var_397 = param1;
      }
      
      public function trackEventLogOncePerSession(param1:String, param2:String, param3:String) : void
      {
         _habboTracking.trackEventLogOncePerSession(param1,param2,param3);
      }
      
      public function start() : Boolean
      {
         if(var_149 == "RSE_CREATED" && var_26 != null)
         {
            var_149 = "RSE_STARTED";
            if(var_2337)
            {
               return sendPredefinedOpenConnection();
            }
            return sendOpenFlatConnectionMessage();
         }
         return false;
      }
      
      public function reset(param1:int) : void
      {
         if(param1 != var_369)
         {
            var_369 = param1;
            var_3421 = false;
            var_1518 = 0;
            var_870 = 0;
            var_3914 = false;
         }
      }
      
      private function sendOpenFlatConnectionMessage() : Boolean
      {
         if(var_26 == null)
         {
            return false;
         }
         var_26.send(new class_974(var_369,var_937));
         return true;
      }
      
      private function sendPredefinedOpenConnection() : Boolean
      {
         if(var_26 == null)
         {
            return false;
         }
         var_26.send(var_2337);
         var_2337 = null;
         return true;
      }
      
      public function sendChatMessage(param1:String, param2:int = 0) : void
      {
         if(var_4175)
         {
            var_26.send(new Game2GameChatMessageComposer(param1));
         }
         else
         {
            param1 = param1.replace(/&#[0-9]+;/g,"");
            var_26.send(new class_698(param1,param2,var_1291));
            var_2870.add(var_1291,getTimer());
            var_1291++;
         }
      }
      
      public function sendChangeMottoMessage(param1:String) : void
      {
         var_26.send(new class_739(param1));
      }
      
      public function receivedChatWithTrackingId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = var_2870.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getTimer();
            if(_loc3_ - int(_loc2_) > 2500)
            {
               if(_habboTracking != null)
               {
                  _habboTracking.chatLagDetected(_loc3_);
               }
            }
         }
      }
      
      public function sendShoutMessage(param1:String, param2:int = 0) : void
      {
         var_26.send(new class_817(param1,param2));
      }
      
      public function sendWhisperMessage(param1:String, param2:String, param3:int = 0) : void
      {
         var_26.send(new class_847(param1,param2,param3));
      }
      
      public function sendChatTypingMessage(param1:Boolean) : void
      {
         if(param1)
         {
            var_26.send(new class_993());
         }
         else
         {
            var_26.send(new class_838());
         }
      }
      
      public function sendAvatarExpressionMessage(param1:int) : void
      {
         var_26.send(new class_1053(param1));
      }
      
      public function sendSignMessage(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 17)
         {
            var_26.send(new class_582(param1));
         }
      }
      
      public function sendDanceMessage(param1:int) : void
      {
         var_26.send(new class_724(param1));
      }
      
      public function sendChangePostureMessage(param1:int) : void
      {
         var_26.send(new ChangePostureMessageComposer(param1));
      }
      
      public function sendCreditFurniRedeemMessage(param1:int) : void
      {
         var_26.send(new class_1059(param1));
      }
      
      public function sendPresentOpenMessage(param1:int) : void
      {
         var_26.send(new class_768(param1));
      }
      
      public function sendOpenPetPackageMessage(param1:int, param2:String) : void
      {
         var_26.send(new class_383(param1,param2));
      }
      
      public function sendRoomDimmerGetPresetsMessage(param1:int) : void
      {
         var_26.send(new class_665(param1));
      }
      
      public function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean, param6:int) : void
      {
         var _loc7_:String = "000000" + param3.toString(16).toUpperCase();
         var _loc8_:String = "#" + _loc7_.substr(_loc7_.length - 6);
         var_26.send(new RoomDimmerSavePresetMessageComposer(param1,param2,_loc8_,param4,param5,param6));
      }
      
      public function sendRoomDimmerChangeStateMessage(param1:int) : void
      {
         var_26.send(new class_571(param1));
      }
      
      public function sendConversionPoint(param1:String, param2:String, param3:String, param4:String = null, param5:int = 0) : void
      {
         var_26.send(new EventLogMessageComposer(param1,param2,param3,param4,param5));
      }
      
      public function sendPollStartMessage(param1:int) : void
      {
         var_26.send(new PollStartComposer(param1));
      }
      
      public function sendPollRejectMessage(param1:int) : void
      {
         var_26.send(new class_753(param1));
      }
      
      public function sendPollAnswerMessage(param1:int, param2:int, param3:Array) : void
      {
         var_26.send(new class_163(param1,param2,param3));
      }
      
      public function sendPeerUsersClassificationMessage(param1:String) : void
      {
         var_26.send(new class_942(param1));
      }
      
      public function sendRoomUsersClassificationMessage(param1:String) : void
      {
         var_26.send(new class_368(param1));
      }
      
      public function sendVisitFlatMessage(param1:int) : void
      {
         var_26.send(new class_974(param1));
      }
      
      public function sendVisitUserMessage(param1:String) : void
      {
         var_26.send(new VisitUserMessageComposer(param1));
      }
      
      public function ambassadorAlert(param1:int) : void
      {
         var_26.send(new class_482(param1));
      }
      
      public function kickUser(param1:int) : void
      {
         var_26.send(new class_1041(param1));
      }
      
      public function banUserWithDuration(param1:int, param2:String) : void
      {
         var_26.send(new BanUserWithDurationMessageComposer(param1,param2,roomId));
      }
      
      public function muteUser(param1:int, param2:int) : void
      {
         var_26.send(new class_234(param1,param2,roomId));
      }
      
      public function unmuteUser(param1:int) : void
      {
         var_26.send(new UnmuteUserMessageComposer(param1,roomId));
      }
      
      public function assignRights(param1:int) : void
      {
         var_26.send(new class_595(param1));
      }
      
      public function removeRights(param1:int) : void
      {
         var _loc3_:Array = [];
         _loc3_.push(param1);
         var _loc2_:RemoveRightsMessageComposer = new RemoveRightsMessageComposer(_loc3_);
         var_26.send(_loc2_);
      }
      
      public function letUserIn(param1:String, param2:Boolean) : void
      {
         var_26.send(new LetUserInMessageComposer(param1,param2));
      }
      
      public function pickUpPet(param1:int) : void
      {
         var_26.send(new class_146(param1));
      }
      
      public function mountPet(param1:int) : void
      {
         var_26.send(new class_1047(param1,true));
      }
      
      public function togglePetRidingPermission(param1:int) : void
      {
         var_26.send(new class_1028(param1));
      }
      
      public function togglePetBreedingPermission(param1:int) : void
      {
         var_26.send(new class_417(param1));
      }
      
      public function dismountPet(param1:int) : void
      {
         var_26.send(new class_1047(param1,false));
      }
      
      public function removeSaddleFromPet(param1:int) : void
      {
         var_26.send(new class_513(param1));
      }
      
      public function harvestPet(param1:int) : void
      {
         var_26.send(new HarvestPetMessageComposer(param1));
      }
      
      public function compostPlant(param1:int) : void
      {
         var_26.send(new class_191(param1));
      }
      
      public function requestPetCommands(param1:int) : void
      {
         var_26.send(new class_956(param1));
      }
      
      public function useProductForPet(param1:int, param2:int) : void
      {
         var_26.send(new CustomizePetWithFurniComposer(param1,param2));
      }
      
      public function plantSeed(param1:int) : void
      {
         var_26.send(new UseFurnitureMessageComposer(param1));
      }
      
      public function sendScriptProceed() : void
      {
         var_26.send(new class_805());
      }
      
      public function quit() : void
      {
         if(var_26 != null)
         {
            var_26.send(new class_325());
         }
      }
      
      public function changeQueue(param1:int) : void
      {
         if(var_26 == null)
         {
            return;
         }
         var_26.send(new class_155(param1));
      }
      
      public function sendUpdateClothingChangeFurniture(param1:int, param2:String, param3:String) : void
      {
         if(var_26 == null)
         {
            return;
         }
         var _loc4_:class_508 = new class_508(param1,param2,param3);
         var_26.send(_loc4_);
         _loc4_.dispose();
         _loc4_ = null;
      }
      
      public function get userDataManager() : class_3525
      {
         return var_2711 as class_3525;
      }
      
      public function get ownUserRoomId() : int
      {
         return var_4330;
      }
      
      public function set ownUserRoomId(param1:int) : void
      {
         var_4330 = param1;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         var_3421 = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return var_3421;
      }
      
      public function set roomControllerLevel(param1:int) : void
      {
         if(param1 >= 0 && param1 <= 5)
         {
            var_1518 = param1;
         }
         else
         {
            class_14.log("Invalid roomControllerLevel " + param1 + ", setting to ROOM_CONTROL_LEVEL_NONE instead");
            var_1518 = 0;
         }
      }
      
      public function get roomControllerLevel() : int
      {
         if(var_397)
         {
            return 0;
         }
         return var_1518;
      }
      
      public function get tradeMode() : int
      {
         return var_870;
      }
      
      public function get isPrivateRoom() : Boolean
      {
         return true;
      }
      
      public function set tradeMode(param1:int) : void
      {
         var_870 = param1;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function get isNoobRoom() : Boolean
      {
         return var_1194 == 4;
      }
      
      public function set doorMode(param1:int) : void
      {
         var_1194 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return var_3914;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         var_3914 = param1;
      }
      
      public function get arePetsAllowed() : Boolean
      {
         return var_4280;
      }
      
      public function set arePetsAllowed(param1:Boolean) : void
      {
         var_4280 = param1;
      }
      
      public function get areBotsAllowed() : Boolean
      {
         return var_3421;
      }
      
      public function get isUserDecorating() : Boolean
      {
         return var_4786;
      }
      
      public function set isUserDecorating(param1:Boolean) : void
      {
         var_4786 = param1;
      }
      
      public function get isNuxNotComplete() : Boolean
      {
         return var_4580;
      }
      
      public function set isNuxNotComplete(param1:Boolean) : void
      {
         var_4580 = param1;
      }
   }
}
