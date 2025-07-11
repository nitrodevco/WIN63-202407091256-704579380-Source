package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_3893 extends class_3879
   {
       
      
      private var var_3992:String;
      
      public function class_3893()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.goToRoom(var_3992);
         landingView.tracking.trackGoogle("landingView","click_promotedroom" + var_3992);
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         if(param3.length > 1)
         {
            var_3992 = param3[2];
         }
      }
   }
}
