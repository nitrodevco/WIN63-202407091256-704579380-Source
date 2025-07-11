package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.runtime.IDisposable;
   
   public class Location3D implements IDisposable
   {
       
      
      private var var_31:int;
      
      private var var_28:int;
      
      private var var_30:int;
      
      private var var_318:Boolean = false;
      
      public function Location3D(param1:int, param2:int, param3:int)
      {
         super();
         var_31 = param1;
         var_28 = param2;
         var_30 = param3;
      }
      
      public static function isInDistanceStatic(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc7_:int;
         if((_loc7_ = param3 - param1) < 0)
         {
            _loc7_ = -_loc7_;
         }
         var _loc6_:int;
         if((_loc6_ = param4 - param2) < 0)
         {
            _loc6_ = -_loc6_;
         }
         if(_loc6_ > param5 || _loc7_ > param5)
         {
            return false;
         }
         if(_loc7_ * _loc7_ + _loc6_ * _loc6_ < param5 * param5)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var_31 = 0;
         var_28 = 0;
         var_30 = 0;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get x() : int
      {
         return var_31;
      }
      
      public function get y() : int
      {
         return var_28;
      }
      
      public function get z() : int
      {
         return var_30;
      }
      
      public function changeLocation(param1:int, param2:int, param3:int) : void
      {
         var_31 = param1;
         var_28 = param2;
         var_30 = param3;
      }
      
      public function change2DLocation(param1:int, param2:int) : void
      {
         var_31 = param1;
         var_28 = param2;
      }
      
      public function changeLocationToLocation(param1:Location3D) : void
      {
         var_31 = param1.var_31;
         var_28 = param1.var_28;
         var_30 = param1.var_30;
      }
      
      public function distanceTo(param1:Location3D) : int
      {
         var _loc2_:int = param1.var_31 - var_31;
         var _loc3_:int = param1.var_28 - var_28;
         var _loc4_:int = param1.var_30 - var_30;
         return int(Math.abs(_loc2_) + Math.abs(_loc3_) + Math.abs(_loc4_));
      }
      
      public function directionTo(param1:Location3D) : Direction8
      {
         if(param1.var_31 == var_31 && param1.var_28 == var_28)
         {
            return null;
         }
         var _loc3_:int = param1.var_31 - var_31;
         var _loc2_:int = param1.var_28 - var_28;
         var _loc4_:int = Direction360.getAngleFromComponents(_loc3_,_loc2_);
         return Direction360.direction360ValueToDirection8(_loc4_);
      }
      
      public function equals(param1:Object) : Boolean
      {
         if(this == param1)
         {
            return true;
         }
         if(!(param1 is Location3D))
         {
            return false;
         }
         var _loc2_:Location3D = Location3D(param1);
         if(var_31 != _loc2_.var_31)
         {
            return false;
         }
         if(var_28 != _loc2_.var_28)
         {
            return false;
         }
         if(var_30 != _loc2_.var_30)
         {
            return false;
         }
         return true;
      }
      
      public function hashCode() : int
      {
         var _loc1_:int = 0;
         _loc1_ = var_31;
         _loc1_ = 29 * _loc1_ + var_28;
         return 29 * _loc1_ + var_30;
      }
      
      public function toString() : String
      {
         return "_x:" + var_31 + "yy:" + var_28 + "_zz:" + var_30;
      }
      
      public function isInDistance(param1:Location3D, param2:int) : Boolean
      {
         return isInDistanceStatic(var_31,var_28,param1.var_31,param1.var_28,param2);
      }
   }
}
