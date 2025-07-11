package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendlist.Util;
   
   public class FriendCategory implements IDisposable
   {
      
      public static const PAGE_SIZE:int = 100;
      
      public static const CATID_ONLINE:int = 0;
      
      public static const CATID_OFFLINE:int = -1;
       
      
      private var var_280:int;
      
      private var _name:String;
      
      private var _open:Boolean;
      
      private var var_1471:Array;
      
      private var var_4468:Boolean;
      
      private var _disposed:Boolean;
      
      private var var_1631:IWindowContainer;
      
      private var var_479:int;
      
      public function FriendCategory(param1:int, param2:String)
      {
         var_1471 = [];
         super();
         var_280 = param1;
         _name = param2;
         _open = var_280 != -1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_1631 = null;
      }
      
      public function addFriend(param1:Friend) : void
      {
         removeFriend(param1.id);
         var_1471.push(param1);
      }
      
      public function sort() : void
      {
         var_1471.sortOn("name",1);
      }
      
      public function getSelectedFriends(param1:Array) : void
      {
         for each(var _loc2_ in var_1471)
         {
            if(_loc2_.selected)
            {
               param1.push(_loc2_);
            }
         }
      }
      
      public function getFriend(param1:int) : Friend
      {
         for each(var _loc2_ in var_1471)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_ in var_1471)
         {
            if((!param1 || _loc4_.online) && (!param2 || _loc4_.followingAllowed))
            {
               _loc3_ += 1;
            }
         }
         return _loc3_;
      }
      
      public function removeFriend(param1:int) : Friend
      {
         var _loc2_:Friend = getFriend(param1);
         if(_loc2_ != null)
         {
            Util.remove(var_1471,_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      private function checkPageIndex() : void
      {
         if(this.var_479 >= this.getPageCount())
         {
            this.var_479 = Math.max(0,this.getPageCount() - 1);
         }
      }
      
      public function getPageCount() : int
      {
         return Math.ceil(this.var_1471.length / 100);
      }
      
      public function getStartFriendIndex() : int
      {
         checkPageIndex();
         return this.var_479 * 100;
      }
      
      public function getEndFriendIndex() : int
      {
         checkPageIndex();
         return Math.min((this.var_479 + 1) * 100,this.var_1471.length);
      }
      
      public function setOpen(param1:Boolean) : void
      {
         _open = param1;
         if(!param1)
         {
            for each(var _loc2_ in var_1471)
            {
               _loc2_.selected = false;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get received() : Boolean
      {
         return var_4468;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get friends() : Array
      {
         return var_1471;
      }
      
      public function get view() : IWindowContainer
      {
         return var_1631;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function get pageIndex() : int
      {
         return var_479;
      }
      
      public function set id(param1:int) : void
      {
         var_280 = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
         var_1631 = param1;
      }
      
      public function set received(param1:Boolean) : void
      {
         var_4468 = param1;
      }
      
      public function set pageIndex(param1:int) : void
      {
         var_479 = param1;
      }
   }
}
