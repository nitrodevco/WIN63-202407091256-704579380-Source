package com.sulake.habbo.navigator.mainview
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1784;
   
   public class PromotedRoomsGuestRoomListCtrl extends GuestRoomListCtrl
   {
       
      
      private var var_638:class_1784;
      
      public function PromotedRoomsGuestRoomListCtrl(param1:HabboNavigator)
      {
         super(param1,-6,false);
      }
      
      public function set category(param1:class_1784) : void
      {
         var_638 = param1;
      }
      
      override public function getRooms() : Array
      {
         return var_638.rooms;
      }
      
      override public function beforeEnterRoom(param1:int) : void
      {
         navigator.data.roomSessionTags = new RoomSessionTags(var_638.code,"" + (param1 + 2));
      }
   }
}
