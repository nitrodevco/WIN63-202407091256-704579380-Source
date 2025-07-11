package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.class_3566;
   
   public class SynchronizedGameArena implements IDisposable
   {
       
      
      private var var_1655:SnowWarEngine;
      
      private var var_2165:Array;
      
      protected var var_1132:int;
      
      private var var_1963:int;
      
      private var var_4945:int = 1;
      
      private var var_3699:class_3565;
      
      private var var_2926:class_3615;
      
      private var _checkSums:Map;
      
      private var var_318:Boolean = false;
      
      private var var_3868:Boolean = false;
      
      private var _numberOfTeams:int;
      
      private var var_1213:Array;
      
      public function SynchronizedGameArena()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_318 = true;
         var_1655 = null;
         var_2165 = null;
         var_3699 = null;
         if(var_2926 != null)
         {
            var_2926.dispose();
            var_2926 = null;
         }
         _checkSums = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function initialize(param1:SnowWarEngine, param2:int) : void
      {
         var_1655 = param1;
         var_3699 = new class_3566();
         _checkSums = new Map();
         var_2165 = [];
         _numberOfTeams = param2;
         var_1132 = 0;
         var_1963 = 0;
         var_2165[var_1132] = initEmptyEventQueue();
         _checkSums = new Map();
         resetTeamScores();
      }
      
      public function get gameEngine() : SnowWarEngine
      {
         return var_1655;
      }
      
      public function pulse() : void
      {
         gamePulse();
      }
      
      public function gamePulse() : void
      {
         var _loc1_:Array = null;
         var _loc4_:ISynchronizedGameEvent = null;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Turn " + var_1132 + " subturn " + (var_1963 + 1) + "/" + getNumberOfSubTurns());
         }
         var _loc3_:class_3565 = class_3565(getCurrentStage());
         var _loc2_:Array = var_2165[var_1132];
         if(_loc2_)
         {
            _loc1_ = _loc2_[var_1963];
            while(_loc1_.length > 0)
            {
               _loc4_ = _loc1_.shift() as ISynchronizedGameEvent;
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log("GameInstance::gameTurn: applying event " + _loc4_ + " turn " + var_1132 + " subturn " + (var_1963 + 1) + "/" + getNumberOfSubTurns());
               }
               _loc4_.apply(_loc3_);
            }
         }
         if(!var_3868)
         {
            _loc3_.subturn();
         }
         if(var_1963 >= getNumberOfSubTurns() - 1)
         {
            if(var_1132 % var_4945 == 0)
            {
               _checkSums[var_1132] = getCurrentStage().calculateChecksum(var_1132);
            }
            var_1132++;
            var_3868 = false;
            if(HabboGamesCom.logEnabled)
            {
               HabboGamesCom.log("Turn:" + var_1132);
            }
         }
         var_1963++;
         if(var_1963 >= getNumberOfSubTurns())
         {
            var_1963 = 0;
         }
      }
      
      public function addGameEvent(param1:int, param2:int, param3:ISynchronizedGameEvent) : void
      {
         var _loc4_:Array;
         if((_loc4_ = var_2165[param1]) == null)
         {
            _loc4_ = initEmptyEventQueue();
            var_2165[param1] = _loc4_;
         }
         _loc4_[param2].push(param3);
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Add game event: " + param3 + " (subturn/turn): " + param2 + "/" + param1);
         }
      }
      
      public function debugEventQueue() : void
      {
         var _loc5_:int = 0;
         var _loc1_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < var_2165.length)
         {
            _loc1_ = var_2165[_loc5_];
            if(_loc1_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < getNumberOfSubTurns())
               {
                  if((_loc4_ = _loc1_[_loc6_]).length != 0)
                  {
                     _loc2_ += _loc5_ + " (" + _loc6_ + ") : ";
                     for each(var _loc3_ in _loc4_)
                     {
                        _loc2_ += _loc3_;
                     }
                     _loc2_ += "\n";
                  }
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         HabboGamesCom.log(_loc2_);
      }
      
      public function getNumberOfSubTurns() : int
      {
         return this.getExtension().getNumberOfSubTurns();
      }
      
      public function getTurnNumber() : int
      {
         return var_1132;
      }
      
      public function get subturn() : int
      {
         return var_1963;
      }
      
      public function getCurrentStage() : class_3565
      {
         return var_3699;
      }
      
      public function getExtension() : class_3615
      {
         return var_2926;
      }
      
      public function setExtension(param1:class_3615) : void
      {
         var_2926 = param1;
         param1.gameArena = this;
      }
      
      public function getCheckSum(param1:int) : int
      {
         return _checkSums[param1];
      }
      
      public function seekToTurn(param1:int, param2:int) : void
      {
         var_1132 = param1;
         var_1963 = 0;
         _checkSums[param1] = param2;
         var_2165 = [];
         var_2165[var_1132] = initEmptyEventQueue();
         var_3868 = true;
      }
      
      private function initEmptyEventQueue() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < getNumberOfSubTurns())
         {
            _loc2_[_loc1_] = [];
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      private function resetTeamScores() : void
      {
         var _loc1_:int = 0;
         var_1213 = [];
         _loc1_ = 0;
         while(_loc1_ < _numberOfTeams)
         {
            var_1213[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function addTeamScore(param1:int, param2:int) : void
      {
         if(param1 > 0 && param1 <= _numberOfTeams)
         {
            var _loc3_:* = param1 - 1;
            var _loc4_:* = var_1213[_loc3_] + param2;
            var_1213[_loc3_] = _loc4_;
         }
      }
      
      public function getTeamScores() : Array
      {
         return var_1213;
      }
   }
}
