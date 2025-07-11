package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindow;
   
   use namespace friend;
   
   public class MoveBy extends MoveTo
   {
       
      
      public function MoveBy(param1:IWindow, param2:int, param3:int, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override friend function start() : void
      {
         var_3297 = target.x + var_3297;
         var_3368 = target.y + var_3368;
         super.friend::start();
      }
   }
}
