package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   public class DefaultGameStage implements class_3564
   {
       
      
      protected var var_1692:SynchronizedGameArena;
      
      protected var var_1392:GameLevelData;
      
      private var var_318:Boolean = false;
      
      public function DefaultGameStage()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_318 = true;
         var_1692 = null;
         var_1392 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function initialize(param1:SynchronizedGameArena, param2:GameLevelData) : void
      {
         var_1692 = param1;
         var_1392 = param2;
      }
      
      public function get gameArena() : SynchronizedGameArena
      {
         return var_1692;
      }
      
      public function get gameLevelData() : GameLevelData
      {
         return var_1392;
      }
      
      public function get roomType() : String
      {
         return "";
      }
   }
}
