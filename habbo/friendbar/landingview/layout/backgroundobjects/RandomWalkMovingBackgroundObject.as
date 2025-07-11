package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import com.sulake.habbo.utils.class_419;
   import flash.events.EventDispatcher;
   
   public class RandomWalkMovingBackgroundObject extends BackgroundObject
   {
       
      
      private var var_4223:int;
      
      private var var_3995:int;
      
      private var var_4272:Number;
      
      private var var_4463:Number;
      
      private var var_3591:Number;
      
      private var var_3590:Number;
      
      private var var_4067:Number;
      
      private var var_1883:uint = 0;
      
      private var var_2752:Number;
      
      private var var_2818:Number;
      
      private var var_3965:Number = 0;
      
      private var var_4059:Number = 0;
      
      private var var_4748:Number = 0;
      
      private var var_4564:Number = 0;
      
      private var var_4172:uint;
      
      public function RandomWalkMovingBackgroundObject(param1:int, param2:IWindowContainer, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5,false);
         var _loc7_:Array;
         var _loc6_:String = String((_loc7_ = param5.split(";"))[0]);
         var_4223 = int(_loc7_[2]);
         var_3995 = int(_loc7_[3]);
         var_3591 = Number(_loc7_[4]);
         var_3590 = Number(_loc7_[5]);
         var_4272 = Number(_loc7_[6]);
         var_4463 = Number(_loc7_[7]);
         var_4067 = int(_loc7_[8]);
         var_2752 = var_4223;
         var_2818 = var_3995;
         sprite.assetUri = "${image.library.url}" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         if(!sprite)
         {
            return;
         }
         var_1883 += param1;
         if(var_1883 - var_4172 > var_4067)
         {
            var_4748 = var_3965;
            var_4564 = var_4059;
            var_3965 = (Math.random() * 2 - 1) * var_4272;
            var_4059 = (Math.random() * 2 - 1) * var_4463;
            var_4172 = var_1883;
         }
         var _loc4_:int = window.width;
         var _loc2_:int = window.height;
         var _loc3_:Number = (var_1883 - var_4172) / var_4067;
         var_2752 += param1 / 1000 * (var_3591 + class_419.lerp(_loc3_,var_4748,var_3965));
         var_2818 += param1 / 1000 * (var_3590 + class_419.lerp(_loc3_,var_4564,var_4059));
         sprite.x = var_2752;
         sprite.y = var_2818;
         if(var_3591 > 0 && sprite.x > _loc4_ || var_3591 < 0 && sprite.x + sprite.width < 0 || var_3590 > 0 && sprite.y > _loc2_ || var_3590 < 0 && sprite.y + sprite.height < 0)
         {
            var_2752 = var_4223;
            var_2818 = var_3995;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
      }
   }
}
