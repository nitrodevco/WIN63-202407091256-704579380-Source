package com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown
{
   public class ExpandableDropdownOption
   {
       
      
      private var var_280:int;
      
      private var _displayString:String;
      
      private var var_4374:Boolean;
      
      public function ExpandableDropdownOption(param1:int, param2:String, param3:Boolean)
      {
         super();
         var_280 = param1;
         _displayString = param2;
         var_4374 = param3;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get displayString() : String
      {
         return _displayString;
      }
      
      public function get isAdvanced() : Boolean
      {
         return var_4374;
      }
   }
}
