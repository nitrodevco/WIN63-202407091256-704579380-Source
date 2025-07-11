package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.friendlist.*;
   
   public class FriendListTabs
   {
       
      
      private var var_2776:class_3508;
      
      private var var_2253:Array;
      
      private var var_4137:FriendListTab;
      
      private var var_2885:int = 200;
      
      private var var_4697:int = 200;
      
      private var _windowWidth:int = 200;
      
      public function FriendListTabs(param1:class_3508)
      {
         var_2253 = [];
         super();
         var_2776 = param1;
         var_2253.push(new FriendListTab(var_2776.getFriendList(),1,new FriendsView(),"${friendlist.friends}","friends_footer","hdr_friends"));
         var_2253.push(new FriendListTab(var_2776.getFriendList(),2,new FriendRequestsView(),"${friendlist.tab.friendrequests}","friend_requests_footer","hdr_friend_requests"));
         var_2253.push(new FriendListTab(var_2776.getFriendList(),3,new SearchView(),"${generic.search}","search_footer","hdr_search"));
         toggleSelected(null);
      }
      
      public function getTabs() : Array
      {
         return var_2253;
      }
      
      public function findTab(param1:int) : FriendListTab
      {
         for each(var _loc2_ in var_2253)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function clearSelections() : void
      {
         for each(var _loc1_ in var_2253)
         {
            _loc1_.setSelected(false);
         }
      }
      
      public function findSelectedTab() : FriendListTab
      {
         for each(var _loc1_ in var_2253)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function toggleSelected(param1:FriendListTab) : void
      {
         var _loc2_:FriendListTab = findSelectedTab();
         if(_loc2_ == null)
         {
            var_2885 = var_4697;
            setSelected(determineDisplayedTab(param1),true);
         }
         else if(_loc2_ == param1 || param1 == null)
         {
            var_4697 = var_2885;
            var_2885 = 0;
            clearSelections();
         }
         else
         {
            setSelected(determineDisplayedTab(param1),true);
         }
      }
      
      private function setSelected(param1:FriendListTab, param2:Boolean) : void
      {
         var _loc3_:FriendListTab = findSelectedTab();
         clearSelections();
         param1.setSelected(param2);
         if(param2)
         {
            var_4137 = param1;
         }
      }
      
      private function determineDisplayedTab(param1:FriendListTab) : FriendListTab
      {
         if(param1 != null)
         {
            return param1;
         }
         if(var_4137 != null)
         {
            return var_4137;
         }
         return var_2253[0];
      }
      
      public function get tabContentHeight() : int
      {
         return var_2885;
      }
      
      public function get windowWidth() : int
      {
         return _windowWidth;
      }
      
      public function get tabContentWidth() : int
      {
         return _windowWidth - 2;
      }
      
      public function set tabContentHeight(param1:int) : void
      {
         var_2885 = param1;
      }
      
      public function set windowWidth(param1:int) : void
      {
         _windowWidth = param1;
      }
   }
}
