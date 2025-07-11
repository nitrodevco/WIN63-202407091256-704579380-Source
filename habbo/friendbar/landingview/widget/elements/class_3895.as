package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class class_3895 extends class_3879
   {
       
      
      public function class_3895()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.catalog.openClubCenter();
         landingView.tracking.trackGoogle("landingView","click_buyVip");
      }
   }
}
