package com.sulake.habbo.session
{
   import flash.display.BitmapData;
   
   public class BadgeInfo
   {
       
      
      private var var_859:BitmapData;
      
      private var var_4549:Boolean;
      
      public function BadgeInfo(param1:BitmapData, param2:Boolean)
      {
         super();
         var_859 = param1;
         var_4549 = param2;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
      }
      
      public function get placeHolder() : Boolean
      {
         return var_4549;
      }
   }
}
