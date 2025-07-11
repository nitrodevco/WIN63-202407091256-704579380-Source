package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanThrowsSnowballAtPositionEvent extends class_3587
   {
       
      
      private var var_2970:HumanGameObject;
      
      private var var_932:int;
      
      private var var_1081:int;
      
      private var var_795:int;
      
      public function HumanThrowsSnowballAtPositionEvent(param1:HumanGameObject, param2:int, param3:int, param4:int)
      {
         super();
         this.var_2970 = param1;
         this.var_932 = param2;
         this.var_1081 = param3;
         this.var_795 = param4;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2970 = null;
      }
      
      override public function apply(param1:class_3565) : void
      {
         human.throwSnowball(targetX,targetY);
         human.startThrowTimer();
         SnowWarEngine.playSound("HBSTG_snowwar_throw");
      }
      
      public function get human() : HumanGameObject
      {
         return var_2970;
      }
      
      public function get targetX() : int
      {
         return var_932;
      }
      
      public function get targetY() : int
      {
         return var_1081;
      }
      
      public function get trajectory() : int
      {
         return var_795;
      }
   }
}
