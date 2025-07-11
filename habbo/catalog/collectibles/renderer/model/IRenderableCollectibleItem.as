package com.sulake.habbo.catalog.collectibles.renderer.model
{
   public interface IRenderableCollectibleItem
   {
       
      
      function get productTypeId() : int;
      
      function get itemTypeId() : String;
      
      function get amount() : int;
      
      function get petFigureString() : String;
      
      function get figureSetIds() : Vector.<int>;
   }
}
