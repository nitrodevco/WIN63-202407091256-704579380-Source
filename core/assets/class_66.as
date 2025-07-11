package com.sulake.core.assets
{
   import com.sulake.core.class_79;
   import com.sulake.core.runtime.IUpdateReceiver;
   
   public class class_66 implements IUpdateReceiver
   {
       
      
      private var var_81:Vector.<ILazyAsset>;
      
      private var var_92:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function class_66()
      {
         var_81 = new Vector.<ILazyAsset>();
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            class_79.instance.removeUpdateReceiver(this);
            var_81 = null;
            var_92 = false;
            _disposed = true;
         }
      }
      
      public function push(param1:ILazyAsset) : void
      {
         if(param1)
         {
            var_81.push(param1);
            if(!var_92)
            {
               class_79.instance.registerUpdateReceiver(this,2);
               var_92 = true;
            }
         }
      }
      
      public function flush() : void
      {
         for each(var _loc1_ in var_81)
         {
            if(!_loc1_.disposed)
            {
               _loc1_.prepareLazyContent();
            }
         }
         var_81 = new Vector.<ILazyAsset>();
         if(var_92)
         {
            class_79.instance.removeUpdateReceiver(this);
            var_92 = false;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:ILazyAsset = var_81.shift();
         if(!_loc2_)
         {
            if(var_92)
            {
               class_79.instance.removeUpdateReceiver(this);
               var_92 = false;
            }
         }
         else if(!_loc2_.disposed)
         {
            _loc2_.prepareLazyContent();
         }
      }
   }
}
