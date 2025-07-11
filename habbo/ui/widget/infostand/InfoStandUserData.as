package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   
   public class InfoStandUserData
   {
       
      
      private var var_418:int = 0;
      
      private var _userName:String = "";
      
      private var var_121:Array;
      
      private var _groupId:int = 0;
      
      private var _groupName:String = "";
      
      private var var_4434:String = "";
      
      private var var_1524:int = 0;
      
      private var var_4423:int = 0;
      
      private var var_4464:int = 0;
      
      private var var_329:String;
      
      private var var_1569:int = 0;
      
      public function InfoStandUserData()
      {
         var_121 = [];
         super();
      }
      
      public function set userId(param1:int) : void
      {
         var_418 = param1;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function set badges(param1:Array) : void
      {
         var_121 = param1;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function set groupName(param1:String) : void
      {
         _groupName = param1;
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var_4434 = param1;
      }
      
      public function set respectLeft(param1:int) : void
      {
         var_1524 = param1;
      }
      
      public function set carryItem(param1:int) : void
      {
         var_4423 = param1;
      }
      
      public function set userRoomId(param1:int) : void
      {
         var_4464 = param1;
      }
      
      public function set type(param1:String) : void
      {
         var_329 = param1;
      }
      
      public function set petRespectLeft(param1:int) : void
      {
         var_1569 = param1;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get badges() : Array
      {
         return var_121.slice();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get groupBadgeId() : String
      {
         return var_4434;
      }
      
      public function get respectLeft() : int
      {
         return var_1524;
      }
      
      public function get carryItem() : int
      {
         return var_4423;
      }
      
      public function get userRoomId() : int
      {
         return var_4464;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get petRespectLeft() : int
      {
         return var_1569;
      }
      
      public function isBot() : Boolean
      {
         return type == "RWUIUE_BOT";
      }
      
      public function setData(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userId = param1.webID;
         userName = param1.name;
         badges = param1.badges;
         groupId = param1.groupId;
         groupName = param1.groupName;
         groupBadgeId = param1.groupBadgeId;
         respectLeft = param1.respectLeft;
         carryItem = param1.carryItem;
         userRoomId = param1.userRoomId;
         type = param1.type;
      }
   }
}
