package com.sulake.core.runtime.events
{
   public class ErrorEvent extends WarningEvent
   {
       
      
      protected var var_638:int;
      
      protected var var_1300:Boolean;
      
      protected var var_176:Error;
      
      public function ErrorEvent(param1:String, param2:String, param3:Boolean, param4:int, param5:Error = null)
      {
         var_1300 = param3;
         var_638 = param4;
         var_176 = param5;
         super(param1,param2);
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get critical() : Boolean
      {
         return var_1300;
      }
      
      public function get error() : Error
      {
         return var_176;
      }
   }
}
