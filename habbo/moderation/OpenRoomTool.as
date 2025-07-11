package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   
   public class OpenRoomTool
   {
       
      
      private var _frame:class_3514;
      
      private var _main:ModerationManager;
      
      private var var_369:int;
      
      public function OpenRoomTool(param1:class_3514, param2:ModerationManager, param3:IWindow, param4:int)
      {
         super();
         _frame = param1;
         _main = param2;
         var_369 = param4;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new RoomToolCtrl(_main,var_369),_frame,false,false,true);
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
   }
}
