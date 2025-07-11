package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class Interval extends Motion
   {
       
      
      private var var_4446:int;
      
      private var var_377:int;
      
      public function Interval(param1:IWindow, param2:int)
      {
         super(param1);
         var_1808 = false;
         var_377 = param2;
      }
      
      public function get duration() : int
      {
         return var_377;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_1808 = false;
         var_4446 = getTimer();
      }
      
      final override friend function tick(param1:int) : void
      {
         var _loc2_:Number = (param1 - var_4446) / var_377;
         if(_loc2_ < 1)
         {
            friend::update(_loc2_);
         }
         else
         {
            friend::update(1);
            var_1808 = true;
         }
      }
   }
}
