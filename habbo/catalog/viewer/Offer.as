package com.sulake.habbo.catalog.viewer
{
    import assets.class_14

    import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   
   public class Offer implements class_3377
   {
      
      public static const PRICING_MODEL_UNKNOWN:String = "pricing_model_unknown";
      
      public static const PRICING_MODEL_SINGLE:String = "pricing_model_single";
      
      public static const PRICING_MODEL_MULTI:String = "pricing_model_multi";
      
      public static const PRICING_MODEL_BUNDLE:String = "pricing_model_bundle";
      
      public static const PRICING_MODEL_FURNI:String = "pricing_model_furniture";
      
      public static const PRICE_TYPE_NONE:String = "price_type_none";
      
      public static const PRICE_TYPE_CREDITS:String = "price_type_credits";
      
      public static const PRICE_TYPE_ACTIVITYPOINTS:String = "price_type_activitypoints";
      
      public static const PRICE_TYPE_CREDITS_AND_ACTIVITYPOINTS:String = "price_type_credits_and_activitypoints";
      
      public static const PRICE_TYPE_SILVER:String = "price_type_silver";
       
      
      private var var_2276:String;
      
      private var var_2378:String;
      
      private var _offerId:int;
      
      private var var_974:String;
      
      private var var_495:int;
      
      private var var_525:int;
      
      private var var_452:int;
      
      private var var_1020:int;
      
      private var var_968:Boolean;
      
      private var var_4389:Boolean;
      
      private var var_1768:class_3455;
      
      private var var_1916:class_3553;
      
      private var _disposed:Boolean = false;
      
      private var var_842:int = 0;
      
      private var var_413:String;
      
      private var var_1420:Boolean = false;
      
      private var _catalog:HabboCatalog;
      
      private var var_3665:int;
      
      public function Offer(param1:int, param2:String, param3:Boolean, param4:int, param5:int, param6:int, param7:int, param8:Boolean, param9:int, param10:Vector.<class_3388>, param11:Boolean, param12:HabboCatalog)
      {
         super();
         _offerId = param1;
         var_974 = param2;
         var_4389 = param3;
         var_495 = param4;
         var_525 = param5;
         var_452 = param6;
         var_1020 = param7;
         var_968 = param8;
         var_842 = param9;
         var_1420 = param11;
         _catalog = param12;
         analyzePricingModel(param10);
         analyzePriceType();
         createProductContainer(param10);
         for each(var _loc13_ in param10)
         {
            if(_loc13_.productType == "b")
            {
               var_413 = _loc13_.extraParam;
               break;
            }
         }
      }
      
      public function get clubLevel() : int
      {
         return var_842;
      }
      
      public function get page() : class_3455
      {
         return var_1768;
      }
      
      public function set page(param1:class_3455) : void
      {
         var_1768 = param1;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get localizationId() : String
      {
         return var_974;
      }
      
      public function get priceInCredits() : int
      {
         return var_495;
      }
      
      public function get priceInActivityPoints() : int
      {
         return var_525;
      }
      
      public function get activityPointType() : int
      {
         return var_452;
      }
      
      public function get priceInSilver() : int
      {
         return var_1020;
      }
      
      public function get giftable() : Boolean
      {
         return var_968;
      }
      
      public function get productContainer() : class_3553
      {
         return var_1916;
      }
      
      public function get product() : class_3388
      {
         return !!var_1916 ? var_1916.firstProduct : null;
      }
      
      public function get gridItem() : class_3517
      {
         return var_1916 as class_3517;
      }
      
      public function get pricingModel() : String
      {
         return var_2276;
      }
      
      public function get priceType() : String
      {
         return var_2378;
      }
      
      public function get previewCallbackId() : int
      {
         return var_3665;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         var_3665 = param1;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return var_1420;
      }
      
      public function get isRentOffer() : Boolean
      {
         return var_4389;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         _offerId = 0;
         var_974 = "";
         var_495 = 0;
         var_525 = 0;
         var_452 = 0;
         var_1768 = null;
         _catalog = null;
         if(var_1916 != null)
         {
            var_1916.dispose();
            var_1916 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function createProductContainer(param1:Vector.<class_3388>) : void
      {
         switch(var_2276)
         {
            case "pricing_model_single":
               var_1916 = new SingleProductContainer(this,param1,_catalog);
               break;
            case "pricing_model_multi":
               var_1916 = new MultiProductContainer(this,param1,_catalog);
               break;
            case "pricing_model_bundle":
               var_1916 = new BundleProductContainer(this,param1,_catalog);
               break;
            default:
               var_1916 = new ProductContainer(this,param1,_catalog);
               class_14.log("[Offer] Unknown pricing model" + var_2276);
         }
      }
      
      private function analyzePricingModel(param1:Vector.<class_3388>) : void
      {
         var _loc2_:Vector.<class_3388> = Product.stripAddonProducts(param1);
         if(_loc2_.length == 1)
         {
            if(_loc2_[0].productCount == 1)
            {
               var_2276 = "pricing_model_single";
            }
            else
            {
               var_2276 = "pricing_model_multi";
            }
         }
         else if(_loc2_.length > 1)
         {
            var_2276 = "pricing_model_bundle";
         }
         else
         {
            var_2276 = "pricing_model_unknown";
         }
      }
      
      private function analyzePriceType() : void
      {
         if(var_495 > 0 && var_525 > 0)
         {
            var_2378 = "price_type_credits_and_activitypoints";
         }
         else if(var_495 > 0)
         {
            var_2378 = "price_type_credits";
         }
         else if(var_525 > 0)
         {
            var_2378 = "price_type_activitypoints";
         }
         else if(var_1020 > 0)
         {
            var_2378 = "price_type_silver";
         }
         else
         {
            var_2378 = "price_type_none";
         }
      }
      
      public function clone() : Offer
      {
         var _loc4_:class_3365 = null;
         var _loc2_:Product = null;
         var _loc5_:Vector.<class_3388> = new Vector.<class_3388>(0);
         var _loc6_:class_3423 = _catalog.getProductData(localizationId);
         for each(var _loc3_ in var_1916.products)
         {
            _loc4_ = _catalog.getFurnitureData(_loc3_.productClassId,_loc3_.productType);
            _loc2_ = new Product(_loc3_.productType,_loc3_.productClassId,_loc3_.extraParam,_loc3_.productCount,_loc6_,_loc4_,_catalog);
            _loc5_.push(_loc2_);
         }
         var _loc1_:Offer = new Offer(offerId,localizationId,isRentOffer,priceInCredits,priceInActivityPoints,activityPointType,priceInSilver,giftable,clubLevel,_loc5_,bundlePurchaseAllowed,_catalog);
         _loc1_.page = page;
         return _loc1_;
      }
      
      public function get badgeCode() : String
      {
         return var_413;
      }
      
      public function get localizationName() : String
      {
         var _loc1_:class_3423 = _catalog.getProductData(var_974);
         return !!_loc1_ ? _loc1_.name : "${" + var_974 + "}";
      }
      
      public function get localizationDescription() : String
      {
         var _loc1_:class_3423 = _catalog.getProductData(var_974);
         return !!_loc1_ ? _loc1_.description : "${" + var_974 + "}";
      }
   }
}
