package com.sulake.habbo.notifications.feed
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.notifications.feed.view.content.FeedEntity;
   import com.sulake.habbo.notifications.feed.view.content.class_3603;
   import com.sulake.habbo.notifications.feed.view.pane.AbstractPane;
   import com.sulake.habbo.notifications.feed.view.pane.InfoPane;
   import com.sulake.habbo.notifications.feed.view.pane.NotificationsPane;
   import com.sulake.habbo.notifications.feed.view.pane.SettingsPane;
   import com.sulake.habbo.notifications.feed.view.pane.StatusPane;
   import com.sulake.habbo.notifications.feed.view.pane.StreamPane;
   import com.sulake.habbo.notifications.feed.view.pane.class_3674;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class NotificationView
   {
      
      public static const VIEW_PANE_FEEDS:String = "pane_feeds";
      
      public static const VIEW_PANE_NOTIFICATIONS:String = "pane_notifications";
      
      public static const VIEW_PANE_STREAM:String = "pane_stream";
      
      public static const VIEW_PANE_SETTINGS:String = "pane_settings";
      
      public static const VIEW_PANE_INFO:String = "pane_info";
      
      public static const VIEW_PANE_STATUS:String = "pane_status";
      
      private static const const_1123:String = "settings_toggle";
      
      private static const ELEMENT_INFO:String = "info_toggle";
       
      
      private var var_2477:StateController;
      
      private var var_1660:HabboNotifications;
      
      private var var_319:NotificationController;
      
      private var _window:IWindowContainer;
      
      private var var_1868:Map;
      
      public function NotificationView(param1:NotificationController, param2:HabboNotifications)
      {
         super();
         var_319 = param1;
         var_1660 = param2;
         var_2477 = new StateController();
         FeedEntity.assignHandles(windowManager,assets,localization,param1);
         setupUserInterface();
         closePaneLevel(2);
         switchToPane("pane_notifications");
         setVisibilityState(1);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1868)
         {
            for each(var _loc1_ in var_1868)
            {
               _loc1_.dispose();
            }
            var_1868.dispose();
            var_1868 = null;
         }
         FeedEntity.removeHandles();
         var_319 = null;
         var_2477 = null;
         var_1660 = null;
      }
      
      public function get windowManager() : IHabboWindowManager
      {
         return var_1660.windowManager;
      }
      
      public function get assets() : IAssetLibrary
      {
         return var_1660.assets;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return var_1660.localization;
      }
      
      public function get controller() : NotificationController
      {
         return var_319;
      }
      
      private function setupUserInterface() : void
      {
         if(_window)
         {
            return;
         }
         _window = var_1660.windowManager.buildFromXML(var_1660.assets.getAssetByName("feed_display_xml").content as XML) as IWindowContainer;
         _window.height = _window.desktop.height;
         _window.setParamFlag(64);
         _window.setParamFlag(2048);
         _window.findChildByName("settings_toggle").addEventListener("WME_CLICK",onSettingsToggle);
         _window.findChildByName("info_toggle").addEventListener("WME_CLICK",onInfoToggle);
         var_1868 = new Map();
         var_1868.add("pane_notifications",new NotificationsPane("pane_notifications",this,_window.findChildByName("pane_notifications") as IWindowContainer));
         var_1868.add("pane_stream",new StreamPane("pane_stream",this,_window.findChildByName("pane_stream") as IWindowContainer));
         var_1868.add("pane_info",new InfoPane("pane_info",this,_window.findChildByName("pane_info") as IWindowContainer));
         var_1868.add("pane_settings",new SettingsPane("pane_settings",this,_window.findChildByName("pane_settings") as IWindowContainer));
         var_1868.add("pane_status",new StatusPane("pane_status",this,_window.findChildByName("pane_status") as IWindowContainer));
      }
      
      public function toggleMinimized() : void
      {
         switch(var_2477.currentState() - 1)
         {
            case 0:
               setVisibilityState(2);
               break;
            case 1:
               setVisibilityState(1);
         }
      }
      
      public function setVisibilityState(param1:int) : void
      {
         var _loc2_:IWindowContainer = null;
         var _loc3_:int = var_2477.requestState(param1);
         switch(_loc3_)
         {
            case 0:
               _window.x = _window.desktop.width;
               _window.visible = false;
               break;
            case 1:
               _window.visible = true;
               _loc2_ = _window.findChildByName("main_view") as IWindowContainer;
               _window.x = _window.desktop.width - (_window.width - _loc2_.width);
               break;
            case 2:
               _window.visible = true;
               _window.x = _window.desktop.width - _window.width;
         }
      }
      
      public function setViewEnabled(param1:Boolean) : void
      {
         var_2477.setEnabled(param1);
         setVisibilityState(var_2477.currentState());
      }
      
      public function setGameMode(param1:Boolean) : void
      {
         var_2477.setGameMode(param1);
         setVisibilityState(var_2477.currentState());
      }
      
      public function switchToPane(param1:String) : void
      {
         var _loc2_:class_3674 = var_1868.getValue(param1);
         if(!_loc2_)
         {
            return;
         }
         closePaneLevel(_loc2_.paneLevel);
         _loc2_.isVisible = true;
      }
      
      public function closePaneLevel(param1:int) : void
      {
         for each(var _loc2_ in var_1868)
         {
            if(_loc2_.paneLevel == param1)
            {
               _loc2_.isVisible = false;
            }
         }
      }
      
      public function addNotificationFeedItem(param1:int, param2:class_3603) : void
      {
         (var_1868.getValue("pane_notifications") as NotificationsPane).addItem(param1,param2);
      }
      
      public function addStreamFeedItem(param1:class_3603) : void
      {
         (var_1868.getValue("pane_stream") as StreamPane).addItem(param1);
      }
      
      public function removeStreamItems() : void
      {
      }
      
      private function onSettingsToggle(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_3674 = var_1868.getValue("pane_settings") as class_3674;
         if(_loc2_)
         {
            if(_loc2_.isVisible)
            {
               closePaneLevel(2);
            }
            else
            {
               switchToPane("pane_settings");
            }
         }
      }
      
      private function onInfoToggle(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_3674 = var_1868.getValue("pane_info") as class_3674;
         if(_loc2_)
         {
            if(_loc2_.isVisible)
            {
               closePaneLevel(2);
            }
            else
            {
               switchToPane("pane_info");
            }
         }
      }
   }
}
