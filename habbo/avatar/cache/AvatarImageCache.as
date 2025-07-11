package com.sulake.habbo.avatar.cache
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
   import com.sulake.habbo.avatar.AvatarImagePartContainer;
   import com.sulake.habbo.avatar.AvatarStructure;
   import com.sulake.habbo.avatar.actions.class_3544;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.AnimationLayerData;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.animation.AnimationFrame;
   import com.sulake.habbo.utils.StringBuffer;
   import com.sulake.habbo.utils.class_3543;
   import com.sulake.room.data.RoomObjectSpriteData;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AvatarImageCache
   {
      
      private static const DEFAULT_MAX_CACHE_STORAGE_TIME_MS:int = 60000;
      
      private static const const_908:String = "_";
      
      private static const DEF_SEPARATOR:String = ".";
      
      private static const BASE_ACTION:String = "std";
      
      private static const PART_FACE:String = "fc";
      
      private static const PART_EYES:String = "ey";
      
      private static const PART_RIGHT_ITEM:String = "ri";
      
      private static const ACTION_WAVE:String = "wav";
      
      private static const ACTION_DRINK:String = "drk";
      
      private static const ACTION_BLOW:String = "blw";
      
      private static const ACTION_SIGN:String = "sig";
      
      private static const ACTION_RESPECT:String = "respect";
      
      private static var var_2649:StringBuffer;
      
      private static var _partNameArray:Array;
      
      private static var var_3059:Array;
       
      
      private var var_1671:AvatarStructure;
      
      private var var_254:class_3374;
      
      private var _assets:AssetAliasCollection;
      
      private var var_911:String;
      
      private var _cache:Map;
      
      private var var_1696:AvatarCanvas;
      
      private var _disposed:Boolean;
      
      private var var_2500:String;
      
      private var var_3012:Array;
      
      private var var_2205:ColorTransform;
      
      private var var_1680:Matrix;
      
      private var var_3245:Array;
      
      private var var_3797:Boolean = false;
      
      public function AvatarImageCache(param1:AvatarStructure, param2:class_3374, param3:AssetAliasCollection, param4:String, param5:Boolean)
      {
         var _loc6_:int = 0;
         var_3012 = [];
         var_2205 = new ColorTransform();
         var_1680 = new Matrix();
         var_3245 = [];
         super();
         var_1671 = param1;
         var_254 = param2;
         _assets = param3;
         var_911 = param4;
         _cache = new Map();
         var_3797 = param5;
         if(!var_2649)
         {
            var_2649 = new StringBuffer();
         }
         if(!_partNameArray)
         {
            _partNameArray = [null,"_",null,"_",null,"_",null,"_",null,"_",null];
         }
         if(!var_3059)
         {
            var_3059 = [];
            _loc6_ = 0;
            while(_loc6_ < 10000)
            {
               var_3059.push(_loc6_.toString());
               _loc6_++;
            }
         }
      }
      
      private static function convertColorToHex(param1:Number) : String
      {
         var _loc2_:String = (param1 * 255).toString(16);
         if(_loc2_.length < 2)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc2_:AvatarImageBodyPartCache = null;
         var _loc1_:Array = null;
         var _loc3_:* = null;
         if(_disposed)
         {
            return;
         }
         var_1671 = null;
         var_254 = null;
         _assets = null;
         if(_cache != null)
         {
            _loc1_ = _cache.getKeys();
            for each(_loc3_ in _loc1_)
            {
               _loc2_ = _cache.getValue(_loc3_) as AvatarImageBodyPartCache;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            _cache.dispose();
            _cache = null;
         }
         var_1696 = null;
         _disposed = true;
      }
      
      public function disposeInactiveActions(param1:int = 60000) : void
      {
         var _loc4_:AvatarImageBodyPartCache = null;
         var _loc5_:* = null;
         var _loc3_:int = getTimer();
         var _loc2_:Array = _cache.getKeys();
         for each(_loc5_ in _loc2_)
         {
            if((_loc4_ = _cache.getValue(_loc5_) as AvatarImageBodyPartCache) != null)
            {
               _loc4_.disposeActions(param1,_loc3_);
            }
         }
      }
      
      public function resetBodyPartCache(param1:class_3544) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in _cache)
         {
            if(_loc2_ != null)
            {
               _loc2_.setAction(param1,0);
            }
         }
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         var _loc5_:AvatarImageBodyPartCache = null;
         var _loc3_:Array = var_1671.getBodyPartsUnordered(param1);
         for each(var _loc4_ in _loc3_)
         {
            if((_loc5_ = getBodyPartCache(_loc4_)) != null)
            {
               _loc5_.setDirection(param2);
            }
         }
      }
      
      public function setAction(param1:class_3544, param2:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:AvatarImageBodyPartCache = null;
         var _loc3_:Array = var_1671.getActiveBodyPartIds(param1,var_254);
         for each(_loc4_ in _loc3_)
         {
            if((_loc5_ = getBodyPartCache(_loc4_)) != null)
            {
               _loc5_.setAction(param1,param2);
            }
         }
      }
      
      public function setGeometryType(param1:String) : void
      {
         if(var_2500 == param1)
         {
            return;
         }
         if(var_2500 == "sitting" && param1 == "vertical" || var_2500 == "vertical" && param1 == "sitting" || (var_2500 == "swhorizontal" || param1 == "swhorizontal"))
         {
            var_2500 = param1;
            var_1696 = null;
            return;
         }
         disposeInactiveActions(0);
         var_2500 = param1;
         var_1696 = null;
      }
      
      public function getImageContainer(param1:String, param2:int, param3:Boolean = false) : AvatarImageBodyPartContainer
      {
         var _loc7_:* = 0;
         var _loc14_:Animation = null;
         var _loc17_:int = 0;
         var _loc13_:AnimationLayerData = null;
         var _loc20_:* = undefined;
         var _loc18_:* = undefined;
         var _loc10_:AvatarImageBodyPartCache;
         if((_loc10_ = getBodyPartCache(param1)) == null)
         {
            _loc10_ = new AvatarImageBodyPartCache();
            _cache.add(param1,_loc10_);
         }
         var _loc11_:* = _loc10_.getDirection();
         var _loc9_:* = param2;
         var _loc15_:class_3544;
         if((_loc15_ = _loc10_.getAction()).definition.startFromFrameZero)
         {
            _loc9_ -= _loc15_.startFrame;
         }
         var _loc8_:* = _loc15_;
         var _loc4_:Array = [];
         var _loc16_:Map = new Map();
         var _loc12_:Point = new Point();
         if(!(!_loc15_ || !_loc15_.definition))
         {
            if(_loc15_.definition.isAnimation)
            {
               _loc7_ = _loc11_;
               _loc14_ = var_1671.getAnimation(_loc15_.definition.state + "." + _loc15_.actionParameter);
               _loc17_ = param2 - _loc15_.startFrame;
               if(_loc14_ != null)
               {
                  if((_loc13_ = _loc14_.getLayerData(_loc17_,param1,_loc15_.overridingAction)) != null)
                  {
                     _loc7_ = _loc11_ + _loc13_.directionOffset;
                     if(_loc13_.directionOffset < 0)
                     {
                        if(_loc7_ < 0)
                        {
                           _loc7_ = 8 + _loc7_;
                        }
                        else if(_loc7_ > 7)
                        {
                           _loc7_ = 8 - _loc7_;
                        }
                     }
                     else if(_loc7_ < 0)
                     {
                        _loc7_ += 8;
                     }
                     else if(_loc7_ > 7)
                     {
                        _loc7_ -= 8;
                     }
                     if(var_911 == "h")
                     {
                        _loc12_.x = _loc13_.dx;
                        _loc12_.y = _loc13_.dy;
                     }
                     else
                     {
                        _loc12_.x = _loc13_.dx / 2;
                        _loc12_.y = _loc13_.dy / 2;
                     }
                     _loc9_ = _loc13_.animationFrame;
                     if(_loc13_.action != null)
                     {
                        _loc15_ = _loc13_.action;
                     }
                     if(_loc13_.type == "bodypart")
                     {
                        if(_loc13_.action != null)
                        {
                           _loc8_ = _loc13_.action;
                        }
                        _loc11_ = _loc7_;
                     }
                     else if(_loc13_.type == "fx")
                     {
                        _loc11_ = _loc7_;
                     }
                     _loc16_ = _loc13_.items;
                  }
                  _loc4_ = _loc14_.removeData;
               }
            }
         }
         var _loc19_:AvatarImageActionCache;
         if((_loc19_ = _loc10_.getActionCache(_loc8_)) == null || param3)
         {
            _loc19_ = new AvatarImageActionCache();
            _loc10_.updateActionCache(_loc8_,_loc19_);
         }
         var _loc5_:AvatarImageDirectionCache;
         if((_loc5_ = _loc19_.getDirectionCache(_loc11_)) == null || param3)
         {
            if(!(_loc20_ = var_1671.getParts(param1,var_254.getFigure(),_loc8_,var_2500,_loc11_,_loc4_,var_254,_loc16_)))
            {
               return null;
            }
            _loc5_ = new AvatarImageDirectionCache(_loc20_);
            _loc19_.updateDirectionCache(_loc11_,_loc5_);
         }
         var _loc6_:AvatarImageBodyPartContainer;
         if((_loc6_ = _loc5_.getImageContainer(_loc9_)) == null || param3)
         {
            _loc18_ = _loc5_.getPartList();
            if(!((_loc6_ = renderBodyPart(_loc11_,_loc18_,_loc9_,_loc15_,param3)) != null && !param3))
            {
               return null;
            }
            if(_loc6_.isCacheable)
            {
               _loc5_.updateImageContainer(_loc6_,_loc9_);
            }
         }
         _loc6_.offset = _loc12_.add(var_1671.getFrameBodyPartOffset(_loc8_,_loc11_,_loc9_,param1));
         return _loc6_;
      }
      
      public function getServerRenderData() : Array
      {
         var _loc1_:Array = var_3245;
         var_3245 = [];
         return _loc1_;
      }
      
      public function getBodyPartCache(param1:String) : AvatarImageBodyPartCache
      {
         var _loc2_:AvatarImageBodyPartCache = _cache.getValue(param1) as AvatarImageBodyPartCache;
         if(_loc2_ == null)
         {
            _loc2_ = new AvatarImageBodyPartCache();
            _cache.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function renderBodyPart(param1:int, param2:Vector.<AvatarImagePartContainer>, param3:int, param4:class_3544, param5:Boolean = false) : AvatarImageBodyPartContainer
      {
         var _loc12_:Boolean = false;
         var _loc24_:* = 0;
         var _loc8_:AvatarImagePartContainer = null;
         var _loc18_:String = null;
         var _loc6_:String = null;
         var _loc15_:AnimationFrame = null;
         var _loc26_:int = 0;
         var _loc10_:String = null;
         var _loc30_:BitmapDataAsset = null;
         var _loc29_:BitmapData = null;
         var _loc21_:Boolean = false;
         var _loc17_:ColorTransform = null;
         var _loc19_:Point = null;
         var _loc11_:ColorTransform = null;
         var _loc27_:RoomObjectSpriteData = null;
         var _loc9_:ImageData = null;
         if(param2 == null)
         {
            return null;
         }
         if(param2.length == 0)
         {
            return null;
         }
         if(!var_1696)
         {
            var_1696 = var_1671.getCanvas(var_911,var_2500);
            if(!var_1696)
            {
               return null;
            }
         }
         var _loc23_:* = param1;
         var _loc25_:Boolean = Boolean(AvatarDirectionAngle.const_444[param1]);
         var _loc31_:String = param4.definition.assetPartDefinition;
         var _loc13_:Boolean = true;
         var _loc20_:int;
         _loc24_ = _loc20_ = param2.length - 1;
         while(_loc24_ >= 0)
         {
            _loc8_ = param2[_loc24_] as AvatarImagePartContainer;
            if(!(param1 == 7 && (_loc8_.partType == "fc" || _loc8_.partType == "ey")))
            {
               if(!(_loc8_.partType == "ri" && _loc8_.partId == null))
               {
                  _loc18_ = _loc8_.partType;
                  _loc6_ = _loc8_.partId;
                  if(_loc15_ = _loc8_.getFrameDefinition(param3))
                  {
                     _loc26_ = _loc15_.number;
                     if(_loc15_.assetPartDefinition && _loc15_.assetPartDefinition.length > 0)
                     {
                        _loc31_ = _loc15_.assetPartDefinition;
                     }
                  }
                  else
                  {
                     _loc26_ = _loc8_.getFrameIndex(param3);
                  }
                  _loc23_ = param1;
                  _loc12_ = false;
                  if(_loc25_)
                  {
                     if(_loc31_ == "wav" && (_loc18_ == "lh" || _loc18_ == "ls" || _loc18_ == "lc"))
                     {
                        _loc12_ = true;
                     }
                     else if(_loc31_ == "drk" && (_loc18_ == "rh" || _loc18_ == "rs" || _loc18_ == "rc"))
                     {
                        _loc12_ = true;
                     }
                     else if(_loc31_ == "blw" && _loc18_ == "rh")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc31_ == "sig" && _loc18_ == "lh")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc31_ == "respect" && _loc18_ == "lh")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc18_ == "ri")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc18_ == "li")
                     {
                        _loc12_ = true;
                     }
                     else if(_loc18_ == "cp")
                     {
                        _loc12_ = true;
                     }
                     else
                     {
                        if(param1 == 4)
                        {
                           _loc23_ = 2;
                        }
                        else if(param1 == 5)
                        {
                           _loc23_ = 1;
                        }
                        else if(param1 == 6)
                        {
                           _loc23_ = 0;
                        }
                        if(_loc8_.flippedPartType != _loc18_)
                        {
                           _loc18_ = _loc8_.flippedPartType;
                        }
                     }
                  }
                  var_2649.length = 0;
                  _partNameArray[0] = var_3797 ? "h" : var_911;
                  _partNameArray[2] = _loc31_;
                  _partNameArray[4] = _loc18_;
                  _partNameArray[6] = _loc6_;
                  _partNameArray[8] = var_3059[_loc23_];
                  _partNameArray[10] = var_3059[_loc26_];
                  var_2649.appendStringArray(_partNameArray);
                  _loc10_ = var_2649.toString();
                  if((_loc30_ = _assets.getAssetByName(_loc10_) as BitmapDataAsset) == null)
                  {
                     var_2649.length = 0;
                     _partNameArray[2] = "std";
                     _partNameArray[10] = var_3059[0];
                     var_2649.appendStringArray(_partNameArray);
                     _loc10_ = var_2649.toString();
                     _loc30_ = _assets.getAssetByName(_loc10_) as BitmapDataAsset;
                  }
                  if(_loc30_)
                  {
                     if((_loc29_ = _loc30_.content as BitmapData) == null)
                     {
                        _loc13_ = false;
                     }
                     else
                     {
                        _loc21_ = false;
                        if(_loc8_.isColorable && _loc8_.color != null)
                        {
                           _loc17_ = _loc8_.color.colorTransform;
                           var_2205.redMultiplier = _loc17_.redMultiplier;
                           var_2205.greenMultiplier = _loc17_.greenMultiplier;
                           var_2205.blueMultiplier = _loc17_.blueMultiplier;
                           var_2205.alphaMultiplier = _loc17_.alphaMultiplier;
                           _loc21_ = true;
                        }
                        else
                        {
                           var_2205.redMultiplier = var_2205.greenMultiplier = var_2205.blueMultiplier = var_2205.alphaMultiplier = 1;
                        }
                        if(_loc8_.isBlendable)
                        {
                           var_2205.concat(_loc8_.blendTransform);
                           _loc21_ = true;
                        }
                        _loc19_ = _loc30_.offset.clone();
                        if(_loc12_)
                        {
                           _loc19_.x += var_911 == "h" ? 65 : 31;
                        }
                        _loc11_ = null;
                        if(_loc21_)
                        {
                           (_loc11_ = new ColorTransform()).concat(var_2205);
                        }
                        if(param5)
                        {
                           (_loc27_ = new RoomObjectSpriteData()).name = _assets.getAssetName(_loc10_);
                           _loc27_.x = -_loc19_.x - 33;
                           _loc27_.y = -_loc19_.y;
                           _loc27_.z = var_3245.length * -0.0001;
                           _loc27_.width = _loc30_.rectangle.width;
                           _loc27_.height = _loc30_.rectangle.height;
                           _loc27_.flipH = _loc12_;
                           if(_loc31_ == "lay")
                           {
                              _loc27_.x += 53;
                           }
                           if(_loc25_)
                           {
                              _loc27_.flipH = !_loc27_.flipH;
                              if(_loc27_.flipH)
                              {
                                 _loc27_.x = -_loc27_.x - _loc29_.width;
                              }
                              else
                              {
                                 _loc27_.x += 65;
                              }
                           }
                           if(_loc8_.isColorable && _loc11_)
                           {
                              _loc27_.color = "0x" + convertColorToHex(_loc11_.redMultiplier) + convertColorToHex(_loc11_.greenMultiplier) + convertColorToHex(_loc11_.blueMultiplier);
                           }
                           var_3245.push(_loc27_);
                        }
                        var_3012.push(new ImageData(_loc29_,_loc30_.rectangle,_loc19_,_loc12_,_loc11_));
                     }
                  }
               }
            }
            _loc24_--;
         }
         if(var_3012.length == 0)
         {
            return null;
         }
         var _loc16_:ImageData = createUnionImage(var_3012,_loc25_);
         var _loc14_:int = var_911 == "h" ? var_1696.height - 16 : var_1696.height - 8;
         var _loc22_:Point = _loc16_.regPoint;
         if(var_3797)
         {
            _loc22_ = new Point(_loc22_.x / 2,_loc22_.y / 2);
         }
         var _loc7_:Point = new Point(-_loc22_.x,_loc14_ - _loc22_.y);
         if(_loc25_ && _loc31_ != "lay")
         {
            _loc7_.x += var_911 == "h" ? 67 : 31;
         }
         _loc24_ = var_3012.length - 1;
         while(_loc24_ >= 0)
         {
            if(_loc9_ = var_3012.pop())
            {
               _loc9_.dispose();
            }
            _loc24_--;
         }
         var _loc28_:BitmapData = _loc16_.bitmap;
         if(var_3797)
         {
            _loc28_ = class_3543.resampleBitmapData(_loc28_,0.5);
         }
         return new AvatarImageBodyPartContainer(_loc28_,_loc7_,_loc13_);
      }
      
      private function createUnionImage(param1:Array, param2:Boolean) : ImageData
      {
         var _loc4_:* = null;
         var _loc7_:Point = null;
         var _loc5_:Point = null;
         var _loc6_:BitmapData = null;
         var _loc8_:Boolean = false;
         var _loc3_:Rectangle = null;
         _loc3_ = new Rectangle();
         for each(_loc4_ in param1)
         {
            _loc3_ = _loc3_.union(_loc4_.offsetRect);
         }
         _loc5_ = new Point(-_loc3_.left,-_loc3_.top);
         _loc6_ = new BitmapData(_loc3_.width,_loc3_.height,true,16777215);
         for each(_loc4_ in param1)
         {
            _loc7_ = _loc5_.subtract(_loc4_.regPoint);
            if(param2)
            {
               _loc7_.x = _loc6_.width - (_loc7_.x + _loc4_.rect.width);
            }
            if(_loc8_ = !(param2 && _loc4_.flipH) && (param2 || _loc4_.flipH))
            {
               var_1680.a = -1;
               var_1680.tx = _loc4_.rect.x + _loc4_.rect.width + _loc7_.x;
               var_1680.ty = _loc7_.y - _loc4_.rect.y;
               _loc3_.x = _loc7_.x;
               _loc3_.y = _loc7_.y;
               _loc3_.width = _loc4_.rect.width;
               _loc3_.height = _loc4_.rect.height;
               _loc6_.draw(_loc4_.bitmap,var_1680,_loc4_.colorTransform,null,_loc3_);
            }
            else if(_loc4_.colorTransform)
            {
               var_1680.a = 1;
               var_1680.tx = _loc7_.x - _loc4_.rect.x;
               var_1680.ty = _loc7_.y - _loc4_.rect.y;
               _loc3_.x = _loc7_.x;
               _loc3_.y = _loc7_.y;
               _loc3_.width = _loc4_.rect.width;
               _loc3_.height = _loc4_.rect.height;
               _loc6_.draw(_loc4_.bitmap,var_1680,_loc4_.colorTransform,null,_loc3_);
            }
            else
            {
               _loc6_.copyPixels(_loc4_.bitmap,_loc4_.rect,_loc7_,null,null,true);
            }
         }
         return new ImageData(_loc6_,_loc6_.rect,_loc5_,param2,null);
      }
      
      private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.bottom - 1;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right - 1)
         {
            param1.setPixel32(_loc4_,0,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc4_++;
         }
         _loc5_ = param2.top;
         while(_loc5_ < param2.bottom - 1)
         {
            param1.setPixel32(0,_loc5_,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc5_++;
         }
      }
      
      private function debugInfo(param1:String) : void
      {
         class_14.log("[AvatarImageCache] " + param1);
      }
   }
}
