package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.Map;
   import flash.geom.ColorTransform;
   
   public class AvatarDataContainer implements class_3581
   {
       
      
      private var var_4150:int;
      
      private var var_4725:uint;
      
      private var var_4350:uint;
      
      private var var_2205:ColorTransform;
      
      private var var_3575:uint;
      
      private var _r:uint;
      
      private var _g:uint;
      
      private var _b:uint;
      
      private var var_4233:Number = 1;
      
      private var var_3994:Number = 1;
      
      private var var_4122:Number = 1;
      
      private var var_2792:Number = 1;
      
      private var var_3487:Map;
      
      private var var_4405:Boolean = true;
      
      public function AvatarDataContainer(param1:XML)
      {
         super();
         var_4150 = parseInt(param1.@ink);
         var _loc2_:String = String(param1.@foreground);
         _loc2_ = _loc2_.replace("#","");
         var _loc3_:String = String(param1.@background);
         _loc3_ = _loc3_.replace("#","");
         var_4725 = parseInt(_loc2_,16);
         var_4350 = parseInt(_loc3_,16);
         var_3575 = parseInt(_loc2_,16);
         _r = var_3575 >> 16 & 255;
         _g = var_3575 >> 8 & 255;
         _b = var_3575 >> 0 & 255;
         var_4233 = _r / 255 * 1;
         var_3994 = _g / 255 * 1;
         var_4122 = _b / 255 * 1;
         if(var_4150 == 37)
         {
            var_2792 = 0.5;
            var_4405 = false;
         }
         var_2205 = new ColorTransform(var_4233,var_3994,var_4122,var_2792);
         var_3487 = generatePaletteMapForGrayscale(var_4350,var_4725);
      }
      
      public function get ink() : int
      {
         return var_4150;
      }
      
      public function get colorTransform() : ColorTransform
      {
         return var_2205;
      }
      
      public function get reds() : Array
      {
         return var_3487.getValue("reds") as Array;
      }
      
      public function get greens() : Array
      {
         return var_3487.getValue("greens") as Array;
      }
      
      public function get blues() : Array
      {
         return var_3487.getValue("blues") as Array;
      }
      
      public function get alphas() : Array
      {
         return var_3487.getValue("alphas") as Array;
      }
      
      public function get paletteIsGrayscale() : Boolean
      {
         return var_4405;
      }
      
      private function generatePaletteMapForGrayscale(param1:uint, param2:uint) : Map
      {
         var _loc9_:int = 0;
         var _loc15_:* = param1 >> 24 & 255;
         var _loc24_:* = param1 >> 16 & 255;
         var _loc10_:* = param1 >> 8 & 255;
         var _loc14_:* = param1 >> 0 & 255;
         var _loc17_:* = param2 >> 24 & 255;
         var _loc3_:* = param2 >> 16 & 255;
         var _loc11_:* = param2 >> 8 & 255;
         var _loc16_:* = param2 >> 0 & 255;
         var _loc21_:Number = (_loc17_ - _loc15_) / 255;
         var _loc12_:Number = (_loc3_ - _loc24_) / 255;
         var _loc6_:Number = (_loc11_ - _loc10_) / 255;
         var _loc23_:Number = (_loc16_ - _loc14_) / 255;
         var _loc22_:Map = new Map();
         var _loc19_:Array = [];
         var _loc8_:Array = [];
         var _loc13_:Array = [];
         var _loc20_:Array = [];
         var _loc4_:Number = _loc15_;
         var _loc18_:Number = _loc24_;
         var _loc7_:Number = _loc10_;
         var _loc5_:Number = _loc14_;
         _loc9_ = 0;
         while(_loc9_ < 256)
         {
            if(_loc18_ == _loc24_ && _loc7_ == _loc10_ && _loc5_ == _loc14_)
            {
               _loc4_ = 0;
            }
            _loc4_ += _loc21_;
            _loc18_ += _loc12_;
            _loc7_ += _loc6_;
            _loc5_ += _loc23_;
            _loc20_.push(_loc4_ << 24);
            _loc19_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc8_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc13_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc9_++;
         }
         _loc22_.add("alphas",_loc19_);
         _loc22_.add("reds",_loc19_);
         _loc22_.add("greens",_loc8_);
         _loc22_.add("blues",_loc13_);
         return _loc22_;
      }
   }
}
