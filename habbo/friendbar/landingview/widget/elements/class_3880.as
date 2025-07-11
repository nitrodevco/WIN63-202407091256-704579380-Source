package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class class_3880 extends class_3879
   {
       
      
      public function class_3880()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.catalog.openCreditsHabblet();
         landingView.tracking.trackGoogle("landingView","click_credithabblet");
      }
   }
}
