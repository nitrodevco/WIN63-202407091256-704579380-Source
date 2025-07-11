package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   
   use namespace friend;
   
   public class MoveTo extends Interval
   {
       
      
      protected var var_4223:Number;
      
      protected var var_3995:Number;
      
      protected var var_3297:Number;
      
      protected var var_3368:Number;
      
      protected var var_3002:Number;
      
      protected var var_3101:Number;
      
      public function MoveTo(param1:IWindow, param2:int, param3:int, param4:int)
      {
         super(param1,param2);
         var_3297 = param3;
         var_3368 = param4;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_4223 = target.x;
         var_3995 = target.y;
         var_3002 = var_3297 - var_4223;
         var_3101 = var_3368 - var_3995;
      }
      
      override friend function update(param1:Number) : void
      {
         target.x = var_4223 + var_3002 * param1;
         target.y = var_3995 + var_3101 * param1;
      }
   }
}
