package com.sulake.habbo.catalog.club
{
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.class_3553;
   
   public class ClubBuyOfferData implements class_3377
   {
       
      
      private var _offerId:int;
      
      private var var_394:String;
      
      private var var_896:int;
      
      private var var_1327:int;
      
      private var var_1387:int;
      
      private var var_1294:Boolean;
      
      private var var_1229:int;
      
      private var var_1190:int;
      
      private var var_1768:class_3455;
      
      private var var_557:int;
      
      private var _month:int;
      
      private var var_1404:int;
      
      private var var_2859:String;
      
      private var var_4552:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_772:int;
      
      private var var_968:Boolean;
      
      public function ClubBuyOfferData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:Boolean = false)
      {
         super();
         _offerId = param1;
         var_394 = param2;
         var_896 = param3;
         var_1327 = param4;
         var_1387 = param5;
         var_1294 = param6;
         var_1229 = param7;
         var_772 = param8;
         var_1190 = param9;
         var_557 = param10;
         _month = param11;
         var_1404 = param12;
         var_968 = param13;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         var_1768 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get extraParameter() : String
      {
         return var_2859;
      }
      
      public function set extraParameter(param1:String) : void
      {
         var_2859 = param1;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productCode() : String
      {
         return var_394;
      }
      
      public function get priceCredits() : int
      {
         return var_896;
      }
      
      public function get vip() : Boolean
      {
         return var_1294;
      }
      
      public function get months() : int
      {
         return var_1229;
      }
      
      public function get daysLeftAfterPurchase() : int
      {
         return var_1190;
      }
      
      public function get year() : int
      {
         return var_557;
      }
      
      public function get month() : int
      {
         return _month;
      }
      
      public function get day() : int
      {
         return var_1404;
      }
      
      public function get isGiftable() : Boolean
      {
         return var_968;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_1327;
      }
      
      public function get activityPointType() : int
      {
         return var_1387;
      }
      
      public function get priceInCredits() : int
      {
         return var_896;
      }
      
      public function get page() : class_3455
      {
         return var_1768;
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
         return var_394;
      }
      
      public function set page(param1:class_3455) : void
      {
         var_1768 = param1;
      }
      
      public function get upgradeHcPeriodToVip() : Boolean
      {
         return var_4552;
      }
      
      public function set upgradeHcPeriodToVip(param1:Boolean) : void
      {
         var_4552 = param1;
      }
      
      public function get extraDays() : int
      {
         return var_772;
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
         return var_968;
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
