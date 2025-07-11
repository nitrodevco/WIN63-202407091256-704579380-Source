package com.sulake.habbo.inventory
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   
   public class Util
   {
       
      
      public function Util()
      {
         super();
      }
      
      public static function disableButton(param1:IWindow, param2:Boolean) : void
      {
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
      }
      
      public static function moveAllChildrenToColumn(param1:IWindowContainer, param2:int, param3:Boolean = false, param4:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:IWindow = null;
         _loc5_ = 0;
         while(_loc5_ < param1.numChildren)
         {
            if((_loc6_ = param1.getChildAt(_loc5_)) != null && _loc6_.visible && _loc6_.height > 0)
            {
               if(param4 < _loc6_.y && param3)
               {
                  param4 = _loc6_.y;
               }
               else
               {
                  _loc6_.y = param4;
               }
               param4 += _loc6_.height + param2;
            }
            _loc5_++;
         }
      }
      
      public static function getLowestPoint(param1:IWindowContainer) : int
      {
         var _loc2_:int = 0;
         var _loc4_:IWindow = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            if((_loc4_ = param1.getChildAt(_loc2_)).visible && _loc4_.height > 0)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
   }
}
