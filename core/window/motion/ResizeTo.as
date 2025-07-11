package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   
   use namespace friend;
   
   public class ResizeTo extends Interval
   {
       
      
      protected var var_3988:Number;
      
      protected var var_4110:Number;
      
      protected var var_4857:Number;
      
      protected var var_4290:Number;
      
      protected var var_4306:Number;
      
      protected var var_4380:Number;
      
      public function ResizeTo(param1:IWindow, param2:int, param3:int, param4:int)
      {
         super(param1,param2);
         var_4857 = param3;
         var_4290 = param4;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_3988 = target.width;
         var_4110 = target.height;
         var_4306 = var_4857 - var_3988;
         var_4380 = var_4290 - var_4110;
      }
      
      override friend function update(param1:Number) : void
      {
         target.width = var_3988 + var_4306 * param1;
         target.height = var_4110 + var_4380 * param1;
      }
   }
}
