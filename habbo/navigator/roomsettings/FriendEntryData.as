package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1733;
   
   public class FriendEntryData implements class_1733
   {
       
      
      private var var_418:int;
      
      private var _userName:String;
      
      public function FriendEntryData(param1:int, param2:String)
      {
         super();
         var_418 = param1;
         _userName = param2;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}
