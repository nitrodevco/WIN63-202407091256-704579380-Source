package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   
   public class PlacedObjectPurchaseData implements IDisposable
   {
       
      
      private var var_318:Boolean = false;
      
      private var var_455:int;
      
      private var var_638:int;
      
      private var var_369:int;
      
      private var var_1126:String = "";
      
      private var var_31:int = 0;
      
      private var var_28:int = 0;
      
      private var var_1210:int = 0;
      
      private var _offerId:int;
      
      private var var_389:int;
      
      private var var_1236:class_3423;
      
      private var var_1691:class_3365;
      
      private var var_2859:String;
      
      public function PlacedObjectPurchaseData(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int, param7:int, param8:class_3377)
      {
         super();
         var_369 = param1;
         var_455 = param2;
         var_638 = param3;
         var_1126 = param4;
         var_31 = param5;
         var_28 = param6;
         var_1210 = param7;
         setOfferData(param8);
      }
      
      public function dispose() : void
      {
         var_318 = true;
         var_1236 = null;
         var_1691 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function setOfferData(param1:class_3377) : void
      {
         _offerId = param1.offerId;
         var_389 = param1.product.productClassId;
         var_1236 = param1.product.productData;
         var_1691 = param1.product.furnitureData;
         var_2859 = param1.product.extraParam;
      }
      
      public function toString() : String
      {
         return [var_369,var_455,var_638,var_1126,var_31,var_28,var_1210,_offerId,var_389].toString();
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get wallLocation() : String
      {
         return var_1126;
      }
      
      public function get x() : int
      {
         return var_31;
      }
      
      public function get y() : int
      {
         return var_28;
      }
      
      public function get direction() : int
      {
         return var_1210;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get productClassId() : int
      {
         return var_389;
      }
      
      public function get extraParameter() : String
      {
         return var_2859;
      }
      
      public function get furniData() : class_3365
      {
         return var_1691;
      }
   }
}
