package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.friendbar.data.IHabboFriendBarData;
   import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
   import com.sulake.habbo.friendbar.view.utils.TextCropper;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.class_1805;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.geom.Point;
   
   public class Tab implements ITab
   {
      
      public static var WIDTH:int = 127;
      
      public static var HEIGHT:int = 36;
      
      public static var DATA:IHabboFriendBarData;
      
      public static var FRIENDS:IHabboFriendList;
      
      public static var GAMES:class_1805;
      
      public static var VIEW:IHabboFriendBarView;
      
      public static var ASSETS:IAssetLibrary;
      
      public static var WINDOWING:IHabboWindowManager;
      
      public static var var_1924:IHabboLocalizationManager;
      
      public static var TRACKING:IHabboTracking;
      
      public static var CROPPER:TextCropper;
      
      protected static const const_884:Boolean = false;
      
      protected static const _MOTION_TIME:int = 80;
      
      protected static const const_619:int = 3;
       
      
      protected var _window:IWindowContainer;
      
      protected var var_1708:Boolean;
      
      private var var_3625:Boolean;
      
      private var _selected:Boolean;
      
      private var _disposed:Boolean;
      
      public function Tab()
      {
         super();
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get recycled() : Boolean
      {
         return var_1708;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function get exposed() : Boolean
      {
         return var_3625;
      }
      
      public function select(param1:Boolean) : void
      {
         conceal();
         _selected = true;
      }
      
      public function deselect(param1:Boolean) : void
      {
         _selected = false;
      }
      
      public function recycle() : void
      {
         conceal();
         var_1708 = true;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            _disposed = true;
         }
      }
      
      protected function expose() : void
      {
         var_3625 = true;
      }
      
      protected function conceal() : void
      {
         var_3625 = false;
      }
      
      protected function onMouseClick(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled)
         {
            return;
         }
         if(selected)
         {
            VIEW.deSelect(true);
         }
         else
         {
            VIEW.selectTab(this,true);
         }
      }
      
      protected function onMouseOver(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled)
         {
            return;
         }
         if(!selected)
         {
            expose();
         }
      }
      
      protected function onMouseOut(param1:WindowMouseEvent) : void
      {
         if(disposed || recycled || _window == null)
         {
            return;
         }
         if(!selected)
         {
            if(!_window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               conceal();
            }
         }
      }
   }
}
