package com.sulake.room.renderer.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   [SecureSWF(rename="true")]
   public class class_3741 extends Bitmap
   {
       
      
      private var var_3857:int = 128;
      
      private var _basePoint:Point;
      
      private var var_881:String = "";
      
      private var var_443:String = "";
      
      private var var_4111:Boolean = false;
      
      private var var_4579:Boolean = false;
      
      private var _varyingDepth:Boolean = false;
      
      private var _bitmapData:class_3815 = null;
      
      private var _width:int = 0;
      
      private var var_46:int = 0;
      
      private var _updateID1:int = -1;
      
      private var _updateID2:int = -1;
      
      private var _offsetRefX:int = 0;
      
      private var _offsetRefY:int = 0;
      
      public function class_3741()
      {
         super();
         _basePoint = new Point();
         cacheAsBitmap = false;
      }
      
      public function get alphaTolerance() : int
      {
         return var_3857;
      }
      
      public function set alphaTolerance(param1:int) : void
      {
         var_3857 = param1;
      }
      
      public function get tag() : String
      {
         return var_881;
      }
      
      public function set tag(param1:String) : void
      {
         var_881 = param1;
      }
      
      public function get identifier() : String
      {
         return var_443;
      }
      
      public function set identifier(param1:String) : void
      {
         var_443 = param1;
      }
      
      public function get varyingDepth() : Boolean
      {
         return _varyingDepth;
      }
      
      public function set varyingDepth(param1:Boolean) : void
      {
         _varyingDepth = param1;
      }
      
      public function get clickHandling() : Boolean
      {
         return var_4111;
      }
      
      public function set clickHandling(param1:Boolean) : void
      {
         var_4111 = param1;
      }
      
      public function get skipMouseHandling() : Boolean
      {
         return var_4579;
      }
      
      public function set skipMouseHandling(param1:Boolean) : void
      {
         var_4579 = param1;
      }
      
      public function get offsetRefX() : int
      {
         return _offsetRefX;
      }
      
      public function set offsetRefX(param1:int) : void
      {
         _offsetRefX = param1;
      }
      
      public function get offsetRefY() : int
      {
         return _offsetRefY;
      }
      
      public function set offsetRefY(param1:int) : void
      {
         _offsetRefY = param1;
      }
      
      public function dispose() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         var _loc2_:class_3815 = null;
         if(param1 == bitmapData)
         {
            return;
         }
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(param1 != null)
         {
            _width = param1.width;
            var_46 = param1.height;
            _loc2_ = param1 as class_3815;
            if(_loc2_ != null)
            {
               _loc2_.addReference();
               _bitmapData = _loc2_;
            }
         }
         else
         {
            _width = 0;
            var_46 = 0;
            _updateID1 = -1;
            _updateID2 = -1;
         }
         super.bitmapData = param1;
      }
      
      public function needsUpdate(param1:int, param2:int) : Boolean
      {
         if(param1 != _updateID1 || param2 != _updateID2)
         {
            _updateID1 = param1;
            _updateID2 = param2;
            return true;
         }
         if(_bitmapData != null && _bitmapData.disposed)
         {
            return true;
         }
         return false;
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return hitTest(param1,param2);
      }
      
      public function hitTest(param1:int, param2:int) : Boolean
      {
         if(var_3857 > 255 || bitmapData == null)
         {
            return false;
         }
         if(param1 < 0 || param2 < 0 || param1 >= _width || param2 >= var_46)
         {
            return false;
         }
         return hitTestBitmapData(param1,param2);
      }
      
      private function hitTestBitmapData(param1:int, param2:int) : Boolean
      {
         var _loc4_:* = 0;
         var _loc3_:* = false;
         try
         {
            _loc3_ = (_loc4_ = uint((_loc4_ = bitmapData.getPixel32(param1,param2)) >> 24)) > var_3857;
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
   }
}
