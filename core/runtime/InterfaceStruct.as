package com.sulake.core.runtime
{
   import flash.utils.getQualifiedClassName;
   
   internal final class InterfaceStruct implements IDisposable
   {
       
      
      private var var_323:IID;
      
      private var _iis:String;
      
      private var var_17:IUnknown;
      
      private var var_93:uint;
      
      public function InterfaceStruct(param1:IID, param2:IUnknown)
      {
         super();
         var_323 = param1;
         _iis = getQualifiedClassName(var_323);
         var_17 = param2;
         var_93 = 0;
      }
      
      public function get iid() : IID
      {
         return var_323;
      }
      
      public function get iis() : String
      {
         return _iis;
      }
      
      public function get unknown() : IUnknown
      {
         return var_17;
      }
      
      public function get references() : uint
      {
         return var_93;
      }
      
      public function get disposed() : Boolean
      {
         return var_17 == null;
      }
      
      public function dispose() : void
      {
         var_323 = null;
         _iis = null;
         var_17 = null;
         var_93 = 0;
      }
      
      public function reserve() : uint
      {
         return ++var_93;
      }
      
      public function release() : uint
      {
         return references > 0 ? --var_93 : 0;
      }
   }
}
