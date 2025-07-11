package com.sulake.core.utils.debug
{
   import com.sulake.core.runtime.IDisposable;
   import flash.utils.Dictionary;
   
   public class GarbageMonitor implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var var_2830:Dictionary;
      
      public function GarbageMonitor()
      {
         super();
         var_2830 = new Dictionary(true);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            for each(var _loc1_ in var_2830)
            {
               delete var_2830[_loc1_];
            }
            var_2830 = null;
            _disposed = true;
         }
      }
      
      public function insert(param1:Object, param2:String = null) : void
      {
         var_2830[param1] = param2 == null ? param1.toString() : param2;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get list() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in var_2830)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
   }
}
