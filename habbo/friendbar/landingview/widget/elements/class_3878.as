package com.sulake.habbo.friendbar.landingview.widget.elements
{
    import assets.class_14

    import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_3878 implements IElementHandler
   {
       
      
      public function class_3878()
      {
         super();
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         var _loc8_:String = String(param3[2]);
         var _loc5_:IWindowContainer;
         (_loc5_ = IWindowContainer(param2)).findChildByName("badge_desc").caption = "";
         var _loc6_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_loc5_.findChildByName("badge_image"));
         var _loc7_:String = "${image.library.url}album1584/" + param3[1] + ".png";
         class_14.log("IMAGE: " + _loc7_);
         _loc6_.assetUri = _loc7_;
      }
      
      public function refresh() : void
      {
      }
   }
}
