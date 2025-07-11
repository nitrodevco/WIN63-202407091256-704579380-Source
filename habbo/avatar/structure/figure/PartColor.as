package com.sulake.habbo.avatar.structure.figure
{
   import flash.geom.ColorTransform;
   
   public class PartColor implements IPartColor
   {
       
      
      private var var_280:int;
      
      private var _index:int;
      
      private var var_842:int;
      
      private var var_901:Boolean = false;
      
      private var var_3575:uint;
      
      private var _r:uint;
      
      private var _g:uint;
      
      private var _b:uint;
      
      private var var_4233:Number;
      
      private var var_3994:Number;
      
      private var var_4122:Number;
      
      private var var_2205:ColorTransform;
      
      public function PartColor(param1:XML)
      {
         super();
         var_280 = parseInt(param1.@id);
         _index = parseInt(param1.@index);
         var_842 = parseInt(param1.@club);
         var_901 = Boolean(parseInt(param1.@selectable));
         var _loc2_:String = param1.text();
         var_3575 = parseInt(_loc2_,16);
         _r = var_3575 >> 16 & 255;
         _g = var_3575 >> 8 & 255;
         _b = var_3575 >> 0 & 255;
         var_4233 = _r / 255 * 1;
         var_3994 = _g / 255 * 1;
         var_4122 = _b / 255 * 1;
         var_2205 = new ColorTransform(var_4233,var_3994,var_4122);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return var_2205;
      }
      
      public function get redMultiplier() : Number
      {
         return var_4233;
      }
      
      public function get greenMultiplier() : Number
      {
         return var_3994;
      }
      
      public function get blueMultiplier() : Number
      {
         return var_4122;
      }
      
      public function get rgb() : uint
      {
         return var_3575;
      }
      
      public function get r() : uint
      {
         return _r;
      }
      
      public function get g() : uint
      {
         return _g;
      }
      
      public function get b() : uint
      {
         return _b;
      }
      
      public function get id() : int
      {
         return var_280;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get clubLevel() : int
      {
         return var_842;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_901;
      }
   }
}
