package com.sulake.habbo.avatar.structure.animation
{
   public class AnimationFrame
   {
       
      
      private var var_3726:int;
      
      private var var_4278:String;
      
      public function AnimationFrame(param1:XML)
      {
         super();
         var_3726 = parseInt(param1.@number);
         var_4278 = param1.@assetpartdefinition;
      }
      
      public function get number() : int
      {
         return var_3726;
      }
      
      public function get assetPartDefinition() : String
      {
         return var_4278;
      }
   }
}
