package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IDisposable;
   
   public interface class_3615 extends IDisposable
   {
       
      
      function createGameStage() : class_3564;
      
      function set gameArena(param1:SynchronizedGameArena) : void;
      
      function pulse() : void;
      
      function getPulseInterval() : int;
      
      function getNumberOfSubTurns() : int;
   }
}
