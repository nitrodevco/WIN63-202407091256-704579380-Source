package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_3892 extends class_3879
   {
       
      
      private var var_369:int;
      
      public function class_3892()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_369 = int(param3[2]);
      }
      
      override protected function onClick() : void
      {
         landingView.navigator.goToPrivateRoom(var_369);
         landingView.tracking.trackGoogle("landingView","click_gotoroom");
      }
   }
}
