package com.sulake.core.assets.loaders
{
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class ZipFileLoader extends class_37 implements class_36
   {
       
      
      protected var var_96:String;
      
      protected var var_329:String;
      
      protected var var_35:URLStream;
      
      protected var var_47:ByteArray;
      
      private var var_280:int;
      
      public function ZipFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_96 = param2 == null ? "" : param2.url;
         var_329 = param1;
         var_35 = new URLStream();
         var_35.addEventListener("complete",loadEventHandler);
         var_35.addEventListener("httpStatus",loadEventHandler);
         var_35.addEventListener("ioError",loadEventHandler);
         var_35.addEventListener("open",loadEventHandler);
         var_35.addEventListener("progress",loadEventHandler);
         var_35.addEventListener("securityError",loadEventHandler);
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
         return !!var_47 ? var_47 : var_35;
      }
      
      public function get bytes() : ByteArray
      {
         if(var_47)
         {
            return var_47;
         }
         var _loc1_:ByteArray = new ByteArray();
         var_35.readBytes(_loc1_);
         return _loc1_;
      }
      
      public function get mimeType() : String
      {
         return var_329;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_35.bytesAvailable;
      }
      
      public function get bytesTotal() : uint
      {
         return var_35.bytesAvailable;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function load(param1:URLRequest) : void
      {
         var_96 = param1.url;
         var_35.load(param1);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_35.removeEventListener("complete",loadEventHandler);
            var_35.removeEventListener("httpStatus",loadEventHandler);
            var_35.removeEventListener("ioError",loadEventHandler);
            var_35.removeEventListener("open",loadEventHandler);
            var_35.removeEventListener("progress",loadEventHandler);
            var_35.removeEventListener("securityError",loadEventHandler);
            var_35.close();
            var_35 = null;
            var_329 = null;
            var_96 = null;
         }
      }
   }
}
