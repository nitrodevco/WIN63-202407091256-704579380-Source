package com.sulake.core.window.utils
{
   public class class_3835 implements class_3412
   {
       
      
      protected var var_20:Vector.<class_3488>;
      
      public function class_3835()
      {
         var_20 = new Vector.<class_3488>();
         super();
      }
      
      public function get numChildren() : int
      {
         return var_20.length;
      }
      
      public function getChildAt(param1:int) : class_3488
      {
         return var_20[param1];
      }
      
      public function getChildByID(param1:int) : class_3488
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_20)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildByName(param1:String) : class_3488
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_20)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChildIndex(param1:class_3488) : int
      {
         return var_20.indexOf(param1);
      }
      
      public function groupChildrenWithID(param1:uint, param2:Array) : uint
      {
         var _loc4_:* = null;
         var _loc3_:uint = 0;
         for each(_loc4_ in var_20)
         {
            if(_loc4_.id == param1)
            {
               param2.push(_loc4_);
               _loc3_++;
            }
         }
         return _loc3_;
      }
   }
}
