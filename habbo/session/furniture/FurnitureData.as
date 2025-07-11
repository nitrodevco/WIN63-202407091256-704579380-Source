package com.sulake.habbo.session.furniture
{
   public class FurnitureData implements class_3365
   {
      
      public static const const_540:String = "i";
      
      public static const const_934:String = "s";
       
      
      private var var_329:String;
      
      private var var_280:int;
      
      private var _className:String;
      
      private var _hasIndexedColor:Boolean;
      
      private var var_4733:int;
      
      private var var_4525:int;
      
      private var var_4498:int;
      
      private var var_4675:int;
      
      private var var_4623:int;
      
      private var _colours:Array;
      
      private var _localizedName:String;
      
      private var var_363:String;
      
      private var var_4402:String;
      
      private var var_4357:int;
      
      private var var_4430:int;
      
      private var _customParams:String;
      
      private var var_638:int;
      
      private var _purchaseCouldBeUsedForBuyout:Boolean;
      
      private var _rentCouldBeUsedForBuyout:Boolean;
      
      private var var_4319:Boolean;
      
      private var _fullName:String;
      
      private var var_1272:Boolean;
      
      private var var_4356:Boolean;
      
      private var var_4427:Boolean;
      
      private var var_4317:Boolean;
      
      private var var_4831:String;
      
      public function FurnitureData(param1:String, param2:int, param3:String, param4:String, param5:String, param6:String, param7:int, param8:int, param9:int, param10:int, param11:Array, param12:Boolean, param13:int, param14:String, param15:int, param16:Boolean, param17:int, param18:Boolean, param19:Boolean, param20:String, param21:int, param22:Boolean, param23:Boolean, param24:Boolean, param25:Boolean, param26:String)
      {
         super();
         var_329 = param1;
         var_280 = param2;
         _fullName = param3;
         _className = param4;
         var_4525 = param7;
         var_4498 = param8;
         var_4675 = param9;
         var_4623 = param10;
         _colours = param11;
         _hasIndexedColor = param12;
         var_4733 = param13;
         _localizedName = param5;
         var_363 = param6;
         var_4402 = param14;
         var_4357 = param15;
         _purchaseCouldBeUsedForBuyout = param16;
         var_4430 = param17;
         _rentCouldBeUsedForBuyout = param18;
         _customParams = param20;
         var_638 = param21;
         var_4319 = param19;
         var_1272 = param22;
         var_4356 = param23;
         var_4427 = param24;
         var_4317 = param25;
         var_4831 = param26;
      }
      
      public function get type() : String
      {
         return var_329;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get className() : String
      {
         return _className;
      }
      
      public function get fullName() : String
      {
         return _fullName;
      }
      
      public function get hasIndexedColor() : Boolean
      {
         return _hasIndexedColor;
      }
      
      public function get colourIndex() : int
      {
         return var_4733;
      }
      
      public function get revision() : int
      {
         return var_4525;
      }
      
      public function get tileSizeX() : int
      {
         return var_4498;
      }
      
      public function get tileSizeY() : int
      {
         return var_4675;
      }
      
      public function get tileSizeZ() : int
      {
         return var_4623;
      }
      
      public function get colours() : Array
      {
         return _colours;
      }
      
      public function get localizedName() : String
      {
         return _localizedName;
      }
      
      public function get description() : String
      {
         return var_363;
      }
      
      public function get adUrl() : String
      {
         return var_4402;
      }
      
      public function get purchaseOfferId() : int
      {
         return var_4357;
      }
      
      public function get customParams() : String
      {
         return _customParams;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function set className(param1:String) : void
      {
         _className = param1;
      }
      
      public function get rentOfferId() : int
      {
         return var_4430;
      }
      
      public function get purchaseCouldBeUsedForBuyout() : Boolean
      {
         return _purchaseCouldBeUsedForBuyout;
      }
      
      public function get rentCouldBeUsedForBuyout() : Boolean
      {
         return _rentCouldBeUsedForBuyout;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return var_4319;
      }
      
      public function get canStandOn() : Boolean
      {
         return var_1272;
      }
      
      public function get canSitOn() : Boolean
      {
         return var_4356;
      }
      
      public function get canLayOn() : Boolean
      {
         return var_4427;
      }
      
      public function get isExternalImageType() : Boolean
      {
         return _className.indexOf("external_image") != -1;
      }
      
      public function get excludedFromDynamic() : Boolean
      {
         return var_4317;
      }
      
      public function get furniLine() : String
      {
         return var_4831;
      }
   }
}
