package com.sulake.core.assets.loaders
{
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class SoundFileLoader extends class_37 implements class_36
   {
       
      
      protected var var_96:String;
      
      protected var var_329:String;
      
      protected var var_36:Sound;
      
      private var var_280:int;
      
      public function SoundFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_96 = param2 == null ? "" : param2.url;
         var_329 = param1;
         var_36 = new Sound(null,null);
         var_36.addEventListener("id3",loadEventHandler);
         var_36.addEventListener("open",loadEventHandler);
         var_36.addEventListener("complete",loadEventHandler);
         var_36.addEventListener("ioError",loadEventHandler);
         var_36.addEventListener("progress",loadEventHandler);
         var_280 = param3;
         if(param2 != null)
         {
            this.load(param2);
         }
      }
      
      public function get url() : String
      {
         return var_96;
      }
      
      public function get content() : Object
      {
         return var_36;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         var_36.extract(_loc1_,var_36.length);
         return _loc1_;
      }
      
      public function get mimeType() : String
      {
         return var_329;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!var_36 ? var_36.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!var_36 ? var_36.bytesTotal : 0;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_36.removeEventListener("id3",loadEventHandler);
            var_36.removeEventListener("open",loadEventHandler);
            var_36.removeEventListener("complete",loadEventHandler);
            var_36.removeEventListener("ioError",loadEventHandler);
            var_36.removeEventListener("progress",loadEventHandler);
            var_36 = null;
            var_329 = null;
            var_96 = null;
            super.dispose();
         }
      }
      
      public function load(param1:URLRequest) : void
      {
         var_96 = param1.url;
         var_36.load(param1,null);
      }
   }
}
