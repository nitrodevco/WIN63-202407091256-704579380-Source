package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   
   public class OpenRoomInSpectatorMode
   {
       
      
      private var _main:ModerationManager;
      
      private var var_369:int;
      
      public function OpenRoomInSpectatorMode(param1:ModerationManager, param2:IWindow, param3:int)
      {
         super();
         _main = param1;
         var_369 = param3;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.goToRoom(var_369);
      }
   }
}
