package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanStartsToMakeASnowballEvent extends class_3587
   {
       
      
      private var var_2970:HumanGameObject;
      
      public function HumanStartsToMakeASnowballEvent(param1:HumanGameObject)
      {
         super();
         var_2970 = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2970 = null;
      }
      
      override public function apply(param1:class_3565) : void
      {
         var_2970.startMakingSnowball();
      }
      
      public function get human() : HumanGameObject
      {
         return var_2970;
      }
   }
}
