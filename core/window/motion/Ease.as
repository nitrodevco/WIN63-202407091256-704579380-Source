package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Ease extends Interval
   {
       
      
      protected var var_3505:Interval;
      
      public function Ease(param1:Interval)
      {
         super(param1.target,param1.duration);
         var_3505 = param1;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_3505.friend::start();
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         var_3505.friend::update(param1);
      }
      
      override friend function stop() : void
      {
         super.friend::stop();
         var_3505.friend::stop();
      }
   }
}
