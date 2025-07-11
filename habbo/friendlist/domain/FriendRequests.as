package com.sulake.habbo.friendlist.domain
{
    import assets.class_14

    import com.sulake.habbo.friendlist.Util;
   
   public class FriendRequests
   {
       
      
      private var var_2776:class_3384;
      
      private var var_115:Array;
      
      private var var_1452:int;
      
      private var var_4590:int;
      
      public function FriendRequests(param1:class_3384, param2:int, param3:int)
      {
         var_115 = [];
         super();
         var_2776 = param1;
         var_1452 = param2;
         var_4590 = param3;
      }
      
      public function clearAndUpdateView(param1:Boolean) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in var_115)
         {
            if(!param1 || _loc2_.state != 1)
            {
               _loc3_.push(_loc2_);
            }
         }
         for each(var _loc4_ in _loc3_)
         {
            Util.remove(var_115,_loc4_);
            if(var_2776.view != null)
            {
               var_2776.view.removeRequest(_loc4_);
            }
            _loc4_.dispose();
         }
         refreshShading();
      }
      
      public function acceptFailed(param1:int) : void
      {
         var _loc2_:FriendRequest = getRequestByRequesterId(param1);
         if(_loc2_ == null)
         {
            class_14.log("Failed to accept friend request from " + param1 + ", error retrieving the friendrequest.");
            return;
         }
         _loc2_.state = 4;
         var_2776.view.refreshRequestEntry(_loc2_);
      }
      
      public function addRequest(param1:FriendRequest) : void
      {
         var_115.push(param1);
      }
      
      public function addRequestAndUpdateView(param1:FriendRequest) : void
      {
         var_115.push(param1);
         var_2776.view.addRequest(param1);
      }
      
      public function getRequest(param1:int) : FriendRequest
      {
         for each(var _loc2_ in var_115)
         {
            if(_loc2_.requestId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRequestByRequesterId(param1:int) : FriendRequest
      {
         for each(var _loc2_ in var_115)
         {
            if(_loc2_.requesterUserId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function refreshShading() : void
      {
         var _loc1_:* = true;
         for each(var _loc2_ in var_115)
         {
            _loc1_ = !_loc1_;
            var_2776.view.refreshShading(_loc2_,_loc1_);
         }
      }
      
      public function getCountOfOpenRequests() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in requests)
         {
            if(_loc2_.state == 1)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get requests() : Array
      {
         return var_115;
      }
      
      public function get limit() : int
      {
         return var_1452;
      }
      
      public function get clubLimit() : int
      {
         return var_4590;
      }
      
      public function set limit(param1:int) : void
      {
         var_1452 = param1;
      }
   }
}
