package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1786;
   
   public class CollectionItemWrapper implements IRenderableCollectibleItem
   {
       
      
      private var var_2959:class_1786;
      
      public function CollectionItemWrapper(param1:class_1786)
      {
         super();
         var_2959 = param1;
      }
      
      public function get productTypeId() : int
      {
         return var_2959.productTypeId;
      }
      
      public function get itemTypeId() : String
      {
         return var_2959.itemTypeId;
      }
      
      public function get amount() : int
      {
         return var_2959.amount;
      }
      
      public function get petFigureString() : String
      {
         return var_2959.petFigureString;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return var_2959.figureSetIds;
      }
      
      public function get collectionItem() : class_1786
      {
         return var_2959;
      }
   }
}
