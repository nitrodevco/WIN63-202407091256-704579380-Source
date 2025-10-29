package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.groupforums.ModerateThreadMessageComposer;
   
   public class HideDiscussionThread
   {
       
      
      private var _main:ModerationManager;
      
      private var _popup:ChatlogCtrl;
      
      private var _groupId:int;
      
      private var var_345:int;
      
      public function HideDiscussionThread(param1:ModerationManager, param2:ChatlogCtrl, param3:IWindow, param4:int, param5:int)
      {
         super();
         _main = param1;
         _popup = param2;
         _groupId = param4;
         var_345 = param5;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _popup.dispose();
         _main.connection.send(new ModerateThreadMessageComposer(_groupId,var_345,20));
      }
   }
}
