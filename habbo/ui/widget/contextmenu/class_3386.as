package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public interface class_3386
   {
       
      
      function get assets() : IAssetLibrary;
      
      function get windowManager() : IHabboWindowManager;
      
      function get messageListener() : IRoomWidgetMessageListener;
      
      function get catalog() : IHabboCatalog;
      
      function get friendList() : IHabboFriendList;
      
      function removeView(param1:ContextInfoView, param2:Boolean) : void;
   }
}
