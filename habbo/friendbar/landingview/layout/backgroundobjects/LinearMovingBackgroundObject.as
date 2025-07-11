package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class LinearMovingBackgroundObject extends BackgroundObject
   {
       
      
      private var var_4223:int;
      
      private var var_3995:int;
      
      private var var_2752:Number;
      
      private var var_2818:Number;
      
      private var var_3591:Number;
      
      private var var_3590:Number;
      
      public function LinearMovingBackgroundObject(param1:int, param2:IWindowContainer, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc7_:Array;
         var _loc6_:String = String((_loc7_ = param5.split(";"))[0]);
         var_4223 = int(_loc7_[2]);
         var_3995 = int(_loc7_[3]);
         var_3591 = Number(_loc7_[4]);
         var_3590 = Number(_loc7_[5]);
         var_2752 = var_4223;
         var_2818 = var_3995;
         sprite.assetUri = "${image.library.url}reception/" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         if(!sprite)
         {
            return;
         }
         var _loc3_:int = window.width;
         var _loc2_:int = window.height;
         var_2752 += param1 * var_3591;
         var_2818 += param1 * var_3590;
         sprite.x = var_2752;
         sprite.y = var_2818 + window.desktop.height;
         if(var_3591 > 0 && sprite.x > _loc3_ || var_3591 < 0 && sprite.x + sprite.width < 0 || var_3590 > 0 && sprite.y > _loc2_ || var_3590 < 0 && sprite.y + sprite.height < 0)
         {
            var_2752 = var_4223;
            var_2818 = var_3995;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
      }
   }
}
