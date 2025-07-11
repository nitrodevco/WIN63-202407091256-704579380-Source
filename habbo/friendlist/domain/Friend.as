package com.sulake.habbo.friendlist.domain
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendlist.IFriend;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   
   public class Friend implements IFriend, IDisposable
   {
      
      public static const GENDER_FEMALE:int = "F".charCodeAt(0);
      
      public static const GENDER_MALE:int = "M".charCodeAt(0);
       
      
      private var var_280:int;
      
      private var _name:String;
      
      private var var_129:int;
      
      private var var_1106:Boolean;
      
      private var var_1544:Boolean;
      
      private var var_426:String;
      
      private var var_962:String;
      
      private var var_1597:String;
      
      private var var_634:int;
      
      private var _selected:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_1631:IWindowContainer;
      
      private var var_2659:BitmapData;
      
      private var _realName:String;
      
      private var var_1578:Boolean;
      
      private var var_1546:Boolean;
      
      private var var_1541:Boolean;
      
      private var _relationshipStatus:int;
      
      public function Friend(param1:FriendData)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var_280 = param1.id;
         _name = param1.name;
         var_129 = param1.gender;
         var_1106 = param1.online;
         var_1544 = param1.followingAllowed && param1.online;
         var_426 = param1.figure;
         var_962 = param1.motto;
         var_1597 = param1.lastAccess;
         var_634 = param1.categoryId;
         _realName = param1.realName;
         var_1578 = param1.persistedMessageUser;
         var_1541 = param1.vipMember;
         var_1546 = param1.pocketHabboUser;
         _relationshipStatus = param1.relationshipStatus;
         class_14.log("Creating friend: " + id + ", " + name + ", " + gender + ", " + online + ", " + followingAllowed + ", " + figure + ", " + categoryId);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_2659 != null)
         {
            var_2659.dispose();
            var_2659 = null;
         }
         _disposed = true;
         var_1631 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
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
      
      public function get followingAllowed() : Boolean
      {
         return var_1544;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function get motto() : String
      {
         return var_962;
      }
      
      public function get lastAccess() : String
      {
         return var_1597;
      }
      
      public function get categoryId() : int
      {
         return var_634;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get view() : IWindowContainer
      {
         return var_1631;
      }
      
      public function get face() : BitmapData
      {
         return var_2659;
      }
      
      public function get realName() : String
      {
         return _realName;
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return var_1578;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return var_1546;
      }
      
      public function get relationshipStatus() : int
      {
         return _relationshipStatus;
      }
      
      public function get vipMember() : Boolean
      {
         return var_1541;
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
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
      
      public function set followingAllowed(param1:Boolean) : void
      {
         var_1544 = param1;
      }
      
      public function set figure(param1:String) : void
      {
         var_426 = param1;
      }
      
      public function set motto(param1:String) : void
      {
         var_962 = param1;
      }
      
      public function set lastAccess(param1:String) : void
      {
         var_1597 = param1;
      }
      
      public function set categoryId(param1:int) : void
      {
         var_634 = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         var_1631 = param1;
      }
      
      public function set face(param1:BitmapData) : void
      {
         var_2659 = param1;
      }
      
      public function set realName(param1:String) : void
      {
         _realName = param1;
      }
      
      public function set persistedMessageUser(param1:Boolean) : void
      {
         var_1578 = param1;
      }
      
      public function set pocketHabboUser(param1:Boolean) : void
      {
         var_1546 = param1;
      }
      
      public function set vipMember(param1:Boolean) : void
      {
         var_1541 = param1;
      }
      
      public function isGroupFriend() : Boolean
      {
         return var_280 < 0;
      }
   }
}
