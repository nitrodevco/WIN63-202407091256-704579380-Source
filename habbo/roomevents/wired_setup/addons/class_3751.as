package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3847;
   
   public class class_3751 extends class_3704
   {
       
      
      public function class_3751()
      {
         super();
      }
      
      override protected function get variableType() : int
      {
         return class_3847.FURNI;
      }
      
      override public function get code() : int
      {
         return class_3833.FURNI_VARIABLE_FILTER;
      }
   }
}
