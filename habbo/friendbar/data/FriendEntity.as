package com.sulake.habbo.friendbar.data
{
   public class FriendEntity implements IFriendEntity
   {
      
      private static var ROLLING_LOG_EVENT_ID:int = 0;
       
      
      private var var_280:int;
      
      private var _name:String;
      
      private var var_129:int;
      
      private var var_1106:Boolean;
      
      private var _allowFollow:Boolean;
      
      private var var_426:String;
      
      private var var_634:int;
      
      private var var_962:String;
      
      private var var_1597:String;
      
      private var _realName:String;
      
      private var _notifications:Vector.<IFriendNotification>;
      
      private var var_4647:int = -1;
      
      public function FriendEntity(param1:int, param2:String, param3:String, param4:String, param5:int, param6:Boolean, param7:Boolean, param8:String, param9:int, param10:String)
      {
         super();
         var_280 = param1;
         _name = param2;
         _realName = param3;
         var_962 = param4;
         var_129 = param5;
         var_1106 = param6;
         _allowFollow = param7;
         var_426 = param8;
         var_634 = param9;
         var_1597 = param10;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get gender() : int
      {
         return var_129;
      }
      
      public function get online() : Boolean
      {
         return var_1106;
      }
      
      public function get allowFollow() : Boolean
      {
         return _allowFollow;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function get categoryId() : int
      {
         return var_634;
      }
      
      public function get motto() : String
      {
         return var_962;
      }
      
      public function get lastAccess() : String
      {
         return var_1597;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get logEventId() : int
      {
         return var_4647;
      }
      
      public function get notifications() : Vector.<IFriendNotification>
      {
         if(!_notifications)
         {
            _notifications = new Vector.<IFriendNotification>();
         }
         return _notifications;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set gender(param1:int) : void
      {
         var_129 = param1;
      }
      
      public function set online(param1:Boolean) : void
      {
         var_1106 = param1;
      }
      
      public function set allowFollow(param1:Boolean) : void
      {
         _allowFollow = param1;
      }
      
      public function set figure(param1:String) : void
      {
         var_426 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_634 = param1;
      }
      
      public function set motto(param1:String) : void
      {
         var_962 = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         var_1597 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function set logEventId(param1:int) : void
      {
         var_4647 = param1;
      }
      
      public function getNextLogEventId() : int
      {
         return ++ROLLING_LOG_EVENT_ID;
      }
   }
}
