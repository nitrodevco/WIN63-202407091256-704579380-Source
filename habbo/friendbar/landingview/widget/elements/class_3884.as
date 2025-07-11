package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class class_3884 extends class_3879
   {
       
      
      private var var_445:String;
      
      private var var_3846:String;
      
      public function class_3884()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_445 = param3[2];
         var_3846 = param4.configurationCode;
      }
      
      override protected function onClick() : void
      {
         landingView.context.createLinkEvent(var_445);
         landingView.tracking.trackEventLog("LandingView",var_3846,"client_link",var_445);
      }
   }
}
