package com.sulake.habbo.friendlist.domain
{
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_1712;
   
   public class AvatarSearchResults
   {
       
      
      private var var_2776:class_3366;
      
      private var var_1471:Array;
      
      private var _others:Array;
      
      private var var_4071:Dictionary;
      
      public function AvatarSearchResults(param1:class_3366)
      {
         var_4071 = new Dictionary();
         super();
         var_2776 = param1;
      }
      
      public function getResult(param1:int) : class_1712
      {
         for each(var _loc3_ in var_1471)
         {
            if(_loc3_.avatarId == param1)
            {
               return _loc3_;
            }
         }
         for each(var _loc2_ in _others)
         {
            if(_loc2_.avatarId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function searchReceived(param1:Array, param2:Array) : void
      {
         var_1471 = param1;
         _others = param2;
         var_2776.view.refreshList();
      }
      
      public function get friends() : Array
      {
         return var_1471;
      }
      
      public function get others() : Array
      {
         return _others;
      }
      
      public function setFriendRequestSent(param1:int) : void
      {
         var_4071[param1] = "yes";
      }
      
      public function isFriendRequestSent(param1:int) : Boolean
      {
         return var_4071[param1] != null;
      }
   }
}
