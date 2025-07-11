package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class OpenDiscussionThread
   {
       
      
      private var _main:ModerationManager;
      
      private var _groupId:int;
      
      private var var_345:int;
      
      public function OpenDiscussionThread(param1:ModerationManager, param2:IWindow, param3:int, param4:int)
      {
         super();
         _main = param1;
         _groupId = param3;
         var_345 = param4;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.openThread(_groupId,var_345);
      }
   }
}
