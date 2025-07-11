package com.sulake.habbo.session.product
{
   public class ProductData implements class_3423
   {
       
      
      private var var_329:String;
      
      private var _name:String;
      
      private var var_363:String = "";
      
      public function ProductData(param1:String, param2:String)
      {
         super();
         var_329 = param1;
         _name = param2;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_363;
      }
   }
}
