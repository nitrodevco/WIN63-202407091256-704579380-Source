package com.sulake.habbo.catalog.targetedoffers.data
{
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.class_3553;
   import com.sulake.habbo.session.product.class_3423;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1725;
   
   public class TargetedOffer extends class_1725 implements class_3377
   {
      
      public static const const_1006:int = 10;
       
      
      public function TargetedOffer(param1:class_1725 = null)
      {
         super(param1);
      }
      
      public function get offerId() : int
      {
         return 0;
      }
      
      public function get page() : class_3455
      {
         return null;
      }
      
      public function set page(param1:class_3455) : void
      {
      }
      
      public function get priceType() : String
      {
         return "";
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
         return "";
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
      
      public function get previewCallbackId() : int
      {
         return 0;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
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
         return "";
      }
      
      public function get localizationDescription() : String
      {
         return "";
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function isExpired() : Boolean
      {
         return _expirationTime > 0 && getSecondsRemaining() <= 0;
      }
      
      public function getSecondsRemaining() : int
      {
         var _loc1_:uint = (_expirationTime - getTimer()) / 1000 - 10;
         return Math.max(0,_loc1_);
      }
      
      public function checkPurseBalance(param1:class_3378, param2:int) : Boolean
      {
         if(!param1 || param1.credits < var_495 * param2)
         {
            return false;
         }
         if(param1.getActivityPointsForType(var_452) < var_525 * param2)
         {
            return false;
         }
         return true;
      }
      
      public function getLocalizedSubProductNames(param1:IHabboCatalog) : Vector.<String>
      {
         var _loc4_:class_3423 = null;
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         for each(var _loc3_ in var_297)
         {
            _loc4_ = param1.getProductData(_loc3_);
            _loc2_.push(!!_loc4_ ? _loc4_.name : _loc3_);
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
      }
      
      public function get priceInSilver() : int
      {
         return -1;
      }
   }
}
