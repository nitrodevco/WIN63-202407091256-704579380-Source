package com.sulake.habbo.communication
{
   public class WebApiRequest extends ApiRequest
   {
       
      
      private var var_1403:Boolean;
      
      public function WebApiRequest(param1:String, param2:String, param3:Boolean = true)
      {
         var_1403 = param3;
         super(param2,param1);
      }
      
      public function get requiresSession() : Boolean
      {
         return var_1403;
      }
   }
}
