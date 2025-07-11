package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanLeftGameEvent extends class_3587
   {
       
      
      private var var_2970:HumanGameObject;
      
      public function HumanLeftGameEvent(param1:HumanGameObject)
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
         param1.putGameObjectOnDeleteList(var_2970);
         var_2970.onRemove();
      }
   }
}
