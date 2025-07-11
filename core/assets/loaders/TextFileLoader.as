package com.sulake.core.assets.loaders
{
   import com.probertson.utils.class_726;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class TextFileLoader extends BinaryFileLoader implements class_36
   {
       
      
      public function TextFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super(param1,param2,param3);
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
               }
               catch(e:Error)
               {
               }
               var_16.load(new URLRequest(var_96 + (var_96.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_51));
               return true;
            }
         }
         return false;
      }
      
      override protected function loadEventHandler(param1:Event) : void
      {
         if(param1.type == "complete")
         {
            unCompress();
         }
         super.loadEventHandler(param1);
      }
      
      private function unCompress() : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:class_726 = null;
         var _loc1_:String = "";
         if(var_16.data is ByteArray)
         {
            _loc2_ = var_16.data as ByteArray;
            if(_loc2_.length == 0)
            {
               _loc1_ = "";
            }
            else
            {
               try
               {
                  _loc3_ = new class_726();
                  _loc1_ = _loc3_.uncompressToByteArray(_loc2_).toString();
               }
               catch(error:IllegalOperationError)
               {
                  _loc2_.position = 0;
                  _loc1_ = _loc2_.readUTFBytes(_loc2_.length);
               }
            }
            _loc2_.position = 0;
         }
         else
         {
            _loc1_ = var_16.data as String;
         }
         var_16.data = _loc1_;
      }
   }
}
