package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   
   use namespace friend;
   
   public class JumpBy extends Interval
   {
       
      
      protected var var_4223:int;
      
      protected var var_3995:int;
      
      protected var var_3002:Number;
      
      protected var var_3101:Number;
      
      protected var var_46:Number;
      
      protected var var_4516:int;
      
      public function JumpBy(param1:IWindow, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super(param1,param2);
         var_3002 = param3;
         var_3101 = param4;
         var_46 = -param5;
         var_4516 = param6;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_4223 = target.x;
         var_3995 = target.y;
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         target.x = var_4223 + var_3002 * param1;
         target.y = var_3995 + var_46 * Math.abs(Math.sin(param1 * 3.141592653589793 * var_4516)) + var_3101 * param1;
      }
   }
}
