package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class Reset extends DefaultActionType
   {
       
      
      public function Reset()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.RESET;
      }
   }
}
