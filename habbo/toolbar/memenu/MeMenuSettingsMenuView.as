package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.chatsettings.MeMenuChatSettingsView;
   import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsView;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.external.ExternalInterface;
   
   public class MeMenuSettingsMenuView
   {
       
      
      private var var_1629:MeMenuController;
      
      private var _window:IWindowContainer;
      
      private var var_1733:ToolbarView;
      
      private var var_3199:MeMenuSoundSettingsView;
      
      private var var_3219:MeMenuChatSettingsView;
      
      public function MeMenuSettingsMenuView()
      {
         super();
      }
      
      public function init(param1:MeMenuController, param2:ToolbarView) : void
      {
         var_1733 = param2;
         var_1629 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(var_3199 != null)
         {
            var_3199.dispose();
            var_3199 = null;
         }
         if(var_3219 != null)
         {
            var_3219.dispose();
            var_3219 = null;
         }
         var_1629 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = var_1629.toolbar.assets.getAssetByName("me_menu_settings_menu_xml") as XmlAsset;
         if(_loc1_)
         {
            _window = var_1629.toolbar.windowManager.buildFromXML(_loc1_.content as XML) as IWindowContainer;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct settings window from XML!");
         }
         _window.procedure = eventHandler;
         _window.x = var_1733.window.width + 10;
         _window.y = var_1733.window.bottom - _window.height;
         if(!ExternalInterface.available || var_1629.toolbar.getProperty("has.identity") != "1")
         {
            _window.findChildByName("character_settings").disable();
         }
         else
         {
            _window.findChildByName("identity_text").visible = false;
         }
         _window.findChildByName("chat_settings").visible = true;
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "character_settings":
               HabboWebTools.openAvatars();
               break;
            case "sound_settings":
               var_3199 = new MeMenuSoundSettingsView();
               var_3199.init(this,var_1733);
               _window.visible = false;
               break;
            case "chat_settings":
               var_3219 = new MeMenuChatSettingsView();
               var_3219.init(this,var_1733);
               break;
            case "back":
               var_1629.window.visible = true;
               dispose();
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
      
      public function get widget() : MeMenuController
      {
         return var_1629;
      }
   }
}
