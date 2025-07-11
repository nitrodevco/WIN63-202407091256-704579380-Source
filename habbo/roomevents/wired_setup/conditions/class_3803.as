package com.sulake.habbo.roomevents.wired_setup.conditions
{
   public class class_3803 extends DefaultConditionType
   {
       
      
      public function class_3803()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.STUFF_TYPE_MATCHES;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_STUFF_TYPE_MATCHES;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.match." + param1;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}
