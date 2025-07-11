package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Tween extends EventDispatcher implements class_65
   {
      
      private static const HINT_MARKER:String = "#";
      
      private static var var_465:Vector.<Tween> = new Vector.<Tween>(0);
       
      
      private var var_157:Object;
      
      private var var_126:Function;
      
      private var mTransitionName:String;
      
      private var var_147:Vector.<String>;
      
      private var var_116:Vector.<Number>;
      
      private var var_227:Vector.<Number>;
      
      private var var_352:Vector.<Function>;
      
      private var var_156:Function;
      
      private var mOnUpdate:Function;
      
      private var var_164:Function;
      
      private var var_200:Function;
      
      private var var_229:Array;
      
      private var var_248:Array;
      
      private var var_251:Array;
      
      private var var_226:Array;
      
      private var mTotalTime:Number;
      
      private var mCurrentTime:Number;
      
      private var var_111:Number;
      
      private var var_337:Number;
      
      private var var_341:Boolean;
      
      private var mNextTween:Tween;
      
      private var var_75:int;
      
      private var var_274:Number;
      
      private var var_276:Boolean;
      
      private var var_110:int;
      
      private const REMOVE_FROM_JUGGLER:String = "REMOVE_FROM_JUGGLER";
      
      public function Tween(param1:Object, param2:Number, param3:Object = "linear")
      {
         super();
         reset(param1,param2,param3);
      }
      
      internal static function getPropertyHint(param1:String) : String
      {
         if(param1.indexOf("color") != -1 || param1.indexOf("Color") != -1)
         {
            return "rgb";
         }
         var _loc2_:int = param1.indexOf("#");
         if(_loc2_ != -1)
         {
            return param1.substr(_loc2_ + 1);
         }
         return null;
      }
      
      internal static function getPropertyName(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("#");
         if(_loc2_ != -1)
         {
            return param1.substring(0,_loc2_);
         }
         return param1;
      }
      
      internal static function fromPool(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         if(var_465.length)
         {
            return var_465.pop().reset(param1,param2,param3);
         }
         return new Tween(param1,param2,param3);
      }
      
      internal static function toPool(param1:Tween) : void
      {
         param1.var_156 = param1.mOnUpdate = param1.var_164 = param1.var_200 = null;
         param1.var_229 = param1.var_248 = param1.var_251 = param1.var_226 = null;
         param1.var_157 = null;
         param1.var_126 = null;
         var_465.push(param1);
      }
      
      public function reset(param1:Object, param2:Number, param3:Object = "linear") : Tween
      {
         var_157 = param1;
         mCurrentTime = 0;
         mTotalTime = Math.max(0.0001,param2);
         var_111 = 0;
         var_337 = var_274 = 0;
         var_156 = mOnUpdate = var_164 = var_200 = null;
         var_229 = var_248 = var_251 = var_226 = null;
         var_341 = var_276 = false;
         var_75 = 1;
         var_110 = -1;
         mNextTween = null;
         if(param3 is String)
         {
            this.transition = param3 as String;
         }
         else
         {
            if(!(param3 is Function))
            {
               throw new ArgumentError("Transition must be either a string or a function");
            }
            this.transitionFunc = param3 as Function;
         }
         if(var_147)
         {
            var_147.length = 0;
         }
         else
         {
            var_147 = new Vector.<String>(0);
         }
         if(var_116)
         {
            var_116.length = 0;
         }
         else
         {
            var_116 = new Vector.<Number>(0);
         }
         if(var_227)
         {
            var_227.length = 0;
         }
         else
         {
            var_227 = new Vector.<Number>(0);
         }
         if(var_352)
         {
            var_352.length = 0;
         }
         else
         {
            var_352 = new Vector.<Function>(0);
         }
         return this;
      }
      
      public function animate(param1:String, param2:Number) : void
      {
         if(var_157 == null)
         {
            return;
         }
         var _loc3_:int = int(var_147.length);
         var _loc4_:Function = getUpdateFuncFromProperty(param1);
         var_147[_loc3_] = getPropertyName(param1);
         var_116[_loc3_] = NaN;
         var_227[_loc3_] = param2;
         var_352[_loc3_] = _loc4_;
      }
      
      public function scaleTo(param1:Number) : void
      {
         animate("scaleX",param1);
         animate("scaleY",param1);
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         animate("x",param1);
         animate("y",param2);
      }
      
      public function fadeTo(param1:Number) : void
      {
         animate("alpha",param1);
      }
      
      public function rotateTo(param1:Number, param2:String = "rad") : void
      {
         animate("rotation#" + param2,param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Function = null;
         var _loc5_:Function = null;
         var _loc8_:Array = null;
         if(param1 == 0 || var_75 == 1 && mCurrentTime == mTotalTime)
         {
            return;
         }
         var _loc3_:Number = mCurrentTime;
         var _loc2_:Number = mTotalTime - mCurrentTime;
         var _loc10_:Number = param1 > _loc2_ ? param1 - _loc2_ : 0;
         mCurrentTime += param1;
         if(mCurrentTime <= 0)
         {
            return;
         }
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(var_110 < 0 && _loc3_ <= 0 && mCurrentTime > 0)
         {
            var_110++;
            if(var_156 != null)
            {
               var_156.apply(this,var_229);
            }
         }
         var _loc11_:Number = mCurrentTime / mTotalTime;
         var _loc9_:Boolean = var_276 && var_110 % 2 == 1;
         var _loc4_:int = int(var_116.length);
         var_111 = _loc9_ ? var_126(1 - _loc11_) : var_126(_loc11_);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(var_116[_loc6_] != var_116[_loc6_])
            {
               var_116[_loc6_] = var_157[var_147[_loc6_]] as Number;
            }
            (_loc7_ = var_352[_loc6_] as Function)(var_147[_loc6_],var_116[_loc6_],var_227[_loc6_]);
            _loc6_++;
         }
         if(mOnUpdate != null)
         {
            mOnUpdate.apply(this,var_248);
         }
         if(_loc3_ < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(var_75 == 0 || var_75 > 1)
            {
               mCurrentTime = -var_274;
               var_110++;
               if(var_75 > 1)
               {
                  var_75--;
               }
               if(var_164 != null)
               {
                  var_164.apply(this,var_251);
               }
            }
            else
            {
               _loc5_ = var_200;
               _loc8_ = var_226;
               dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
               if(_loc5_ != null)
               {
                  _loc5_.apply(this,_loc8_);
               }
               if(mCurrentTime == 0)
               {
                  _loc10_ = 0;
               }
            }
         }
         if(_loc10_)
         {
            advanceTime(_loc10_);
         }
      }
      
      private function getUpdateFuncFromProperty(param1:String) : Function
      {
         var _loc3_:Function = null;
         var _loc2_:String = getPropertyHint(param1);
         switch(_loc2_)
         {
            case null:
               _loc3_ = updateStandard;
               break;
            case "rgb":
               _loc3_ = updateRgb;
               break;
            case "rad":
               _loc3_ = updateRad;
               break;
            case "deg":
               _loc3_ = updateDeg;
               break;
            default:
               _loc3_ = updateStandard;
         }
         return _loc3_;
      }
      
      private function updateStandard(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param2 + var_111 * (param3 - param2);
         if(var_341)
         {
            _loc4_ = Math.round(_loc4_);
         }
         var_157[param1] = _loc4_;
      }
      
      private function updateRgb(param1:String, param2:Number, param3:Number) : void
      {
         var _loc11_:uint = param2;
         var _loc6_:uint = param3;
         var _loc13_:uint = uint(_loc11_ >> 24 & 255);
         var _loc17_:uint = uint(_loc11_ >> 16 & 255);
         var _loc7_:uint = uint(_loc11_ >> 8 & 255);
         var _loc10_:uint = uint(_loc11_ & 255);
         var _loc9_:uint = uint(_loc6_ >> 24 & 255);
         var _loc16_:uint = uint(_loc6_ >> 16 & 255);
         var _loc5_:uint = uint(_loc6_ >> 8 & 255);
         var _loc8_:uint = uint(_loc6_ & 255);
         var _loc14_:uint = _loc13_ + (_loc9_ - _loc13_) * var_111;
         var _loc4_:uint = _loc17_ + (_loc16_ - _loc17_) * var_111;
         var _loc15_:uint = _loc7_ + (_loc5_ - _loc7_) * var_111;
         var _loc12_:uint = _loc10_ + (_loc8_ - _loc10_) * var_111;
         var_157[param1] = _loc14_ << 24 | _loc4_ << 16 | _loc15_ << 8 | _loc12_;
      }
      
      private function updateRad(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(3.141592653589793,param1,param2,param3);
      }
      
      private function updateDeg(param1:String, param2:Number, param3:Number) : void
      {
         updateAngle(180,param1,param2,param3);
      }
      
      private function updateAngle(param1:Number, param2:String, param3:Number, param4:Number) : void
      {
         while(Math.abs(param4 - param3) > param1)
         {
            if(param3 < param4)
            {
               param4 -= 2 * param1;
            }
            else
            {
               param4 += 2 * param1;
            }
         }
         updateStandard(param2,param3,param4);
      }
      
      public function getEndValue(param1:String) : Number
      {
         var _loc2_:int = var_147.indexOf(param1);
         if(_loc2_ == -1)
         {
            throw new ArgumentError("The property \'" + param1 + "\' is not animated");
         }
         return var_227[_loc2_] as Number;
      }
      
      public function get isComplete() : Boolean
      {
         return mCurrentTime >= mTotalTime && var_75 == 1;
      }
      
      public function get target() : Object
      {
         return var_157;
      }
      
      public function get transition() : String
      {
         return mTransitionName;
      }
      
      public function set transition(param1:String) : void
      {
         mTransitionName = param1;
         var_126 = Transitions.getTransition(param1);
         if(var_126 == null)
         {
            throw new ArgumentError("Invalid transiton: " + param1);
         }
      }
      
      public function get transitionFunc() : Function
      {
         return var_126;
      }
      
      public function set transitionFunc(param1:Function) : void
      {
         mTransitionName = "custom";
         var_126 = param1;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get progress() : Number
      {
         return var_111;
      }
      
      public function get delay() : Number
      {
         return var_337;
      }
      
      public function set delay(param1:Number) : void
      {
         mCurrentTime = mCurrentTime + var_337 - param1;
         var_337 = param1;
      }
      
      public function get repeatCount() : int
      {
         return var_75;
      }
      
      public function set repeatCount(param1:int) : void
      {
         var_75 = param1;
      }
      
      public function get repeatDelay() : Number
      {
         return var_274;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         var_274 = param1;
      }
      
      public function get reverse() : Boolean
      {
         return var_276;
      }
      
      public function set reverse(param1:Boolean) : void
      {
         var_276 = param1;
      }
      
      public function get roundToInt() : Boolean
      {
         return var_341;
      }
      
      public function set roundToInt(param1:Boolean) : void
      {
         var_341 = param1;
      }
      
      public function get onStart() : Function
      {
         return var_156;
      }
      
      public function set onStart(param1:Function) : void
      {
         var_156 = param1;
      }
      
      public function get onUpdate() : Function
      {
         return mOnUpdate;
      }
      
      public function set onUpdate(param1:Function) : void
      {
         mOnUpdate = param1;
      }
      
      public function get onRepeat() : Function
      {
         return var_164;
      }
      
      public function set onRepeat(param1:Function) : void
      {
         var_164 = param1;
      }
      
      public function get onComplete() : Function
      {
         return var_200;
      }
      
      public function set onComplete(param1:Function) : void
      {
         var_200 = param1;
      }
      
      public function get onStartArgs() : Array
      {
         return var_229;
      }
      
      public function set onStartArgs(param1:Array) : void
      {
         var_229 = param1;
      }
      
      public function get onUpdateArgs() : Array
      {
         return var_248;
      }
      
      public function set onUpdateArgs(param1:Array) : void
      {
         var_248 = param1;
      }
      
      public function get onRepeatArgs() : Array
      {
         return var_251;
      }
      
      public function set onRepeatArgs(param1:Array) : void
      {
         var_251 = param1;
      }
      
      public function get onCompleteArgs() : Array
      {
         return var_226;
      }
      
      public function set onCompleteArgs(param1:Array) : void
      {
         var_226 = param1;
      }
      
      public function get nextTween() : Tween
      {
         return mNextTween;
      }
      
      public function set nextTween(param1:Tween) : void
      {
         mNextTween = param1;
      }
   }
}
