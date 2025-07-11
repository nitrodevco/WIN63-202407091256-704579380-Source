package com.sulake.habbo.catalog.targetedoffers.data
{
   public class HabboMallOffer
   {
       
      
      private var var_4784:int;
      
      private var var_443:String;
      
      private var var_617:String;
      
      private var _highlight:String;
      
      private var var_363:String;
      
      private var var_406:String;
      
      private var _smallImageUrl:String;
      
      private var var_577:int;
      
      public function HabboMallOffer(param1:Object)
      {
         super();
         var_4784 = parseInt(param1.targetedOfferId);
         var_443 = param1.identifier;
         var_617 = param1.header;
         _highlight = param1.highlight;
         var_363 = param1.description;
         var_406 = param1.imageUrl;
         _smallImageUrl = param1.smallImageUrl;
         var_577 = parseInt(param1.trackingStateCode);
      }
      
      public function get targetedOfferId() : int
      {
         return var_4784;
      }
      
      public function get identifier() : String
      {
         return var_443;
      }
      
      public function get title() : String
      {
         return var_617;
      }
      
      public function get highlight() : String
      {
         return _highlight;
      }
      
      public function get description() : String
      {
         return var_363;
      }
      
      public function get imageUrl() : String
      {
         return var_406;
      }
      
      public function get smallImageUrl() : String
      {
         return _smallImageUrl;
      }
      
      public function get trackingState() : int
      {
         return var_577;
      }
   }
}
