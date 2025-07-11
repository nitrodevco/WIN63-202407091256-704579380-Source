package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const RENTABLE_BOT:String = "RWRBIUE_RENTABLE_BOT";
      
      public static const DEFAULT_BOT_BADGE_ID:String = "RENTABLE_BOT";
       
      
      private var _name:String = "";
      
      private var var_962:String = "";
      
      private var var_1241:int = 0;
      
      private var var_426:String = "";
      
      private var var_121:Array;
      
      private var var_4423:int = 0;
      
      private var var_4464:int = 0;
      
      private var var_876:int;
      
      private var _ownerName:String;
      
      private var var_3758:Boolean = false;
      
      private var var_3695:Boolean = false;
      
      private var var_3906:int = 0;
      
      private var _botSkills:Array;
      
      public function RoomWidgetRentableBotInfoUpdateEvent(param1:Boolean = false, param2:Boolean = false)
      {
         var_121 = [];
         super("RWRBIUE_RENTABLE_BOT",param1,param2);
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
      
      public function set webID(param1:int) : void
      {
         var_1241 = param1;
      }
      
      public function get webID() : int
      {
         return var_1241;
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
      
      public function set amIOwner(param1:Boolean) : void
      {
         var_3758 = param1;
      }
      
      public function get amIOwner() : Boolean
      {
         return var_3758;
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
      
      public function get botSkills() : Array
      {
         return _botSkills;
      }
      
      public function set botSkills(param1:Array) : void
      {
         _botSkills = param1;
      }
   }
}
