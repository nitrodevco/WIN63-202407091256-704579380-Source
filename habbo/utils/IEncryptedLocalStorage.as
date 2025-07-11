package com.sulake.habbo.utils
{
   public interface IEncryptedLocalStorage
   {
       
      
      function reset() : void;
      
      function storeString(param1:String, param2:String) : Boolean;
      
      function restoreString(param1:String) : String;
   }
}
