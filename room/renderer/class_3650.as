package com.sulake.room.renderer
{
    import assets.class_14

    import com.sulake.core.utils.Map;
   import com.sulake.room.data.RoomObjectSpriteData;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.enum.RoomObjectSpriteType;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.renderer.cache.class_3686;
   import com.sulake.room.renderer.cache.class_3726;
   import com.sulake.room.renderer.cache.class_3730;
   import com.sulake.room.renderer.cache.class_3807;
   import com.sulake.room.renderer.cache.class_3826;
   import com.sulake.room.renderer.utils.class_3707;
   import com.sulake.room.renderer.utils.class_3727;
   import com.sulake.room.renderer.utils.class_3741;
   import com.sulake.room.renderer.utils.class_3815;
   import com.sulake.room.utils.*;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   [SecureSWF(rename="true")]
   public class class_3650 implements IRoomRenderingCanvas
   {
      
      private static const ZERO_POINT:Point = new Point(0,0);
      
      private static const SKIP_FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
      
      private static const FRAME_COUNT_FOR_UPDATE_INTERVAL:int = 50;
      
      private static const SLOW_FRAME_UPDATE_INTERVAL:Number = 60;
      
      private static const FAST_FRAME_UPDATE_INTERVAL:Number = 50;
      
      private static const MAXIMUM_VALID_FRAME_UPDATE_INTERVAL:int = 1000;
       
      
      private var _container:class_3446;
      
      private var _geometry:RoomGeometry;
      
      private var _bgColor:int = 0;
      
      private var var_1788:Sprite;
      
      private var var_1769:Sprite;
      
      private var _display:Sprite;
      
      private var var_2491:Map;
      
      private var var_2497:Point;
      
      private var _bitmapDataCache:class_3807;
      
      private var _roomObjectCache:class_3826;
      
      private var var_2273:Array;
      
      private var var_2449:Array;
      
      private var var_3305:IRoomRenderingCanvasMouseListener = null;
      
      private var var_280:int;
      
      private var _eventCache:Map = null;
      
      private var var_4154:int = 0;
      
      private var var_2447:int;
      
      private var var_2525:int;
      
      private var var_1942:int;
      
      private var var_1953:int;
      
      private var var_3666:int;
      
      private var var_3833:int;
      
      private var var_3458:int = -1;
      
      private var var_4299:Number = -10000000;
      
      private var var_4375:Number = -10000000;
      
      private var var_3095:int = 0;
      
      private var var_4131:Boolean = false;
      
      private var var_2881:Boolean = false;
      
      private var var_2205:ColorTransform;
      
      private var var_2459:Matrix;
      
      private var var_2182:Number = 0;
      
      private var var_2624:int = 0;
      
      private var _runningSlow:Boolean = false;
      
      private var _skipObjectUpdate:Boolean = false;
      
      private var var_3013:int = 0;
      
      private var var_4935:Boolean = false;
      
      private var var_4673:Array;
      
      private var var_2796:int = 0;
      
      private var var_3713:Number = 0;
      
      private var var_4911:int = 0;
      
      private var var_4194:int = 0;
      
      private var var_911:Number = 1;
      
      private var var_2658:Boolean;
      
      public function class_3650(param1:class_3446, param2:int, param3:int, param4:int, param5:int)
      {
         var_2491 = new Map();
         var_2497 = new Point();
         var_2273 = [];
         var_2449 = [];
         var_4673 = [];
         super();
         _container = param1;
         var_280 = param2;
         var_1788 = new Sprite();
         var_1788.mouseEnabled = false;
         _display = new Sprite();
         _display.name = "canvas";
         _display.mouseEnabled = false;
         var_1788.addChild(_display);
         _display.mouseEnabled = true;
         _display.doubleClickEnabled = true;
         _display.addEventListener("click",clickHandler);
         _display.addEventListener("doubleClick",clickHandler);
         _geometry = new RoomGeometry(param5,new Vector3d(-135,30,0),new Vector3d(11,11,5),new Vector3d(-135,0.5,0));
         _bitmapDataCache = new class_3807(16,32,1);
         var _loc6_:String = null;
         if(_container != null)
         {
            _loc6_ = _container.roomObjectVariableAccurateZ;
         }
         _eventCache = new Map();
         _roomObjectCache = new class_3826(_loc6_);
         var_2205 = new ColorTransform();
         var_2459 = new Matrix();
         initialize(param3,param4);
      }
      
      protected function get container() : class_3446
      {
         return _container;
      }
      
      protected function get activeSpriteCount() : int
      {
         return var_2796;
      }
      
      public function get width() : int
      {
         return var_2447 * var_911;
      }
      
      public function get height() : int
      {
         return var_2525 * var_911;
      }
      
      public function set screenOffsetX(param1:int) : void
      {
         var_2497.x -= param1 - var_1942;
         var_1942 = param1;
      }
      
      public function set screenOffsetY(param1:int) : void
      {
         var_2497.y -= param1 - var_1953;
         var_1953 = param1;
      }
      
      public function get screenOffsetX() : int
      {
         return var_1942;
      }
      
      public function get screenOffsetY() : int
      {
         return var_1953;
      }
      
      public function get displayObject() : DisplayObject
      {
         return var_1788;
      }
      
      public function get geometry() : IRoomGeometry
      {
         return _geometry;
      }
      
      public function set mouseListener(param1:IRoomRenderingCanvasMouseListener) : void
      {
         var_3305 = param1;
      }
      
      public function set useMask(param1:Boolean) : void
      {
         if(param1 && !var_2881)
         {
            var_2881 = true;
            if(var_1769 != null && !var_1788.contains(var_1769))
            {
               var_1788.addChild(var_1769);
               _display.mask = var_1769;
            }
         }
         else if(!param1 && var_2881)
         {
            var_2881 = false;
            if(var_1769 != null && var_1788.contains(var_1769))
            {
               var_1788.removeChild(var_1769);
               _display.mask = null;
            }
         }
      }
      
      public function getSortableSpriteList() : Vector.<RoomObjectSpriteData>
      {
         return _roomObjectCache.getSortableSpriteList();
      }
      
      public function getPlaneSortableSprites() : Array
      {
         return _roomObjectCache.getPlaneSortableSprites();
      }
      
      public function setScale(param1:Number, param2:Point = null, param3:Point = null, param4:Boolean = false) : void
      {
         if(!var_1788 || !var_1788.stage || !_display)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = new Point(var_1788.stage.stageWidth / 2,var_1788.stage.stageHeight / 2);
         }
         if(param3 == null)
         {
            param3 = param2;
         }
         param2 = _display.globalToLocal(param2);
         var_911 = param1;
         if(var_911 < 1)
         {
            _display.stage.quality = var_911 == 0.5 ? "best" : _display.stage.quality;
            if(!param4)
            {
               _display.rotationX = 0;
            }
         }
         else
         {
            recreateRoomDisplaySprite();
         }
         screenOffsetX = param3.x - param2.x * param1;
         screenOffsetY = param3.y - param2.y * param1;
      }
      
      private function recreateRoomDisplaySprite() : void
      {
         _display.removeEventListener("click",clickHandler);
         _display.removeEventListener("doubleClick",clickHandler);
         var_1788.removeChild(_display);
         var _loc1_:Sprite = new Sprite();
         while(_display.numChildren > 0)
         {
            _loc1_.addChild(_display.removeChildAt(0));
         }
         _loc1_.name = "canvas";
         _loc1_.mouseEnabled = false;
         var_1788.addChild(_loc1_);
         _loc1_.mouseEnabled = true;
         _loc1_.doubleClickEnabled = true;
         _loc1_.addEventListener("click",clickHandler);
         _loc1_.addEventListener("doubleClick",clickHandler);
         if(var_2881 && var_1769 != null)
         {
            _loc1_.mask = var_1769;
         }
         var_3666 = -1;
         var_3833 = -1;
         _display = _loc1_;
      }
      
      public function get scale() : Number
      {
         return var_911;
      }
      
      public function takeScreenShot() : BitmapData
      {
         var_2658 = true;
         var _loc5_:Number = var_911;
         var _loc2_:int = var_1942;
         var _loc1_:int = var_1953;
         var _loc6_:String = _display.stage.quality;
         setScale(1);
         var_1942 = 0;
         var_1953 = 0;
         _display.stage.quality = "low";
         render(-1,true);
         var _loc3_:BitmapData = new BitmapData(_display.width,_display.height,true,0);
         var _loc4_:Rectangle = _display.getBounds(_display);
         _loc3_.draw(_display,new Matrix(1,0,0,1,-_loc4_.x,-_loc4_.y));
         var_2658 = false;
         setScale(_loc5_);
         var_1942 = _loc2_;
         var_1953 = _loc1_;
         _display.stage.quality = _loc6_;
         return _loc3_;
      }
      
      public function skipSpriteVisibilityChecking() : void
      {
         var_2658 = true;
         render(-1,true);
      }
      
      public function resumeSpriteVisibilityChecking() : void
      {
         var_2658 = false;
      }
      
      public function dispose() : void
      {
         cleanSprites(0,true);
         if(_geometry != null)
         {
            _geometry.dispose();
            _geometry = null;
         }
         if(var_1769 != null)
         {
            var_1769 = null;
         }
         if(_bitmapDataCache != null)
         {
            _bitmapDataCache.dispose();
            _bitmapDataCache = null;
         }
         if(_roomObjectCache != null)
         {
            _roomObjectCache.dispose();
            _roomObjectCache = null;
         }
         _container = null;
         if(var_1788 != null)
         {
            while(var_1788.numChildren > 0)
            {
               var_1788.removeChildAt(0);
            }
            var_1788 = null;
         }
         _display = null;
         var_1769 = null;
         var_2273 = [];
         if(var_2491 != null)
         {
            var_2491.dispose();
            var_2491 = null;
         }
         var _loc1_:int = 0;
         if(var_2449 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_2449.length)
            {
               cleanSprite(var_2449[_loc1_] as class_3741,true);
               _loc1_++;
            }
            var_2449 = [];
         }
         if(_eventCache != null)
         {
            _eventCache.dispose();
            _eventCache = null;
         }
         var_3305 = null;
         var_2205 = null;
         var_2459 = null;
      }
      
      public function initialize(param1:int, param2:int) : void
      {
         if(param1 < 1)
         {
            param1 = 1;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(var_1769 != null)
         {
            var_1769.graphics.clear();
         }
         else
         {
            var_1769 = new Sprite();
            var_1769.name = "mask";
            if(var_2881)
            {
               var_1788.addChild(var_1769);
               _display.mask = var_1769;
            }
         }
         var_1769.graphics.beginFill(0);
         var_1769.graphics.drawRect(0,0,param1,param2);
         var_2447 = param1;
         var_2525 = param2;
      }
      
      public function roomObjectRemoved(param1:String) : void
      {
         _roomObjectCache.removeObjectCache(param1);
      }
      
      public function render(param1:int, param2:Boolean = false) : void
      {
         if(param1 == -1)
         {
            param1 == var_3458 + 1;
         }
         _skipObjectUpdate = !_skipObjectUpdate;
         var _loc6_:int = 0;
         if(_container == null || _geometry == null)
         {
            return;
         }
         if(param1 == var_3458)
         {
            return;
         }
         calculateUpdateInterval(param1);
         _bitmapDataCache.compress();
         var _loc7_:int = _container.getRoomObjectCount();
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:String = "";
         var _loc9_:IRoomObject = null;
         if(var_2447 != var_3666 || var_2525 != var_3833)
         {
            param2 = true;
         }
         if(_display.x != var_1942 || _display.y != var_1953 || _display.scaleX != var_911)
         {
            _display.x = var_1942;
            _display.y = var_1953;
            _display.scaleX = var_911;
            _display.scaleY = var_911;
            param2 = true;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            if((_loc9_ = _container.getRoomObjectWithIndex(_loc4_)) != null)
            {
               _loc8_ = _container.getRoomObjectIdWithIndex(_loc4_);
               _loc5_ += renderObject(_loc9_,_loc8_,param1,param2,_loc5_);
            }
            _loc4_++;
         }
         var_2273.sortOn("z",16);
         var_2273.reverse();
         if(_loc5_ < var_2273.length)
         {
            var_2273.splice(_loc5_);
         }
         var _loc3_:class_3707 = null;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = var_2273[_loc4_] as class_3707;
            if(_loc3_ != null)
            {
               updateSprite(_loc4_,_loc3_);
            }
            _loc4_++;
         }
         cleanSprites(_loc5_);
         var_3458 = param1;
         var_3666 = var_2447;
         var_3833 = var_2525;
      }
      
      private function calculateUpdateInterval(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Number = NaN;
         if(var_3458 > 0)
         {
            _loc3_ = param1 - var_3458;
            if(_loc3_ > 60 * 3)
            {
               class_14.log("Really slow frame update " + _loc3_ + "ms");
               var_4194 = _loc3_;
            }
            if(_loc3_ <= 1000)
            {
               var_2624++;
               if(var_2624 == 50 + 1)
               {
                  var_2182 = _loc3_;
                  var_3713 = var_4911;
               }
               else if(var_2624 > 50 + 1)
               {
                  _loc2_ = var_2624 - 50;
                  var_2182 = var_2182 * (_loc2_ - 1) / _loc2_ + _loc3_ / _loc2_;
                  var_3713 = var_3713 * (_loc2_ - 1) / _loc2_ + var_4911 / _loc2_;
                  if(var_2624 > 50 + 50)
                  {
                     var_2624 = 50;
                     if(!_runningSlow && var_2182 > 60)
                     {
                        _runningSlow = true;
                        class_14.log("Room canvas updating really slow - now entering frame skipping mode...");
                     }
                     else if(_runningSlow && var_2182 < 50)
                     {
                        _runningSlow = false;
                        class_14.log("Room canvas updating fast again - now entering normal frame mode...");
                     }
                     var_4194 = 0;
                  }
               }
            }
         }
      }
      
      protected function getRoomObjectCacheItem(param1:String) : class_3730
      {
         return _roomObjectCache.getObjectCache(param1);
      }
      
      private function renderObject(param1:IRoomObject, param2:String, param3:int, param4:Boolean, param5:int) : int
      {
         var _loc14_:int = 0;
         var _loc11_:BitmapData = null;
         var _loc8_:IRoomObjectSpriteVisualization;
         if((_loc8_ = param1.getVisualization() as IRoomObjectSpriteVisualization) == null)
         {
            _roomObjectCache.removeObjectCache(param2);
            return 0;
         }
         var _loc9_:class_3730;
         (_loc9_ = getRoomObjectCacheItem(param2)).objectId = param1.getId();
         var _loc20_:class_3686 = _loc9_.location;
         var _loc7_:class_3726 = _loc9_.sprites;
         var _loc10_:IVector3d;
         if((_loc10_ = _loc20_.getScreenLocation(param1,_geometry)) == null)
         {
            _roomObjectCache.removeObjectCache(param2);
            return 0;
         }
         _loc8_.update(_geometry,param3,!_loc7_.isEmpty || param4,_skipObjectUpdate && _runningSlow);
         var _loc17_:Boolean;
         if(_loc17_ = _loc20_.locationChanged)
         {
            param4 = true;
         }
         if(!_loc7_.needsUpdate(_loc8_.getInstanceId(),_loc8_.getUpdateID()) && !param4)
         {
            return _loc7_.spriteCount;
         }
         var _loc12_:int = _loc8_.spriteCount;
         var _loc16_:int = int(_loc10_.x);
         var _loc15_:int = int(_loc10_.y);
         var _loc13_:Number = Number(_loc10_.z);
         if(_loc16_ > 0)
         {
            _loc13_ += _loc16_ * 1.2e-7;
         }
         else
         {
            _loc13_ += -_loc16_ * 1.2e-7;
         }
         _loc16_ += int(var_2447 / 2);
         _loc15_ += int(var_2525 / 2);
         var _loc19_:int = 0;
         var _loc18_:class_3707 = null;
         var _loc6_:IRoomObjectSprite = null;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         _loc14_ = 0;
         while(_loc14_ < _loc12_)
         {
            if((_loc6_ = _loc8_.getSprite(_loc14_)) != null && _loc6_.visible)
            {
               if((_loc11_ = _loc6_.asset) != null)
               {
                  _loc21_ = _loc16_ + _loc6_.offsetX + var_1942;
                  _loc22_ = _loc15_ + _loc6_.offsetY + var_1953;
                  if(rectangleVisible(_loc21_,_loc22_,_loc11_.width,_loc11_.height))
                  {
                     if((_loc18_ = _loc7_.getSprite(_loc19_)) == null)
                     {
                        _loc18_ = new class_3707();
                        _loc7_.addSprite(_loc18_);
                        var_2273.push(_loc18_);
                        _loc18_.name = param2;
                     }
                     _loc18_.sprite = _loc6_;
                     if(_loc6_.spriteType == RoomObjectSpriteType.AVATAR || _loc6_.spriteType == RoomObjectSpriteType.var_4442)
                     {
                        _loc18_.sprite.libraryAssetName = param1.getAvatarLibraryAssetName();
                     }
                     _loc18_.x = _loc21_ - var_1942;
                     _loc18_.y = _loc22_ - var_1953;
                     _loc18_.z = _loc13_ + _loc6_.relativeDepth + 3.7e-11 * param5;
                     _loc19_++;
                     param5++;
                  }
               }
            }
            _loc14_++;
         }
         _loc7_.setSpriteCount(_loc19_);
         return _loc19_;
      }
      
      private function rectangleVisible(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         if(var_2658)
         {
            return true;
         }
         param1 = (param1 - var_1942) * var_911 + var_1942;
         param2 = (param2 - var_1953) * var_911 + var_1953;
         param3 *= var_911;
         param4 *= var_911;
         if(param1 < var_2447 && param1 + param3 >= 0 && (param2 < var_2525 && param2 + param4 >= 0))
         {
            if(!var_4935)
            {
               return true;
            }
            return rectangleVisibleWithExclusion(param1,param2,param3,param4);
         }
         return false;
      }
      
      private function rectangleVisibleWithExclusion(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         if(param1 < 0)
         {
            param3 += param1;
            param1 = 0;
         }
         if(param2 < 0)
         {
            param4 += param2;
            param2 = 0;
         }
         if(param1 + param3 >= var_2447)
         {
            param3 -= var_2447 + 1 - (param1 + param3);
         }
         if(param2 + param4 >= var_2525)
         {
            param4 -= var_2525 + 1 - (param2 + param4);
         }
         for each(var _loc5_ in var_4673)
         {
            if(param1 >= _loc5_.left && param1 + param3 < _loc5_.right && param2 >= _loc5_.top && param2 + param4 < _loc5_.bottom)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function getSprite(param1:int) : class_3741
      {
         if(param1 < 0 || param1 >= var_3013)
         {
            return null;
         }
         return _display.getChildAt(param1) as class_3741;
      }
      
      private function createSprite(param1:class_3707, param2:int = -1) : void
      {
         var _loc4_:class_3741 = null;
         var _loc3_:IRoomObjectSprite = param1.sprite;
         if(var_2449.length > 0)
         {
            _loc4_ = var_2449.pop() as class_3741;
         }
         if(_loc4_ == null)
         {
            _loc4_ = new class_3741();
         }
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.offsetRefX = _loc3_.offsetX;
         _loc4_.offsetRefY = _loc3_.offsetY;
         _loc4_.identifier = param1.name;
         _loc4_.alpha = _loc3_.alpha / 255;
         _loc4_.tag = _loc3_.tag;
         _loc4_.blendMode = _loc3_.blendMode;
         _loc4_.filters = _loc3_.filters;
         _loc4_.varyingDepth = _loc3_.varyingDepth;
         _loc4_.clickHandling = _loc3_.clickHandling;
         _loc4_.skipMouseHandling = _loc3_.skipMouseHandling;
         _loc4_.smoothing = false;
         _loc4_.pixelSnapping = "always";
         _loc4_.bitmapData = getBitmapData(_loc3_.asset,_loc3_.assetName,_loc3_.flipH,_loc3_.flipV,_loc3_.color);
         updateEnterRoomEffect(_loc4_,_loc3_);
         _loc4_.alphaTolerance = _loc3_.alphaTolerance;
         if(param2 < 0 || param2 >= var_3013)
         {
            _display.addChild(_loc4_);
            var_3013++;
         }
         else
         {
            _display.addChildAt(_loc4_,param2);
         }
         var_2796++;
      }
      
      private function updateSprite(param1:int, param2:class_3707) : Boolean
      {
         var _loc5_:Number = NaN;
         var _loc4_:BitmapData = null;
         if(param1 >= var_3013)
         {
            createSprite(param2);
            return true;
         }
         var _loc3_:IRoomObjectSprite = param2.sprite;
         var _loc6_:class_3741;
         if((_loc6_ = getSprite(param1)) != null)
         {
            if(_loc6_.varyingDepth != _loc3_.varyingDepth)
            {
               if(_loc6_.varyingDepth && !_loc3_.varyingDepth)
               {
                  _display.removeChildAt(param1);
                  var_2449.push(_loc6_);
                  return updateSprite(param1,param2);
               }
               createSprite(param2,param1);
               return true;
            }
            if(_loc6_.needsUpdate(_loc3_.instanceId,_loc3_.updateId) || RoomEnterEffect.isVisualizationOn())
            {
               _loc6_.alphaTolerance = _loc3_.alphaTolerance;
               _loc5_ = _loc3_.alpha / 255;
               if(_loc6_.alpha != _loc5_)
               {
                  _loc6_.alpha = _loc5_;
               }
               _loc6_.identifier = param2.name;
               _loc6_.tag = _loc3_.tag;
               _loc6_.varyingDepth = _loc3_.varyingDepth;
               _loc6_.blendMode = _loc3_.blendMode;
               _loc6_.clickHandling = _loc3_.clickHandling;
               _loc6_.skipMouseHandling = _loc3_.skipMouseHandling;
               _loc6_.filters = _loc3_.filters;
               _loc4_ = getBitmapData(_loc3_.asset,_loc3_.assetName,_loc3_.flipH,_loc3_.flipV,_loc3_.color);
               if(_loc6_.bitmapData != _loc4_)
               {
                  _loc6_.bitmapData = _loc4_;
               }
               updateEnterRoomEffect(_loc6_,_loc3_);
            }
            if(_loc6_.x != param2.x)
            {
               _loc6_.x = param2.x;
            }
            if(_loc6_.y != param2.y)
            {
               _loc6_.y = param2.y;
            }
            _loc6_.offsetRefX = _loc3_.offsetX;
            _loc6_.offsetRefY = _loc3_.offsetY;
            return true;
         }
         return false;
      }
      
      private function updateEnterRoomEffect(param1:class_3741, param2:IRoomObjectSprite) : void
      {
         if(!RoomEnterEffect.isVisualizationOn() || param1.bitmapData == null || param2 == null)
         {
            return;
         }
         switch(param2.spriteType)
         {
            case RoomObjectSpriteType.var_4442:
               break;
            case RoomObjectSpriteType.ROOM_PLANE:
               param1.alpha = RoomEnterEffect.getDelta(0.9);
               break;
            case RoomObjectSpriteType.AVATAR:
               param1.alpha = RoomEnterEffect.getDelta(0.5);
               break;
            default:
               param1.alpha = RoomEnterEffect.getDelta(0.1);
         }
      }
      
      private function cleanSprites(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         if(_display == null)
         {
            return;
         }
         if(param1 < 0)
         {
            param1 = 0;
         }
         var _loc3_:class_3741 = null;
         if(param1 < var_2796 || var_2796 == 0)
         {
            _loc4_ = var_3013 - 1;
            while(_loc4_ >= param1)
            {
               _loc3_ = getSprite(_loc4_);
               cleanSprite(_loc3_,param2);
               _loc4_--;
            }
         }
         var_2796 = param1;
      }
      
      private function cleanSprite(param1:class_3741, param2:Boolean) : void
      {
         if(param1 != null)
         {
            if(!param2)
            {
               param1.bitmapData = null;
            }
            else
            {
               param1.dispose();
            }
         }
      }
      
      private function getSortableSprite(param1:int) : class_3707
      {
         if(param1 < 0 || param1 >= var_2273.length)
         {
            return null;
         }
         return var_2273[param1] as class_3707;
      }
      
      private function getBitmapData(param1:BitmapData, param2:String, param3:Boolean, param4:Boolean, param5:int) : BitmapData
      {
         param5 &= 16777215;
         if(!param3 && !param4 && param5 == 16777215)
         {
            return param1;
         }
         var _loc7_:class_3815 = null;
         var _loc6_:String = "";
         if((param3 || param4) && param5 != 16777215)
         {
            _loc6_ = param2 + " " + param5 + (param3 ? " FH" : "") + (param4 ? " FV" : "");
            if(param2.length > 0)
            {
               _loc7_ = _bitmapDataCache.getBitmapData(_loc6_);
            }
            if(_loc7_ == null)
            {
               if((_loc7_ = getColoredBitmapData(param1,param2,param5)) != null)
               {
                  _loc7_ = getFlippedBitmapData(_loc7_,param2,true,param3,param4);
                  if(param2.length > 0)
                  {
                     _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
                  }
                  return _loc7_;
               }
               if((_loc7_ = getFlippedBitmapData(param1,param2,true,param3,param4)) != null)
               {
                  _loc7_ = getColoredBitmapData(_loc7_,"",param5,true);
                  if(param2.length > 0)
                  {
                     _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
                  }
                  return _loc7_;
               }
               _loc7_ = getColoredBitmapData(param1,param2,param5,true);
               _loc7_ = getFlippedBitmapData(_loc7_,param2,true,param3,param4);
               if(param2.length > 0)
               {
                  _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
               }
            }
         }
         else if(param3 || param4)
         {
            _loc7_ = getFlippedBitmapData(param1,param2,true,param3,param4);
         }
         else
         {
            if(param5 == 16777215)
            {
               return param1;
            }
            _loc7_ = getColoredBitmapData(param1,param2,param5,true);
         }
         return _loc7_;
      }
      
      private function getFlippedBitmapData(param1:BitmapData, param2:String, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false) : class_3815
      {
         var _loc6_:String = param2 + (param4 ? " FH" : "") + (param5 ? " FV" : "");
         var _loc7_:class_3815 = null;
         if(param2.length > 0)
         {
            _loc7_ = _bitmapDataCache.getBitmapData(_loc6_);
            if(!param3)
            {
               return _loc7_;
            }
         }
         if(_loc7_ == null)
         {
            try
            {
               _loc7_ = new class_3815(param1.width,param1.height,true,16777215);
            }
            catch(e:Error)
            {
               _loc7_ = new class_3815(1,1,true,16777215);
            }
            var_2459.identity();
            if(param4)
            {
               var_2459.scale(-1,1);
               var_2459.translate(param1.width,0);
            }
            if(param5)
            {
               var_2459.scale(1,-1);
               var_2459.translate(0,param1.height);
            }
            _loc7_.draw(param1,var_2459);
            if(param2.length > 0)
            {
               _bitmapDataCache.addBitmapData(_loc6_,_loc7_);
            }
         }
         return _loc7_;
      }
      
      private function getColoredBitmapData(param1:BitmapData, param2:String, param3:int, param4:Boolean = false) : class_3815
      {
         var _loc5_:* = 0;
         var _loc10_:* = 0;
         var _loc6_:* = 0;
         var _loc11_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc7_:String = param2 + " " + param3;
         var _loc9_:class_3815 = null;
         if(param2.length > 0)
         {
            _loc9_ = _bitmapDataCache.getBitmapData(_loc7_);
            if(!param4)
            {
               return _loc9_;
            }
         }
         if(_loc9_ == null)
         {
            _loc5_ = param3 >> 16 & 255;
            _loc10_ = param3 >> 8 & 255;
            _loc6_ = param3 & 255;
            _loc11_ = _loc5_ / 255;
            _loc8_ = _loc10_ / 255;
            _loc12_ = _loc6_ / 255;
            try
            {
               (_loc9_ = new class_3815(param1.width,param1.height,true,16777215)).copyPixels(param1,param1.rect,ZERO_POINT);
            }
            catch(e:Error)
            {
               _loc9_ = new class_3815(1,1,true,16777215);
            }
            var_2205.redMultiplier = _loc11_;
            var_2205.greenMultiplier = _loc8_;
            var_2205.blueMultiplier = _loc12_;
            _loc9_.colorTransform(_loc9_.rect,var_2205);
            if(param2.length > 0)
            {
               _bitmapDataCache.addBitmapData(_loc7_,_loc9_);
            }
         }
         return _loc9_;
      }
      
      protected function getObjectId(param1:class_3741) : String
      {
         var _loc2_:* = null;
         if(param1 != null)
         {
            return param1.identifier;
         }
         return "";
      }
      
      public function handleMouseEvent(param1:int, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         param1 -= var_1942;
         param2 -= var_1953;
         var_2497.x = param1 / var_911;
         var_2497.y = param2 / var_911;
         if(var_3095 > 0 && param3 == "mouseMove")
         {
            return var_4131;
         }
         var_4131 = checkMouseHits(param1 / var_911,param2 / var_911,param3,param4,param5,param6,param7);
         var_3095++;
         return var_4131;
      }
      
      protected function createMouseEvent(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : RoomSpriteMouseEvent
      {
         var _loc13_:Number = param1 - var_2447 / 2;
         var _loc14_:Number = param2 - var_2525 / 2;
         var _loc11_:String = "canvas_" + var_280;
         var _loc12_:RoomSpriteMouseEvent = null;
         return new RoomSpriteMouseEvent(param5,_loc11_ + "_" + var_4154,_loc11_,param6,_loc13_,_loc14_,param3,param4,param8,param7,param9,param10);
      }
      
      private function checkMouseClickHits(param1:Number, param2:Number, param3:Boolean, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         var _loc15_:String = "";
         var _loc12_:class_3741 = null;
         var _loc14_:RoomSpriteMouseEvent = null;
         var _loc9_:String = "click";
         if(param3)
         {
            _loc9_ = "doubleClick";
         }
         var _loc13_:Array = [];
         var _loc8_:int = 0;
         _loc8_ = activeSpriteCount - 1;
         while(_loc8_ >= 0)
         {
            if((_loc12_ = getSprite(_loc8_)) != null && _loc12_.clickHandling)
            {
               if(_loc12_.hitTest(param1 - _loc12_.x,param2 - _loc12_.y))
               {
                  _loc15_ = getObjectId(_loc12_);
                  if(_loc13_.indexOf(_loc15_) < 0)
                  {
                     _loc10_ = _loc12_.tag;
                     _loc14_ = createMouseEvent(param1,param2,param1 - _loc12_.x,param2 - _loc12_.y,_loc9_,_loc10_,param4,param5,param6,param7);
                     bufferMouseEvent(_loc14_,_loc15_);
                     _loc13_.push(_loc15_);
                  }
               }
               _loc11_ = true;
            }
            _loc8_--;
         }
         processMouseEvents();
         return _loc11_;
      }
      
      private function checkMouseHits(param1:int, param2:int, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc12_:String = null;
         var _loc16_:String = null;
         var _loc11_:int = 0;
         var _loc13_:Boolean = false;
         var _loc18_:String = "";
         var _loc14_:class_3741 = null;
         var _loc17_:RoomSpriteMouseEvent = null;
         var _loc15_:Array = [];
         var _loc8_:class_3727 = null;
         var _loc10_:int = 0;
         _loc10_ = activeSpriteCount - 1;
         while(_loc10_ >= 0)
         {
            if((_loc14_ = getSprite(_loc10_) as class_3741) != null && _loc14_.hitTestPoint(param1 - _loc14_.x,param2 - _loc14_.y))
            {
               if(!_loc14_.skipMouseHandling)
               {
                  if(!(_loc14_.clickHandling && (param3 == "click" || param3 == "doubleClick")))
                  {
                     _loc18_ = getObjectId(_loc14_);
                     if(_loc15_.indexOf(_loc18_) < 0)
                     {
                        _loc12_ = _loc14_.tag;
                        if((_loc8_ = var_2491.getValue(_loc18_) as class_3727) != null)
                        {
                           if(_loc8_.spriteTag != _loc12_)
                           {
                              _loc17_ = createMouseEvent(0,0,0,0,"rollOut",_loc8_.spriteTag,param4,param5,param6,param7);
                              bufferMouseEvent(_loc17_,_loc18_);
                           }
                        }
                        if(param3 == "mouseMove" && (_loc8_ == null || _loc8_.spriteTag != _loc12_))
                        {
                           _loc17_ = createMouseEvent(param1,param2,param1 - _loc14_.x,param2 - _loc14_.y,"rollOver",_loc12_,param4,param5,param6,param7);
                        }
                        else
                        {
                           (_loc17_ = createMouseEvent(param1,param2,param1 - _loc14_.x,param2 - _loc14_.y,param3,_loc12_,param4,param5,param6,param7)).spriteOffsetX = _loc14_.offsetRefX;
                           _loc17_.spriteOffsetY = _loc14_.offsetRefY;
                        }
                        if(_loc8_ == null)
                        {
                           (_loc8_ = new class_3727()).objectId = _loc18_;
                           var_2491.add(_loc18_,_loc8_);
                        }
                        _loc8_.spriteTag = _loc12_;
                        if(param3 != "mouseMove" || param1 != var_4299 || param2 != var_4375)
                        {
                           bufferMouseEvent(_loc17_,_loc18_);
                        }
                        _loc15_.push(_loc18_);
                     }
                     _loc13_ = true;
                  }
               }
            }
            _loc10_--;
         }
         var _loc9_:Array = var_2491.getKeys();
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            _loc16_ = _loc9_[_loc10_] as String;
            if((_loc11_ = _loc15_.indexOf(_loc16_)) >= 0)
            {
               _loc9_[_loc10_] = null;
            }
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < _loc9_.length)
         {
            if((_loc18_ = _loc9_[_loc10_] as String) != null)
            {
               if((_loc8_ = var_2491.remove(_loc18_) as class_3727) != null)
               {
                  _loc17_ = createMouseEvent(0,0,0,0,"rollOut",_loc8_.spriteTag,param4,param5,param6,param7);
                  bufferMouseEvent(_loc17_,_loc18_);
               }
            }
            _loc10_++;
         }
         processMouseEvents();
         var_4299 = param1;
         var_4375 = param2;
         return _loc13_;
      }
      
      protected function bufferMouseEvent(param1:RoomSpriteMouseEvent, param2:String) : void
      {
         if(_eventCache != null && param1 != null)
         {
            _eventCache.remove(param2);
            _eventCache.add(param2,param1);
         }
      }
      
      protected function processMouseEvents() : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:RoomSpriteMouseEvent = null;
         var _loc6_:IRoomObject = null;
         var _loc1_:IRoomObjectMouseHandler = null;
         if(_container == null || _eventCache == null)
         {
            return;
         }
         var _loc2_:int = int(_eventCache.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_eventCache == null)
            {
               return;
            }
            _loc5_ = _eventCache.getKey(_loc3_);
            _loc4_ = _eventCache.getWithIndex(_loc3_);
            if(_loc5_ != null && _loc4_ != null)
            {
               if((_loc6_ = _container.getRoomObject(_loc5_)) != null)
               {
                  if(var_3305 != null)
                  {
                     var_3305.processRoomCanvasMouseEvent(_loc4_,_loc6_,geometry);
                  }
                  else
                  {
                     _loc1_ = _loc6_.getMouseHandler();
                     if(_loc1_ != null)
                     {
                        _loc1_.mouseEvent(_loc4_,_geometry);
                     }
                  }
               }
            }
            _loc3_++;
         }
         if(_eventCache)
         {
            _eventCache.reset();
         }
      }
      
      public function update() : void
      {
         if(var_3095 == 0)
         {
            checkMouseHits(var_2497.x,var_2497.y,"mouseMove");
         }
         var_3095 = 0;
         var_4154++;
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = false;
         if(param1.type == "click" || param1.type == "doubleClick")
         {
            _loc2_ = param1.type == "doubleClick";
            checkMouseClickHits(param1.localX,param1.localY,_loc2_,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
         }
      }
      
      public function getId() : int
      {
         return var_280;
      }
   }
}
