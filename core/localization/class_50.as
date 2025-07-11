package com.sulake.core.localization
{
   public class class_50 implements class_40
   {
       
      
      private var var_1142:String;
      
      private var _externalTextsHash:String;
      
      private var var_1306:String;
      
      private var _externalVariablesHash:String;
      
      private var var_1127:String;
      
      private var _furniDataHash:String;
      
      private var var_1159:String;
      
      private var _productDataHash:String;
      
      public function class_50()
      {
         super();
      }
      
      public static function parse(param1:String) : class_50
      {
         var _loc2_:Object = JSON.parse(param1);
         var _loc4_:class_50 = new class_50();
         for each(var _loc3_ in _loc2_.hashes)
         {
            if(_loc3_.name == "external_texts")
            {
               _loc4_.var_1142 = _loc3_.url;
               _loc4_._externalTextsHash = _loc3_.hash;
            }
            else if(_loc3_.name == "external_variables")
            {
               _loc4_.var_1306 = _loc3_.url;
               _loc4_._externalVariablesHash = _loc3_.hash;
            }
            else if(_loc3_.name == "furnidata")
            {
               _loc4_.var_1127 = _loc3_.url;
               _loc4_._furniDataHash = _loc3_.hash;
            }
            else if(_loc3_.name == "productdata")
            {
               _loc4_.var_1159 = _loc3_.url;
               _loc4_._productDataHash = _loc3_.hash;
            }
         }
         return _loc4_;
      }
      
      public function isValid() : Boolean
      {
         return var_1142 && _externalTextsHash && var_1306 && _externalVariablesHash && var_1127 && _furniDataHash && var_1159 && _productDataHash;
      }
      
      public function getExternalTextsUrl() : String
      {
         return var_1142;
      }
      
      public function getExternalTextsHash() : String
      {
         return _externalTextsHash;
      }
      
      public function getExternalVariablesUrl() : String
      {
         return var_1306;
      }
      
      public function getExternalVariablesHash() : String
      {
         return _externalVariablesHash;
      }
      
      public function getFurniDataUrl() : String
      {
         return var_1127;
      }
      
      public function getFurniDataHash() : String
      {
         return _furniDataHash;
      }
      
      public function getProductDataUrl() : String
      {
         return var_1159;
      }
      
      public function getProductDataHash() : String
      {
         return _productDataHash;
      }
   }
}
