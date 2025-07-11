package com.sulake.habbo.ui.widget.events
{
   public class ChooserItem
   {
       
      
      private var var_280:int;
      
      private var var_638:int;
      
      private var _name:String;
      
      public function ChooserItem(param1:int, param2:int, param3:String)
      {
         super();
         var_280 = param1;
         var_638 = param2;
         _name = param3;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}
