package com.sulake.habbo.catalog
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.class_3553;
   
   public interface class_3377 extends IDisposable
   {
       
      
      function get offerId() : int;
      
      function get priceInActivityPoints() : int;
      
      function get activityPointType() : int;
      
      function get priceInCredits() : int;
      
      function get priceInSilver() : int;
      
      function get page() : class_3455;
      
      function get priceType() : String;
      
      function get product() : class_3388;
      
      function get productContainer() : class_3553;
      
      function get gridItem() : class_3517;
      
      function get localizationId() : String;
      
      function get bundlePurchaseAllowed() : Boolean;
      
      function get isRentOffer() : Boolean;
      
      function get giftable() : Boolean;
      
      function get pricingModel() : String;
      
      function set previewCallbackId(param1:int) : void;
      
      function get previewCallbackId() : int;
      
      function get clubLevel() : int;
      
      function get badgeCode() : String;
      
      function set page(param1:class_3455) : void;
      
      function get localizationName() : String;
      
      function get localizationDescription() : String;
   }
}
