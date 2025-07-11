package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Combo extends Motion
   {
       
      
      private var var_2502:Vector.<Motion>;
      
      private var var_3878:Vector.<Motion>;
      
      public function Combo(... rest)
      {
         var_2502 = new Vector.<Motion>();
         var_3878 = new Vector.<Motion>();
         for each(var _loc2_ in rest)
         {
            var_2502.push(_loc2_);
         }
         super(var_2502.length > 0 ? var_2502[0].target : null);
      }
      
      override friend function start() : void
      {
         super.friend::start();
         for each(var _loc1_ in var_2502)
         {
            _loc1_.friend::start();
         }
      }
      
      override friend function tick(param1:int) : void
      {
         var _loc2_:Motion = null;
         super.friend::tick(param1);
         while((_loc2_ = var_3878.pop()) != null)
         {
            var_2502.splice(var_3878.indexOf(_loc2_),1);
            if(_loc2_.running)
            {
               _loc2_.friend::stop();
            }
         }
         for each(_loc2_ in var_2502)
         {
            if(_loc2_.running)
            {
               _loc2_.friend::tick(param1);
            }
            if(_loc2_.complete)
            {
               var_3878.push(_loc2_);
            }
         }
         if(var_2502.length > 0)
         {
            for each(_loc2_ in var_2502)
            {
               var_294 = _loc2_.target;
               if(var_294 && !var_294.disposed)
               {
                  break;
               }
            }
            var_1808 = false;
         }
         else
         {
            var_1808 = true;
         }
      }
   }
}
