package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class class_3881 extends class_3879
   {
       
      
      public function class_3881()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         landingView.navigator.goToHomeRoom();
         landingView.tracking.trackGoogle("landingView","click_gotohomeroom");
      }
   }
}
