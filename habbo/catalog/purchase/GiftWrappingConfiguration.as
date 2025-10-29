package com.sulake.habbo.catalog.purchase
{
   import com.sulake.habbo.communication.messages.parser.catalog.class_1182;
   import com.sulake.habbo.communication.messages.incoming.catalog.GiftWrappingConfigurationEvent;
   
   public class GiftWrappingConfiguration
   {
       
      
      private var var_1479:Boolean = false;
      
      private var var_886:int;
      
      private var var_739:Array;
      
      private var var_754:Array;
      
      private var var_711:Array;
      
      private var var_684:Array;
      
      public function GiftWrappingConfiguration(param1:GiftWrappingConfigurationEvent)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1182 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var_1479 = _loc2_.isWrappingEnabled;
         var_886 = _loc2_.wrappingPrice;
         var_739 = _loc2_.stuffTypes;
         var_754 = _loc2_.boxTypes;
         var_711 = _loc2_.ribbonTypes;
         var_684 = _loc2_.defaultStuffTypes;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_1479;
      }
      
      public function get price() : int
      {
         return var_886;
      }
      
      public function get stuffTypes() : Array
      {
         return var_739;
      }
      
      public function get boxTypes() : Array
      {
         return var_754;
      }
      
      public function get ribbonTypes() : Array
      {
         return var_711;
      }
      
      public function get defaultStuffTypes() : Array
      {
         return var_684;
      }
   }
}
