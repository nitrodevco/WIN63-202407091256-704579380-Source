package com.sulake.room.utils
{
   import com.sulake.core.utils.Map;
   import flash.geom.Point;
   
   public class RoomGeometry implements IRoomGeometry
   {
      
      public static const SCALE_ZOOMED_IN:Number = 64;
      
      public static const SCALE_ZOOMED_OUT:Number = 32;
       
      
      private var var_1744:int = 0;
      
      private var var_31:Vector3d;
      
      private var var_28:Vector3d;
      
      private var var_30:Vector3d;
      
      private var _directionAxis:Vector3d;
      
      private var var_587:Vector3d;
      
      private var var_1210:Vector3d;
      
      private var _depth:Vector3d;
      
      private var var_911:Number = 1;
      
      private var var_2345:Number = 1;
      
      private var var_2321:Number = 1;
      
      private var var_2320:Number = 1;
      
      private var _x_scale_internal:Number = 1;
      
      private var _y_scale_internal:Number = 1;
      
      private var _z_scale_internal:Number = 1;
      
      private var var_501:Vector3d;
      
      private var var_643:Vector3d;
      
      private var var_4956:Number = -500;
      
      private var var_4929:Number = 500;
      
      private var var_2379:Map = null;
      
      public function RoomGeometry(param1:Number, param2:IVector3d, param3:IVector3d, param4:IVector3d = null)
      {
         super();
         this.scale = param1;
         var_31 = new Vector3d();
         var_28 = new Vector3d();
         var_30 = new Vector3d();
         _directionAxis = new Vector3d();
         var_587 = new Vector3d();
         var_1210 = new Vector3d();
         _depth = new Vector3d();
         _x_scale_internal = 1;
         _y_scale_internal = 1;
         x_scale = 1;
         y_scale = 1;
         _z_scale_internal = Math.sqrt(0.5) / Math.sqrt(0.75);
         z_scale = 1;
         location = new Vector3d(param3.x,param3.y,param3.z);
         direction = new Vector3d(param2.x,param2.y,param2.z);
         if(param4 != null)
         {
            setDepthVector(param4);
         }
         else
         {
            setDepthVector(param2);
         }
         var_2379 = new Map();
      }
      
      public static function getIntersectionVector(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d) : IVector3d
      {
         var _loc6_:Number = Vector3d.dotProduct(param2,param4);
         if(Math.abs(_loc6_) < 0.00001)
         {
            return null;
         }
         var _loc8_:Vector3d = Vector3d.dif(param1,param3);
         var _loc5_:Number = -Vector3d.dotProduct(param4,_loc8_) / _loc6_;
         return Vector3d.sum(param1,Vector3d.product(param2,_loc5_));
      }
      
      public function get updateId() : int
      {
         return var_1744;
      }
      
      public function get scale() : Number
      {
         return var_911 / Math.sqrt(0.5);
      }
      
      public function get directionAxis() : IVector3d
      {
         return _directionAxis;
      }
      
      public function get location() : IVector3d
      {
         var_587.assign(var_501);
         var_587.x *= var_2345;
         var_587.y *= var_2321;
         var_587.z *= var_2320;
         return var_587;
      }
      
      public function get direction() : IVector3d
      {
         return var_1210;
      }
      
      public function set x_scale(param1:Number) : void
      {
         if(var_2345 != param1 * _x_scale_internal)
         {
            var_2345 = param1 * _x_scale_internal;
            var_1744++;
         }
      }
      
      public function set y_scale(param1:Number) : void
      {
         if(var_2321 != param1 * _y_scale_internal)
         {
            var_2321 = param1 * _y_scale_internal;
            var_1744++;
         }
      }
      
      public function set z_scale(param1:Number) : void
      {
         if(var_2320 != param1 * _z_scale_internal)
         {
            var_2320 = param1 * _z_scale_internal;
            var_1744++;
         }
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 <= 1)
         {
            param1 = 1;
         }
         param1 *= Math.sqrt(0.5);
         if(param1 != var_911)
         {
            var_911 = param1;
            var_1744++;
         }
      }
      
      public function set location(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_501 == null)
         {
            var_501 = new Vector3d();
         }
         var _loc2_:Number = var_501.x;
         var _loc3_:Number = var_501.y;
         var _loc4_:Number = var_501.z;
         var_501.assign(param1);
         var_501.x /= var_2345;
         var_501.y /= var_2321;
         var_501.z /= var_2320;
         if(var_501.x != _loc2_ || var_501.y != _loc3_ || var_501.z != _loc4_)
         {
            var_1744++;
         }
      }
      
      public function set direction(param1:IVector3d) : void
      {
         var _loc4_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc19_:Vector3d = null;
         var _loc14_:Vector3d = null;
         var _loc2_:Vector3d = null;
         if(param1 == null)
         {
            return;
         }
         if(var_643 == null)
         {
            var_643 = new Vector3d();
         }
         var _loc7_:Number = var_643.x;
         var _loc8_:Number = var_643.y;
         var _loc9_:Number = var_643.z;
         var_643.assign(param1);
         var_1210.assign(param1);
         if(var_643.x != _loc7_ || var_643.y != _loc8_ || var_643.z != _loc9_)
         {
            var_1744++;
         }
         var _loc18_:Vector3d = new Vector3d(0,1,0);
         var _loc20_:Vector3d = new Vector3d(0,0,1);
         var _loc22_:Vector3d = new Vector3d(1,0,0);
         var _loc10_:Number = param1.x / 180 * 3.141592653589793;
         var _loc11_:Number = param1.y / 180 * 3.141592653589793;
         var _loc12_:Number = param1.z / 180 * 3.141592653589793;
         var _loc6_:Number = Math.cos(_loc10_);
         var _loc25_:Number = Math.sin(_loc10_);
         var _loc16_:Vector3d = Vector3d.sum(Vector3d.product(_loc18_,_loc6_),Vector3d.product(_loc22_,-_loc25_));
         var _loc15_:Vector3d = new Vector3d(_loc20_.x,_loc20_.y,_loc20_.z);
         var _loc17_:Vector3d = Vector3d.sum(Vector3d.product(_loc18_,_loc25_),Vector3d.product(_loc22_,_loc6_));
         var _loc5_:Number = Math.cos(_loc11_);
         var _loc24_:Number = Math.sin(_loc11_);
         var _loc13_:Vector3d = new Vector3d(_loc16_.x,_loc16_.y,_loc16_.z);
         var _loc23_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc5_),Vector3d.product(_loc17_,_loc24_));
         var _loc3_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,-_loc24_),Vector3d.product(_loc17_,_loc5_));
         if(_loc12_ != 0)
         {
            _loc4_ = Math.cos(_loc12_);
            _loc21_ = Math.sin(_loc12_);
            _loc19_ = Vector3d.sum(Vector3d.product(_loc13_,_loc4_),Vector3d.product(_loc23_,_loc21_));
            _loc14_ = Vector3d.sum(Vector3d.product(_loc13_,-_loc21_),Vector3d.product(_loc23_,_loc4_));
            _loc2_ = new Vector3d(_loc3_.x,_loc3_.y,_loc3_.z);
            var_31.assign(_loc19_);
            var_28.assign(_loc14_);
            var_30.assign(_loc2_);
            _directionAxis.assign(var_30);
         }
         else
         {
            var_31.assign(_loc13_);
            var_28.assign(_loc23_);
            var_30.assign(_loc3_);
            _directionAxis.assign(var_30);
         }
      }
      
      public function dispose() : void
      {
         var_31 = null;
         var_28 = null;
         var_30 = null;
         var_501 = null;
         var_643 = null;
         _directionAxis = null;
         var_587 = null;
         if(var_2379 != null)
         {
            var_2379.dispose();
            var_2379 = null;
         }
      }
      
      public function setDisplacement(param1:IVector3d, param2:IVector3d) : void
      {
         var _loc4_:String = null;
         var _loc3_:Vector3d = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(var_2379 != null)
         {
            _loc4_ = int(Math.round(param1.x)) + "_" + int(Math.round(param1.y)) + "_" + int(Math.round(param1.z));
            var_2379.remove(_loc4_);
            _loc3_ = new Vector3d();
            _loc3_.assign(param2);
            var_2379.add(_loc4_,_loc3_);
            var_1744++;
         }
      }
      
      private function getDisplacenent(param1:IVector3d) : IVector3d
      {
         var _loc2_:String = null;
         if(var_2379 != null)
         {
            _loc2_ = int(Math.round(param1.x)) + "_" + int(Math.round(param1.y)) + "_" + int(Math.round(param1.z));
            return var_2379.getValue(_loc2_);
         }
         return null;
      }
      
      public function setDepthVector(param1:IVector3d) : void
      {
         var _loc9_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc16_:Vector3d = null;
         var _loc7_:Vector3d = null;
         var _loc4_:Vector3d = null;
         var _loc15_:Vector3d = new Vector3d(0,1,0);
         var _loc17_:Vector3d = new Vector3d(0,0,1);
         var _loc19_:Vector3d = new Vector3d(1,0,0);
         var _loc2_:Number = param1.x / 180 * 3.141592653589793;
         var _loc3_:Number = param1.y / 180 * 3.141592653589793;
         var _loc5_:Number = param1.z / 180 * 3.141592653589793;
         var _loc11_:Number = Math.cos(_loc2_);
         var _loc22_:Number = Math.sin(_loc2_);
         var _loc13_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc11_),Vector3d.product(_loc19_,-_loc22_));
         var _loc12_:Vector3d = new Vector3d(_loc17_.x,_loc17_.y,_loc17_.z);
         var _loc14_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc22_),Vector3d.product(_loc19_,_loc11_));
         var _loc10_:Number = Math.cos(_loc3_);
         var _loc21_:Number = Math.sin(_loc3_);
         var _loc6_:Vector3d = new Vector3d(_loc13_.x,_loc13_.y,_loc13_.z);
         var _loc20_:Vector3d = Vector3d.sum(Vector3d.product(_loc12_,_loc10_),Vector3d.product(_loc14_,_loc21_));
         var _loc8_:Vector3d = Vector3d.sum(Vector3d.product(_loc12_,-_loc21_),Vector3d.product(_loc14_,_loc10_));
         if(_loc5_ != 0)
         {
            _loc9_ = Math.cos(_loc5_);
            _loc18_ = Math.sin(_loc5_);
            _loc16_ = Vector3d.sum(Vector3d.product(_loc6_,_loc9_),Vector3d.product(_loc20_,_loc18_));
            _loc7_ = Vector3d.sum(Vector3d.product(_loc6_,-_loc18_),Vector3d.product(_loc20_,_loc9_));
            _loc4_ = new Vector3d(_loc8_.x,_loc8_.y,_loc8_.z);
            _depth.assign(_loc4_);
         }
         else
         {
            _depth.assign(_loc8_);
         }
         var_1744++;
      }
      
      public function adjustLocation(param1:IVector3d, param2:Number) : void
      {
         if(param1 == null || var_30 == null)
         {
            return;
         }
         var _loc4_:Vector3d = Vector3d.product(var_30,-param2);
         var _loc3_:Vector3d = new Vector3d(param1.x + _loc4_.x,param1.y + _loc4_.y,param1.z + _loc4_.z);
         location = _loc3_;
      }
      
      public function getCoordinatePosition(param1:IVector3d) : IVector3d
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Number = Vector3d.scalarProjection(param1,var_31);
         var _loc4_:Number = Vector3d.scalarProjection(param1,var_28);
         var _loc5_:Number = Vector3d.scalarProjection(param1,var_30);
         return new Vector3d(_loc3_,_loc4_,_loc5_);
      }
      
      public function getScreenPosition(param1:IVector3d) : IVector3d
      {
         var _loc2_:Vector3d = Vector3d.dif(param1,var_501);
         _loc2_.x *= var_2345;
         _loc2_.y *= var_2321;
         _loc2_.z *= var_2320;
         var _loc5_:Number;
         if((_loc5_ = Vector3d.scalarProjection(_loc2_,_depth)) < var_4956 || _loc5_ > var_4929)
         {
            return null;
         }
         var _loc3_:Number = Vector3d.scalarProjection(_loc2_,var_31);
         var _loc4_:Number = -Vector3d.scalarProjection(_loc2_,var_28);
         _loc3_ *= var_911;
         _loc4_ *= var_911;
         var _loc6_:IVector3d;
         if((_loc6_ = getDisplacenent(param1)) != null)
         {
            _loc2_ = Vector3d.dif(param1,var_501);
            _loc2_.add(_loc6_);
            _loc2_.x *= var_2345;
            _loc2_.y *= var_2321;
            _loc2_.z *= var_2320;
            _loc5_ = Vector3d.scalarProjection(_loc2_,_depth);
         }
         _loc2_.x = _loc3_;
         _loc2_.y = _loc4_;
         _loc2_.z = _loc5_;
         return _loc2_;
      }
      
      public function getScreenPoint(param1:IVector3d) : Point
      {
         var _loc2_:IVector3d = getScreenPosition(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y);
      }
      
      public function getPlanePosition(param1:Point, param2:IVector3d, param3:IVector3d, param4:IVector3d) : Point
      {
         var _loc10_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc14_:Number = param1.x / var_911;
         var _loc16_:Number = -param1.y / var_911;
         var _loc6_:Vector3d;
         (_loc6_ = Vector3d.product(var_31,_loc14_)).add(Vector3d.product(var_28,_loc16_));
         var _loc8_:Vector3d;
         (_loc8_ = new Vector3d(var_501.x * var_2345,var_501.y * var_2321,var_501.z * var_2320)).add(_loc6_);
         var _loc15_:IVector3d = var_30;
         var _loc5_:Vector3d = new Vector3d(param2.x * var_2345,param2.y * var_2321,param2.z * var_2320);
         var _loc13_:Vector3d = new Vector3d(param3.x * var_2345,param3.y * var_2321,param3.z * var_2320);
         var _loc7_:Vector3d = new Vector3d(param4.x * var_2345,param4.y * var_2321,param4.z * var_2320);
         var _loc11_:IVector3d = Vector3d.crossProduct(_loc13_,_loc7_);
         var _loc9_:Vector3d;
         (_loc9_ = new Vector3d()).assign(RoomGeometry.getIntersectionVector(_loc8_,_loc15_,_loc5_,_loc11_));
         if(_loc9_ != null)
         {
            _loc9_.sub(_loc5_);
            _loc10_ = Vector3d.scalarProjection(_loc9_,param3) / _loc13_.length * param3.length;
            _loc12_ = Vector3d.scalarProjection(_loc9_,param4) / _loc7_.length * param4.length;
            return new Point(_loc10_,_loc12_);
         }
         return null;
      }
      
      public function performZoom() : void
      {
         if(isZoomedIn())
         {
            scale = 32;
         }
         else
         {
            scale = 64;
         }
      }
      
      public function isZoomedIn() : Boolean
      {
         return scale == 64;
      }
      
      public function performZoomOut() : void
      {
         scale = 32;
      }
      
      public function performZoomIn() : void
      {
         scale = 64;
      }
   }
}
