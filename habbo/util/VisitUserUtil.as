package com.sulake.habbo.util
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.moderation.ModerationManager;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.class_450;
   
   public class VisitUserUtil
   {
       
      
      private var _main:ModerationManager;
      
      private var var_418:int;
      
      public function VisitUserUtil(param1:ModerationManager, param2:IWindow, param3:int)
      {
         super();
         _main = param1;
         var_418 = param3;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.connection.send(new class_450(var_418));
      }
   }
}
