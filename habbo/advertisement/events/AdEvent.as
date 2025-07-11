package com.sulake.habbo.advertisement.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class AdEvent extends Event
   {
      
      public static const ROOM_AD_IMAGE_LOADED:String = "AE_ROOM_AD_IMAGE_LOADED";
      
      public static const ROOM_AD_IMAGE_LOADING_FAILED:String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
      
      public static const ROOM_AD_SHOW:String = "AE_ROOM_AD_SHOW";
       
      
      private var var_859:BitmapData;
      
      private var var_369:int;
      
      private var var_406:String;
      
      private var var_3950:String;
      
      private var var_4710:BitmapData;
      
      private var var_4653:BitmapData;
      
      private var var_455:int;
      
      private var var_1114:int;
      
      public function AdEvent(param1:String, param2:int, param3:BitmapData = null, param4:String = "", param5:String = "", param6:BitmapData = null, param7:BitmapData = null, param8:int = -1, param9:int = -1, param10:Boolean = false, param11:Boolean = false)
      {
         super(param1,param10,param11);
         var_859 = param3;
         var_369 = param2;
         var_406 = param4;
         var_3950 = param5;
         var_4710 = param6;
         var_4653 = param7;
         var_455 = param8;
         var_1114 = param9;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get imageUrl() : String
      {
         return var_406;
      }
      
      public function get clickUrl() : String
      {
         return var_3950;
      }
      
      public function get adWarningL() : BitmapData
      {
         return var_4710;
      }
      
      public function get adWarningR() : BitmapData
      {
         return var_4653;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get objectCategory() : int
      {
         return var_1114;
      }
   }
}
