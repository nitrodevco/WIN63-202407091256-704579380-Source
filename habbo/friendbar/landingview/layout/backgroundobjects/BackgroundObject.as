package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import flash.events.EventDispatcher;
   
   public class BackgroundObject implements IDisposable, IUpdateReceiver
   {
       
      
      private var var_280:int;
      
      private var _window:IWindow;
      
      private var name_1:EventDispatcher;
      
      private var var_2342:IStaticBitmapWrapperWindow;
      
      public function BackgroundObject(param1:int, param2:IWindowContainer, param3:EventDispatcher, param4:HabboLandingView, param5:String, param6:Boolean = false)
      {
         super();
         var_280 = param1;
         _window = param2;
         name_1 = param3;
         if(param6)
         {
            var_2342 = IStaticBitmapWrapperWindow(param4.getXmlWindow("moving_object"));
         }
         else
         {
            var_2342 = IStaticBitmapWrapperWindow(param4.getXmlWindow("moving_object_floating"));
         }
         param2.addChild(var_2342);
      }
      
      public function dispose() : void
      {
         _window = null;
         var_2342 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function set sprite(param1:IStaticBitmapWrapperWindow) : void
      {
         var_2342 = param1;
      }
      
      public function get sprite() : IStaticBitmapWrapperWindow
      {
         return var_2342;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function set window(param1:IWindow) : void
      {
         _window = param1;
      }
      
      public function get events() : EventDispatcher
      {
         return name_1;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function update(param1:uint) : void
      {
         if(!var_2342)
         {
            return;
         }
      }
   }
}
