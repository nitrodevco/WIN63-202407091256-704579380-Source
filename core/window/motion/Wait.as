package com.sulake.core.window.motion
{
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class Wait extends Motion
   {
       
      
      private var var_4446:int;
      
      private var var_4450:int;
      
      public function Wait(param1:int)
      {
         super(null);
         var_4450 = param1;
      }
      
      override public function get running() : Boolean
      {
         return var_92;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         var_1808 = false;
         var_4446 = getTimer();
      }
      
      override friend function tick(param1:int) : void
      {
         var_1808 = param1 - var_4446 >= var_4450;
         if(var_1808)
         {
            friend::stop();
         }
         super.friend::tick(param1);
      }
   }
}
