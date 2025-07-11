package com.sulake.habbo.friendbar.events
{
   import flash.events.Event;
   
   public class ActiveConversationsCountEvent extends Event
   {
      
      public static const ACTIVE_MESSENGER_CONVERSATION_EVENT:String = "AMC_EVENT";
       
      
      private var var_4412:int;
      
      private var _hasUnread:Boolean;
      
      public function ActiveConversationsCountEvent(param1:int, param2:Boolean)
      {
         var_4412 = param1;
         _hasUnread = param2;
         super("AMC_EVENT");
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
