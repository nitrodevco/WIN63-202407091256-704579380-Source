package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   
   public class HcRequiredWindowCtrl implements IDisposable
   {
       
      
      private var var_480:HabboGroupsManager;
      
      private var _window:class_3514;
      
      public function HcRequiredWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_480 = param1;
      }
      
      public function dispose() : void
      {
         var_480 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      public function show(param1:Boolean) : void
      {
         prepareWindow();
         _window.findChildByName("info_txt").caption = param1 ? "${group.hcrequired.info.manage}" : "${group.hcrequired.info.join}";
         _window.visible = true;
         _window.activate();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(var_480.getXmlWindow("club_required"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("cancel_link_region").procedure = onClose;
         _window.findChildByName("join_button").procedure = onOpenCatalog;
         _window.findChildByName("more_info_link_region").procedure = onOpenCatalog;
         _window.center();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function onOpenCatalog(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var_480.openVipPurchase("HcRequiredWindowCtrl");
            close();
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
   }
}
