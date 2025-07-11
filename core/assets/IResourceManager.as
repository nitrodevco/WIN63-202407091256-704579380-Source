package com.sulake.core.assets
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface IResourceManager extends IDisposable
   {
       
      
      function createAsset(param1:String, param2:Class, param3:Object) : IAsset;
      
      function retrieveAsset(param1:String, param2:class_3607) : void;
      
      function isSameAsset(param1:String, param2:String) : Boolean;
      
      function removeAsset(param1:String) : void;
   }
}
