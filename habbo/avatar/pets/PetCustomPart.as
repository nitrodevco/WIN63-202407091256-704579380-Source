package com.sulake.habbo.avatar.pets
{
   public class PetCustomPart
   {
       
      
      private var var_3722:int;
      
      private var var_1482:int;
      
      private var var_907:int;
      
      public function PetCustomPart(param1:int, param2:int, param3:int)
      {
         super();
         var_3722 = param1;
         var_1482 = param2;
         var_907 = param3;
      }
      
      public function get paletteId() : int
      {
         return var_907;
      }
      
      public function set paletteId(param1:int) : void
      {
         var_907 = param1;
      }
      
      public function get partId() : int
      {
         return var_1482;
      }
      
      public function set partId(param1:int) : void
      {
         var_1482 = param1;
      }
      
      public function get layerId() : int
      {
         return var_3722;
      }
      
      public function set layerId(param1:int) : void
      {
         var_3722 = param1;
      }
   }
}
