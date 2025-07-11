package com.sulake.habbo.friendbar.view.tabs.tokens
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.motion.DropBounce;
   import com.sulake.core.window.motion.class_3596;
   import com.sulake.habbo.friendbar.data.IFriendNotification;
   import com.sulake.habbo.game.class_1805;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.geom.Rectangle;
   
   public class Token implements IDisposable
   {
      
      protected static var _WINDOW_MANAGER:IHabboWindowManager;
      
      protected static var var_4557:IAssetLibrary;
      
      protected static var _GAMES:class_1805;
      
      protected static const TITLE:String = "title";
      
      protected static const MESSAGE:String = "message";
      
      protected static const ICON_RECTANGLE:Rectangle = new Rectangle(0,0,25,25);
       
      
      protected var _icon:IRegionWindow;
      
      protected var _window:IWindowContainer;
      
      protected var _disposed:Boolean;
      
      protected var var_3274:IFriendNotification;
      
      public function Token(param1:IFriendNotification)
      {
         super();
         var_3274 = param1;
      }
      
      public static function set WINDOWING(param1:IHabboWindowManager) : void
      {
         _WINDOW_MANAGER = param1;
      }
      
      public static function set ASSETS(param1:IAssetLibrary) : void
      {
         var_4557 = param1;
      }
      
      public static function set GAMES(param1:class_1805) : void
      {
         _GAMES = param1;
      }
      
      public function get typeCode() : int
      {
         return var_3274.typeCode;
      }
      
      public function get viewOnce() : Boolean
      {
         return var_3274.viewOnce;
      }
      
      public function get notification() : IFriendNotification
      {
         return var_3274;
      }
      
      public function get iconElement() : IWindow
      {
         return _icon;
      }
      
      public function get windowElement() : IWindow
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(_icon)
         {
            _icon.dispose();
            _icon = null;
         }
         var_3274 = null;
         _disposed = true;
      }
      
      protected function prepare(param1:String, param2:String, param3:String, param4:String) : void
      {
         _window = _WINDOW_MANAGER.buildFromXML(var_4557.getAssetByName(param3).content as XML) as IWindowContainer;
         _window.findChildByName("title").caption = param1;
         _window.findChildByName("message").caption = !!param2 ? param2 : "";
         _icon = _WINDOW_MANAGER.create("ICON_" + typeCode,5,0,1,Token.ICON_RECTANGLE) as IRegionWindow;
         _icon.mouseThreshold = 0;
         var _loc5_:IStaticBitmapWrapperWindow;
         (_loc5_ = _WINDOW_MANAGER.create("BITMAP_" + typeCode,23,0,0,Token.ICON_RECTANGLE) as IStaticBitmapWrapperWindow).assetUri = param4;
         _icon.addChild(_loc5_);
         if(class_3596.getMotionByTarget(_icon) == null)
         {
            class_3596.runMotion(new DropBounce(_icon,600,32));
         }
      }
   }
}
