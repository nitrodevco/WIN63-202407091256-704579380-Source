package com.sulake.habbo.catalog.collectibles.renderer.model
{
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1661;
   
   public class MintableItemWrapper implements IRenderableCollectibleItem
   {
       
      
      private var var_3850:class_1661;
      
      private var _amount:int;
      
      public function MintableItemWrapper(param1:class_1661, param2:int)
      {
         super();
         var_3850 = param1;
         _amount = param2;
      }
      
      public function get productTypeId() : int
      {
         switch(var_3850.itemType)
         {
            case "i":
               return 0;
            case "s":
               return 1;
            case "cl":
               return 11;
            default:
               return -1;
         }
      }
      
      public function get itemTypeId() : String
      {
         return String(var_3850.itemTypeId);
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(param1:int) : void
      {
         _amount = param1;
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return new Vector.<int>();
      }
      
      public function get productItem() : class_1661
      {
         return var_3850;
      }
   }
}
