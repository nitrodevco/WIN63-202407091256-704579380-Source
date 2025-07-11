package com.sulake.core.window.utils
{
   public class ChildEntityArray extends class_3835 implements IChildEntityArray
   {
       
      
      public function ChildEntityArray()
      {
         super();
      }
      
      public function removeChild(param1:class_3488) : class_3488
      {
         var _loc2_:int = var_20.indexOf(param1);
         if(_loc2_ < 0)
         {
            return null;
         }
         var_20.splice(_loc2_,1);
         return param1;
      }
      
      public function addChild(param1:class_3488) : class_3488
      {
         var_20.push(param1);
         return param1;
      }
      
      public function addChildAt(param1:class_3488, param2:int) : class_3488
      {
         var_20.splice(param2,0,param1);
         return param1;
      }
      
      public function removeChildAt(param1:int) : class_3488
      {
         var _loc2_:class_3488 = var_20[param1];
         if(_loc2_ != null)
         {
            var_20.splice(param1,1);
            return _loc2_;
         }
         return null;
      }
      
      public function setChildIndex(param1:class_3488, param2:int) : void
      {
         var _loc3_:int = var_20.indexOf(param1);
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            var_20.splice(_loc3_,1);
            var_20.splice(param2,0,param1);
         }
      }
      
      public function swapChildren(param1:class_3488, param2:class_3488) : void
      {
         var _loc3_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = null;
         var _loc4_:* = 0;
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = var_20.indexOf(param1);
            if(_loc3_ < 0)
            {
               return;
            }
            if((_loc6_ = var_20.indexOf(param2)) < 0)
            {
               return;
            }
            if(_loc6_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc4_ = _loc3_;
               _loc3_ = _loc6_;
               _loc6_ = _loc4_;
            }
            var_20.splice(_loc6_,1);
            var_20.splice(_loc3_,1);
            var_20.splice(_loc3_,0,param2);
            var_20.splice(_loc6_,0,param1);
         }
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         swapChildren(var_20[param1],var_20[param2]);
      }
   }
}
