package com.sulake.core.localization
{
   public class LocalizationDefinition implements ILocalizationDefinition
   {
       
      
      private var var_755:String;
      
      private var var_706:String;
      
      private var var_745:String;
      
      private var _name:String;
      
      private var var_96:String;
      
      public function LocalizationDefinition(param1:String, param2:String, param3:String)
      {
         super();
         var _loc4_:Array;
         var_755 = (_loc4_ = param1.split("_"))[0];
         var _loc5_:Array;
         var_706 = (_loc5_ = String(_loc4_[1]).split("."))[0];
         var_745 = _loc5_[1];
         _name = param2;
         var_96 = param3;
      }
      
      public function get id() : String
      {
         return var_755 + "_" + var_706 + "." + var_745;
      }
      
      public function get languageCode() : String
      {
         return var_755;
      }
      
      public function get countryCode() : String
      {
         return var_706;
      }
      
      public function get encoding() : String
      {
         return var_745;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get url() : String
      {
         return var_96;
      }
   }
}
