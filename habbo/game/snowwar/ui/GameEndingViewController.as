package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.avatar.class_3405;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamPlayerData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamScoreData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.class_553;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2GetAccountGameStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.class_647;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.Game2ExitGameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.class_955;
   
   public class GameEndingViewController implements IDisposable, IAvatarImageListener
   {
      
      private static const NUMBER_OF_TEAMS:uint = 2;
      
      private static const STATE_RESULTS:int = 0;
      
      private static const STATE_RESULTS_PENDING_REMATCH:int = 1;
      
      private static const STATE_WAITING:int = 2;
      
      private static const STATE_LOBBY:int = 3;
      
      private static const STATE_LOADING:int = 4;
      
      private static const STATE_AFTER_SKI:int = 5;
      
      private static const const_896:int = 1;
       
      
      private var _window:IWindowContainer;
      
      private var var_1655:SnowWarEngine;
      
      private var var_318:Boolean = false;
      
      private var _teams:Array;
      
      private var _players:Dictionary;
      
      private var var_3193:BackgroundViewController;
      
      private var var_780:Game2GameResult;
      
      private var var_2683:Timer;
      
      private var var_1461:int = 0;
      
      private var var_149:int = 0;
      
      private var _lobbyPlayers:Map;
      
      private var var_2212:Map;
      
      private var var_4868:int = 1;
      
      public function GameEndingViewController(param1:SnowWarEngine, param2:Array, param3:Game2SnowWarGameStats, param4:Game2GameResult, param5:int)
      {
         super();
         _teams = param2;
         _players = new Dictionary();
         var_1655 = param1;
         var_780 = param4;
         var_2212 = new Map();
         param1.roomUI.visible = false;
         param1.windowManager.getDesktop(1).visible = false;
         var_3193 = new BackgroundViewController(var_1655);
         var_3193.background.visible = true;
         createMainView();
         for each(var _loc6_ in param2)
         {
            addTeamScores(_loc6_);
         }
         var _loc7_:ITextWindow = getElement(_window,"endingInformation") as ITextWindow;
         if(var_780.resultType == 2)
         {
            WindowUtils.colorStrokes(_loc7_.parent,getNeutralTeamColor());
            WindowUtils.setCaption(_loc7_,"${snowwar.result.tie}");
         }
         else
         {
            WindowUtils.colorStrokes(_loc7_.parent,getTeamColor(var_780.winnerId));
            WindowUtils.setCaption(_loc7_,"${snowwar.team_" + var_780.winnerId + "_wins}");
         }
         showMostHits(param3.playerWithMostHits);
         showMostKills(param3.playerWithMostKills);
         startResultsCountDown(param5);
         if(var_1655.hasUnlimitedGames)
         {
            WindowUtils.hideElement(_window,"statusContainer");
         }
         else
         {
            WindowUtils.showElement(_window,"statusContainer");
            var_1655.communication.connection.send(new Game2GetAccountGameStatusMessageComposer(0));
         }
         updateGamesLeft();
      }
      
      public function dispose() : void
      {
         var_1655.windowManager.getDesktop(1).visible = true;
         disposeCountDownTimer();
         if(var_2212)
         {
            for each(var _loc1_ in var_2212)
            {
               _loc1_.dispose();
            }
            var_2212.dispose();
            var_2212 = null;
         }
         if(var_3193)
         {
            var_3193.dispose();
            var_3193 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _teams = null;
         _players = null;
         var_780 = null;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function createMainView() : void
      {
         _window = WindowUtils.createWindow("snowwar_ending") as IWindowContainer;
         _window.x = (_window.desktop.width - _window.width) / 2;
         _window.y = _window.desktop.height > 685 ? 115 : 10;
         _window.findChildByName("leave_link_region").procedure = onCancel;
         _window.findChildByName("button_rematch").addEventListener("WME_CLICK",onJoinRematch);
         _window.findChildByName("button_play_again").addEventListener("WME_CLICK",onPlayAgain);
         _window.findChildByName("button_buy_games").addEventListener("WME_CLICK",onBuyMoreGames);
         _window.findChildByName("loadingContainer").visible = false;
         _window.findChildByName("statusContainer").addEventListener("WME_CLICK",onGetMore);
      }
      
      private function onJoinRematch(param1:WindowMouseEvent = null, param2:IWindow = null) : void
      {
         var _loc3_:IWindow = null;
         if(var_1655.freeGamesLeft == 0)
         {
            onGetMore(param1);
         }
         else
         {
            var_149 = 1;
            var_1655.sendRejoinGame();
            _loc3_ = _window.findChildByName("button_rematch");
            _loc3_.color = 13421772;
            _loc3_.disable();
            _window.findChildByName("statusContainer").visible = false;
         }
      }
      
      private function onPlayAgain(param1:WindowEvent = null, param2:IWindow = null) : void
      {
         var_1655.startQuickServerGame();
         _window.findChildByName("button_play_again").visible = false;
         _window.findChildByName("statusContainer").visible = false;
      }
      
      private function onBuyMoreGames(param1:WindowMouseEvent) : void
      {
         onGetMore(param1);
      }
      
      private function updateGettingMoreGamesOption() : void
      {
         var _loc2_:IWindow = _window.findChildByName("button_rematch");
         var _loc1_:IWindow = _window.findChildByName("button_buy_games");
         var _loc3_:IWindow = _window.findChildByName("status.text_get_vip");
         var _loc4_:IWindow = _window.findChildByName("status.text_get_more_games");
         _loc2_.visible = false;
         _loc1_.visible = false;
         _loc3_.visible = false;
         _loc4_.visible = false;
         switch(var_4868 - 1)
         {
            case 0:
               if(var_1655.freeGamesLeft == 0)
               {
                  _loc1_.visible = true;
               }
               else
               {
                  _loc2_.visible = true;
               }
               _loc4_.visible = true;
               break;
            default:
               _loc2_.visible = true;
               _loc3_.visible = true;
         }
      }
      
      private function onCancel(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         onClose(true);
      }
      
      public function onClose(param1:Boolean) : void
      {
         if(param1)
         {
            var_1655.gameCancelled(true);
            if(var_149 == 3 || var_149 == 2)
            {
               var_1655.communication.connection.send(new class_647());
               if(var_1655.roomBeforeGame > -1)
               {
                  var_1655.communication.connection.send(new class_553(var_1655.roomBeforeGame,false,true));
               }
            }
            else if(var_149 == 5)
            {
               if(var_1655.roomBeforeGame > -1)
               {
                  var_1655.communication.connection.send(new class_553(var_1655.roomBeforeGame,false,true));
               }
               else
               {
                  var_1655.communication.connection.send(new Game2ExitGameMessageComposer());
               }
            }
            else
            {
               var_1655.communication.connection.send(new Game2ExitGameMessageComposer());
            }
            disposeCountDownTimer();
         }
      }
      
      private function disposeCountDownTimer() : void
      {
         if(var_2683)
         {
            var_2683.removeEventListener("timer",onTick);
            var_2683.stop();
            var_2683 = null;
            var_1461 = 0;
         }
      }
      
      private function addTeamScores(param1:Game2TeamScoreData) : void
      {
         var _loc2_:int = param1.teamReference;
         for each(var _loc3_ in param1.players)
         {
            addPlayerScore(_loc3_);
         }
         WindowUtils.setCaption(getElement(_window,"team" + _loc2_ + "Score"),param1.score.toString());
      }
      
      private function addPlayerScore(param1:Game2TeamPlayerData) : void
      {
         _players[param1.userId] = param1;
         var _loc6_:IItemListWindow = _window.findChildByName("team" + param1.teamId + "PlayersList") as IItemListWindow;
         var _loc5_:IItemListWindow;
         var _loc7_:IWindowContainer = (_loc5_ = WindowUtils.createWindow("snowwar_results_player_team_" + param1.teamId) as IItemListWindow).getListItemByName("playerImageContainer") as IWindowContainer;
         var _loc4_:IWindowContainer = _loc5_.getListItemByName("playerDataContainer") as IWindowContainer;
         var _loc2_:IWindowContainer = _loc5_.getListItemByName("playerScoreContainer") as IWindowContainer;
         WindowUtils.setElementImage(getElement(_loc7_,"playerImage"),getAvatarFigure(param1.teamId,param1.figure,param1.gender),0,0,0);
         WindowUtils.setCaption(getElement(_loc4_,"playerName"),param1.userName);
         WindowUtils.hideElement(_loc4_,"playerTotalStats");
         WindowUtils.setCaption(getElement(_loc4_,"playerHits"),param1.playerStats.snowballHits.toString());
         WindowUtils.setCaption(getElement(_loc4_,"playerKills"),param1.playerStats.kills.toString());
         WindowUtils.setCaption(getElement(_loc2_,"playerScore"),param1.score.toString());
         var _loc3_:IWindowContainer = _loc7_.findChildByName("addFriend") as IWindowContainer;
         if(var_1655.friendList.canBeAskedForAFriend(param1.userId) && param1.userId != var_1655.sessionDataManager.userId)
         {
            _loc3_.id = param1.userId;
            _loc3_.getChildAt(0).id = param1.teamId;
            _loc3_.addEventListener("WME_CLICK",onAddFriendClick);
            _loc3_.addEventListener("WME_OVER",onAddFriendOver);
            _loc3_.addEventListener("WME_OUT",onAddFriendOut);
            _loc3_.visible = true;
         }
         _loc6_.addListItem(_loc5_);
         _loc5_.name = "player" + param1.userId;
      }
      
      private function onAddFriendClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:int = param1.window.id;
         var _loc3_:Game2TeamPlayerData = _players[_loc2_];
         if(_loc3_)
         {
            var_1655.friendList.askForAFriend(_loc2_,_loc3_.userName);
            var_1655.communication.connection.send(new class_955("GameFramework","SnowStorm","gameFramework.sendFriendRequest.rematchView"));
            var_1655.addChatMessage(_loc2_,"${snowwar.friend_request.sent}",true);
         }
         param1.window.visible = false;
      }
      
      private function onAddFriendOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = (param1.window as IWindowContainer).getChildAt(0);
         WindowUtils.setElementImage(_loc2_,getBitmap("add_friend_icon_green"));
      }
      
      private function onAddFriendOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:IWindow = (param1.window as IWindowContainer).getChildAt(0);
         var _loc3_:String = "add_friend_icon_" + (_loc2_.id == 1 ? "blue" : "red");
         WindowUtils.setElementImage(_loc2_,getBitmap(_loc3_));
      }
      
      private function showMostHits(param1:int) : void
      {
         var _loc3_:Game2TeamPlayerData = _players[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = _window.findChildByName("mostHitsContainer") as IWindowContainer;
         if(_loc3_.playerStats.snowballHits == 0)
         {
            _loc2_.visible = false;
            return;
         }
         WindowUtils.setElementImage(getElement(_loc2_,"backgroundImage"),getBitmap(getPlayerImageBackground(_loc3_.teamId)));
         WindowUtils.setElementImage(getElement(_loc2_,"playerImage"),getAvatarFigure(_loc3_.teamId,_loc3_.figure,_loc3_.gender),0,0,0);
         WindowUtils.setCaption(getElement(_loc2_,"playerName"),_loc3_.userName);
         WindowUtils.colorStrokes(_loc2_,getTeamColor(_loc3_.teamId));
      }
      
      private function showMostKills(param1:int) : void
      {
         var _loc3_:Game2TeamPlayerData = _players[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IWindowContainer = _window.findChildByName("mostKillsContainer") as IWindowContainer;
         if(_loc3_.playerStats.kills == 0)
         {
            _loc2_.visible = false;
            return;
         }
         WindowUtils.setElementImage(getElement(_loc2_,"backgroundImage"),getBitmap(getPlayerImageBackground(_loc3_.teamId)));
         WindowUtils.setElementImage(getElement(_loc2_,"playerImage"),getAvatarFigure(_loc3_.teamId,_loc3_.figure,_loc3_.gender),0,0,0);
         WindowUtils.setCaption(getElement(_loc2_,"playerName"),_loc3_.userName);
         WindowUtils.colorStrokes(_loc2_,getTeamColor(_loc3_.teamId));
      }
      
      private function getPlayerImageBackground(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = "blue_square";
               break;
            case 1:
               _loc2_ = "red_square";
               break;
            default:
               _loc2_ = "blue_square";
         }
         return _loc2_;
      }
      
      private function getNeutralTeamColor() : uint
      {
         return 8227482;
      }
      
      private function getTeamColor(param1:int) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return 4279269292;
            case 1:
               return 4294797401;
            default:
               return 4279269292;
         }
      }
      
      private function getTeamPlayerDirection(param1:int) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return 2;
            case 1:
               return 4;
            default:
               return 2;
         }
      }
      
      private function getAvatarFigure(param1:int, param2:String, param3:String) : BitmapData
      {
         var _loc4_:class_3405 = var_1655.avatarManager.createFigureContainer(param2);
         switch(param1 - 1)
         {
            case 0:
               _loc4_.updatePart("ch",20000,[1]);
               break;
            case 1:
               _loc4_.updatePart("ch",20001,[1]);
               break;
            default:
               _loc4_.updatePart("ch",20000,[1]);
         }
         _loc4_.removePart("cc");
         var _loc5_:class_3374;
         if(_loc5_ = var_1655.avatarManager.createAvatarImage(_loc4_.getFigureString(),"h_50",param3,this))
         {
            _loc5_.setDirection("full",getTeamPlayerDirection(param1));
            return _loc5_.getCroppedImage("full");
         }
         return null;
      }
      
      private function getElement(param1:IWindowContainer, param2:String) : IWindow
      {
         return param1 != null ? param1.findChildByName(param2) : null;
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
      
      public function avatarImageReady(param1:String) : void
      {
      }
      
      public function playerRematches(param1:int) : void
      {
         var _loc5_:SnowWarAnimatedWindowElement = null;
         var _loc3_:IItemListWindow = _window.findChildByName("player" + param1) as IItemListWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc6_:Game2TeamPlayerData;
         if((_loc6_ = _players[param1]) == null)
         {
            return;
         }
         _loc6_.willRejoin = true;
         var _loc2_:IWindowContainer = _loc3_.getListItemByName("playerScoreContainer") as IWindowContainer;
         var _loc4_:IBitmapWrapperWindow = getElement(_loc2_,"playerScoreGlow") as IBitmapWrapperWindow;
         if(!var_2212.hasKey(_loc4_))
         {
            _loc5_ = new SnowWarAnimatedWindowElement(var_1655.assets,_loc4_,"rematch_",6,100,true);
            var_2212.add(_loc4_,_loc5_);
         }
      }
      
      public function changeToWaitState(param1:Boolean) : void
      {
         var _loc6_:IItemListWindow = null;
         var _loc3_:IItemListWindow = null;
         var _loc4_:IWindowContainer = null;
         var _loc2_:IWindowContainer = null;
         if(!param1)
         {
            return changeToAfterSkiState();
         }
         var_149 = 2;
         stopResultsCountDown();
         var _loc5_:Array = [];
         for each(var _loc8_ in _players)
         {
            _loc6_ = _window.findChildByName("team" + _loc8_.teamId + "PlayersList") as IItemListWindow;
            _loc3_ = _window.findChildByName("player" + _loc8_.userId) as IItemListWindow;
            if(_loc3_ == null)
            {
               return;
            }
            if(!_loc8_.willRejoin)
            {
               _loc6_.removeListItem(_loc3_);
               _loc5_.push(_loc8_.userId);
            }
            else
            {
               _loc4_ = _loc3_.getListItemByName("playerDataContainer") as IWindowContainer;
               _loc2_ = _loc3_.getListItemByName("playerScoreContainer") as IWindowContainer;
               _loc4_.findChildByName("playerStats").visible = false;
               WindowUtils.setCaption(getElement(_loc4_,"playerName"),_loc8_.userName);
               WindowUtils.hideElement(_loc2_,"playerScore");
            }
         }
         for each(var _loc7_ in _loc5_)
         {
            delete _players[_loc7_];
         }
         WindowUtils.hideElement(_window,"buttonsContainer");
         WindowUtils.hideElement(_window,"mostKillsContainer");
         WindowUtils.hideElement(_window,"mostHitsContainer");
         WindowUtils.hideElement(_window,"team1Score");
         WindowUtils.hideElement(_window,"team2Score");
         WindowUtils.setCaption(getElement(_window,"endingInformation"),"${snowwar.lobby_waiting_for_more_players}");
      }
      
      private function changeToAfterSkiState() : void
      {
         var_149 = 5;
         if(var_2212)
         {
            for each(var _loc2_ in var_2212)
            {
               _loc2_.dispose();
            }
            var_2212.reset();
         }
         hideChatInput();
         if(var_1655.freeGamesLeft == 0)
         {
            return;
         }
         _window.findChildByName("button_rematch").visible = false;
         _window.findChildByName("button_play_again").visible = true;
         var _loc1_:IWindow = _window.findChildByName("button_play_again");
         _loc1_.enable();
         _loc1_.color = 5622784;
      }
      
      private function updateDialog() : void
      {
         if(var_318)
         {
            return;
         }
         var _loc1_:ITextWindow = _window.findChildByName("endingInformation") as ITextWindow;
         var _loc2_:ITextWindow = _window.findChildByName("endingInformation_stroke") as ITextWindow;
         _loc1_.fontSize = 28;
         _loc2_.fontSize = 28;
         if(var_1655.freeGamesLeft == 0)
         {
            WindowUtils.setCaption(getElement(_window,"button_rematch"),"${catalog.vip.buy.title}");
         }
         else if(var_149 == 0)
         {
            var_1655.localization.registerParameter("snowwar.rematch","seconds",var_1461.toString());
            WindowUtils.setCaption(getElement(_window,"button_rematch"),"${snowwar.rematch}");
         }
         else if(var_149 == 1)
         {
            var_1655.localization.registerParameter("snowwar.please_wait","seconds",var_1461.toString());
            WindowUtils.setCaption(getElement(_window,"button_rematch"),"${snowwar.please_wait}");
         }
         else if(var_149 == 3)
         {
            var_1655.localization.registerParameter("snowwar.lobby_game_start_countdown","seconds",var_1461.toString());
            WindowUtils.setCaption(getElement(_window,"endingInformation"),"${snowwar.lobby_game_start_countdown}");
            _loc1_.fontSize = 22;
            _loc2_.fontSize = 22;
         }
         else if(var_149 == 2)
         {
            WindowUtils.setCaption(getElement(_window,"endingInformation"),"${snowwar.lobby_waiting_for_more_players}");
            _loc1_.fontSize = 22;
            _loc2_.fontSize = 22;
         }
      }
      
      private function startCountDownTimer(param1:int) : void
      {
         disposeCountDownTimer();
         var_2683 = new Timer(1000,param1);
         var_2683.addEventListener("timer",onTick);
         var_2683.start();
         var_1461 = param1;
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(var_1461 && var_1461 > 0)
         {
            var_1461--;
            HabboGamesCom.log("On results window tick " + var_1461);
            updateDialog();
         }
      }
      
      private function startResultsCountDown(param1:int) : void
      {
         startCountDownTimer(param1);
         updateDialog();
      }
      
      private function stopResultsCountDown() : void
      {
         disposeCountDownTimer();
         updateDialog();
      }
      
      public function startLobbyCountDown(param1:int) : void
      {
         var_149 = 3;
         startCountDownTimer(param1);
         updateDialog();
      }
      
      public function stopLobbyCountDown() : void
      {
         disposeCountDownTimer();
         updateDialog();
      }
      
      public function changeToLobbyState(param1:GameLobbyData) : void
      {
         var _loc4_:IItemListWindow = null;
         var _loc2_:IItemListWindow = null;
         var_149 = 3;
         _lobbyPlayers = new Map();
         var _loc3_:Array = [];
         for each(var _loc6_ in _players)
         {
            _loc4_ = _window.findChildByName("team" + _loc6_.teamId + "PlayersList") as IItemListWindow;
            _loc2_ = _window.findChildByName("player" + _loc6_.userId) as IItemListWindow;
            if(_loc2_ == null)
            {
               return;
            }
            _loc4_.removeListItem(_loc2_);
            _loc3_.push(_loc6_.userId);
         }
         for each(var _loc5_ in _loc3_)
         {
            delete _players[_loc5_];
         }
         _window.findChildByName("loadingContainer").visible = true;
         WindowUtils.hideElement(_window.findChildByName("loadingContainer") as IWindowContainer,"loadingText");
         WindowUtils.setCaption(_window.findChildByName("arenaName"),var_1655.getArenaName(param1));
         WindowUtils.colorStrokes(getElement(_window,"headerContainer"),getTeamColor(1));
         WindowUtils.setElementImage(_window.findChildByName("arenaPreview"),getBitmap("arena_" + param1.fieldType + "_preview"));
      }
      
      public function playerJoined(param1:GameLobbyPlayerData) : void
      {
         if(param1)
         {
            _lobbyPlayers.add(param1.userId,param1);
            renderLobbyPlayers();
         }
      }
      
      public function playerLeft(param1:int) : void
      {
         var _loc2_:GameLobbyPlayerData = _lobbyPlayers[param1];
         if(_loc2_ != null)
         {
            _lobbyPlayers.remove(param1);
         }
         renderLobbyPlayers();
      }
      
      private function renderLobbyPlayers() : void
      {
         clearPlayers();
         var _loc1_:Array = _lobbyPlayers.getValues();
         if(var_149 != 0 && var_149 != 1)
         {
            _loc1_.sort(GameLobbyPlayerData.var_1538);
         }
         for each(var _loc2_ in _loc1_)
         {
            addLobbyPlayer(_loc2_);
         }
      }
      
      private function clearPlayers() : void
      {
         var _loc2_:IItemListWindow = null;
         var _loc1_:int = 1;
         while((_loc2_ = _window.findChildByName("team" + _loc1_++ + "PlayersList") as IItemListWindow) != null)
         {
            _loc2_.destroyListItems();
         }
      }
      
      private function addLobbyPlayer(param1:GameLobbyPlayerData) : void
      {
         HabboGamesCom.log("Add Lobby Player: " + [param1.name,param1.userId,param1.teamId]);
         var _loc4_:int = _lobbyPlayers.getKeys().indexOf(param1.userId) % 2 + 1;
         var _loc7_:IItemListWindow;
         if((_loc7_ = _window.findChildByName("team" + _loc4_ + "PlayersList") as IItemListWindow) == null)
         {
            return;
         }
         var _loc6_:IItemListWindow;
         if((_loc6_ = WindowUtils.createWindow("snowwar_lobby_player_team_" + _loc4_) as IItemListWindow) == null)
         {
            return;
         }
         var _loc8_:IWindowContainer = _loc6_.getListItemByName("playerImageContainer") as IWindowContainer;
         var _loc5_:IWindowContainer = _loc6_.getListItemByName("playerDataContainer") as IWindowContainer;
         var _loc2_:IWindowContainer = _loc6_.getListItemByName("playerScoreContainer") as IWindowContainer;
         WindowUtils.setElementImage(getElement(_loc8_,"playerImage"),getAvatarFigure(_loc4_,param1.figure,param1.gender));
         WindowUtils.setCaption(getElement(_loc5_,"playerName"),param1.name);
         WindowUtils.hideElement(_loc5_,"playerStats");
         WindowUtils.hideElement(_loc2_,"playerScore");
         WindowUtils.hideElement(_loc5_,"playerTotalStats");
         var _loc9_:IBitmapWrapperWindow;
         if((_loc9_ = _loc5_.findChildByName("skillLevel") as IBitmapWrapperWindow).bitmap)
         {
            _loc9_.bitmap.dispose();
         }
         _loc9_.bitmap = getSkillLevelImage(param1.skillLevel,_loc4_);
         var _loc3_:IRegionWindow = _loc5_.findChildByName("scoreTooltip") as IRegionWindow;
         _loc3_.toolTipCaption = param1.totalScore.toString() + "/" + param1.scoreToNextLevel.toString();
         _loc3_.visible = true;
         _loc7_.addListItem(_loc6_);
      }
      
      private function getSkillLevelImage(param1:int, param2:int) : BitmapData
      {
         var _loc6_:BitmapData = null;
         var _loc8_:int = 0;
         var _loc7_:Point = null;
         param1 = Math.min(param1,30);
         var _loc3_:BitmapData = var_1655.assets.getAssetByName("star_empty").content as BitmapData;
         var _loc11_:BitmapData = var_1655.assets.getAssetByName("star_filled_bronze").content as BitmapData;
         var _loc9_:BitmapData = var_1655.assets.getAssetByName("star_filled_silver").content as BitmapData;
         var _loc10_:BitmapData = var_1655.assets.getAssetByName("star_filled_gold").content as BitmapData;
         var _loc5_:int = param1 > 0 ? (param1 - 1) % 10 + 1 : 0;
         var _loc4_:BitmapData = new BitmapData(150,13,true,0);
         _loc8_ = 0;
         while(_loc8_ < 10)
         {
            _loc7_ = param2 == 1 ? new Point(_loc8_ * 15,0) : new Point((9 - _loc8_) * 15,0);
            _loc6_ = param1 > 20 ? (_loc5_-- > 0 ? _loc10_ : _loc3_) : (param1 > 10 ? (_loc5_-- > 0 ? _loc9_ : _loc3_) : (_loc5_-- > 0 ? _loc11_ : _loc3_));
            _loc4_.copyPixels(_loc6_,_loc6_.rect,_loc7_);
            _loc8_++;
         }
         return _loc4_;
      }
      
      public function updateGamesLeft() : void
      {
         var _loc4_:ITextWindow = null;
         var _loc1_:IWindow = null;
         var _loc3_:IWindowContainer = _window.findChildByName("buttonsContainer") as IWindowContainer;
         var _loc2_:IWindowContainer = _window.findChildByName("statusContainer") as IWindowContainer;
         if(_loc2_ && _loc3_)
         {
            _loc3_.visible = true;
            WindowUtils.setCaption(_loc2_.findChildByName("games_left"),var_1655.freeGamesLeft.toString());
            _loc4_ = _loc2_.findChildByName("games_left_stroke") as ITextWindow;
            _loc1_ = _window.findChildByName("button_rematch");
            updateGettingMoreGamesOption();
            if(var_1655.hasUnlimitedGames)
            {
               _loc1_.enable();
               _loc1_.color = 5622784;
               _loc2_.visible = false;
               return;
            }
            switch(var_1655.freeGamesLeft - -1)
            {
               case 0:
                  _loc1_.enable();
                  _loc1_.color = 5622784;
                  _loc2_.visible = false;
                  break;
               case 1:
                  _loc4_.textColor = 16711680;
                  _loc1_.enable();
                  _loc1_.color = 5622784;
                  break;
               default:
                  _loc4_.textColor = 1079212;
                  _loc1_.enable();
                  _loc1_.color = 5622784;
            }
         }
      }
      
      private function onGetMore(param1:WindowMouseEvent) : void
      {
         switch(var_4868 - 1)
         {
            case 0:
               var_1655.openGetMoreGames("gameFramework.buyTokens.clicked.rematchView");
               break;
            default:
               onClose(true);
               var_1655.openClubCenter("gameFramework.getVip.clicked.rematchView");
         }
      }
      
      private function hideChatInput() : void
      {
         var_1655.roomUI.hideWidget("RWE_CHAT_INPUT_WIDGET");
      }
   }
}
