package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionFavouriteGroupUpdateEvent extends RoomSessionEvent
   {
      
      public static const const_1093:String = "rsfgue_favourite_group_update";
       
      
      private var var_871:int;
      
      private var var_903:int;
      
      private var _habboGroupName:String;
      
      private var _status:int;
      
      public function RoomSessionFavouriteGroupUpdateEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:String, param6:Boolean = false, param7:Boolean = false)
      {
         super("rsfgue_favourite_group_update",param1,param6,param7);
         var_871 = param2;
         var_903 = param3;
         _habboGroupName = param5;
         _status = param4;
      }
      
      public function get roomIndex() : int
      {
         return var_871;
      }
      
      public function get habboGroupId() : int
      {
         return var_903;
      }
      
      public function get habboGroupName() : String
      {
         return _habboGroupName;
      }
      
      public function get status() : int
      {
         return _status;
      }
   }
}
