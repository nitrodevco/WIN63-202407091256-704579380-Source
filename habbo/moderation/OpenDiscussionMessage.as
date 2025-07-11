package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class OpenDiscussionMessage
   {
       
      
      private var _main:ModerationManager;
      
      private var _groupId:int;
      
      private var var_345:int;
      
      private var var_494:int;
      
      public function OpenDiscussionMessage(param1:ModerationManager, param2:IWindow, param3:int, param4:int, param5:int)
      {
         super();
         _main = param1;
         _groupId = param3;
         var_345 = param4;
         var_494 = param5;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.openThreadMessage(_groupId,var_345,var_494);
      }
   }
}
