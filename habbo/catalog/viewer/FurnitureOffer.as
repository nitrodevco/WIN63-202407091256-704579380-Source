package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.session.furniture.class_3365;
   
   public class FurnitureOffer implements class_3377
   {
       
      
      private var var_1691:class_3365;
      
      private var var_3665:int;
      
      private var var_1768:class_3455;
      
      private var var_1916:FurniProductContainer;
      
      private var var_4664:Product;
      
      public function FurnitureOffer(param1:class_3365, param2:HabboCatalog)
      {
         super();
         var_1691 = param1;
         var_1916 = new FurniProductContainer(this,new Vector.<class_3388>(0),param2,var_1691);
         var_4664 = new Product(var_1691.type,var_1691.id,var_1691.customParams,1,param2.getProductData(var_1691.className),var_1691,param2);
      }
      
      public function dispose() : void
      {
         var_1691 = null;
         var_1768 = null;
         var_3665 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_1691 == null;
      }
      
      public function get offerId() : int
      {
         return isRentOffer ? var_1691.rentOfferId : var_1691.purchaseOfferId;
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
      
      public function get page() : class_3455
      {
         return var_1768;
      }
      
      public function get priceType() : String
      {
         return "";
      }
      
      public function get productContainer() : class_3553
      {
         return var_1916;
      }
      
      public function get product() : class_3388
      {
         return var_4664;
      }
      
      public function get gridItem() : class_3517
      {
         return var_1916 as class_3517;
      }
      
      public function get localizationId() : String
      {
         return "roomItem.name." + var_1691.id;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return false;
      }
      
      public function get isRentOffer() : Boolean
      {
         return var_1691.rentOfferId > -1 && !(var_1768 != null && var_1768.isBuilderPage);
      }
      
      public function get giftable() : Boolean
      {
         return false;
      }
      
      public function get pricingModel() : String
      {
         return "pricing_model_furniture";
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_3665 = param1;
      }
      
      public function get previewCallbackId() : int
      {
         return var_3665;
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
         var_1768 = param1;
      }
      
      public function get localizationName() : String
      {
         return var_1691.localizedName;
      }
      
      public function get localizationDescription() : String
      {
         return var_1691.description;
      }
      
      public function get priceInSilver() : int
      {
         return -1;
      }
   }
}
