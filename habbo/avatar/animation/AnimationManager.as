package com.sulake.habbo.avatar.animation
{
   import com.sulake.habbo.avatar.AvatarStructure;
   import flash.utils.Dictionary;
   
   public class AnimationManager implements class_3372
   {
       
      
      private var var_2086:Dictionary;
      
      public function AnimationManager()
      {
         super();
         var_2086 = new Dictionary();
      }
      
      public function registerAnimation(param1:AvatarStructure, param2:XML) : Boolean
      {
         var _loc3_:String = String(param2.@name);
         var_2086[_loc3_] = new Animation(param1,param2);
         return true;
      }
      
      public function getAnimation(param1:String) : class_3557
      {
         return var_2086[param1];
      }
      
      public function getLayerData(param1:String, param2:int, param3:String) : class_3526
      {
         var _loc4_:Animation;
         if((_loc4_ = var_2086[param1] as Animation) != null)
         {
            return _loc4_.getLayerData(param2,param3);
         }
         return null;
      }
      
      public function get animations() : Dictionary
      {
         return var_2086;
      }
   }
}
