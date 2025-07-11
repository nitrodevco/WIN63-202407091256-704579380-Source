package com.sulake.habbo.catalog.offers
{
   public class OfferReward
   {
       
      
      private var _name:String;
      
      private var var_489:String;
      
      private var var_390:int;
      
      public function OfferReward(param1:String, param2:String, param3:int)
      {
         super();
         _name = param1;
         var_489 = param2;
         var_390 = param3;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get contentType() : String
      {
         return var_489;
      }
      
      public function get classId() : int
      {
         return var_390;
      }
   }
}
