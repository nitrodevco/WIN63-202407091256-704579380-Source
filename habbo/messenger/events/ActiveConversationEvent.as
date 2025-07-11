package com.sulake.habbo.messenger.events
{
   import flash.events.Event;
   
   public class ActiveConversationEvent extends Event
   {
      
      public static const ACTIVE_CONVERSATION_COUNT_CHANGED:String = "ACCE_changed";
       
      
      private var var_4412:int;
      
      private var _hasUnread:Boolean;
      
      public function ActiveConversationEvent(param1:String, param2:int, param3:Boolean)
      {
         super(param1);
         var_4412 = param2;
         _hasUnread = param3;
      }
      
      public function get activeConversationsCount() : int
      {
         return var_4412;
      }
      
      public function get hasUnread() : Boolean
      {
         return _hasUnread;
      }
   }
}
