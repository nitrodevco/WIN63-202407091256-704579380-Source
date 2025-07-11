package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   
   public class class_3797 extends WithVariable
   {
       
      
      public function class_3797()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.var_4938;
      }
      
      override protected function get variableSource() : int
      {
         return WiredInputSourcePicker.var_1736;
      }
   }
}
