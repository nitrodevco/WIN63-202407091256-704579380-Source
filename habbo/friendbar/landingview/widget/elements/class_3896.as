package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_3896 implements IElementHandler
   {
       
      
      public function class_3896()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         var _loc5_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param2);
         var _loc6_:String = "${image.library.url}" + param3[1];
         _loc5_.assetUri = _loc6_;
         _loc5_.x = int(param3[2]);
      }
      
      public function refresh() : void
      {
      }
   }
}
