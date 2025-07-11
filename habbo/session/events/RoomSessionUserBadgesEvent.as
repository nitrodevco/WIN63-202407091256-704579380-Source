package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserBadgesEvent extends RoomSessionEvent
   {
      
      public static const USER_BADGES:String = "RSUBE_BADGES";
       
      
      private var var_418:int = 0;
      
      private var var_121:Array;
      
      public function RoomSessionUserBadgesEvent(param1:IRoomSession, param2:int, param3:Array, param4:Boolean = false, param5:Boolean = false)
      {
         var_121 = [];
         super("RSUBE_BADGES",param1,param4,param5);
         var_418 = param2;
         var_121 = param3;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get badges() : Array
      {
         return var_121;
      }
   }
}
