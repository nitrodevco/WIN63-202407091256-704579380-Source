package com.sulake.core.window.motion
{
   import com.sulake.core.class_79;
   import com.sulake.core.window.IWindow;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   use namespace friend;
   
   public class class_3596
   {
      
      private static const const_414:Vector.<Motion> = new Vector.<Motion>();
      
      private static const const_410:Vector.<Motion> = new Vector.<Motion>();
      
      private static const const_427:Vector.<Motion> = new Vector.<Motion>();
      
      private static const _TIMER:Timer = new Timer(1000 / class_79.instance.displayObjectContainer.stage.frameRate,0);
      
      private static var _IS_UPDATING:Boolean;
       
      
      public function class_3596()
      {
         super();
      }
      
      public static function runMotion(param1:Motion) : Motion
      {
         if(const_410.indexOf(param1) == -1 && const_414.indexOf(param1) == -1)
         {
            if(_IS_UPDATING)
            {
               const_414.push(param1);
            }
            else
            {
               const_410.push(param1);
               param1.friend::start();
            }
            startTimer();
         }
         return param1;
      }
      
      public static function removeMotion(param1:Motion) : void
      {
         var _loc2_:int = const_410.indexOf(param1);
         if(_loc2_ > -1)
         {
            if(_IS_UPDATING)
            {
               _loc2_ = const_427.indexOf(param1);
               if(_loc2_ == -1)
               {
                  const_427.push(param1);
               }
            }
            else
            {
               const_410.splice(_loc2_,1);
               if(param1.running)
               {
                  param1.friend::stop();
               }
               if(const_410.length == 0)
               {
                  stopTimer();
               }
            }
         }
         else
         {
            _loc2_ = const_414.indexOf(param1);
            if(_loc2_ > -1)
            {
               const_414.splice(_loc2_,1);
            }
         }
      }
      
      public static function getMotionByTag(param1:String) : Motion
      {
         var _loc2_:* = null;
         for each(_loc2_ in const_410)
         {
            if(_loc2_.tag == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in const_414)
         {
            if(_loc2_.tag == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getMotionByTarget(param1:IWindow) : Motion
      {
         var _loc2_:* = null;
         for each(_loc2_ in const_410)
         {
            if(_loc2_.target == param1)
            {
               return _loc2_;
            }
         }
         for each(_loc2_ in const_414)
         {
            if(_loc2_.target == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getMotionByTagAndTarget(param1:String, param2:IWindow) : Motion
      {
         var _loc3_:* = null;
         for each(_loc3_ in const_410)
         {
            if(_loc3_.tag == param1 && _loc3_.target == param2)
            {
               return _loc3_;
            }
         }
         for each(_loc3_ in const_414)
         {
            if(_loc3_.tag == param1 && _loc3_.target == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function get isRunning() : Boolean
      {
         return !!_TIMER ? _TIMER.running : false;
      }
      
      public static function get isUpdating() : Boolean
      {
         return _IS_UPDATING;
      }
      
      private static function onTick(param1:TimerEvent) : void
      {
         var _loc2_:Motion = null;
         _IS_UPDATING = true;
         var _loc3_:int = getTimer();
         while((_loc2_ = const_414.pop()) != null)
         {
            const_410.push(_loc2_);
         }
         while((_loc2_ = const_427.pop()) != null)
         {
            const_410.splice(const_410.indexOf(_loc2_),1);
            if(_loc2_.running)
            {
               _loc2_.friend::stop();
            }
         }
         for each(_loc2_ in const_410)
         {
            if(_loc2_.running)
            {
               _loc2_.friend::tick(_loc3_);
               if(_loc2_.complete)
               {
                  removeMotion(_loc2_);
               }
            }
            else
            {
               removeMotion(_loc2_);
            }
         }
         if(const_410.length == 0)
         {
            stopTimer();
         }
         _IS_UPDATING = false;
      }
      
      private static function startTimer() : void
      {
         if(!_TIMER.running)
         {
            _TIMER.addEventListener("timer",onTick);
            _TIMER.start();
         }
      }
      
      private static function stopTimer() : void
      {
         if(_TIMER.running)
         {
            _TIMER.removeEventListener("timer",onTick);
            _TIMER.stop();
         }
      }
      
      public function getNumRunningMotions(param1:IWindow) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in const_410)
         {
            if(_loc3_.target == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
   }
}
