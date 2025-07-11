package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.external.ExternalInterface;
   
   public class MeMenuSettingsMenuView implements IMeMenuView
   {
       
      
      private var var_1629:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      public function MeMenuSettingsMenuView()
      {
         super();
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         var_1629 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         var_1629 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:XmlAsset = var_1629.assets.getAssetByName("memenu_settings_menu") as XmlAsset;
         if(_loc2_)
         {
            _window = var_1629.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct settings window from XML!");
         }
         _window.name = param1;
         _window.procedure = eventHandler;
         if(!ExternalInterface.available || var_1629.config.getProperty("has.identity") != "1")
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
               var_1629.hide();
               break;
            case "sound_settings":
               var_1629.changeView("me_menu_sound_settings");
               break;
            case "chat_settings":
               var_1629.changeView("me_menu_chat_settings");
               break;
            case "back":
               var_1629.changeView("me_menu_top_view");
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
   }
}
