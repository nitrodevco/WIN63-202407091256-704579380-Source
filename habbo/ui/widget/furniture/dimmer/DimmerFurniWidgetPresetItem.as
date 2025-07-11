package com.sulake.habbo.ui.widget.furniture.dimmer
{
   public class DimmerFurniWidgetPresetItem
   {
       
      
      private var var_280:int = 0;
      
      private var var_329:int = 0;
      
      private var _color:uint = 0;
      
      private var var_1022:uint = 0;
      
      public function DimmerFurniWidgetPresetItem(param1:int, param2:int, param3:uint, param4:uint)
      {
         super();
         var_280 = param1;
         var_329 = param2;
         _color = param3;
         var_1022 = param4;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get light() : uint
      {
         return var_1022;
      }
      
      public function set type(param1:int) : void
      {
         var_329 = param1;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function set light(param1:uint) : void
      {
         var_1022 = param1;
      }
   }
}
