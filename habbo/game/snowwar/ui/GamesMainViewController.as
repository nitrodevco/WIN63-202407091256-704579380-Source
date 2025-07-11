package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class GamesMainViewController implements IDisposable
   {
      
      private static const INSTRUCTION_ASSETS:Array = ["move_","throw_1_","throw_2_","throw_3_","balls_"];
      
      private static const INSTRUCTION_FRAME_COUNTS:Array = [4,4,5,5,5];
      
      private static const INSTRUCTION_FRAME_LENGTH:int = 1000;
       
      
      private var var_1655:SnowWarEngine;
      
      private var var_1980:IWindowContainer;
      
      private var var_1641:IWindowContainer;
      
      private var var_1810:GameLobbyWindowCtrl;
      
      private var var_318:Boolean;
      
      private var var_2429:SnowWarAnimatedWindowElement;
      
      private var var_2509:Timer;
      
      private var var_1931:int = 0;
      
      private var var_1860:int = 0;
      
      public function GamesMainViewController(param1:SnowWarEngine)
      {
         super();
         var_1655 = param1;
      }
      
      public function get gameEngine() : SnowWarEngine
      {
         return var_1655;
      }
      
      public function get rootWindow() : IWindowContainer
      {
         return var_1980;
      }
      
      public function get lobbyView() : GameLobbyWindowCtrl
      {
         return var_1810;
      }
      
      public function toggleVisibility() : void
      {
         if(var_1980)
         {
            var_1980.visible = !rootWindow.visible;
         }
         else
         {
            openMainWindow(true);
         }
      }
      
      private function createWindow() : void
      {
         var _loc1_:int = 0;
         var_1980 = WindowUtils.createWindow("games_main",1) as IWindowContainer;
         var_1980.findChildByTag("close").addEventListener("WME_CLICK",onClose);
         var_1980.visible = true;
         var_1980.center();
         var_1641 = var_1980.findChildByName("quick_play_container") as IWindowContainer;
         var_1641.findChildByName("play.button").addEventListener("WME_CLICK",onPlay);
         var_1641.visible = false;
         var_1641.findChildByName("instructions_link").addEventListener("WME_CLICK",onInstructions);
         var_1641.findChildByName("leaderboard_link").addEventListener("WME_CLICK",onLeaderboard);
         var_1641.findChildByName("instructions_back").addEventListener("WME_CLICK",onBack);
         var_1641.findChildByName("instructions_next").addEventListener("WME_CLICK",onNext);
         var_1641.findChildByName("instructions_prev").addEventListener("WME_CLICK",onPrevious);
         var_1641.findChildByName("games_vip_region").addEventListener("WME_CLICK",onOpenClubCenter);
         var_1641.procedure = windowEventProc;
         var_1641.findChildByName("leaderboard_link").visible = var_1655.config.getBoolean("games.highscores.enabled");
         var _loc2_:IItemListWindow = var_1641.findChildByName("page_list") as IItemListWindow;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.numListItems)
         {
            _loc2_.getListItemAt(_loc1_).addEventListener("WME_CLICK",onSelectPage);
            _loc1_++;
         }
         var_318 = false;
         updateGameStartingStatus();
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_OVER" || param1.type == "WME_OUT")
         {
            switch(param2.name)
            {
               case "btn_more_games_10":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_10" + (param1.type == "WME_OVER" ? "_hi" : "")));
                  break;
               case "btn_more_games_100":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_100" + (param1.type == "WME_OVER" ? "_hi" : "")));
                  break;
               case "btn_more_games_300":
                  WindowUtils.setElementImage(param2,getBitmap("btn_more_games_300" + (param1.type == "WME_OVER" ? "_hi" : "")));
            }
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "btn_more_games_10":
                  var_1655.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
                  var_1655.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                  break;
               case "btn_more_games_100":
                  var_1655.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS2");
                  var_1655.logGameEvent("gameFramework.buyTokens.clicked.frontView");
                  break;
               case "btn_more_games_300":
                  var_1655.catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS3");
                  var_1655.logGameEvent("gameFramework.buyTokens.clicked.frontView");
            }
         }
      }
      
      public function close(param1:Boolean) : void
      {
         if(var_1810 && var_1810.visible)
         {
            var_1810.onClose(param1);
         }
         disposeViews();
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         close(true);
      }
      
      private function onPlay(param1:WindowMouseEvent) : void
      {
         if(var_1655.freeGamesLeft != 0)
         {
            var_1655.startQuickServerGame();
         }
         else
         {
            var_1655.openGetMoreGames("gameFramework.onPlay.clicked.frontView");
         }
      }
      
      private function updateGettingMoreGamesOption() : void
      {
         var _loc1_:IWindow = var_1641.findChildByName("play.button");
         if(var_1655.freeGamesLeft == 0)
         {
            _loc1_.visible = false;
         }
         else
         {
            _loc1_.visible = true;
         }
      }
      
      private function onInstructions(param1:WindowMouseEvent) : void
      {
         showInstructions(true);
      }
      
      private function onLeaderboard(param1:WindowMouseEvent) : void
      {
         var_1655.showLeaderboard();
      }
      
      private function onBack(param1:WindowMouseEvent) : void
      {
         showInstructions(false);
      }
      
      private function onNext(param1:WindowMouseEvent) : void
      {
         var_1860++;
         var_1860 %= INSTRUCTION_ASSETS.length;
         showInstructions(true);
      }
      
      private function onPrevious(param1:WindowMouseEvent) : void
      {
         var_1860 = var_1860 - 1 + INSTRUCTION_ASSETS.length;
         var_1860 %= INSTRUCTION_ASSETS.length;
         showInstructions(true);
      }
      
      private function onSelectPage(param1:WindowMouseEvent) : void
      {
         var_1860 = parseInt(param1.window.name.replace("page_",""));
         showInstructions(true);
      }
      
      private function showInstructions(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc7_:IWindowContainer = null;
         var_1641.findChildByName("teaser_container").visible = !param1;
         var_1641.findChildByName("instructions_container").visible = param1;
         if(var_2429)
         {
            var_2429.dispose();
            var_2429 = null;
         }
         if(!param1)
         {
            return;
         }
         var _loc4_:IBitmapWrapperWindow = var_1641.findChildByName("instructions_image") as IBitmapWrapperWindow;
         var _loc6_:String = String(INSTRUCTION_ASSETS[var_1860]);
         var _loc2_:int = int(INSTRUCTION_FRAME_COUNTS[var_1860]);
         var_2429 = new SnowWarAnimatedWindowElement(var_1655.assets,_loc4_,_loc6_,_loc2_,1000);
         var_1641.findChildByName("instruction_text").caption = "${snowwar.instructions." + (var_1860 + 1) + "}";
         var _loc5_:IItemListWindow = var_1641.findChildByName("page_list") as IItemListWindow;
         _loc3_ = 0;
         while(_loc3_ < _loc5_.numListItems)
         {
            _loc7_ = _loc5_.getListItemAt(_loc3_) as IWindowContainer;
            _loc6_ = _loc3_ <= var_1860 ? "pagination_ball_hilite" : "pagination_ball";
            WindowUtils.setElementImage(_loc7_.getChildAt(0),getBitmap(_loc6_));
            _loc3_++;
         }
      }
      
      private function getBitmap(param1:String) : BitmapData
      {
         var _loc2_:IAsset = var_1655.assets.getAssetByName(param1);
         if(_loc2_)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function onOpenClubCenter(param1:WindowMouseEvent) : void
      {
         var_1655.openClubCenter("gameFramework.getVip.clicked.frontView");
      }
      
      public function openMainWindow(param1:Boolean) : void
      {
         if(!var_1980 && param1)
         {
            createWindow();
         }
         else if(!rootWindow && !param1)
         {
            return;
         }
         if(var_1810)
         {
            var_1810.visible = false;
         }
         var_1641.visible = true;
      }
      
      public function openGameLobbyWindow(param1:String, param2:int, param3:int) : void
      {
         if(!var_1980)
         {
            createWindow();
         }
         if(!var_1810)
         {
            var_1810 = new GameLobbyWindowCtrl(this,param1,param2,param3);
         }
         else
         {
            var_1810.levelName = param1;
            var_1810.numberOfTeams = param2;
            var_1810.maxNumberOfPlayers = param3;
            var_1810.clearPlayerList();
         }
         var_1641.visible = false;
         var_1810.visible = true;
      }
      
      public function dispose() : void
      {
         if(!var_318)
         {
            disposeViews();
            var_318 = true;
            disposeCounter();
         }
      }
      
      private function disposeViews() : void
      {
         if(var_2429)
         {
            var_2429.dispose();
            var_2429 = null;
         }
         if(var_1810)
         {
            var_1810.dispose();
            var_1810 = null;
         }
         if(var_1641)
         {
            var_1641.dispose();
            var_1641 = null;
         }
         if(var_1980)
         {
            var_1980.dispose();
            var_1980 = null;
         }
      }
      
      private function disposeCounter() : void
      {
         if(var_2509)
         {
            var_2509.removeEventListener("timer",onTick);
            var_2509.stop();
            var_2509 = null;
         }
         var_1931 = NaN;
      }
      
      public function get gameLobbyWindowActive() : Boolean
      {
         return var_1810 && var_1810.visible;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function updateGameStartingStatus() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc3_:ITextWindow = null;
         var _loc2_:IWindow = null;
         if(var_1641 && var_1641.visible)
         {
            WindowUtils.setCaption(var_1641.findChildByName("games_left"),var_1655.freeGamesLeft.toString());
            _loc1_ = var_1641.findChildByName("games_left_region") as IWindowContainer;
            _loc3_ = var_1641.findChildByName("games_left_stroke") as ITextWindow;
            _loc2_ = var_1641.findChildByName("play.button");
            _loc2_.visible = true;
            updateGettingMoreGamesOption();
            if(checkGameAmountStatus(_loc1_,_loc3_,_loc2_))
            {
               checkBlockStatus(_loc2_);
            }
         }
      }
      
      private function checkGameAmountStatus(param1:IWindowContainer, param2:ITextWindow, param3:IWindow) : Boolean
      {
         if(var_1655.hasUnlimitedGames)
         {
            param1.visible = false;
            return true;
         }
         param1.visible = true;
         var _loc4_:IWindow = ITextWindow(var_1641.findChildByName("play_text"));
         param3.color = 5622784;
         switch(var_1655.freeGamesLeft - -1)
         {
            case 0:
               param1.visible = false;
               WindowUtils.setCaption(_loc4_,"${snowwar.play}");
               return true;
            case 1:
               param1.visible = true;
               param2.textColor = 16711680;
               WindowUtils.setCaption(_loc4_,"${catalog.vip.buy.title}");
               return false;
            default:
               param1.visible = true;
               param2.textColor = 1079212;
               WindowUtils.setCaption(_loc4_,"${snowwar.play}");
               return true;
         }
      }
      
      private function checkBlockStatus(param1:IWindow) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:IWindow = ITextWindow(var_1641.findChildByName("play_text"));
         if(var_1931 > 0)
         {
            param1.disable();
            param1.color = 13421772;
            _loc3_ = Math.floor(var_1931 / 60);
            _loc2_ = var_1931 % 60;
            _loc4_.caption = _loc3_ + ":" + (_loc2_ < 10 ? "0" + _loc2_ : _loc2_);
         }
         else if(var_1931 <= 0)
         {
            param1.enable();
            param1.color = 5622784;
            WindowUtils.setCaption(_loc4_,"${snowwar.play}");
         }
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(var_1931 && var_1931 > 0)
         {
            var_1931--;
            HabboGamesCom.log("on block tick " + var_1931);
            updateGameStartingStatus();
         }
         if(var_1931 <= 0)
         {
            updateGameStartingStatus();
            disposeCounter();
         }
      }
      
      public function changeBlockStatus(param1:int) : void
      {
         if(param1 > 0)
         {
            var_1931 = param1;
            if(!var_2509)
            {
               var_2509 = new Timer(1000,var_1931);
               var_2509.addEventListener("timer",onTick);
               var_2509.start();
            }
         }
         updateGameStartingStatus();
      }
   }
}
