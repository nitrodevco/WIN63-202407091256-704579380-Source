package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class class_3744 extends DefaultConditionType
   {
       
      
      public function class_3744()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.TRIGGERER_IS_ON_FURNI;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_TRIGGERER_IS_ON_FURNI;
      }
   }
}
