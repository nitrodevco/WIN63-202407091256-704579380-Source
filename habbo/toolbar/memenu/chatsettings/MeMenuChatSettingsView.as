package com.sulake.habbo.toolbar.memenu.chatsettings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.MeMenuSettingsMenuView;
   
   public class MeMenuChatSettingsView
   {
       
      
      private var var_1629:MeMenuSettingsMenuView;
      
      private var _window:IWindowContainer;
      
      private var var_1733:ToolbarView;
      
      public function MeMenuChatSettingsView()
      {
         super();
      }
      
      public function init(param1:MeMenuSettingsMenuView, param2:ToolbarView) : void
      {
         var_1629 = param1;
         var_1733 = param2;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:class_3398 = _window.findChildByName("prefer_old_chat_checkbox") as class_3398;
         var_1629.window.visible = true;
         var_1629.widget.toolbar.freeFlowChat.isDisabledInPreferences = _loc1_ != null && Boolean(_loc1_.isSelected);
         _window.dispose();
         _window = null;
         var_1629 = null;
      }
      
      private function createWindow() : void
      {
         var _loc3_:int = 0;
         var _loc1_:IWindow = null;
         var _loc2_:XmlAsset = var_1629.widget.toolbar.assets.getAssetByName("me_menu_chat_settings_xml") as XmlAsset;
         _window = var_1629.widget.toolbar.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
         _window.x = var_1733.window.width + 10;
         _window.y = var_1733.window.bottom - _window.height;
         var_1629.window.visible = false;
         _loc3_ = 0;
         _loc1_ = null;
         while(_loc3_ < _window.numChildren)
         {
            _loc1_ = _window.getChildAt(_loc3_);
            _loc1_.addEventListener("WME_CLICK",onButtonClicked);
            _loc3_++;
         }
         class_3398(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = var_1629.widget.toolbar.freeFlowChat.isDisabledInPreferences;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "back_btn":
               dispose();
               break;
            case "prefer_old_chat_checkbox":
               var_1629.widget.toolbar.freeFlowChat.isDisabledInPreferences = class_3398(_window.findChildByName("prefer_old_chat_checkbox")).isSelected;
               if(!var_1629.widget.toolbar.freeFlowChat.isDisabledInPreferences)
               {
                  if(var_1629.widget.toolbar.roomUI.chatContainer != null)
                  {
                     var_1629.widget.toolbar.roomUI.chatContainer.setDisplayObject(var_1629.widget.toolbar.freeFlowChat.displayObject);
                  }
               }
               else
               {
                  var_1629.widget.toolbar.freeFlowChat.clear();
               }
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
