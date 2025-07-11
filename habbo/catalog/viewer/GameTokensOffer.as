package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.catalog.class_3377;
   
   public class GameTokensOffer implements class_3377, IDisposable
   {
       
      
      private var _offerId:int;
      
      private var var_974:String;
      
      private var var_495:int;
      
      private var var_525:int;
      
      private var var_452:int;
      
      public function GameTokensOffer(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         _offerId = param1;
         var_974 = param2;
         var_495 = param3;
         var_525 = param4;
         var_452 = param5;
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_525;
      }
      
      public function get activityPointType() : int
      {
         return var_452;
      }
      
      public function get priceInCredits() : int
      {
         return var_495;
      }
      
      public function get page() : class_3455
      {
         return null;
      }
      
      public function get priceType() : String
      {
         return "price_type_credits";
      }
      
      public function get productContainer() : class_3553
      {
         return null;
      }
      
      public function get product() : class_3388
      {
         return !!productContainer ? productContainer.firstProduct : null;
      }
      
      public function get gridItem() : class_3517
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return var_974;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return false;
      }
      
      public function get isRentOffer() : Boolean
      {
         return false;
      }
      
      public function get giftable() : Boolean
      {
         return false;
      }
      
      public function get pricingModel() : String
      {
         return "";
      }
      
      public function set previewCallbackId(param1:int) : void
      {
      }
      
      public function get previewCallbackId() : int
      {
         return 0;
      }
      
      public function get clubLevel() : int
      {
         return 0;
      }
      
      public function get badgeCode() : String
      {
         return "";
      }
      
      public function set page(param1:class_3455) : void
      {
      }
      
      public function get localizationName() : String
      {
         return "${" + localizationId + "}";
      }
      
      public function get localizationDescription() : String
      {
         return "${" + localizationId + "}";
      }
      
      public function get priceInSilver() : int
      {
         return -1;
      }
   }
}
