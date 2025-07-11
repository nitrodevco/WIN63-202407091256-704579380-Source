package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.class_1708;
   
   public class WiredErrorInfoView implements IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var _window:IWindowContainer;
      
      private var var_319:WiredMenuController;
      
      private var _windowManager:IHabboWindowManager;
      
      public function WiredErrorInfoView(param1:WiredMenuController)
      {
         super();
         var_319 = param1;
         _windowManager = param1.windowManager;
         _window = _windowManager.buildFromXML(XML(param1.assets.getAssetByName("error_info_view_xml").content),1) as IWindowContainer;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
      }
      
      public function initialize(param1:class_1708) : void
      {
         errorName.text = param1.errorName;
         typeIcon.assetUri = "icon_wired_" + param1.category.toLowerCase() + "_png";
         errorText.text = var_319.localizationManager.getLocalization("wiredmenu.error_info." + param1.errorId);
         _window.height = contentsContainer.height + 48;
      }
      
      public function show() : void
      {
         var _loc1_:class_3460 = null;
         _window.x = Math.max(_window.x,0);
         _window.y = Math.max(_window.y,0);
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.activate();
      }
      
      private function hide() : void
      {
         var _loc1_:class_3460 = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide();
         _window.dispose();
         _window = null;
         _windowManager = null;
         var_319 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindow
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get errorName() : ITextWindow
      {
         return _window.findChildByName("error_name") as ITextWindow;
      }
      
      private function get errorText() : ITextWindow
      {
         return _window.findChildByName("error_text") as ITextWindow;
      }
      
      private function get contentsContainer() : IWindowContainer
      {
         return _window.findChildByName("contents") as IWindowContainer;
      }
      
      private function get typeIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("type_icon") as IStaticBitmapWrapperWindow;
      }
   }
}
