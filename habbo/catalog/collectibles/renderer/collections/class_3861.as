package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   public class class_3861
   {
      
      public static var NO_DISPLAY:uint = 0;
      
      private static var var_4892:int = 1;
      
      private static var var_4177:int = 50;
      
      private static var endPercentage:int = 99;
      
      private static var startColor:uint = 12278528;
      
      private static var midColor:uint = 12952320;
      
      private static var endColor:uint = 8958976;
      
      private static var notStartedColor:uint = 8912917;
      
      private static var completionColor:uint = 37130;
       
      
      public function class_3861()
      {
         super();
      }
      
      public static function getColor(param1:int, param2:int) : uint
      {
         var _loc4_:Number = NaN;
         if(param1 == param2)
         {
            return completionColor;
         }
         if(param1 == 0)
         {
            return notStartedColor;
         }
         var _loc3_:Number = param1 * 100 / param2;
         if(_loc3_ <= var_4177)
         {
            _loc4_ = (_loc3_ - var_4892) / (var_4177 - var_4892);
            return interpolate(startColor,midColor,_loc4_);
         }
         _loc4_ = (_loc3_ - var_4177) / (endPercentage - var_4177);
         return interpolate(midColor,endColor,_loc4_);
      }
      
      private static function interpolate(param1:uint, param2:uint, param3:Number) : uint
      {
         var _loc5_:Object = hexToRGB(param1);
         var _loc4_:Object = hexToRGB(param2);
         var _loc6_:Object = {
            "r":_loc5_.r + param3 * (_loc4_.r - _loc5_.r),
            "g":_loc5_.g + param3 * (_loc4_.g - _loc5_.g),
            "b":_loc5_.b + param3 * (_loc4_.b - _loc5_.b)
         };
         return RGBToHex(_loc6_.r,_loc6_.g,_loc6_.b);
      }
      
      private static function hexToRGB(param1:uint) : Object
      {
         return {
            "r":param1 >> 16 & 255,
            "g":param1 >> 8 & 255,
            "b":param1 & 255
         };
      }
      
      private static function RGBToHex(param1:Number, param2:Number, param3:Number) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
   }
}
