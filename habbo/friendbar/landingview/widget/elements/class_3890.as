package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_490;
   
   public class class_3890 extends class_3879
   {
       
      
      private var var_891:String;
      
      public function class_3890()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         var_891 = param3[2];
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         landingView.send(new class_490(var_891));
         landingView.tracking.trackGoogle("landingView","click_gotocompetitionroom");
      }
   }
}
