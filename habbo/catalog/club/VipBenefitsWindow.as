package com.sulake.habbo.catalog.club
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   
   public class VipBenefitsWindow implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _window:IWindowContainer;
      
      public function VipBenefitsWindow(param1:HabboCatalog)
      {
         super();
         _window = param1.utils.createWindow("vip_benefits") as IWindowContainer;
         _window.findChildByName("header_button_close").addEventListener("WME_CLICK",onClose);
         _window.center();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window != null)
            {
               _window.dispose();
               _window = null;
            }
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
   }
}
