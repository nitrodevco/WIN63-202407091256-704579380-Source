package com.sulake.core.assets
{
   public class AssetTypeDeclaration
   {
       
      
      private var var_1378:String;
      
      private var var_868:Class;
      
      private var var_770:Class;
      
      private var var_417:Array;
      
      public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class = null, ... rest)
      {
         super();
         var_1378 = param1;
         var_868 = param2;
         var_770 = param3;
         if(rest == null)
         {
            var_417 = [];
         }
         else
         {
            var_417 = rest;
         }
      }
      
      public function get mimeType() : String
      {
         return var_1378;
      }
      
      public function get assetClass() : Class
      {
         return var_868;
      }
      
      public function get loaderClass() : Class
      {
         return var_770;
      }
      
      public function get fileTypes() : Array
      {
         return var_417;
      }
   }
}
