package com.sulake.habbo.quest.events
{
   import flash.events.Event;
   
   public class UnseenAchievementsCountUpdateEvent extends Event
   {
      
      public static const TYPE:String = "qe_uacue";
       
      
      private var var_178:int;
      
      public function UnseenAchievementsCountUpdateEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super("qe_uacue",param2,param3);
         var_178 = param1;
      }
      
      public function get count() : int
      {
         return var_178;
      }
   }
}
