package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.communication.messages.parser.game.score.class_1729;
   import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetFriendsLeaderboardComposer;
   
   public class LeaderboardTable
   {
      
      public static const SCROLL_DOWN:int = 0;
      
      public static const SCROLL_UP:int = 1;
       
      
      protected var var_1655:SnowWarEngine;
      
      protected var var_4982:Boolean;
      
      protected var var_4252:int;
      
      protected var var_477:int = -1;
      
      protected var _disposed:Boolean;
      
      protected var var_97:Array;
      
      protected var var_1718:int = -1;
      
      protected var var_416:int;
      
      protected var var_1773:int = 8;
      
      protected var var_2397:int = 50;
      
      protected var var_1956:Boolean = true;
      
      protected var var_4166:int;
      
      public function LeaderboardTable(param1:SnowWarEngine)
      {
         super();
         var_1655 = param1;
         var_4252 = var_1655.sessionDataManager.userId;
         var_1773 = var_1655.config.getInteger("games.highscores.viewSize",8);
         var_2397 = var_1655.config.getInteger("games.highscores.windowSize",50);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         disposeTable();
         var_1655 = null;
         var_97 = null;
         _disposed = true;
      }
      
      public function disposeTable() : void
      {
         var_1718 = -1;
         var_97 = null;
         var_416 = -1;
         var_1956 = true;
      }
      
      public function addEntries(param1:Array, param2:int) : void
      {
         var_416 = param2;
         if(!var_97)
         {
            var_97 = param1;
            initializeList();
         }
         else
         {
            var_97 = param1;
            updateCurrentIndex();
         }
         var_1956 = false;
      }
      
      public function addGroupEntries(param1:Array, param2:int, param3:int) : void
      {
         var_477 = param3;
         var_416 = param2;
         if(!var_97)
         {
            var_97 = param1;
            initializeList();
         }
         else
         {
            var_97 = param1;
            updateCurrentIndex();
         }
         var_1956 = false;
      }
      
      protected function initializeList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = false;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < var_97.length)
         {
            _loc1_ = (var_97[_loc3_] as class_1729).gender == "g";
            if(!_loc1_ && (var_97[_loc3_] as class_1729).userId == var_4252)
            {
               _loc2_ = _loc3_;
               break;
            }
            if(_loc1_ && (var_97[_loc3_] as class_1729).userId == var_477)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ >= var_1773)
         {
            var_1718 = _loc2_ - var_1773 / 2;
         }
         else
         {
            var_1718 = 0;
         }
      }
      
      private function updateCurrentIndex() : void
      {
         if(var_1718 < 0)
         {
            var_1718 += var_2397;
         }
         else
         {
            var_1718 -= var_2397;
         }
      }
      
      public function isInitialized() : Boolean
      {
         return var_97 != null;
      }
      
      public function scrollUp() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IMessageComposer = null;
         if(var_1956)
         {
            return false;
         }
         var_1718 -= var_1773;
         if(var_1718 < 0)
         {
            if(var_97[0].rank > 1)
            {
               _loc2_ = Math.max(1,var_97[0].rank - var_2397);
               _loc1_ = getMessageComposer(var_4166,_loc2_,1);
               var_1655.communication.connection.send(_loc1_);
               var_1956 = true;
               return false;
            }
            var_1718 = 0;
         }
         return true;
      }
      
      protected function getMessageComposer(param1:int, param2:int, param3:int) : IMessageComposer
      {
         return new Game2GetFriendsLeaderboardComposer(param1,param2,param3,var_1773,var_2397);
      }
      
      public function scrollDown() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IMessageComposer = null;
         if(var_1956)
         {
            return false;
         }
         var_1718 += var_1773;
         if(var_1718 + var_1773 >= var_97.length)
         {
            if(var_97[var_97.length - 1].rank < var_416)
            {
               _loc2_ = var_97[var_97.length - 1].rank + 1;
               _loc1_ = getMessageComposer(var_4166,_loc2_,0);
               var_1655.communication.connection.send(_loc1_);
               var_1956 = true;
               return false;
            }
         }
         return true;
      }
      
      public function revertToDefaultView(param1:int) : void
      {
         disposeTable();
         var _loc2_:IMessageComposer = getMessageComposer(param1,-1,0);
         var_1655.communication.connection.send(_loc2_);
         var_1956 = true;
         var_4166 = param1;
      }
      
      public function getVisibleEntries() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(!var_97)
         {
            return _loc1_;
         }
         var _loc3_:int = Math.min(var_97.length,var_1718 + var_1773);
         _loc2_ = var_1718;
         while(_loc2_ < _loc3_)
         {
            _loc1_.push(var_97[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function canScrollUp() : Boolean
      {
         if(var_1956 || !var_97 || var_97.length == 0)
         {
            return false;
         }
         if(var_97[0].rank == 1 && var_1718 <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function canScrollDown() : Boolean
      {
         if(var_1956 || !var_97 || var_97.length == 0)
         {
            return false;
         }
         if(var_97[var_97.length - 1].rank >= var_416 && var_1718 + var_1773 >= var_97.length)
         {
            return false;
         }
         return true;
      }
      
      public function get viewSize() : int
      {
         return var_1773;
      }
      
      public function get favouriteGroupId() : int
      {
         return var_477;
      }
   }
}
