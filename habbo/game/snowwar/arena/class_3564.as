package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   public interface class_3564 extends IDisposable
   {
       
      
      function initialize(param1:SynchronizedGameArena, param2:GameLevelData) : void;
      
      function get gameArena() : SynchronizedGameArena;
      
      function get roomType() : String;
   }
}
