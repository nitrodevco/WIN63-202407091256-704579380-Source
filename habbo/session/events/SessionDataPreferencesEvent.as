package com.sulake.habbo.session.events
{
   import flash.events.Event;
   
   public class SessionDataPreferencesEvent extends Event
   {
      
      public static const const_846:String = "APUE_UPDATED";
       
      
      private var var_533:int;
      
      public function SessionDataPreferencesEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         var_533 = param1;
         super("APUE_UPDATED",param2,param3);
      }
      
      public function get uiFlags() : int
      {
         return var_533;
      }
   }
}
