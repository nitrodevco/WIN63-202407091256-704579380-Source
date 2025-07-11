package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.SnowWarAnimatedWindowElement;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.class_647;
   
   public class GameLobbyWindowCtrl implements IDisposable, IAvatarImageListener
   {
       
      
      private var var_1747:GamesMainViewController;
      
      private var var_1655:SnowWarEngine;
      
      private var _levelName:String;
      
      private var _numberOfTeams:int;
      
      private var _numberOfPlayers:int;
      
      private var _maxNumberOfPlayers:int;
      
      private var var_1907:IWindowContainer;
      
      private var var_2683:Timer;
      
      private var var_1461:int = -1;
      
      private var var_2629:int = -1;
      
      private var var_318:Boolean = false;
      
      private var var_2401:Map;
      
      private var var_2217:Map;
      
      public function GameLobbyWindowCtrl(param1:GamesMainViewController, param2:String, param3:int, param4:int)
      {
         super();
         var_1747 = param1;
         var_1655 = param1.gameEngine;
         var_2401 = new Map();
         var_2217 = new Map();
         _levelName = param2;
         _numberOfTeams = param3;
         _numberOfPlayers = numberOfPlayers;
         _maxNumberOfPlayers = param4;
      }
      
      private function createLobbyView() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var_1907 = var_1747.rootWindow.findChildByName("snowwar_lobby_cont") as IWindowContainer;
         var_1907.center();
         var_1907.findChildByName("cancel_link_region").procedure = onCancel;
         var _loc2_:IItemGridWindow = var_1907.findChildByName("players_grid") as IItemGridWindow;
         var _loc4_:IWindowContainer = WindowUtils.createWindow("snowwar_lobby_player") as IWindowContainer;
         _loc3_ = 0;
         while(_loc3_ < _maxNumberOfPlayers)
         {
            _loc2_.addGridItem(_loc4_.clone());
            _loc3_++;
         }
         _loc4_.dispose();
         var_1907.visible = false;
      }
      
      private function createWindow(param1:String) : IWindowContainer
      {
         var _loc2_:XmlAsset = var_1655.assets.getAssetByName(param1) as XmlAsset;
         return var_1655.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer;
      }
      
      private function onCancel(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         onClose(true);
         if(!var_1655.gameCenterEnabled)
         {
            var_1747.openMainWindow(true);
         }
         else
         {
            var_1747.close(true);
         }
      }
      
      public function onClose(param1:Boolean) : void
      {
         if(param1)
         {
            var_1655.communication.connection.send(new class_647());
         }
         disposeCountdownTimer();
         var_2629 = -1;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(!var_1907)
         {
            createLobbyView();
         }
         var_1907.visible = param1;
      }
      
      public function get visible() : Boolean
      {
         if(var_1907)
         {
            return var_1907.visible;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var_318 = true;
         if(var_2217)
         {
            for each(var _loc1_ in var_2217)
            {
               _loc1_.dispose();
            }
            var_2217.dispose();
            var_2217 = null;
         }
         if(var_1907 != null)
         {
            var_1907.dispose();
            var_1907 = null;
         }
         disposeCountdownTimer();
         if(var_2401)
         {
            var_2401.dispose();
            var_2401 = null;
         }
         var_2629 = -1;
      }
      
      private function disposeCountdownTimer() : void
      {
         if(var_2683 != null)
         {
            var_2683.removeEventListener("timer",onTick);
            var_2683.stop();
            var_2683 = null;
         }
         var_1461 = -1;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function playerLeft(param1:int) : void
      {
         var_2401.remove(param1);
         updateDialog(true);
      }
      
      public function playerJoined(param1:GameLobbyPlayerData) : void
      {
         if(param1)
         {
            var_2401.add(param1.userId,param1);
            updateDialog(true,param1.figure);
         }
      }
      
      public function clearPlayerList() : void
      {
         var_2401.reset();
      }
      
      public function startCountdown(param1:int) : void
      {
         disposeCountdownTimer();
         var_1461 = param1;
         var_2683 = new Timer(1000,param1);
         var_2683.addEventListener("timer",onTick);
         var_2683.start();
         updateDialog(false);
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(var_318)
         {
            return;
         }
         if(var_1461 && var_1461 > 0)
         {
            var_1461--;
            HabboGamesCom.log("on tick " + var_1461);
            updateDialog(false);
         }
      }
      
      public function stopCountdown() : void
      {
         disposeCountdownTimer();
         updateDialog(false);
      }
      
      public function set queuePosition(param1:int) : void
      {
         var_2629 = param1;
      }
      
      private function updateDialog(param1:Boolean, param2:String = null) : void
      {
         var _loc16_:String = null;
         var _loc13_:* = null;
         var _loc9_:IRegionWindow = null;
         var _loc8_:IBitmapWrapperWindow = null;
         var _loc15_:SnowWarAnimatedWindowElement = null;
         var _loc10_:class_3374 = null;
         var _loc4_:BitmapData = null;
         var _loc6_:Point = null;
         var _loc14_:IWindow = var_1907.findChildByName("wait_text") as ITextWindow;
         var _loc5_:IWindow = var_1907.findChildByName("wait_text_stroke") as ITextWindow;
         var _loc3_:IHabboLocalizationManager = var_1655.localization;
         if(var_1461 >= 0)
         {
            _loc16_ = "snowwar.lobby_game_start_countdown";
            _loc3_.registerParameter(_loc16_,"seconds",String(var_1461));
            _loc13_ = _loc16_ + " " + "%seconds%" + " " + var_1461;
         }
         else if(var_2629 >= 0)
         {
            _loc16_ = "snowwar.lobby_arena_queue_position";
            _loc3_.registerParameter(_loc16_,"position",String(var_2629));
            _loc13_ = _loc16_ + " " + "%position%" + " " + var_2629;
         }
         else
         {
            _loc13_ = _loc16_ = "snowwar.lobby_waiting_for_more_players";
         }
         var _loc11_:String;
         if(_loc11_ = String(_loc3_.getLocalization(_loc16_)))
         {
            _loc14_.caption = _loc11_;
            _loc5_.caption = _loc11_;
         }
         else
         {
            _loc14_.caption = _loc13_;
            _loc5_.caption = _loc13_;
         }
         var _loc7_:int = 0;
         var _loc12_:IItemGridWindow = var_1907.findChildByName("players_grid") as IItemGridWindow;
         if(param1)
         {
            for each(var _loc17_ in var_2401.getValues())
            {
               _loc10_ = null;
               if(_loc17_.figure == param2 || !param2)
               {
                  _loc10_ = var_1655.avatarManager.createAvatarImage(_loc17_.figure,"h",_loc17_.gender,this);
               }
               if(_loc10_)
               {
                  _loc10_.setDirection("head",2);
                  _loc4_ = _loc10_.getCroppedImage("head");
                  if(_loc9_ = _loc12_.getGridItemAt(_loc7_) as IRegionWindow)
                  {
                     _loc9_.toolTipCaption = _loc17_.name;
                     _loc9_.mouseThreshold = 0;
                     _loc8_ = _loc9_.findChildByName("image") as IBitmapWrapperWindow;
                     if(_loc15_ = var_2217.remove(_loc8_))
                     {
                        _loc15_.dispose();
                     }
                     if(_loc8_.bitmap)
                     {
                        _loc8_.bitmap.dispose();
                     }
                     _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                     _loc6_ = new Point((_loc8_.width - _loc4_.width) / 2,(_loc8_.height - _loc4_.height) / 2);
                     _loc8_.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc6_);
                  }
                  _loc4_.dispose();
                  _loc10_.dispose();
               }
               _loc7_++;
            }
            while(_loc7_ < maxNumberOfPlayers)
            {
               _loc8_ = (_loc9_ = _loc12_.getGridItemAt(_loc7_) as IRegionWindow).findChildByName("image") as IBitmapWrapperWindow;
               if(!var_2217.hasKey(_loc8_))
               {
                  _loc15_ = new SnowWarAnimatedWindowElement(var_1655.assets,_loc8_,"load_",8);
                  var_2217.add(_loc8_,_loc15_);
               }
               _loc7_++;
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateDialog(true,param1);
      }
      
      public function get levelName() : String
      {
         return _levelName;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get numberOfPlayers() : int
      {
         return _numberOfPlayers;
      }
      
      public function get maxNumberOfPlayers() : int
      {
         return _maxNumberOfPlayers;
      }
      
      public function set levelName(param1:String) : void
      {
         _levelName = param1;
      }
      
      public function set maxNumberOfPlayers(param1:int) : void
      {
         _maxNumberOfPlayers = param1;
      }
      
      public function set numberOfTeams(param1:int) : void
      {
         _numberOfTeams = param1;
      }
      
      public function set numberOfPlayers(param1:int) : void
      {
         _numberOfPlayers = param1;
      }
      
      public function set counter(param1:int) : void
      {
         var_1461 = param1;
      }
   }
}
