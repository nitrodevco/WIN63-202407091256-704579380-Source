package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionQueueEvent extends RoomSessionEvent
   {
      
      public static const QUEUE_STATUS:String = "RSQE_QUEUE_STATUS";
      
      public static const const_749:String = "c";
      
      public static const QUEUE_TYPE_NORMAL:String = "d";
      
      public static const const_623:int = 2;
      
      public static const const_707:int = 1;
       
      
      private var _name:String;
      
      private var var_294:int;
      
      private var var_472:Map;
      
      private var var_2341:Boolean;
      
      private var var_4973:String;
      
      public function RoomSessionQueueEvent(param1:IRoomSession, param2:String, param3:int, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSQE_QUEUE_STATUS",param1,param5,param6);
         _name = param2;
         var_294 = param3;
         var_472 = new Map();
         var_2341 = param4;
      }
      
      public function get isActive() : Boolean
      {
         return var_2341;
      }
      
      public function get queueSetName() : String
      {
         return _name;
      }
      
      public function get queueSetTarget() : int
      {
         return var_294;
      }
      
      public function get queueTypes() : Array
      {
         return var_472.getKeys();
      }
      
      public function getQueueSize(param1:String) : int
      {
         return var_472.getValue(param1);
      }
      
      public function addQueue(param1:String, param2:int) : void
      {
         var_472.add(param1,param2);
      }
   }
}
