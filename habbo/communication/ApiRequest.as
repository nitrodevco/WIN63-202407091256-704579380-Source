package com.sulake.habbo.communication
{
    import assets.class_14

    import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ApiRequest
   {
      
      public static const ERROR_TYPE_INVALID_CAPTCHA:String = "invalid-captcha";
       
      
      private var var_85:IApiListener;
      
      private var var_252:URLRequest;
      
      private var _uri:String;
      
      private var var_107:String;
      
      private var _currentStatus:int;
      
      public function ApiRequest(param1:String, param2:String)
      {
         super();
         _uri = param2;
         var_107 = param1;
      }
      
      public function get uri() : String
      {
         return _uri;
      }
      
      public function get requestMethod() : String
      {
         return var_107;
      }
      
      public function dispose() : void
      {
         var_85 = null;
         var_252 = null;
         _uri = null;
         var_107 = null;
         _currentStatus = 0;
      }
      
      public function makeRequest(param1:IApiListener, param2:URLRequest) : void
      {
         param2.method = var_107;
         var_252 = param2;
         var_85 = param1;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = "text";
         configureListeners(_loc3_);
         try
         {
            class_14.log("[ApiRequest] Make request: " + param2.url + " for " + _uri);
            _loc3_.load(param2);
         }
         catch(error:Error)
         {
            class_14.log("[ApiRequest] Unable to load requested document.");
         }
      }
      
      private function configureListeners(param1:IEventDispatcher) : void
      {
         param1.addEventListener("complete",completeHandler);
         param1.addEventListener("open",openHandler);
         param1.addEventListener("progress",progressHandler);
         param1.addEventListener("securityError",securityErrorHandler);
         param1.addEventListener("httpStatus",httpStatusHandler);
         param1.addEventListener("ioError",ioErrorHandler);
      }
      
      private function removeListeners(param1:IEventDispatcher) : void
      {
         param1.removeEventListener("complete",completeHandler);
         param1.removeEventListener("open",openHandler);
         param1.removeEventListener("progress",progressHandler);
         param1.removeEventListener("securityError",securityErrorHandler);
         param1.removeEventListener("httpStatus",httpStatusHandler);
         param1.removeEventListener("ioError",ioErrorHandler);
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Object = null;
         var _loc7_:Boolean = false;
         var _loc4_:URLLoader = URLLoader(param1.target);
         removeListeners(_loc4_);
         if(var_85)
         {
            _loc6_ = (_loc5_ = _loc4_.data as String) && (_loc5_.charAt(0) == "{" || _loc5_.charAt(0) == "[");
            _loc2_ = _loc5_ && _loc5_.charAt(0) == "<";
            try
            {
               if(_loc6_)
               {
                  _loc3_ = JSON.parse(_loc5_);
               }
               else if(_loc2_)
               {
                  _loc3_ = new XML(_loc5_);
               }
               if(_currentStatus >= 400 || _loc6_ && _loc3_.error != null)
               {
                  _loc7_ = false;
                  if(_loc6_)
                  {
                     _loc7_ = _loc3_.error == "invalid-captcha" || _loc3_.message == "invalid-captcha";
                  }
                  var_85.apiError(_uri,_currentStatus,_loc6_ ? _loc3_.error : "",_loc3_,_loc7_);
               }
               else
               {
                  var_85.apiResponse(_uri,_loc3_);
               }
            }
            catch(e:Error)
            {
               class_14.log("JSON parsing for API Request message failed. Data: " + _loc4_.data + " Error: " + e.errorID,e.name,e.message,e.getStackTrace());
               var_85.apiRawResponse(_uri,_loc4_.data);
            }
         }
      }
      
      private function openHandler(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         class_14.log("[ApiRequest] securityErrorHandler: " + param1);
         if(var_85 != null)
         {
            var_85.apiError(_uri,-1,"securityError",null);
         }
         removeListeners(_loc2_);
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         _currentStatus = param1.status;
         switch(param1.status)
         {
            case 200:
            case 403:
               break;
            case 404:
               class_14.log("[ApiRequest - 404] httpStatusHandler: Resource does not exist. " + _uri,var_107,var_252.url);
               break;
            case 409:
               class_14.log("[ApiRequest - 409] httpStatusHandler: Conflict. " + _uri,var_107,var_252.url,_loc2_);
               break;
            case 500:
               class_14.log("[ApiRequest - 500] httpStatusHandler: Internal server error. " + _uri,var_107,_loc2_);
               break;
            default:
               class_14.log("[ApiRequest - " + param1.status + "] httpStatusHandler: undhandled. " + _uri,var_107,var_252.url);
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc5_:URLLoader = URLLoader(param1.target);
         removeListeners(_loc5_);
         if(var_85 != null)
         {
            _loc3_ = {"message":_loc5_.data};
            _loc4_ = false;
            if(_loc5_.data)
            {
               try
               {
                  _loc7_ = (_loc6_ = _loc5_.data) && (_loc6_.charAt(0) == "{" || _loc6_.charAt(0) == "[");
                  _loc2_ = _loc6_ && _loc6_.charAt(0) == "<";
                  _loc3_ = _loc7_ ? JSON.parse(_loc5_.data) : _loc5_.data;
                  if(_loc7_)
                  {
                     if(_loc3_.captcha != null && _loc3_.captcha is Boolean)
                     {
                        _loc4_ = Boolean(_loc3_.captcha);
                     }
                  }
               }
               catch(e:Error)
               {
                  class_14.log("JSON parsing for Api Request ioError. Data: " + _loc5_.data);
               }
            }
            var_85.apiError(_uri,-2,"ioError",_loc3_,_loc4_);
         }
      }
   }
}
