package com.sulake.habbo.avatar.geometry
{
   public class Vector3D
   {
       
      
      private var var_31:Number;
      
      private var var_28:Number;
      
      private var var_30:Number;
      
      public function Vector3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         var_31 = param1;
         var_28 = param2;
         var_30 = param3;
      }
      
      public static function dot(param1:Vector3D, param2:Vector3D) : Number
      {
         return param1.x * param2.x + param1.y * param2.y + param1.z * param2.z;
      }
      
      public static function cross(param1:Vector3D, param2:Vector3D) : Vector3D
      {
         var _loc3_:Vector3D = new Vector3D();
         _loc3_.x = param1.y * param2.z - param1.z * param2.y;
         _loc3_.y = param1.z * param2.x - param1.x * param2.z;
         _loc3_.z = param1.x * param2.y - param1.y * param2.x;
         return _loc3_;
      }
      
      public static function subtract(param1:Vector3D, param2:Vector3D) : Vector3D
      {
         return new Vector3D(param1.x - param2.x,param1.y - param2.y,param1.z - param2.z);
      }
      
      public function dot(param1:Vector3D) : Number
      {
         return var_31 * param1.x + var_28 * param1.y + var_30 * param1.z;
      }
      
      public function cross(param1:Vector3D) : Vector3D
      {
         var _loc2_:Vector3D = new Vector3D();
         _loc2_.x = var_28 * param1.z - var_30 * param1.y;
         _loc2_.y = var_30 * param1.x - var_31 * param1.z;
         _loc2_.z = var_31 * param1.y - var_28 * param1.x;
         return _loc2_;
      }
      
      public function subtract(param1:Vector3D) : void
      {
         var_31 -= param1.x;
         var_28 -= param1.y;
         var_30 -= param1.z;
      }
      
      public function add(param1:Vector3D) : void
      {
         var_31 += param1.x;
         var_28 += param1.y;
         var_30 += param1.z;
      }
      
      public function normalize() : void
      {
         var _loc1_:Number = 1 / this.length();
         var_31 *= _loc1_;
         var_28 *= _loc1_;
         var_30 *= _loc1_;
      }
      
      public function length() : Number
      {
         return Math.sqrt(var_31 * var_31 + var_28 * var_28 + var_30 * var_30);
      }
      
      public function toString() : String
      {
         return "Vector3D: (" + var_31 + "," + var_28 + "," + var_30 + ")";
      }
      
      public function get x() : Number
      {
         return var_31;
      }
      
      public function get y() : Number
      {
         return var_28;
      }
      
      public function get z() : Number
      {
         return var_30;
      }
      
      public function set x(param1:Number) : void
      {
         var_31 = param1;
      }
      
      public function set y(param1:Number) : void
      {
         var_28 = param1;
      }
      
      public function set z(param1:Number) : void
      {
         var_30 = param1;
      }
   }
}
