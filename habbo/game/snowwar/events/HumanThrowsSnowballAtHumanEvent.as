package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanThrowsSnowballAtHumanEvent extends class_3587
   {
       
      
      private var var_2970:HumanGameObject;
      
      private var var_3040:HumanGameObject;
      
      private var var_795:int;
      
      public function HumanThrowsSnowballAtHumanEvent(param1:HumanGameObject, param2:HumanGameObject, param3:int)
      {
         super();
         var_2970 = param1;
         var_3040 = param2;
         var_795 = param3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2970 = null;
         var_3040 = null;
         var_795 = 0;
      }
      
      override public function apply(param1:class_3565) : void
      {
         human.throwSnowball(var_3040.currentLocation.x,var_3040.currentLocation.y);
         human.startThrowTimer();
         SnowWarEngine.playSound("HBSTG_snowwar_throw");
      }
      
      public function get human() : HumanGameObject
      {
         return var_2970;
      }
      
      public function get targetHuman() : HumanGameObject
      {
         return var_3040;
      }
      
      public function get trajectory() : int
      {
         return var_795;
      }
   }
}
