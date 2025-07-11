package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.extensions.settings.OtherSettingsView;
   import com.sulake.habbo.toolbar.extensions.settings.SoundSettingsView;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class SettingsExtension implements IDisposable
   {
      
      private static const SPACING:int = 3;
      
      private static const PADDING:int = 7;
       
      
      private var _toolbar:HabboToolbar;
      
      private var _window:IWindowContainer;
      
      private var var_1640:Vector.<IWindow>;
      
      private var _disposed:Boolean = false;
      
      public function SettingsExtension(param1:HabboToolbar)
      {
         var_1640 = new Vector.<IWindow>();
         super();
         _toolbar = param1;
         _window = _toolbar.windowManager.buildFromXML(param1.assets.getAssetByName("settings_xml").content as XML) as IWindowContainer;
         _window.procedure = windowProcedure;
         addButton("avatar_settings",_toolbar.localization.getLocalization("widget.memenu.settings.character","avatar settings"));
         addButton("sound",_toolbar.localization.getLocalization("widget.memenu.settings.audio","sound settings"));
         addButton("chat",_toolbar.localization.getLocalization("widget.memenu.settings.other","other settings"));
         param1.extensionView.attachExtension("settings",_window,1);
         _window.visible = false;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function addButton(param1:String, param2:String) : void
      {
         var _loc3_:IWindowContainer = _toolbar.windowManager.buildFromXML(_toolbar.assets.getAssetByName("setting_category_xml").content as XML) as IWindowContainer;
         _window.addChild(_loc3_);
         _loc3_.findChildByName("button_label").caption = param2;
         if(var_1640.length > 0)
         {
            _loc3_.y = var_1640[var_1640.length - 1].bottom + 3;
         }
         else
         {
            _loc3_.y = 7;
         }
         _loc3_.x = 7;
         _loc3_.name = param1;
         _loc3_.procedure = windowProcedure;
         var_1640.push(_loc3_);
         _window.height = var_1640[var_1640.length - 1].bottom + 7;
      }
      
      private function openSoundSettingsWindow() : void
      {
         var _loc2_:SoundSettingsView = new SoundSettingsView(_toolbar);
         var _loc1_:IWindowContainer = _toolbar.windowManager.getDesktop(1);
         _loc1_.addChild(_loc2_.window);
         _loc2_.window.x = _loc1_.width - _loc2_.window.width - 200;
      }
      
      private function openChatSettingsWindow() : void
      {
         var _loc2_:OtherSettingsView = new OtherSettingsView(_toolbar);
         var _loc1_:IWindowContainer = _toolbar.windowManager.getDesktop(1);
         _loc1_.addChild(_loc2_.window);
         _loc2_.window.x = _loc1_.width - _loc2_.window.width - 200;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "avatar_settings":
               HabboWebTools.openAvatars();
               _toolbar.toggleSettingVisibility();
               break;
            case "sound":
               openSoundSettingsWindow();
               _toolbar.toggleSettingVisibility();
               break;
            case "chat":
               openChatSettingsWindow();
               _toolbar.toggleSettingVisibility();
         }
      }
   }
}
