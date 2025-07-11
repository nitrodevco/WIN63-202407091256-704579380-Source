package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   
   use namespace friend;
   
   public class DropBounce extends Interval
   {
       
      
      private var var_46:int;
      
      private var _offset:int;
      
      public function DropBounce(param1:IWindow, param2:int, param3:int)
      {
         super(param1,param2);
         var_46 = param3;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         _offset = target.y;
         target.y = _offset - var_46;
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         target.y = _offset - var_46 + getBounceOffset(param1) * var_46;
      }
      
      protected function getBounceOffset(param1:Number) : Number
      {
         if(param1 < 0.364)
         {
            return 7.5625 * param1 * param1;
         }
         if(param1 < 0.727)
         {
            param1 -= 0.545;
            return 7.5625 * param1 * param1 + 0.75;
         }
         if(param1 < 0.909)
         {
            param1 -= 0.9091;
            return 7.5625 * param1 * param1 + 0.9375;
         }
         param1 -= 0.955;
         return 7.5625 * param1 * param1 + 0.984375;
      }
      
      override friend function stop() : void
      {
         target.y = _offset;
         super.friend::stop();
      }
   }
}
