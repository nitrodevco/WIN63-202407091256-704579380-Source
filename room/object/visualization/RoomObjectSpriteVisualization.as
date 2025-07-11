package com.sulake.room.object.visualization
{
    import assets.class_14

    import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.class_3367;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization
   {
      
      protected static const const_908:String = "_";
      
      protected static const ICON_LAYER_ID:String = "_icon_";
      
      private static var var_4433:int = 0;
       
      
      private var var_1761:Array;
      
      private var var_2060:IRoomObject;
      
      private var var_2647:class_3367;
      
      protected var var_2880:int = -1;
      
      protected var var_1804:int = -1;
      
      protected var var_1755:int = -1;
      
      private var var_3999:int = 0;
      
      private var var_1656:int = 0;
      
      public function RoomObjectSpriteVisualization()
      {
         super();
         var_3999 = var_4433++;
         var_1761 = [];
         var_2060 = null;
         var_2647 = null;
      }
      
      public function dispose() : void
      {
         var _loc1_:RoomObjectSprite = null;
         if(var_1761 != null)
         {
            while(var_1761.length > 0)
            {
               _loc1_ = var_1761[0] as RoomObjectSprite;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               var_1761.pop();
            }
            var_1761 = null;
         }
         var_2060 = null;
         assetCollection = null;
      }
      
      public function set assetCollection(param1:class_3367) : void
      {
         if(var_2647 != null)
         {
            var_2647.removeReference();
         }
         var_2647 = param1;
         if(var_2647 != null)
         {
            var_2647.addReference();
         }
      }
      
      public function setExternalBaseUrls(param1:String, param2:String, param3:Boolean) : void
      {
      }
      
      public function get assetCollection() : class_3367
      {
         return var_2647;
      }
      
      public function getUpdateID() : int
      {
         return var_1656;
      }
      
      public function getInstanceId() : int
      {
         return var_3999;
      }
      
      protected function createSprites(param1:int) : void
      {
         var _loc2_:RoomObjectSprite = null;
         while(var_1761.length > param1)
         {
            _loc2_ = var_1761[var_1761.length - 1] as RoomObjectSprite;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            var_1761.pop();
         }
         while(var_1761.length < param1)
         {
            _loc2_ = new RoomObjectSprite();
            var_1761.push(_loc2_);
         }
      }
      
      public function addSprite() : IRoomObjectSprite
      {
         return addSpriteAt(var_1761.length);
      }
      
      public function addSpriteAt(param1:int) : IRoomObjectSprite
      {
         var _loc2_:IRoomObjectSprite = new RoomObjectSprite();
         if(param1 >= var_1761.length)
         {
            var_1761.push(_loc2_);
         }
         else
         {
            var_1761.splice(param1,0,_loc2_);
         }
         return _loc2_;
      }
      
      public function removeSprite(param1:IRoomObjectSprite) : void
      {
         var _loc2_:int = var_1761.indexOf(param1);
         if(_loc2_ == -1)
         {
            throw new Error("Trying to remove non-existing sprite!");
         }
         var_1761.splice(_loc2_,1);
         RoomObjectSprite(param1).dispose();
      }
      
      public function get spriteCount() : int
      {
         return var_1761.length;
      }
      
      public function getSprite(param1:int) : IRoomObjectSprite
      {
         if(param1 >= 0 && param1 < var_1761.length)
         {
            return var_1761[param1];
         }
         return null;
      }
      
      public function get object() : IRoomObject
      {
         return var_2060;
      }
      
      public function set object(param1:IRoomObject) : void
      {
         var_2060 = param1;
      }
      
      public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
      }
      
      protected function increaseUpdateId() : void
      {
         var_1656++;
      }
      
      protected function reset() : void
      {
         var_2880 = 4294967295;
         var_1804 = 4294967295;
         var_1755 = -1;
      }
      
      public function getSpriteList() : Array
      {
         return null;
      }
      
      public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         return false;
      }
      
      public function get image() : BitmapData
      {
         return getImage(0,-1);
      }
      
      private function normalizeColourComponent(param1:int) : Number
      {
         return Math.max(0,Math.min(255,param1)) / 255;
      }
      
      public function getImage(param1:int, param2:int) : BitmapData
      {
         var _loc16_:Number = NaN;
         var _loc6_:int = 0;
         var _loc15_:* = 0;
         var _loc9_:* = 0;
         var _loc4_:* = 0;
         var _loc19_:ColorTransform = null;
         var _loc7_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc13_:Matrix = null;
         var _loc8_:Rectangle;
         if((_loc8_ = boundingRectangle).width * _loc8_.height == 0)
         {
            return null;
         }
         var _loc10_:int = spriteCount;
         var _loc3_:IRoomObjectSprite = null;
         var _loc12_:Array = [];
         var _loc11_:int = 0;
         var _loc5_:BitmapData = null;
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            _loc3_ = getSprite(_loc11_);
            if(_loc3_ != null && _loc3_.visible)
            {
               if((_loc5_ = _loc3_.asset) != null)
               {
                  _loc12_.push(_loc3_);
               }
            }
            _loc11_++;
         }
         _loc12_.sortOn("relativeDepth",16);
         _loc12_.reverse();
         var _loc18_:BitmapData = null;
         try
         {
            _loc18_ = new BitmapData(_loc8_.width,_loc8_.height,true,param1);
         }
         catch(e:ArgumentError)
         {
            class_14.log("Unable to create BitmapData object! " + e);
         }
         if(!_loc18_)
         {
            return new BitmapData(1,1,true);
         }
         _loc11_ = 0;
         while(_loc11_ < _loc12_.length)
         {
            _loc3_ = _loc12_[_loc11_] as IRoomObjectSprite;
            if((_loc5_ = _loc3_.asset) != null)
            {
               _loc15_ = (_loc6_ = _loc3_.color) >> 16;
               _loc9_ = _loc6_ >> 8 & 255;
               _loc4_ = _loc6_ & 255;
               _loc19_ = null;
               if(_loc15_ < 255 || _loc9_ < 255 || _loc4_ < 255)
               {
                  _loc7_ = normalizeColourComponent(_loc15_);
                  _loc14_ = normalizeColourComponent(_loc9_);
                  _loc17_ = normalizeColourComponent(_loc4_);
                  _loc16_ = normalizeColourComponent(_loc3_.alpha);
                  _loc19_ = new ColorTransform(_loc7_,_loc14_,_loc17_,_loc16_);
               }
               else if(_loc3_.alpha < 255)
               {
                  _loc16_ = normalizeColourComponent(_loc3_.alpha);
                  _loc19_ = new ColorTransform(1,1,1,_loc16_);
               }
               if(param1 == 0 && _loc3_.blendMode == "add")
               {
                  _loc5_ = extractDarknessToAlpha(_loc5_);
               }
               _loc13_ = new Matrix();
               if(_loc3_.flipH)
               {
                  _loc13_.scale(-1,1);
                  _loc13_.translate(_loc5_.width,0);
               }
               if(_loc3_.flipV)
               {
                  _loc13_.scale(1,-1);
                  _loc13_.translate(0,_loc5_.height);
               }
               _loc13_.translate(_loc3_.offsetX - _loc8_.left,_loc3_.offsetY - _loc8_.top);
               _loc18_.draw(_loc5_,_loc13_,_loc19_,_loc3_.blendMode,null,false);
            }
            _loc11_++;
         }
         return _loc18_;
      }
      
      public function get boundingRectangle() : Rectangle
      {
         var _loc6_:int = 0;
         var _loc3_:Point = null;
         var _loc5_:int = spriteCount;
         var _loc1_:IRoomObjectSprite = null;
         var _loc4_:Rectangle = new Rectangle();
         var _loc2_:BitmapData = null;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc1_ = getSprite(_loc6_);
            if(_loc1_ != null && _loc1_.visible)
            {
               _loc2_ = _loc1_.asset;
               if(_loc2_ != null)
               {
                  _loc3_ = new Point(_loc1_.offsetX,_loc1_.offsetY);
                  if(_loc6_ == 0)
                  {
                     _loc4_.left = _loc3_.x;
                     _loc4_.top = _loc3_.y;
                     _loc4_.right = _loc3_.x + _loc1_.width;
                     _loc4_.bottom = _loc3_.y + _loc1_.height;
                  }
                  else
                  {
                     if(_loc3_.x < _loc4_.left)
                     {
                        _loc4_.left = _loc3_.x;
                     }
                     if(_loc3_.y < _loc4_.top)
                     {
                        _loc4_.top = _loc3_.y;
                     }
                     if(_loc3_.x + _loc1_.width > _loc4_.right)
                     {
                        _loc4_.right = _loc3_.x + _loc1_.width;
                     }
                     if(_loc3_.y + _loc1_.height > _loc4_.bottom)
                     {
                        _loc4_.bottom = _loc3_.y + _loc1_.height;
                     }
                  }
               }
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      private function extractDarknessToAlpha(param1:BitmapData) : BitmapData
      {
         var _loc8_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:int = 0;
         var _loc10_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:BitmapData = new BitmapData(param1.width,param1.height,true);
         var _loc12_:Vector.<uint> = param1.getVector(param1.rect);
         _loc8_ = 0;
         while(_loc8_ < _loc12_.length)
         {
            _loc3_ = _loc12_[_loc8_];
            _loc4_ = uint(_loc3_ >> 24 & 255);
            _loc11_ = uint(_loc3_ >> 16 & 255);
            _loc6_ = uint(_loc3_ >> 8 & 255);
            _loc5_ = uint(_loc3_ & 255);
            _loc9_ = _loc11_ << 16 | _loc6_ << 8 | _loc5_;
            _loc2_ = ColorConverter.rgbToHSL(_loc9_);
            if((_loc10_ = _loc2_ & 255) <= 128)
            {
               _loc7_ = _loc2_ >> 16 & 255;
               _loc13_ = _loc2_ >> 8 & 255;
               _loc4_ *= _loc10_ / 128;
               _loc10_ = 128;
               _loc2_ = (_loc7_ << 16) + (_loc13_ << 8) + _loc10_;
               _loc9_ = ColorConverter.hslToRGB(_loc2_);
               _loc3_ = uint(_loc4_ << 24 | _loc9_);
            }
            _loc12_[_loc8_] = _loc3_;
            _loc8_++;
         }
         _loc14_.setVector(_loc14_.rect,_loc12_);
         return _loc14_;
      }
   }
}
