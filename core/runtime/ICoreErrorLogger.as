package com.sulake.core.runtime
{
   [SecureSWF(rename="true")]
   public interface ICoreErrorLogger
   {
       
      
      function logCrash(param1:String) : void;
      
      function logError(param1:String) : void;
   }
}
