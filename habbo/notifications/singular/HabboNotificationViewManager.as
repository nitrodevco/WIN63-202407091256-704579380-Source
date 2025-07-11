package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.Event;
   
   public class HabboNotificationViewManager implements IUpdateReceiver
   {
      
      private static const SPACING:int = 4;
       
      
      private var var_2286:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _notifications:HabboNotifications;
      
      private var _styleConfig:Map;
      
      private var _viewConfig:Map;
      
      private var _disposed:Boolean = false;
      
      private var _viewItems:Array;
      
      public function HabboNotificationViewManager(param1:HabboNotifications, param2:IAssetLibrary, param3:IHabboWindowManager, param4:IHabboToolbar, param5:Map, param6:Map)
      {
         super();
         _notifications = param1;
         var_2286 = param2;
         _windowManager = param3;
         _toolbar = param4;
         _styleConfig = param5;
         _viewConfig = param6;
         _viewItems = [];
         if(_toolbar)
         {
            _toolbar.events.addEventListener("EVE_EXTENSION_VIEW_RESIZED",refreshTopMargin);
         }
         _notifications.registerUpdateReceiver(this,2);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function replaceIcon(param1:BadgeImageReadyEvent) : void
      {
         for each(var _loc2_ in _viewItems)
         {
            _loc2_.replaceIcon(param1);
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(_viewItems.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            (_viewItems.pop() as HabboNotificationItemView).dispose();
            _loc2_++;
         }
         var_2286 = null;
         _windowManager = null;
         if(_styleConfig)
         {
            _styleConfig.dispose();
            _styleConfig = null;
         }
         if(_viewConfig)
         {
            _viewConfig.dispose();
            _viewConfig = null;
         }
         if(_toolbar)
         {
            _toolbar.events.removeEventListener("EVE_EXTENSION_VIEW_RESIZED",refreshTopMargin);
            _toolbar = null;
         }
         if(_notifications != null)
         {
            _notifications.removeUpdateReceiver(this);
            _notifications = null;
         }
         _disposed = true;
      }
      
      public function showItem(param1:HabboNotificationItem) : Boolean
      {
         if(!isSpaceAvailable())
         {
            return false;
         }
         var _loc2_:HabboNotificationItemView = new HabboNotificationItemView(var_2286.getAssetByName("layout_notification_xml"),_windowManager,_styleConfig,_viewConfig,param1);
         _loc2_.reposition(getNextAvailableVerticalPosition());
         _viewItems.push(_loc2_);
         _viewItems.sortOn("verticalPosition",16);
         return true;
      }
      
      public function isSpaceAvailable() : Boolean
      {
         return getNextAvailableVerticalPosition() + 70 < _windowManager.getDesktop(0).height;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:HabboNotificationItemView = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            (_viewItems[_loc3_] as HabboNotificationItemView).update(param1);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            _loc2_ = _viewItems[_loc3_] as HabboNotificationItemView;
            if(_loc2_.ready)
            {
               _loc2_.dispose();
               _viewItems.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      private function getNextAvailableVerticalPosition() : int
      {
         var _loc3_:int = 0;
         var _loc1_:HabboNotificationItemView = null;
         if(!_toolbar)
         {
            return 4;
         }
         if(!_toolbar.extensionView)
         {
            return 4;
         }
         var _loc2_:int = _toolbar.extensionView.screenHeight + 4;
         if(_viewItems.length == 0)
         {
            return _loc2_;
         }
         var _loc4_:* = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            _loc1_ = _viewItems[_loc3_] as HabboNotificationItemView;
            if(_loc4_ + 70 < _loc1_.verticalPosition)
            {
               return _loc4_;
            }
            _loc4_ = _loc1_.verticalPosition + 70 + 4;
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function refreshTopMargin(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:HabboNotificationItemView = null;
         var _loc3_:int = _toolbar.extensionView.screenHeight + 4;
         _loc4_ = 0;
         while(_loc4_ < _viewItems.length)
         {
            _loc2_ = _viewItems[_loc4_] as HabboNotificationItemView;
            _loc2_.reposition(_loc3_);
            _loc3_ = _loc2_.verticalPosition + 70 + 4;
            _loc4_++;
         }
      }
   }
}
