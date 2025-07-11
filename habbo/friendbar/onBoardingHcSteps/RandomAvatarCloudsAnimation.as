package com.sulake.habbo.friendbar.onBoardingHcSteps
{
    import assets.c3_1_png$46b02c657bbce715001e1d4686ad3c4d1460401361
    import assets.c3_2_png$9d1d775eb8f0d4b9e5610a5488ea692c1461571410
    import assets.c3_3_png$22b9cf23e5ee97f34a1a8fc83fcfa5c51466705875
    import assets.c3_4_png$6366bc004b859e0a7ee0ffb0f84afa521467891308
    import assets.c4_1_png$044846267c9c41d2c92ab5bd4c7af20136842386
    import assets.c4_2_png$b29213b280e74b70f2a2d1aed3a9998033817107
    import assets.c4_3_png$37f7631b5a666f8f52e2350082d374cc35003052
    import assets.c4_4_png$691508e586c084f583e486e9f9ebfe6c35157293
   import assets.class_3865
   import assets.class_3866
   import assets.class_3867
   import assets.class_3868
   import assets.class_3869
   import assets.class_3870
   import assets.class_3871
   import assets.class_3872

   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RandomAvatarCloudsAnimation extends Sprite
   {
      
      private static const cloud_1_1_png:Class = class_3865;
      
      private static const cloud_1_2_png:Class = class_3866;
      
      private static const cloud_1_3_png:Class = class_3867;
      
      private static const cloud_1_4_png:Class = class_3868;
      
      private static const cloud_2_1_png:Class = class_3869;
      
      private static const cloud_2_2_png:Class = class_3870;
      
      private static const cloud_2_3_png:Class = class_3871;
      
      private static const cloud_2_4_png:Class = class_3872;
      
      private static const cloud_3_1_png:Class = c3_1_png$46b02c657bbce715001e1d4686ad3c4d1460401361;
      
      private static const cloud_3_2_png:Class = c3_2_png$9d1d775eb8f0d4b9e5610a5488ea692c1461571410;
      
      private static const cloud_3_3_png:Class = c3_3_png$22b9cf23e5ee97f34a1a8fc83fcfa5c51466705875;
      
      private static const cloud_3_4_png:Class = c3_4_png$6366bc004b859e0a7ee0ffb0f84afa521467891308;
      
      private static const cloud_4_1_png:Class = c4_1_png$044846267c9c41d2c92ab5bd4c7af20136842386;
      
      private static const cloud_4_2_png:Class = c4_2_png$b29213b280e74b70f2a2d1aed3a9998033817107;
      
      private static const cloud_4_3_png:Class = c4_3_png$37f7631b5a666f8f52e2350082d374cc35003052;
      
      private static const cloud_4_4_png:Class = c4_4_png$691508e586c084f583e486e9f9ebfe6c35157293;
       
      
      private var var_4047:Array;
      
      private var var_4044:Array;
      
      private var _downFrames:Array;
      
      private var var_4203:Array;
      
      private var var_2436:Timer;
      
      private var var_2166:int;
      
      private var _animationFrame:int;
      
      private var var_2031:Sprite;
      
      private var var_1930:Sprite;
      
      private var var_2078:Sprite;
      
      private var var_4043:Array;
      
      private var var_3719:int;
      
      public function RandomAvatarCloudsAnimation()
      {
         var_4043 = [-9,-8,-5,-3,3,5,8,9];
         super();
         var_4044 = [new cloud_1_1_png(),new cloud_1_2_png(),new cloud_1_3_png(),new cloud_1_4_png()];
         var_4047 = [new cloud_2_1_png(),new cloud_2_2_png(),new cloud_2_3_png(),new cloud_2_4_png()];
         _downFrames = [new cloud_3_1_png(),new cloud_3_2_png(),new cloud_3_3_png(),new cloud_3_4_png()];
         var_4203 = [new cloud_4_1_png(),new cloud_4_2_png(),new cloud_4_3_png(),new cloud_4_4_png()];
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private function dispose() : void
      {
         if(var_2436)
         {
            var_2436.reset();
            var_2436 = null;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         var_2078 = new Sprite();
         addChild(var_2078);
         var_2031 = new Sprite();
         addChild(var_2031);
         var_1930 = new Sprite();
         addChild(var_1930);
         resetAnimation();
      }
      
      private function resetAnimation() : void
      {
         var_2166 = 0;
         _animationFrame = 0;
         var_2078.addChild(_downFrames[0]);
         var_2078.x = 75;
         var_2078.y = 140;
         var_2031.addChild(var_4047[0]);
         var_2031.x = 30;
         var_2031.y = 115;
         var_1930.addChild(var_4044[0]);
         var_1930.x = 85;
         var_1930.y = 110;
         var_2078.visible = true;
         var_2031.visible = true;
         var_1930.visible = true;
      }
      
      public function startAnimation() : void
      {
         resetAnimation();
         if(!var_2436)
         {
            var_2436 = new Timer(80);
            var_2436.addEventListener("timer",onAnimateTimer);
         }
         var _loc1_:int = Math.round(Math.random() * (var_4043.length - 1));
         var_3719 = var_4043[_loc1_];
         var_2436.start();
      }
      
      private function onAnimateTimer(param1:TimerEvent) : void
      {
         if(var_2436 == null)
         {
            return;
         }
         var_2166++;
         if(var_2166 > 2 && var_2166 < 5)
         {
            _animationFrame = 1;
         }
         else if(var_2166 > 4 && var_2166 < 7)
         {
            _animationFrame = 2;
         }
         else if(var_2166 > 6 && var_2166 < 9)
         {
            _animationFrame = 3;
         }
         else if(var_2166 >= 9)
         {
            var_2078.visible = false;
            var_2031.visible = false;
            var_1930.visible = false;
         }
         var_2078.removeChildAt(0);
         var_2031.removeChildAt(0);
         var_1930.removeChildAt(0);
         var_2078.addChild(_downFrames[_animationFrame]);
         var_2031.addChild(var_4047[_animationFrame]);
         var_1930.addChild(var_4044[_animationFrame]);
         var _loc2_:int = Math.round(Math.random() * 10);
         if(_loc2_ % 2 != 0)
         {
            var_1930.removeChildAt(0);
            var_1930.addChild(var_4203[_animationFrame]);
         }
         else
         {
            var_2078.removeChildAt(0);
            var_2078.addChild(var_4203[_animationFrame]);
         }
         if(var_2166 <= 9)
         {
            var_1930.x += 10 + Math.random() * 5;
            var_1930.y -= var_3719;
            var_2031.x -= 10 + Math.random() * 5;
            var_2031.y -= var_3719;
            var_2078.y += var_3719 * 1.3;
         }
      }
   }
}
