package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   
   public class class_3630
   {
       
      
      private var var_3924:Boolean = false;
      
      private var var_3692:Boolean = false;
      
      private var var_3800:int = 0;
      
      private var var_3958:Boolean = false;
      
      private var var_3748:Boolean = false;
      
      private var var_3741:Boolean = false;
      
      private var var_3957:Boolean = false;
      
      private var var_3758:Boolean = false;
      
      private var var_3695:Boolean = false;
      
      private var var_1524:int = 0;
      
      private var var_3922:Boolean = false;
      
      private var var_3898:Boolean = false;
      
      private var _isGuildRoom:Boolean = false;
      
      private var var_3765:int = 0;
      
      private var var_3906:int = 0;
      
      private var var_3873:int = 0;
      
      private var var_1255:Boolean = false;
      
      private var _isAmbassador:Boolean = false;
      
      public function class_3630()
      {
         super();
      }
      
      public function get isIgnored() : Boolean
      {
         return var_3924;
      }
      
      public function get canTrade() : Boolean
      {
         return var_3692;
      }
      
      public function get canTradeReason() : int
      {
         return var_3800;
      }
      
      public function get canBeKicked() : Boolean
      {
         return var_3958;
      }
      
      public function get canBeBanned() : Boolean
      {
         return var_3748;
      }
      
      public function get canBeAskedAsFriend() : Boolean
      {
         return var_3957;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_3758;
      }
      
      public function get amIAnyRoomController() : Boolean
      {
         return var_3695;
      }
      
      public function get respectLeft() : int
      {
         return var_1524;
      }
      
      public function get isOwnUser() : Boolean
      {
         return var_3922;
      }
      
      public function get allowNameChange() : Boolean
      {
         return var_3898;
      }
      
      public function get isGuildRoom() : Boolean
      {
         return _isGuildRoom;
      }
      
      public function get carryItemType() : int
      {
         return var_3765;
      }
      
      public function get myRoomControllerLevel() : int
      {
         return var_3906;
      }
      
      public function get targetRoomControllerLevel() : int
      {
         return var_3873;
      }
      
      public function set isIgnored(param1:Boolean) : void
      {
         var_3924 = param1;
      }
      
      public function set canTrade(param1:Boolean) : void
      {
         var_3692 = param1;
      }
      
      public function set canTradeReason(param1:int) : void
      {
         var_3800 = param1;
      }
      
      public function set canBeKicked(param1:Boolean) : void
      {
         var_3958 = param1;
      }
      
      public function set canBeBanned(param1:Boolean) : void
      {
         var_3748 = param1;
      }
      
      public function get canBeMuted() : Boolean
      {
         return var_3741;
      }
      
      public function set canBeMuted(param1:Boolean) : void
      {
         var_3741 = param1;
      }
      
      public function set canBeAskedAsFriend(param1:Boolean) : void
      {
         var_3957 = param1;
      }
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_3758 = param1;
      }
      
      public function set amIAnyRoomController(param1:Boolean) : void
      {
         var_3695 = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_1524 = param1;
      }
      
      public function set isOwnUser(param1:Boolean) : void
      {
         var_3922 = param1;
      }
      
      public function set allowNameChange(param1:Boolean) : void
      {
         var_3898 = param1;
      }
      
      public function set isGuildRoom(param1:Boolean) : void
      {
         _isGuildRoom = param1;
      }
      
      public function set carryItemType(param1:int) : void
      {
         var_3765 = param1;
      }
      
      public function set myRoomControllerLevel(param1:int) : void
      {
         var_3906 = param1;
      }
      
      public function set targetRoomControllerLevel(param1:int) : void
      {
         var_3873 = param1;
      }
      
      public function get isFriend() : Boolean
      {
         return var_1255;
      }
      
      public function get isAmbassador() : Boolean
      {
         return _isAmbassador;
      }
      
      public function populate(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var_3695 = param1.amIAnyRoomController;
         var_3906 = param1.myRoomControllerLevel;
         var_3758 = param1.amIOwner;
         var_3957 = param1.canBeAskedAsFriend;
         var_3958 = param1.canBeKicked;
         var_3748 = param1.canBeBanned;
         var_3741 = param1.canBeMuted;
         var_3692 = param1.canTrade;
         var_3800 = param1.canTradeReason;
         var_3924 = param1.isIgnored;
         var_1524 = param1.respectLeft;
         var_3922 = param1.type == "RWUIUE_OWN_USER";
         var_3898 = param1.allowNameChange;
         _isGuildRoom = param1.isGuildRoom;
         var_3873 = param1.targetRoomControllerLevel;
         var_3765 = param1.carryItem;
         var_1255 = param1.isFriend;
         _isAmbassador = param1.amIAnAmbassador;
      }
   }
}
