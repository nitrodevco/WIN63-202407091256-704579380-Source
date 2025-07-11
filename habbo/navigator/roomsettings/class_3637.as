package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendsListFragmentMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   
   public class class_3637
   {
       
      
      private var var_3176:Dictionary;
      
      private var var_19:Array;
      
      public function class_3637()
      {
         var_3176 = new Dictionary();
         super();
      }
      
      public function onFriendsListFragment(param1:IMessageEvent) : void
      {
         var _loc2_:FriendsListFragmentMessageParser = (param1 as FriendListFragmentMessageEvent).getParser();
         if(_loc2_ == null)
         {
            return;
         }
         for each(var _loc3_ in _loc2_.friendFragment)
         {
            var_3176[_loc3_.id] = _loc3_.name;
         }
      }
      
      public function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FriendListUpdateMessageParser = (param1 as FriendListUpdateEvent).getParser();
         for each(var _loc3_ in _loc2_.removedFriendIds)
         {
            var_3176[_loc3_] = null;
         }
         for each(var _loc4_ in _loc2_.addedFriends)
         {
            var_3176[_loc4_.id] = _loc4_.name;
         }
         var_19 = _loc2_.removedFriendIds.length > 0 || _loc2_.addedFriends.length > 0 ? null : var_19;
      }
      
      public function get list() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(var_19 == null)
         {
            var_19 = [];
            for(var _loc1_ in var_3176)
            {
               _loc3_ = int(_loc1_);
               _loc2_ = String(var_3176[_loc3_]);
               if(_loc2_ != null)
               {
                  var_19.push(new FriendEntryData(_loc3_,_loc2_));
               }
            }
            var_19.sortOn("userName",1);
         }
         return var_19;
      }
   }
}
