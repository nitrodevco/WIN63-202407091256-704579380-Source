package com.sulake.habbo.groups.badge
{
   public class BadgeLayerOptions
   {
       
      
      private var var_3241:int = -1;
      
      private var var_3856:int = -1;
      
      private var var_3473:int = -1;
      
      private var var_2633:int = -1;
      
      private var var_2612:int = -1;
      
      public function BadgeLayerOptions()
      {
         super();
      }
      
      public function setGrid(param1:int) : void
      {
         var_2633 = Math.floor(param1 % 3);
         var_2612 = Math.floor(param1 / 3);
      }
      
      public function clone() : BadgeLayerOptions
      {
         var _loc1_:BadgeLayerOptions = new BadgeLayerOptions();
         _loc1_.var_3241 = var_3241;
         _loc1_.var_3856 = var_3856;
         _loc1_.var_3473 = var_3473;
         _loc1_.var_2633 = var_2633;
         _loc1_.var_2612 = var_2612;
         return _loc1_;
      }
      
      public function equalVisuals(param1:BadgeLayerOptions) : Boolean
      {
         if(param1 == null || var_2633 != param1.gridX || var_2612 != param1.gridY || var_3473 != param1.colorIndex)
         {
            return false;
         }
         if(var_3241 == 0 && param1.layerIndex != 0 || var_3241 != 0 && param1.layerIndex == 0)
         {
            return false;
         }
         return true;
      }
      
      public function isGridEqual(param1:BadgeLayerOptions) : Boolean
      {
         if(param1.gridX == var_2633 && param1.gridY == var_2612)
         {
            return true;
         }
         return false;
      }
      
      public function get layerIndex() : int
      {
         return var_3241;
      }
      
      public function set layerIndex(param1:int) : void
      {
         var_3241 = param1;
      }
      
      public function get partIndex() : int
      {
         return var_3856;
      }
      
      public function set partIndex(param1:int) : void
      {
         var_3856 = param1;
      }
      
      public function get colorIndex() : int
      {
         return var_3473;
      }
      
      public function set colorIndex(param1:int) : void
      {
         var_3473 = param1;
      }
      
      public function get gridX() : int
      {
         return var_2633;
      }
      
      public function set gridX(param1:int) : void
      {
         var_2633 = param1;
      }
      
      public function get gridY() : int
      {
         return var_2612;
      }
      
      public function set gridY(param1:int) : void
      {
         var_2612 = param1;
      }
      
      public function get position() : int
      {
         return gridY * 3 + gridX;
      }
   }
}
