package com.sulake.habbo.utils
{
   public class FixedSizeStack
   {
       
      
      private var var_47:Array;
      
      private var var_3511:int = 0;
      
      private var _index:int = 0;
      
      public function FixedSizeStack(param1:int)
      {
         var_47 = [];
         super();
         var_3511 = param1;
      }
      
      public function reset() : void
      {
         var_47 = [];
         _index = 0;
      }
      
      public function addValue(param1:int) : void
      {
         if(var_47.length < var_3511)
         {
            var_47.push(param1);
         }
         else
         {
            var_47[_index] = param1;
         }
         _index = (_index + 1) % var_3511;
      }
      
      public function getMax() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = -2147483648;
         _loc1_ = 0;
         while(_loc1_ < var_3511)
         {
            if(var_47[_loc1_] > _loc2_)
            {
               _loc2_ = int(var_47[_loc1_]);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function getMin() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 2147483647;
         _loc1_ = 0;
         while(_loc1_ < var_3511)
         {
            if(var_47[_loc1_] < _loc2_)
            {
               _loc2_ = int(var_47[_loc1_]);
            }
            _loc1_++;
         }
         return _loc2_;
      }
   }
}
