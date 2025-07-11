package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class SpiralMovingBackgroundObject extends BackgroundObject
   {
       
      
      private var _startRadius:int;
      
      private var var_4800:int;
      
      private var _posRadius:Number;
      
      private var var_2103:Number;
      
      private var _speedRadius:Number;
      
      private var var_4473:Number;
      
      private var var_4639:Number;
      
      private var var_4540:Number;
      
      public function SpiralMovingBackgroundObject(param1:int, param2:IWindowContainer, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc7_:Array;
         var _loc6_:String = String((_loc7_ = param5.split(";"))[0]);
         _startRadius = int(_loc7_[2]);
         var_4800 = int(_loc7_[3]);
         _speedRadius = Number(_loc7_[4]);
         var_4473 = Number(_loc7_[5]);
         var_4639 = Number(_loc7_[6]);
         var_4540 = Number(_loc7_[7]);
         _posRadius = _startRadius;
         var_2103 = var_4800;
         sprite.assetUri = "${image.library.url}reception/" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         var _loc2_:Number = _startRadius / _posRadius;
         var _loc3_:Number = 1 + _startRadius / _posRadius / 8;
         _posRadius += param1 * _speedRadius;
         var_2103 += param1 * var_4473 * _loc2_;
         if(sprite.bitmapData)
         {
            if(_posRadius <= 0)
            {
               _posRadius = _startRadius;
               sprite.width = sprite.bitmapData.width;
               sprite.height = sprite.bitmapData.height;
               events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
            }
         }
         if(_posRadius > _startRadius)
         {
            _posRadius = 0;
            sprite.width = 0;
            sprite.height = 0;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
         if(var_2103 < 0)
         {
            var_2103 = 3.141592653589793 * 2;
         }
         if(var_2103 > 3.141592653589793 * 2)
         {
            var_2103 = 0;
         }
         sprite.x = var_4639 + Math.sin(var_2103) * _posRadius;
         sprite.y = var_4540 + Math.cos(var_2103) * _posRadius;
         if(sprite.bitmapData)
         {
            sprite.pivotPoint = 4;
            sprite.stretchedX = true;
            sprite.stretchedY = true;
            sprite.width = sprite.bitmapData.width / _loc3_;
            sprite.height = sprite.bitmapData.height / _loc3_;
         }
      }
   }
}
