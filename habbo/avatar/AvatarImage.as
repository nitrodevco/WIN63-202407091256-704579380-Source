package com.sulake.habbo.avatar
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.ActionDefinition;
   import com.sulake.habbo.avatar.actions.ActiveActionData;
   import com.sulake.habbo.avatar.actions.class_3544;
   import com.sulake.habbo.avatar.actions.class_3576;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import com.sulake.habbo.avatar.animation.Animation;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.animation.class_3526;
   import com.sulake.habbo.avatar.animation.class_3581;
   import com.sulake.habbo.avatar.cache.AvatarImageCache;
   import com.sulake.habbo.avatar.structure.AvatarCanvas;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.utils.class_3543;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AvatarImage implements class_3374, IDisposable, class_3375
   {
      
      private static const CHANNELS_EQUAL:String = "CHANNELS_EQUAL";
      
      private static const CHANNELS_UNIQUE:String = "CHANNELS_UNIQUE";
      
      private static const CHANNELS_RED:String = "CHANNELS_RED";
      
      private static const CHANNELS_GREEN:String = "CHANNELS_GREEN";
      
      private static const CHANNELS_BLUE:String = "CHANNELS_BLUE";
      
      private static const CHANNELS_SATURATED:String = "CHANNELS_SATURATED";
      
      private static const DEFAULT_ACTION:String = "Default";
      
      private static const DEFAULT_DIR:int = 2;
      
      private static const DEFAULT_AVATAR_SET:String = "full";
      
      private static const DEFAULT_POINT:Point = new Point(0,0);
       
      
      protected var var_1671:AvatarStructure;
      
      protected var var_911:String;
      
      protected var var_2035:int;
      
      protected var _headDirection:int;
      
      protected var var_1753:class_3544;
      
      protected var var_318:Boolean;
      
      protected var var_2288:Array;
      
      protected var _assets:AssetAliasCollection;
      
      protected var _cache:AvatarImageCache;
      
      protected var var_426:AvatarFigureContainer;
      
      protected var var_2244:class_3581;
      
      protected var var_531:Array;
      
      protected var var_859:BitmapData;
      
      private var _defaultAction:class_3544;
      
      private var var_2172:int = 0;
      
      private var _directionOffset:int = 0;
      
      private var var_1826:Boolean;
      
      private var var_1761:Vector.<ISpriteDataContainer>;
      
      private var var_2820:Boolean;
      
      private var var_3174:Boolean = false;
      
      private var var_2759:Boolean = false;
      
      private var var_1922:Array;
      
      private var var_2962:String;
      
      private var var_2117:String;
      
      private var _fullImageCache:Map;
      
      protected var var_3191:Boolean = false;
      
      private var _useFullImageCache:Boolean;
      
      private var var_3077:int = -1;
      
      private var var_4760:int;
      
      private var var_3632:Array;
      
      private var var_4418:int = -1;
      
      private var var_4586:String = null;
      
      private var var_4767:String = null;
      
      private var var_4184:EffectAssetDownloadManager;
      
      private var var_4258:class_3375;
      
      public function AvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String, param5:EffectAssetDownloadManager, param6:class_3375)
      {
         var_2288 = [];
         var_531 = [];
         var_3632 = [];
         super();
         var_1826 = true;
         var_4184 = param5;
         var_1671 = param1;
         _assets = param2;
         var_911 = param4;
         var_4258 = param6;
         var _loc7_:Boolean = false;
         if(var_911 == null)
         {
            var_911 = "h";
         }
         else if(var_911 == "h_50")
         {
            _loc7_ = true;
            var_911 = "sh";
         }
         if(param3 == null)
         {
            param3 = new AvatarFigureContainer("hr-893-45.hd-180-2.ch-210-66.lg-270-82.sh-300-91.wa-2007-.ri-1-");
            class_14.log("Using default avatar figure");
         }
         var_426 = param3;
         _cache = new AvatarImageCache(var_1671,this,_assets,var_911,_loc7_);
         setDirection("full",2);
         var_531 = [];
         _defaultAction = new ActiveActionData("std");
         _defaultAction.definition = var_1671.getActionDefinition("Default");
         resetActions();
         _fullImageCache = new Map();
      }
      
      public function getServerRenderData() : Array
      {
         getAvatarPartsForCamera("full");
         return _cache.getServerRenderData();
      }
      
      public function dispose() : void
      {
         if(!var_318)
         {
            var_1671 = null;
            _assets = null;
            var_1753 = null;
            var_426 = null;
            var_2244 = null;
            var_531 = null;
            if(var_859)
            {
               var_859.dispose();
            }
            if(_cache)
            {
               _cache.dispose();
               _cache = null;
            }
            if(_fullImageCache)
            {
               for each(var _loc1_ in _fullImageCache)
               {
                  _loc1_.dispose();
               }
               _fullImageCache.dispose();
               _fullImageCache = null;
            }
            var_859 = null;
            var_2288 = null;
            var_318 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function getFigure() : class_3405
      {
         return var_426;
      }
      
      public function getScale() : String
      {
         return var_911;
      }
      
      public function getPartColor(param1:String) : IPartColor
      {
         return var_1671.getPartColor(var_426,param1);
      }
      
      public function setDirection(param1:String, param2:int) : void
      {
         param2 += _directionOffset;
         if(param2 < 0)
         {
            param2 = 7 + (param2 + 1);
         }
         if(param2 > 7)
         {
            param2 -= 7 + 1;
         }
         if(var_1671.isMainAvatarSet(param1))
         {
            var_2035 = param2;
         }
         if(param1 == "head" || param1 == "full")
         {
            if(param1 == "head" && isHeadTurnPreventedByAction())
            {
               param2 = var_2035;
            }
            _headDirection = param2;
         }
         _cache.setDirection(param1,param2);
         var_1826 = true;
      }
      
      public function setDirectionAngle(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 / 45;
         setDirection(param1,_loc3_);
      }
      
      public function getSprites() : Vector.<ISpriteDataContainer>
      {
         return var_1761;
      }
      
      public function getCanvasOffsets() : Array
      {
         return var_2288;
      }
      
      public function getLayerData(param1:ISpriteDataContainer) : class_3526
      {
         return var_1671.getBodyPartData(param1.animation.id,var_2172,param1.id);
      }
      
      public function updateAnimationByFrames(param1:int = 1) : void
      {
         var_2172 += param1;
         var_1826 = true;
      }
      
      public function resetAnimationFrameCounter() : void
      {
         var_2172 = 0;
         var_1826 = true;
      }
      
      private function getFullImageCacheKey() : String
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(!_useFullImageCache)
         {
            return null;
         }
         if(var_1922.length == 1 && var_2035 == _headDirection)
         {
            if(var_1753 == "std")
            {
               return var_2035 + var_2117;
            }
            return var_2035 + var_2117 + var_2172 % 4;
         }
         if(var_1922.length == 2)
         {
            for each(_loc1_ in var_1922)
            {
               if(_loc1_.actionType == "fx" && (_loc1_.actionParameter == "33" || _loc1_.actionParameter == "34" || _loc1_.actionParameter == "35" || _loc1_.actionParameter == "36"))
               {
                  return var_2035 + var_2117 + 0;
               }
               if(_loc1_.actionType == "fx" && (_loc1_.actionParameter == "38" || _loc1_.actionParameter == "39"))
               {
                  _loc2_ = var_2172 % 11;
                  return var_2035 + "_" + _headDirection + var_2117 + _loc2_;
               }
            }
         }
         return null;
      }
      
      private function getBodyParts(param1:String, param2:String, param3:int) : Array
      {
         if(param3 != var_4418 || param2 != var_4586 || param1 != var_4767)
         {
            var_4418 = param3;
            var_4586 = param2;
            var_4767 = param1;
            var_3632 = var_1671.getBodyParts(param1,param2,param3);
         }
         return var_3632;
      }
      
      public function getAvatarPartsForCamera(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc2_:AvatarImageBodyPartContainer = null;
         var _loc6_:int = 0;
         if(var_1753 == null)
         {
            return;
         }
         var _loc5_:AvatarCanvas;
         if((_loc5_ = var_1671.getCanvas(var_911,var_1753.definition.geometryType)) == null)
         {
            return;
         }
         var _loc3_:Array = getBodyParts(param1,var_1753.definition.geometryType,var_2035);
         _loc6_ = _loc3_.length - 1;
         while(_loc6_ >= 0)
         {
            _loc4_ = String(_loc3_[_loc6_]);
            _loc2_ = _cache.getImageContainer(_loc4_,var_2172,true);
            _loc6_--;
         }
      }
      
      public function getImage(param1:String, param2:Boolean, param3:Number = 1) : BitmapData
      {
         var _loc12_:String = null;
         var _loc4_:AvatarImageBodyPartContainer = null;
         var _loc10_:BitmapData = null;
         var _loc8_:Point = null;
         var _loc11_:int = 0;
         var _loc7_:BitmapData = null;
         if(!var_1826)
         {
            return var_859;
         }
         if(var_1753 == null)
         {
            return null;
         }
         if(!var_2759)
         {
            endActionAppends();
         }
         var _loc9_:String;
         if((_loc9_ = getFullImageCacheKey()) != null)
         {
            if(getFullImage(_loc9_))
            {
               var_1826 = false;
               if(param2)
               {
                  return (getFullImage(_loc9_) as BitmapData).clone();
               }
               var_859 = getFullImage(_loc9_) as BitmapData;
               var_3191 = true;
               return var_859;
            }
         }
         var _loc6_:AvatarCanvas;
         if((_loc6_ = var_1671.getCanvas(var_911,var_1753.definition.geometryType)) == null)
         {
            return null;
         }
         if(var_3191 || var_859 == null || (var_859.width != _loc6_.width || var_859.height != _loc6_.height))
         {
            if(var_859 != null && !var_3191)
            {
               var_859.dispose();
            }
            var_859 = new BitmapData(_loc6_.width,_loc6_.height,true,0);
            var_3191 = false;
         }
         var _loc5_:Array = getBodyParts(param1,var_1753.definition.geometryType,var_2035);
         var_859.lock();
         var_859.fillRect(var_859.rect,0);
         var _loc13_:Boolean = true;
         _loc11_ = _loc5_.length - 1;
         while(_loc11_ >= 0)
         {
            _loc12_ = String(_loc5_[_loc11_]);
            if(_loc4_ = _cache.getImageContainer(_loc12_,var_2172))
            {
               _loc13_ &&= _loc4_.isCacheable;
               _loc10_ = _loc4_.image;
               _loc8_ = _loc4_.regPoint.add(_loc6_.offset);
               if(_loc10_ && _loc8_)
               {
                  _loc8_ = _loc8_.add(_loc6_.regPoint);
                  var_859.copyPixels(_loc10_,_loc10_.rect,_loc8_,null,null,true);
               }
            }
            _loc11_--;
         }
         var_859.unlock();
         var_1826 = false;
         if(var_2244 != null)
         {
            if(var_2244.paletteIsGrayscale)
            {
               _loc7_ = convertToGrayscale(var_859);
               if(var_859)
               {
                  var_859.dispose();
               }
               var_859 = _loc7_;
               var_859.paletteMap(var_859,var_859.rect,DEFAULT_POINT,var_2244.reds,[],[]);
            }
            else
            {
               var_859.copyChannel(var_859,var_859.rect,DEFAULT_POINT,2,8);
            }
         }
         if(_loc9_ != null && _loc13_)
         {
            cacheFullImage(_loc9_,var_859.clone());
         }
         if(param3 != 1)
         {
            var_859 = class_3543.resampleBitmapData(var_859,param3);
         }
         if(var_859 && param2)
         {
            return var_859.clone();
         }
         return var_859;
      }
      
      public function getCroppedImage(param1:String, param2:Number = 1) : BitmapData
      {
         var _loc11_:String = null;
         var _loc3_:AvatarImageBodyPartContainer = null;
         var _loc8_:BitmapData = null;
         var _loc7_:Point = null;
         var _loc9_:int = 0;
         if(var_1753 == null)
         {
            return null;
         }
         if(!var_2759)
         {
            endActionAppends();
         }
         var _loc6_:AvatarCanvas;
         if((_loc6_ = var_1671.getCanvas(var_911,var_1753.definition.geometryType)) == null)
         {
            return null;
         }
         var _loc4_:BitmapData = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
         var _loc5_:Array = var_1671.getBodyParts(param1,var_1753.definition.geometryType,var_2035);
         var _loc10_:Rectangle = null;
         var _loc13_:Rectangle = new Rectangle();
         _loc9_ = _loc5_.length - 1;
         while(_loc9_ >= 0)
         {
            _loc11_ = String(_loc5_[_loc9_]);
            _loc3_ = _cache.getImageContainer(_loc11_,var_2172);
            if(_loc3_ != null)
            {
               if((_loc8_ = _loc3_.image) == null)
               {
                  _loc4_.dispose();
                  return null;
               }
               _loc7_ = _loc3_.regPoint;
               _loc4_.copyPixels(_loc8_,_loc8_.rect,_loc7_,null,null,true);
               _loc13_.x = _loc7_.x;
               _loc13_.y = _loc7_.y;
               _loc13_.width = _loc8_.width;
               _loc13_.height = _loc8_.height;
               if(_loc10_ == null)
               {
                  _loc10_ = _loc13_.clone();
               }
               else
               {
                  _loc10_ = _loc10_.union(_loc13_);
               }
            }
            _loc9_--;
         }
         if(_loc10_ == null)
         {
            _loc10_ = new Rectangle(0,0,1,1);
         }
         var _loc12_:BitmapData;
         (_loc12_ = new BitmapData(_loc10_.width,_loc10_.height,true,16777215)).copyPixels(_loc4_,_loc10_,DEFAULT_POINT,null,null,true);
         _loc4_.dispose();
         if(param2 != 1)
         {
            _loc12_ = class_3543.resampleBitmapData(_loc12_,param2);
         }
         return _loc12_;
      }
      
      protected function getFullImage(param1:String) : BitmapData
      {
         return _fullImageCache[param1];
      }
      
      protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         if(_fullImageCache.getValue(param1))
         {
            (_fullImageCache.getValue(param1) as BitmapData).dispose();
            _fullImageCache.remove(param1);
         }
         _fullImageCache[param1] = param2;
      }
      
      public function getAsset(param1:String) : BitmapDataAsset
      {
         return _assets.getAssetByName(param1) as BitmapDataAsset;
      }
      
      public function getDirection() : int
      {
         return var_2035;
      }
      
      public function initActionAppends() : void
      {
         var_531 = [];
         var_2759 = false;
         var_2117 = "";
         _useFullImageCache = false;
      }
      
      public function endActionAppends() : void
      {
         var _loc1_:* = null;
         if(sortActions())
         {
            for each(_loc1_ in var_1922)
            {
               if(_loc1_.actionType == "fx")
               {
                  if(!var_4184.isReady(parseInt(_loc1_.actionParameter)))
                  {
                     var_4184.loadEffectData(parseInt(_loc1_.actionParameter),this);
                  }
               }
            }
            resetActions();
            setActionsToParts();
         }
      }
      
      public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:ActionDefinition = null;
         var_2759 = false;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = String(rest[0]);
         }
         switch(param1)
         {
            case "posture":
               switch(_loc3_)
               {
                  case "lay":
                     if(var_2035 == 0)
                     {
                        setDirection("full",4);
                     }
                     else
                     {
                        setDirection("full",2);
                     }
                  case "mv":
                     _useFullImageCache = true;
                  case "std":
                     _useFullImageCache = true;
                  case "swim":
                  case "float":
                  case "sit":
                  case "swrun":
                  case "swdiefront":
                  case "swdieback":
                  case "swpick":
                  case "swthrow":
                     addActionData(_loc3_);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN POSTURE TYPE: " + _loc3_);
               }
               break;
            case "gest":
               switch(_loc3_)
               {
                  case "agr":
                  case "sad":
                  case "sml":
                  case "srp":
                     addActionData(_loc3_);
                     break;
                  default:
                     errorThis("appendAction() >> UNKNOWN GESTURE TYPE: " + _loc3_);
               }
               break;
            case "fx":
               if(_loc3_ == "33" || _loc3_ == "34" || _loc3_ == "35" || _loc3_ == "36" || _loc3_ == "38" || _loc3_ == "39")
               {
                  _useFullImageCache = true;
               }
            case "dance":
            case "talk":
            case "wave":
            case "Sleep":
            case "sign":
            case "respect":
            case "blow":
            case "laugh":
            case "cry":
            case "idle":
            case "sbollie":
            case "sb360":
            case "ridejump":
               addActionData(param1,_loc3_);
               break;
            case "cri":
            case "usei":
               if((_loc4_ = var_1671.getActionDefinitionWithState(param1)) != null)
               {
                  logThis("appendAction:" + [_loc3_,"->",_loc4_.getParameterValue(_loc3_)]);
                  _loc3_ = _loc4_.getParameterValue(_loc3_);
               }
               addActionData(param1,_loc3_);
               break;
            default:
               errorThis("appendAction() >> UNKNOWN ACTION TYPE: " + param1);
         }
         return true;
      }
      
      protected function addActionData(param1:String, param2:String = "") : void
      {
         var _loc4_:ActiveActionData = null;
         var _loc3_:int = 0;
         if(var_531 == null)
         {
            var_531 = [];
         }
         _loc3_ = 0;
         while(_loc3_ < var_531.length)
         {
            if((_loc4_ = var_531[_loc3_]).actionType == param1 && _loc4_.actionParameter == param2)
            {
               return;
            }
            _loc3_++;
         }
         var_531.push(new ActiveActionData(param1,param2,var_2172));
      }
      
      public function isAnimating() : Boolean
      {
         return var_2820 || var_4760 > 1;
      }
      
      private function resetActions() : Boolean
      {
         var_3174 = false;
         var_2820 = false;
         var_1761 = new Vector.<ISpriteDataContainer>(0);
         var_2244 = null;
         _directionOffset = 0;
         var_1671.removeDynamicItems(this);
         var_1753 = _defaultAction;
         var_1753.definition = _defaultAction.definition;
         resetBodyPartCache(_defaultAction);
         return true;
      }
      
      private function isHeadTurnPreventedByAction() : Boolean
      {
         var _loc2_:class_3576 = null;
         var _loc1_:* = null;
         if(var_1922 == null)
         {
            return false;
         }
         for each(_loc1_ in var_1922)
         {
            _loc2_ = var_1671.getActionDefinitionWithState(_loc1_.actionType);
            if(!(_loc1_.actionType == "Sleep" && var_1753 && var_1753.actionType != "lay"))
            {
               if(_loc2_ != null && _loc2_.getPreventHeadTurn(_loc1_.actionParameter))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function sortActions() : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc1_:Boolean = false;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var_2117 = "";
         var_1922 = var_1671.sortActions(var_531);
         var_4760 = var_1671.maxFrames(var_1922);
         if(var_1922 == null)
         {
            var_2288 = new Array(0,0,0);
            if(var_2962 != "")
            {
               _loc3_ = true;
               var_2962 = "";
            }
         }
         else
         {
            var_2288 = var_1671.getCanvasOffsets(var_1922,var_911,var_2035);
            for each(_loc4_ in var_1922)
            {
               var_2117 += _loc4_.actionType + _loc4_.actionParameter;
               if(_loc4_.actionType == "fx")
               {
                  _loc2_ = parseInt(_loc4_.actionParameter);
                  if(var_3077 != _loc2_)
                  {
                     _loc5_ = true;
                  }
                  var_3077 = _loc2_;
                  _loc1_ = true;
               }
            }
            if(!_loc1_)
            {
               if(var_3077 > -1)
               {
                  _loc5_ = true;
               }
               var_3077 = -1;
            }
            if(_loc5_)
            {
               _cache.disposeInactiveActions(0);
            }
            if(var_2962 != var_2117)
            {
               _loc3_ = true;
               var_2962 = var_2117;
            }
         }
         var_2759 = true;
         return _loc3_;
      }
      
      private function setActionsToParts() : void
      {
         var _loc2_:* = null;
         var _loc6_:Animation = null;
         var _loc1_:Array = null;
         var _loc4_:* = null;
         var _loc5_:* = undefined;
         if(var_1922 == null)
         {
            return;
         }
         var _loc3_:int = getTimer();
         var _loc7_:Array = [];
         for each(_loc2_ in var_1922)
         {
            _loc7_.push(_loc2_.actionType);
         }
         for each(_loc2_ in var_1922)
         {
            if(_loc2_ && _loc2_.definition && _loc2_.definition.isAnimation)
            {
               if((_loc6_ = var_1671.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter)) && _loc6_.hasOverriddenActions())
               {
                  _loc1_ = _loc6_.overriddenActionNames();
                  if(_loc1_)
                  {
                     for each(_loc4_ in _loc1_)
                     {
                        if(_loc7_.indexOf(_loc4_) >= 0)
                        {
                           _loc2_.overridingAction = _loc6_.overridingAction(_loc4_);
                        }
                     }
                  }
               }
               if(_loc6_ && _loc6_.resetOnToggle)
               {
                  var_3174 = true;
               }
            }
         }
         for each(_loc2_ in var_1922)
         {
            if(!(!_loc2_ || !_loc2_.definition))
            {
               if(_loc2_.definition.isAnimation && _loc2_.actionParameter == "")
               {
                  _loc2_.actionParameter = "1";
               }
               setActionToParts(_loc2_,_loc3_);
               if(_loc2_.definition.isAnimation)
               {
                  var_2820 = _loc2_.definition.isAnimated(_loc2_.actionParameter);
                  if((_loc6_ = var_1671.getAnimation(_loc2_.definition.state + "." + _loc2_.actionParameter)) != null)
                  {
                     if(_loc5_ = _loc6_.spriteData)
                     {
                        var_1761 = var_1761.concat(_loc5_);
                     }
                     if(_loc6_.hasDirectionData())
                     {
                        _directionOffset = _loc6_.directionData.offset;
                     }
                     if(_loc6_.hasAvatarData())
                     {
                        var_2244 = _loc6_.avatarData;
                     }
                  }
               }
            }
         }
      }
      
      private function setActionToParts(param1:class_3544, param2:int) : void
      {
         if(param1 == null || param1.definition == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            var_1753 = param1;
            _cache.setGeometryType(param1.definition.geometryType);
         }
         _cache.setAction(param1,param2);
         var_1826 = true;
      }
      
      private function resetBodyPartCache(param1:class_3544) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.definition.assetPartDefinition == "")
         {
            return;
         }
         if(param1.definition.isMain)
         {
            var_1753 = param1;
            _cache.setGeometryType(param1.definition.geometryType);
         }
         _cache.resetBodyPartCache(param1);
         var_1826 = true;
      }
      
      public function get avatarSpriteData() : class_3581
      {
         return var_2244;
      }
      
      private function convertToGrayscale(param1:BitmapData, param2:String = "CHANNELS_EQUAL") : BitmapData
      {
         var _loc5_:Number = 0.33;
         var _loc8_:Number = 0.33;
         var _loc6_:Number = 0.33;
         var _loc4_:Number = 1;
         switch(param2)
         {
            case "CHANNELS_UNIQUE":
               _loc5_ = 0.3;
               _loc8_ = 0.59;
               _loc6_ = 0.11;
               break;
            case "CHANNELS_RED":
               _loc5_ = 1;
               _loc8_ = 0;
               _loc6_ = 0;
               break;
            case "CHANNELS_GREEN":
               _loc5_ = 0;
               _loc8_ = 1;
               _loc6_ = 0;
               break;
            case "CHANNELS_BLUE":
               _loc5_ = 0;
               _loc8_ = 0;
               _loc6_ = 1;
               break;
            case "CHANNELS_DESATURATED":
               _loc5_ = 0.3086;
               _loc8_ = 0.6094;
               _loc6_ = 0.082;
         }
         var _loc7_:Array = [_loc5_,_loc8_,_loc6_,0,0,_loc5_,_loc8_,_loc6_,0,0,_loc5_,_loc8_,_loc6_,0,0,0,0,0,1,0];
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter(_loc7_);
         var _loc9_:BitmapData;
         (_loc9_ = new BitmapData(param1.width,param1.height,param1.transparent,4294967295)).copyPixels(param1,param1.rect,DEFAULT_POINT,null,null,false);
         _loc9_.applyFilter(_loc9_,_loc9_.rect,DEFAULT_POINT,_loc3_);
         return _loc9_;
      }
      
      private function errorThis(param1:String) : void
      {
      }
      
      private function logThis(param1:String) : void
      {
      }
      
      public function isPlaceholder() : Boolean
      {
         return false;
      }
      
      public function forceActionUpdate() : void
      {
         var_2962 = "";
      }
      
      public function get animationHasResetOnToggle() : Boolean
      {
         return var_3174;
      }
      
      public function get mainAction() : String
      {
         return var_1753.actionType;
      }
      
      public function disposeInactiveActionCache() : void
      {
         if(_cache)
         {
            _cache.disposeInactiveActions();
         }
      }
      
      public function avatarEffectReady(param1:int) : void
      {
         if(param1 == var_3077)
         {
            resetActions();
            setActionsToParts();
            var_3174 = true;
            var_1826 = true;
            if(var_4258)
            {
               var_4258.avatarEffectReady(param1);
            }
         }
      }
   }
}
