package com.sulake.core.runtime
{
   [SecureSWF(rename="true")]
   public interface IDisposable
   {
       
      
      function dispose() : void;
      
      function get disposed() : Boolean;
   }
}
