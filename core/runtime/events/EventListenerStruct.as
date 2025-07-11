package com.sulake.core.runtime.events
{
   import flash.utils.Dictionary;
   
   public class EventListenerStruct
   {
       
      
      private var var_41:Dictionary;
      
      public var useCapture:Boolean;
      
      public var priority:int;
      
      public var useWeakReference:Boolean;
      
      public function EventListenerStruct(param1:Function, param2:Boolean = false, param3:int = 0, param4:Boolean = false)
      {
         super();
         var_41 = new Dictionary(param4);
         this.callback = param1;
         this.useCapture = param2;
         this.priority = param3;
         this.useWeakReference = param4;
      }
      
      public function set callback(param1:Function) : void
      {
         for(var _loc2_ in var_41)
         {
            delete var_41[_loc2_];
         }
         var_41[param1] = null;
      }
      
      public function get callback() : Function
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = var_41;
         for(var _loc1_ in _loc2_)
         {
            return _loc1_ as Function;
         }
         return null;
      }
   }
}
