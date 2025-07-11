package com.sulake.habbo.catalog.marketplace
{
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class MarketPlaceOfferData implements IMarketPlaceOfferData
   {
      
      public static const const_465:int = 1;
      
      public static const const_480:int = 2;
       
      
      private var _offerId:int;
      
      private var var_603:int;
      
      private var var_813:int;
      
      private var var_1364:String;
      
      private var var_1091:IStuffData;
      
      private var var_886:int;
      
      private var var_812:int;
      
      private var _imageCallback:int;
      
      private var _status:int;
      
      private var var_1221:int = -1;
      
      private var _offerCount:int;
      
      private var var_859:BitmapData;
      
      public function MarketPlaceOfferData(param1:int, param2:int, param3:int, param4:String, param5:IStuffData, param6:int, param7:int, param8:int, param9:int = -1)
      {
         super();
         _offerId = param1;
         var_603 = param2;
         var_813 = param3;
         var_1364 = param4;
         var_1091 = param5;
         var_886 = param6;
         _status = param7;
         var_812 = param8;
         _offerCount = param9;
      }
      
      public function dispose() : void
      {
         if(var_859)
         {
            var_859.dispose();
            var_859 = null;
         }
         if(var_1091)
         {
            var_1091 = null;
         }
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get furniId() : int
      {
         return var_603;
      }
      
      public function get furniType() : int
      {
         return var_813;
      }
      
      public function get extraData() : String
      {
         return var_1364;
      }
      
      public function get stuffData() : IStuffData
      {
         return var_1091;
      }
      
      public function get price() : int
      {
         return var_886;
      }
      
      public function get averagePrice() : int
      {
         return var_812;
      }
      
      public function get image() : BitmapData
      {
         return var_859;
      }
      
      public function set image(param1:BitmapData) : void
      {
         if(var_859 != null)
         {
            var_859.dispose();
         }
         var_859 = param1;
      }
      
      public function set imageCallback(param1:int) : void
      {
         _imageCallback = param1;
      }
      
      public function get imageCallback() : int
      {
         return _imageCallback;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get timeLeftMinutes() : int
      {
         return var_1221;
      }
      
      public function set timeLeftMinutes(param1:int) : void
      {
         var_1221 = param1;
      }
      
      public function set price(param1:int) : void
      {
         var_886 = param1;
      }
      
      public function set offerId(param1:int) : void
      {
         _offerId = param1;
      }
      
      public function get offerCount() : int
      {
         return _offerCount;
      }
      
      public function set offerCount(param1:int) : void
      {
         _offerCount = param1;
      }
      
      public function get isUniqueLimitedItem() : Boolean
      {
         return stuffData != null && stuffData.uniqueSerialNumber > 0;
      }
   }
}
