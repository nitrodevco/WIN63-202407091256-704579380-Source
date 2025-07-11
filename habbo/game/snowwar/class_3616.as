package com.sulake.habbo.game.snowwar
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.class_3564;
   import com.sulake.habbo.game.snowwar.arena.class_3615;
   
   public class class_3616 implements class_3615
   {
       
      
      private var var_1692:SynchronizedGameArena;
      
      private var var_318:Boolean = false;
      
      public function class_3616()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_318 = true;
         var_1692 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function set gameArena(param1:SynchronizedGameArena) : void
      {
         var_1692 = param1;
      }
      
      public function getPulseInterval() : int
      {
         return 50;
      }
      
      public function getNumberOfSubTurns() : int
      {
         return 3;
      }
      
      public function createGameStage() : class_3564
      {
         return new class_3566();
      }
      
      public function pulse() : void
      {
      }
      
      public function isDeathMatch() : Boolean
      {
         return var_1692.numberOfTeams == 1;
      }
   }
}
