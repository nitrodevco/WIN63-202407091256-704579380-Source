package com.sulake.habbo.catalog.marketplace
{
   public class class_3453
   {
       
      
      private var var_812:int;
      
      private var var_1266:int;
      
      private var _historyLength:int;
      
      private var var_696:Array;
      
      private var var_738:Array;
      
      private var var_712:Array;
      
      private var var_1396:int;
      
      private var var_1175:int;
      
      public function class_3453()
      {
         super();
      }
      
      public function get averagePrice() : int
      {
         return var_812;
      }
      
      public function get offerCount() : int
      {
         return var_1266;
      }
      
      public function get historyLength() : int
      {
         return _historyLength;
      }
      
      public function get dayOffsets() : Array
      {
         return var_696;
      }
      
      public function get averagePrices() : Array
      {
         return var_738;
      }
      
      public function get soldAmounts() : Array
      {
         return var_712;
      }
      
      public function get furniTypeId() : int
      {
         return var_1396;
      }
      
      public function get furniCategoryId() : int
      {
         return var_1175;
      }
      
      public function set averagePrice(param1:int) : void
      {
         var_812 = param1;
      }
      
      public function set offerCount(param1:int) : void
      {
         var_1266 = param1;
      }
      
      public function set historyLength(param1:int) : void
      {
         _historyLength = param1;
      }
      
      public function set dayOffsets(param1:Array) : void
      {
         var_696 = param1.slice();
      }
      
      public function set averagePrices(param1:Array) : void
      {
         var_738 = param1.slice();
      }
      
      public function set soldAmounts(param1:Array) : void
      {
         var_712 = param1.slice();
      }
      
      public function set furniTypeId(param1:int) : void
      {
         var_1396 = param1;
      }
      
      public function set furniCategoryId(param1:int) : void
      {
         var_1175 = param1;
      }
   }
}
