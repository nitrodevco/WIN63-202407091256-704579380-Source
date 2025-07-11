package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetUserInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const OWN_USER:String = "RWUIUE_OWN_USER";
      
      public static const BOT:String = "RWUIUE_BOT";
      
      public static const PEER:String = "RWUIUE_PEER";
      
      public static const TRADE_REASON_OK:int = 0;
      
      public static const TRADE_REASON_SHUTDOWN:int = 2;
      
      public static const TRADE_REASON_NO_TRADINGROOM:int = 3;
      
      public static const DEFAULT_BOT_BADGE_ID:String = "BOT";
       
      
      private var _name:String = "";
      
      private var var_962:String = "";
      
      private var _achievementScore:int;
      
      private var var_1241:int = 0;
      
      private var var_4407:int = 0;
      
      private var var_1347:int;
      
      private var var_426:String = "";
      
      private var var_121:Array;
      
      private var _groupId:int = 0;
      
      private var _groupName:String = "";
      
      private var var_4434:String = "";
      
      private var var_4423:int = 0;
      
      private var var_4464:int = 0;
      
      private var var_3914:Boolean = false;
      
      private var _realName:String = "";
      
      private var var_3898:Boolean = false;
      
      private var var_3758:Boolean = false;
      
      private var var_3695:Boolean = false;
      
      private var var_3906:int = 0;
      
      private var var_3957:Boolean = false;
      
      private var var_3958:Boolean = false;
      
      private var var_3748:Boolean = false;
      
      private var var_3741:Boolean = false;
      
      private var var_1524:int = 0;
      
      private var var_3924:Boolean = false;
      
      private var _isGuildRoom:Boolean = false;
      
      private var var_3692:Boolean = false;
      
      private var var_3800:int = 0;
      
      private var var_3873:int = 0;
      
      private var var_1255:Boolean = false;
      
      private var _isAmbassador:Boolean = false;
      
      public function RoomWidgetUserInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         var_121 = [];
         super(param1,param2,param3);
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set motto(param1:String) : void
      {
         var_962 = param1;
      }
      
      public function get motto() : String
      {
         return var_962;
      }
      
      public function set achievementScore(param1:int) : void
      {
         _achievementScore = param1;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function set webID(param1:int) : void
      {
         var_1241 = param1;
      }
      
      public function get webID() : int
      {
         return var_1241;
      }
      
      public function set xp(param1:int) : void
      {
         var_4407 = param1;
      }
      
      public function get xp() : int
      {
         return var_4407;
      }
      
      public function set userType(param1:int) : void
      {
         var_1347 = param1;
      }
      
      public function get userType() : int
      {
         return var_1347;
      }
      
      public function set figure(param1:String) : void
      {
         var_426 = param1;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function set badges(param1:Array) : void
      {
         var_121 = param1;
      }
      
      public function get badges() : Array
      {
         return var_121;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var_4434 = param1;
      }
      
      public function get groupBadgeId() : String
      {
         return var_4434;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         var_3957 = param1;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return var_3957;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_1524 = param1;
      }
      
      public function get respectLeft() : int
      {
         return var_1524;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_3924 = param1;
      }
      
      public function get isIgnored() : Boolean
      {
         return var_3924;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_3758 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_3758;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function set myRoomControllerLevel(param1:int) : void
      {
         var_3906 = param1;
      }
      
      public function get myRoomControllerLevel() : int
      {
         return var_3906;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_3695 = param1;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_3695;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         var_3692 = param1;
      }
      
      public function get canTrade() : Boolean
      {
         return var_3692;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         var_3800 = param1;
      }
      
      public function get canTradeReason() : int
      {
         return var_3800;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         var_3958 = param1;
      }
      
      public function get canBeKicked() : Boolean
      {
         return var_3958;
      }
      
      public function set canBeBanned(param1:Boolean) : void
      {
         var_3748 = param1;
      }
      
      public function get canBeBanned() : Boolean
      {
         return var_3748;
      }
      
      public function get canBeMuted() : Boolean
      {
         return var_3741;
      }
      
      public function set canBeMuted(param1:Boolean) : void
      {
         var_3741 = param1;
      }
      
      public function set targetRoomControllerLevel(param1:int) : void
      {
         var_3873 = param1;
      }
      
      public function get targetRoomControllerLevel() : int
      {
         return var_3873;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_4423 = param1;
      }
      
      public function get carryItem() : int
      {
         return var_4423;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_4464 = param1;
      }
      
      public function get userRoomId() : int
      {
         return var_4464;
      }
      
      public function set isSpectatorMode(param1:Boolean) : void
      {
         var_3914 = param1;
      }
      
      public function get isSpectatorMode() : Boolean
      {
         return var_3914;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         var_3898 = param1;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3898;
      }
      
      public function get isFriend() : Boolean
      {
         return var_1255;
      }
      
      public function set isFriend(param1:Boolean) : void
      {
         var_1255 = param1;
      }
      
      public function get amIAnAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function set amIAnAmbassador(param1:Boolean) : void
      {
         _isAmbassador = param1;
      }
   }
}
