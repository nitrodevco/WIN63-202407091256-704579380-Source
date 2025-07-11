package com.sulake.habbo.notifications.feed.data
{
   import flash.display.BitmapData;
   
   public class GenericNotificationItemData
   {
       
      
      private var var_617:String;
      
      private var var_781:int;
      
      private var var_363:String;
      
      private var var_4406:BitmapData;
      
      private var var_2298:BitmapData;
      
      private var var_4185:String;
      
      private var var_4478:String;
      
      public function GenericNotificationItemData()
      {
         super();
      }
      
      public function get title() : String
      {
         return var_617;
      }
      
      public function get timeStamp() : int
      {
         return var_781;
      }
      
      public function get description() : String
      {
         return var_363;
      }
      
      public function get decorationImage() : BitmapData
      {
         return var_4406;
      }
      
      public function get iconImage() : BitmapData
      {
         return var_2298;
      }
      
      public function get buttonAction() : String
      {
         return var_4185;
      }
      
      public function get buttonCaption() : String
      {
         return var_4478;
      }
      
      public function set title(param1:String) : void
      {
         var_617 = param1;
      }
      
      public function set timeStamp(param1:int) : void
      {
         var_781 = param1;
      }
      
      public function set description(param1:String) : void
      {
         var_363 = param1;
      }
      
      public function set decorationImage(param1:BitmapData) : void
      {
         var_4406 = param1;
      }
      
      public function set iconImage(param1:BitmapData) : void
      {
         var_2298 = param1;
      }
      
      public function set buttonAction(param1:String) : void
      {
         var_4185 = param1;
      }
      
      public function set buttonCaption(param1:String) : void
      {
         var_4478 = param1;
      }
   }
}
