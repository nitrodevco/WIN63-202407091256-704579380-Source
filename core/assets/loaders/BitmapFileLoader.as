package com.sulake.core.assets.loaders
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.PNGEncoderOptions;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class BitmapFileLoader extends class_37 implements class_36
   {
       
      
      protected var var_96:String;
      
      protected var var_329:String;
      
      protected var var_16:Loader;
      
      protected var var_230:LoaderContext;
      
      private var var_280:int = -1;
      
      public function BitmapFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_96 = param2 == null ? "" : param2.url;
         var_329 = param1;
         var_16 = new Loader();
         var_230 = new LoaderContext();
         var_230.checkPolicyFile = false;
         var_16.contentLoaderInfo.addEventListener("complete",completeEventHandler);
         var_16.contentLoaderInfo.addEventListener("unload",loadEventHandler);
         var_16.contentLoaderInfo.addEventListener("httpStatus",loadEventHandler);
         var_16.contentLoaderInfo.addEventListener("progress",loadEventHandler);
         var_16.contentLoaderInfo.addEventListener("ioError",loadEventHandler);
         var_16.contentLoaderInfo.addEventListener("securityError",loadEventHandler);
         var_280 = param3;
         if(param2 != null && param2.url != null)
         {
            var_16.load(param2,var_230);
         }
      }
      
      public function get url() : String
      {
         return var_96;
      }
      
      public function get content() : Object
      {
         return !!var_16 ? var_16.content : null;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc2_:Bitmap = content as Bitmap;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc1_:BitmapData = _loc2_.bitmapData;
         return _loc1_.encode(_loc1_.rect,new PNGEncoderOptions());
      }
      
      public function get mimeType() : String
      {
         return var_329;
      }
      
      public function get bytesLoaded() : uint
      {
         return !!var_16 ? var_16.contentLoaderInfo.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return !!var_16 ? var_16.contentLoaderInfo.bytesTotal : 0;
      }
      
      public function get loaderContext() : LoaderContext
      {
         return var_230;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function load(param1:URLRequest) : void
      {
         var_96 = param1.url;
         var_51 = 0;
         var_16.load(param1,var_230);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++var_51 <= var_1413)
            {
               try
               {
                  var_16.close();
                  var_16.unload();
               }
               catch(e:Error)
               {
               }
               var_16.load(new URLRequest(var_96 + (var_96.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_51),var_230);
               return true;
            }
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_16.contentLoaderInfo.removeEventListener("complete",completeEventHandler);
            var_16.contentLoaderInfo.removeEventListener("unload",loadEventHandler);
            var_16.contentLoaderInfo.removeEventListener("httpStatus",loadEventHandler);
            var_16.contentLoaderInfo.removeEventListener("progress",loadEventHandler);
            var_16.contentLoaderInfo.removeEventListener("ioError",loadEventHandler);
            var_16.contentLoaderInfo.removeEventListener("securityError",loadEventHandler);
            try
            {
               var_16.close();
            }
            catch(e:*)
            {
            }
            var_16.unload();
            var_16 = null;
            var_329 = null;
            var_96 = null;
         }
      }
      
      private function completeEventHandler(param1:Event) : void
      {
         loadEventHandler(param1);
      }
   }
}
