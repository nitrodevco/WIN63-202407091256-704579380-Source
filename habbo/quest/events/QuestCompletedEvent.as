package com.sulake.habbo.quest.events
{
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class QuestCompletedEvent extends Event
   {
      
      public static const QUEST_SEASONAL:String = "qce_seasonal";
       
      
      private var var_549:class_1715;
      
      public function QuestCompletedEvent(param1:String, param2:class_1715, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         var_549 = param2;
      }
      
      public function get questData() : class_1715
      {
         return var_549;
      }
   }
}
