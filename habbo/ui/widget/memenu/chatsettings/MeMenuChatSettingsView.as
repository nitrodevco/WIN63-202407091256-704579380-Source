package com.sulake.habbo.ui.widget.memenu.chatsettings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.memenu.IMeMenuView;
   import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;
   
   public class MeMenuChatSettingsView implements IMeMenuView
   {
       
      
      private var var_1629:MeMenuWidget;
      
      private var _window:IWindowContainer;
      
      public function MeMenuChatSettingsView()
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
         var _loc2_:RoomWidgetStoreSettingsMessage = new RoomWidgetStoreSettingsMessage("RWSSM_STORE_CHAT");
         var _loc1_:class_3398 = _window.findChildByName("prefer_old_chat_checkbox") as class_3398;
         _loc2_.forceOldChat = _loc1_ != null && Boolean(_loc1_.isSelected);
         var_1629.messageListener.processWidgetMessage(_loc2_);
         _window.dispose();
         _window = null;
         var_1629 = null;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:IWindow = null;
         var _loc3_:XmlAsset = var_1629.assets.getAssetByName("memenu_chat_settings") as XmlAsset;
         if(_loc3_)
         {
            _window = var_1629.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct sound settings window from XML!");
         }
         _window.name = param1;
         _loc4_ = 0;
         _loc2_ = null;
         while(_loc4_ < _window.numChildren)
         {
            _loc2_ = _window.getChildAt(_loc4_);
            _loc2_.addEventListener("WME_CLICK",onButtonClicked);
            _loc4_++;
         }
         class_3398(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = var_1629.handler.container.freeFlowChat.isDisabledInPreferences;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = param1.target as IWindow;
         var _loc3_:String = _loc2_.name;
         var _loc4_:* = _loc3_;
         if("back_btn" === _loc4_)
         {
            var_1629.changeView("me_menu_settings_view");
         }
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
   }
}
