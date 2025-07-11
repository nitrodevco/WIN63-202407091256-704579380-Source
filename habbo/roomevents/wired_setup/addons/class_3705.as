package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3847;
   
   public class class_3705 extends class_3704
   {
       
      
      public function class_3705()
      {
         super();
      }
      
      override protected function get variableType() : int
      {
         return class_3847.USER;
      }
      
      override public function get code() : int
      {
         return class_3833.USER_VARIABLE_FILTER;
      }
   }
}
