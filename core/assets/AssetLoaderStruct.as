package com.sulake.core.assets
{
   import com.sulake.core.assets.loaders.class_36;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   
   public class AssetLoaderStruct extends EventDispatcherWrapper implements IDisposable
   {
       
      
      private var var_174:class_36;
      
      private var _assetName:String;
      
      public function AssetLoaderStruct(param1:String, param2:class_36)
      {
         super();
         _assetName = param1;
         var_174 = param2;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get assetLoader() : class_36
      {
         return var_174;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_174 != null)
            {
               if(!var_174.disposed)
               {
                  var_174.dispose();
                  var_174 = null;
               }
            }
            super.dispose();
         }
      }
   }
}
