package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class OpenExternalLink
   {
       
      
      private var var_96:String;
      
      public function OpenExternalLink(param1:ModerationManager, param2:IWindow, param3:String)
      {
         super();
         param2.procedure = onClick;
         var_96 = param3;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         navigateToURL(new URLRequest(var_96),"_blank");
      }
   }
}
