package com.sulake.habbo.utils.animation
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class DelayedCall extends EventDispatcher implements class_65
   {
      
      private static var var_400:Vector.<DelayedCall> = new Vector.<DelayedCall>(0);
       
      
      private var mCurrentTime:Number;
      
      private var mTotalTime:Number;
      
      private var var_448:Function;
      
      private var var_629:Array;
      
      private var var_75:int;
      
      public function DelayedCall(param1:Function, param2:Number, param3:Array = null)
      {
         super();
         reset(param1,param2,param3);
      }
      
      internal static function fromPool(param1:Function, param2:Number, param3:Array = null) : DelayedCall
      {
         if(var_400.length)
         {
            return var_400.pop().reset(param1,param2,param3);
         }
         return new DelayedCall(param1,param2,param3);
      }
      
      internal static function toPool(param1:DelayedCall) : void
      {
         param1.var_448 = null;
         param1.var_629 = null;
         param1.removeEventListeners();
         var_400.push(param1);
      }
      
      public function reset(param1:Function, param2:Number, param3:Array = null) : DelayedCall
      {
         mCurrentTime = 0;
         mTotalTime = Math.max(param2,0.0001);
         var_448 = param1;
         var_629 = param3;
         var_75 = 1;
         return this;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         var _loc4_:Number = mCurrentTime;
         mCurrentTime += param1;
         if(mCurrentTime > mTotalTime)
         {
            mCurrentTime = mTotalTime;
         }
         if(_loc4_ < mTotalTime && mCurrentTime >= mTotalTime)
         {
            if(var_75 == 0 || var_75 > 1)
            {
               var_448.apply(null,var_629);
               if(var_75 > 0)
               {
                  var_75 -= 1;
               }
               mCurrentTime = 0;
               advanceTime(_loc4_ + param1 - mTotalTime);
            }
            else
            {
               _loc2_ = var_448;
               _loc3_ = var_629;
               dispatchEvent(new Event("REMOVE_FROM_JUGGLER"));
               _loc2_.apply(null,_loc3_);
            }
         }
      }
      
      public function complete() : void
      {
         var _loc1_:Number = mTotalTime - mCurrentTime;
         if(_loc1_ > 0)
         {
            advanceTime(_loc1_);
         }
      }
      
      public function get isComplete() : Boolean
      {
         return var_75 == 1 && mCurrentTime >= mTotalTime;
      }
      
      public function get totalTime() : Number
      {
         return mTotalTime;
      }
      
      public function get currentTime() : Number
      {
         return mCurrentTime;
      }
      
      public function get repeatCount() : int
      {
         return var_75;
      }
      
      public function set repeatCount(param1:int) : void
      {
         var_75 = param1;
      }
      
      private function removeEventListeners() : void
      {
      }
   }
}
