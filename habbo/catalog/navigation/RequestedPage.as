package com.sulake.habbo.catalog.navigation
{
   public class RequestedPage
   {
      
      public static const REQUEST_TYPE_NONE:int = 0;
      
      public static const REQUEST_TYPE_ID:int = 1;
      
      public static const REQUEST_TYPE_NAME:int = 2;
       
      
      private var var_2579:int;
      
      private var var_597:int;
      
      private var var_900:int;
      
      private var _requestName:String;
      
      public function RequestedPage()
      {
         super();
         var_2579 = 0;
      }
      
      public function set requestById(param1:int) : void
      {
         var_2579 = 1;
         var_597 = param1;
      }
      
      public function set requestByName(param1:String) : void
      {
         var_2579 = 2;
         _requestName = param1;
      }
      
      public function resetRequest() : void
      {
         var_2579 = 0;
         var_900 = -1;
      }
      
      public function get requestType() : int
      {
         return var_2579;
      }
      
      public function get requestId() : int
      {
         return var_597;
      }
      
      public function get requestedOfferId() : int
      {
         return var_900;
      }
      
      public function set requestedOfferId(param1:int) : void
      {
         var_900 = param1;
      }
      
      public function get requestName() : String
      {
         return _requestName;
      }
   }
}
