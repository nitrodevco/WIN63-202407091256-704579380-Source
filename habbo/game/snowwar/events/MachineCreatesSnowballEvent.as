package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   
   public class MachineCreatesSnowballEvent extends class_3587
   {
       
      
      private var var_3566:SnowballMachineGameObject;
      
      public function MachineCreatesSnowballEvent(param1:SnowballMachineGameObject)
      {
         super();
         var_3566 = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_3566 = null;
      }
      
      override public function apply(param1:class_3565) : void
      {
         if(var_3566)
         {
            var_3566.createSnowball();
         }
         else
         {
            HabboGamesCom.log("Too early for this stuff..");
         }
      }
   }
}
