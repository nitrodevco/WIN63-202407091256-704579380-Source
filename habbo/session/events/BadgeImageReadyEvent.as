package com.sulake.habbo.session.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class BadgeImageReadyEvent extends Event
   {
      
      public static const BADGE_READY:String = "BIRE_BADGE_IMAGE_READY";
       
      
      private var var_372:String;
      
      private var var_859:BitmapData;
      
      public function BadgeImageReadyEvent(param1:String, param2:BitmapData, param3:Boolean = false, param4:Boolean = false)
      {
         super("BIRE_BADGE_IMAGE_READY",param3,param4);
         var_372 = param1;
         var_859 = param2;
      }
      
      public function get badgeId() : String
      {
         return var_372;
      }
      
      public function get badgeImage() : BitmapData
      {
         return var_859;
      }
   }
}
