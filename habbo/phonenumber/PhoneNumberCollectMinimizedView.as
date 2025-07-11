package com.sulake.habbo.phonenumber
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class PhoneNumberCollectMinimizedView
   {
      
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
       
      
      private var var_1660:HabboPhoneNumber;
      
      private var _window:IWindow;
      
      public function PhoneNumberCollectMinimizedView(param1:HabboPhoneNumber)
      {
         super();
         var_1660 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_CLICK",onClicked);
            _window.dispose();
            _window = null;
         }
         var_1660 = null;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            return;
         }
         _window = var_1660.windowManager.buildFromXML(XML(var_1660.assets.getAssetByName("phonenumber_collect_minimized_xml").content));
         _window.addEventListener("WME_CLICK",onClicked);
         _window.addEventListener("WME_OVER",onContainerMouseOver);
         _window.addEventListener("WME_OUT",onContainerMouseOut);
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
      }
      
      private function onClicked(param1:WindowMouseEvent) : void
      {
         var_1660.setCollectViewMinimized(false);
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4286084205;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
      }
   }
}
