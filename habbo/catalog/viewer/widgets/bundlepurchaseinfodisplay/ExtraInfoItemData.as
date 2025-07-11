package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   public class ExtraInfoItemData
   {
      
      public static const TYPE_PROMO:int = 0;
      
      public static const TYPE_BUNDLES_INFO_SCREEN:int = 1;
      
      public static const const_524:int = 2;
      
      public static const TYPE_BONUS_BADGE:int = 3;
      
      public static const const_527:int = 4;
      
      public static const TYPE_RESET_MESSAGE:int = 5;
       
      
      private var var_329:int;
      
      private var _text:String;
      
      private var var_2460:int;
      
      private var var_452:int;
      
      private var var_4812:int;
      
      private var var_4750:int;
      
      private var var_896:int;
      
      private var var_1327:int;
      
      private var var_4566:int;
      
      private var var_413:String;
      
      private var var_4475:String;
      
      public function ExtraInfoItemData(param1:int, param2:String = "")
      {
         super();
         var_329 = param1;
         _text = param2;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function set quantity(param1:int) : void
      {
         var_2460 = param1;
      }
      
      public function set activityPointType(param1:int) : void
      {
         var_452 = param1;
      }
      
      public function set discountPriceCredits(param1:int) : void
      {
         var_4812 = param1;
      }
      
      public function set discountPriceActivityPoints(param1:int) : void
      {
         var_4750 = param1;
      }
      
      public function set priceCredits(param1:int) : void
      {
         var_896 = param1;
      }
      
      public function set priceActivityPoints(param1:int) : void
      {
         var_1327 = param1;
      }
      
      public function set priceSilver(param1:int) : void
      {
         var_4566 = param1;
      }
      
      public function set badgeCode(param1:String) : void
      {
         var_413 = param1;
      }
      
      public function set achievementCode(param1:String) : void
      {
         var_4475 = param1;
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get quantity() : int
      {
         return var_2460;
      }
      
      public function get priceCredits() : int
      {
         return var_896;
      }
      
      public function get priceActivityPoints() : int
      {
         return var_1327;
      }
      
      public function get activityPointType() : int
      {
         return var_452;
      }
      
      public function get priceSilver() : int
      {
         return var_4566;
      }
      
      public function get badgeCode() : String
      {
         return var_413;
      }
      
      public function get achievementCode() : String
      {
         return var_4475;
      }
      
      public function get discountPriceCredits() : int
      {
         return var_4812;
      }
      
      public function get discountPriceActivityPoints() : int
      {
         return var_4750;
      }
   }
}
