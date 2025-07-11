package com.sulake.habbo.catalog.collectibles.widget
{
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.class_3553;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1685;
   
   public class MintTokenPurchaseOffer implements class_3377
   {
       
      
      internal var var_3654:class_1685;
      
      public function MintTokenPurchaseOffer(param1:class_1685)
      {
         super();
         var_3654 = param1;
      }
      
      public function get offerId() : int
      {
         return var_3654.offerId;
      }
      
      public function get priceInActivityPoints() : int
      {
         return 0;
      }
      
      public function get activityPointType() : int
      {
         return 0;
      }
      
      public function get priceInCredits() : int
      {
         return 0;
      }
      
      public function get priceInSilver() : int
      {
         return var_3654.silverPrice;
      }
      
      public function get page() : class_3455
      {
         return null;
      }
      
      public function get priceType() : String
      {
         return "price_type_silver";
      }
      
      public function get product() : class_3388
      {
         return null;
      }
      
      public function get productContainer() : class_3553
      {
         return null;
      }
      
      public function get gridItem() : class_3517
      {
         return null;
      }
      
      public function get localizationId() : String
      {
         return var_3654.productCode;
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
         return "";
      }
      
      public function get localizationDescription() : String
      {
         return "";
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}
