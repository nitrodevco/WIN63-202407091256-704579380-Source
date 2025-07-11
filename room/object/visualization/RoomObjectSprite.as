package com.sulake.room.object.visualization
{
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public final class RoomObjectSprite implements IRoomObjectSprite
   {
      
      private static var var_4433:int = 0;
       
      
      private var _asset:BitmapData = null;
      
      private var _assetName:String = "";
      
      private var _libraryAssetName:String = "";
      
      private var var_4777:String = null;
      
      private var var_4711:String = null;
      
      private var var_848:Boolean = true;
      
      private var var_881:String = "";
      
      private var _alpha:int = 255;
      
      private var _color:int = 16777215;
      
      private var var_4226:String = "normal";
      
      private var _flipH:Boolean = false;
      
      private var _flipV:Boolean = false;
      
      private var var_1210:int = 0;
      
      private var _offset:Point;
      
      private var _width:int = 0;
      
      private var var_46:int = 0;
      
      private var _depth:Number = 0;
      
      private var var_4439:int = 0;
      
      private var _varyingDepth:Boolean = false;
      
      private var var_3981:int = 128;
      
      private var var_4111:Boolean = false;
      
      private var var_4579:Boolean = false;
      
      private var var_1656:int = 0;
      
      private var var_3999:int = 0;
      
      private var _filters:Array = null;
      
      protected var var_3775:int;
      
      private var var_3402:String;
      
      public function RoomObjectSprite()
      {
         _offset = new Point(0,0);
         var_3775 = RoomObjectSpriteType.DEFAULT;
         super();
         var_3999 = var_4433++;
      }
      
      public function dispose() : void
      {
         _asset = null;
         _width = 0;
         var_46 = 0;
      }
      
      public function get asset() : BitmapData
      {
         return _asset;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get assetPosture() : String
      {
         return var_4777;
      }
      
      public function set assetPosture(param1:String) : void
      {
         var_4777 = param1;
      }
      
      public function get assetGesture() : String
      {
         return var_4711;
      }
      
      public function set assetGesture(param1:String) : void
      {
         var_4711 = param1;
      }
      
      public function get visible() : Boolean
      {
         return var_848;
      }
      
      public function get tag() : String
      {
         return var_881;
      }
      
      public function get alpha() : int
      {
         return _alpha;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function get blendMode() : String
      {
         return var_4226;
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get direction() : int
      {
         return var_1210;
      }
      
      public function get offsetX() : int
      {
         return _offset.x;
      }
      
      public function get offsetY() : int
      {
         return _offset.y;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_46;
      }
      
      public function get relativeDepth() : Number
      {
         return _depth;
      }
      
      public function get varyingDepth() : Boolean
      {
         return _varyingDepth;
      }
      
      public function get clickHandling() : Boolean
      {
         return var_4111;
      }
      
      public function get instanceId() : int
      {
         return var_3999;
      }
      
      public function get updateId() : int
      {
         return var_1656;
      }
      
      public function get filters() : Array
      {
         return _filters;
      }
      
      public function get spriteType() : int
      {
         return var_3775;
      }
      
      public function get objectType() : String
      {
         return var_3402;
      }
      
      public function set objectType(param1:String) : void
      {
         var_3402 = param1;
      }
      
      public function get planeId() : int
      {
         return var_4439;
      }
      
      public function set planeId(param1:int) : void
      {
         var_4439 = param1;
      }
      
      public function set spriteType(param1:int) : void
      {
         var_3775 = param1;
      }
      
      public function set asset(param1:BitmapData) : void
      {
         if(param1 == _asset)
         {
            return;
         }
         if(param1 != null)
         {
            _width = param1.width;
            var_46 = param1.height;
         }
         _asset = param1;
         var_1656++;
      }
      
      public function set assetName(param1:String) : void
      {
         if(param1 == _assetName)
         {
            return;
         }
         _assetName = param1;
         var_1656++;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(param1 == var_848)
         {
            return;
         }
         var_848 = param1;
         var_1656++;
      }
      
      public function set tag(param1:String) : void
      {
         if(param1 == var_881)
         {
            return;
         }
         var_881 = param1;
         var_1656++;
      }
      
      public function set alpha(param1:int) : void
      {
         param1 &= 255;
         if(param1 == _alpha)
         {
            return;
         }
         _alpha = param1;
         var_1656++;
      }
      
      public function set color(param1:int) : void
      {
         param1 &= 16777215;
         if(param1 == _color)
         {
            return;
         }
         _color = param1;
         var_1656++;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(param1 == var_4226)
         {
            return;
         }
         var_4226 = param1;
         var_1656++;
      }
      
      public function set filters(param1:Array) : void
      {
         if(param1 == _filters)
         {
            return;
         }
         _filters = param1;
         var_1656++;
      }
      
      public function set flipH(param1:Boolean) : void
      {
         if(param1 == _flipH)
         {
            return;
         }
         _flipH = param1;
         var_1656++;
      }
      
      public function set flipV(param1:Boolean) : void
      {
         if(param1 == _flipV)
         {
            return;
         }
         _flipV = param1;
         var_1656++;
      }
      
      public function set direction(param1:int) : void
      {
         var_1210 = param1;
      }
      
      public function set offsetX(param1:int) : void
      {
         if(param1 == _offset.x)
         {
            return;
         }
         _offset.x = param1;
         var_1656++;
      }
      
      public function set offsetY(param1:int) : void
      {
         if(param1 == _offset.y)
         {
            return;
         }
         _offset.y = param1;
         var_1656++;
      }
      
      public function set relativeDepth(param1:Number) : void
      {
         if(param1 == _depth)
         {
            return;
         }
         _depth = param1;
         var_1656++;
      }
      
      public function set varyingDepth(param1:Boolean) : void
      {
         if(param1 == _varyingDepth)
         {
            return;
         }
         _varyingDepth = param1;
         var_1656++;
      }
      
      public function set clickHandling(param1:Boolean) : void
      {
         if(var_4111 == param1)
         {
            return;
         }
         var_4111 = param1;
         var_1656++;
      }
      
      public function get alphaTolerance() : int
      {
         return var_3981;
      }
      
      public function set alphaTolerance(param1:int) : void
      {
         if(var_3981 == param1)
         {
            return;
         }
         var_3981 = param1;
         var_1656++;
      }
      
      public function get libraryAssetName() : String
      {
         return _libraryAssetName;
      }
      
      public function set libraryAssetName(param1:String) : void
      {
         _libraryAssetName = param1;
      }
      
      public function get skipMouseHandling() : Boolean
      {
         return var_4579;
      }
      
      public function set skipMouseHandling(param1:Boolean) : void
      {
         var_4579 = param1;
      }
   }
}
