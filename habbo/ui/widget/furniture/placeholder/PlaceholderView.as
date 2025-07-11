package com.sulake.habbo.ui.widget.furniture.placeholder
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.geom.Rectangle;
   
   public class PlaceholderView
   {
       
      
      private var var_2286:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _window:IWindowContainer;
      
      public function PlaceholderView(param1:IAssetLibrary, param2:IHabboWindowManager)
      {
         super();
         var_2286 = param1;
         _windowManager = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function toggleWindow() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            hideWindow();
         }
         else
         {
            showWindow();
         }
      }
      
      public function showWindow() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.x = 200;
      }
      
      private function createWindow() : void
      {
         var _loc2_:XmlAsset = var_2286.getAssetByName("placeholder") as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return;
         }
         _window = _windowManager.createWindow("habbohelp_window","",4,0,131072 | 1,new Rectangle(-300,300,10,10),null) as IWindowContainer;
         _window.buildFromXML(_loc2_.content as XML);
         _window.tags.push("habbo_help_window");
         _window.background = true;
         _window.color = 33554431;
         var _loc1_:IWindow = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.procedure = onWindowClose;
         }
      }
      
      public function hideWindow() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideWindow();
      }
   }
}
