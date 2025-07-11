package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.avatar.class_3405;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FuseObjectData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   import com.sulake.habbo.game.snowwar.KeyboardControl;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
   import com.sulake.habbo.game.snowwar.class_3566;
   import com.sulake.habbo.game.snowwar.class_3616;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowWarGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballPileGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.TreeGameObject;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IRoomCreator;
   import com.sulake.habbo.room.IRoomEngineServices;
   import com.sulake.habbo.room.RoomEngine;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class GameArenaView implements IDisposable
   {
      
      private static const GAME_ROOM_ID:int = 1;
      
      private static const TILE_CURSOR_STATE_TEAM_1:int = 3;
      
      private static const TILE_CURSOR_STATE_TEAM_2:int = 2;
      
      private static const TILE_CURSOR_STATE_TEAM_3:int = 4;
      
      private static const TILE_CURSOR_STATE_TEAM_4:int = 5;
      
      private static const EFFECT_RED_TEAM:int = 95;
      
      private static const EFFECT_BLUE_TEAM:int = 96;
      
      private static const EFFECT_CROSSHAIR:int = 98;
      
      private static const SPLASH_LIFE_SPAN_TIME:int = 500;
       
      
      private var var_1655:SnowWarEngine;
      
      private var var_2850:Array;
      
      private var var_2864:Array;
      
      private var var_3311:Array;
      
      private var var_3335:KeyboardControl;
      
      private var var_318:Boolean = false;
      
      private var var_1735:SnowWarUI;
      
      private var var_3387:Boolean;
      
      private var var_1859:Stage;
      
      private var var_4904:Boolean;
      
      public function GameArenaView(param1:SnowWarEngine)
      {
         var_2850 = [];
         var_2864 = [];
         var_3311 = [];
         super();
         var_1655 = param1;
         var_1655.roomEngine.addObjectUpdateCategory(202);
      }
      
      public function dispose() : void
      {
         var_1655.roomEngine.disposeRoom(1);
         var_1655.roomEngine.removeObjectUpdateCategory(202);
         if(var_3335)
         {
            var_3335.dispose();
            var_3335 = null;
         }
         if(var_1859 != null)
         {
            var_1859.removeEventListener("mouseMove",onMouseMove);
            var_1859 = null;
         }
         var_1655 = null;
         var_2850 = null;
         var_2864 = null;
         if(var_1735)
         {
            var_1735.dispose();
            var_1735 = null;
         }
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function init() : void
      {
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:Number = NaN;
         var _loc1_:Vector3d = null;
         var _loc5_:Vector3d = null;
         var _loc13_:int = 0;
         var _loc9_:IStuffData = null;
         var _loc14_:int = 0;
         var _loc6_:Number = NaN;
         var_1655.roomEngine.isGameMode = true;
         var _loc7_:class_3566;
         var _loc2_:GameLevelData = (_loc7_ = var_1655.gameArena.getCurrentStage() as class_3566).gameLevelData;
         var _loc8_:Array = _loc7_.getTiles();
         var _loc3_:RoomPlaneParser = new RoomPlaneParser();
         _loc3_.initializeTileMap(_loc2_.width,_loc2_.height);
         _loc11_ = 0;
         while(_loc11_ < _loc2_.height)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc2_.width)
            {
               _loc3_.setTileHeight(_loc10_,_loc11_,_loc8_[_loc11_][_loc10_] == null ? -100 : 0);
               _loc10_++;
            }
            _loc11_++;
         }
         _loc3_.initializeFromTileData();
         var_1655.roomEngine.initializeRoom(1,_loc3_.getXML());
         (var_1655.roomEngine as IRoomCreator).updateObjectRoomVisibilities(1,false);
         _loc3_.dispose();
         for each(var _loc4_ in _loc7_.gameLevelData.fuseObjects)
         {
            _loc12_ = _loc4_.altitude / Tile.TILE_HALFWIDTH;
            _loc1_ = new Vector3d(_loc4_.x,_loc4_.y,_loc12_);
            _loc5_ = new Vector3d(_loc4_.direction * 45);
            _loc13_ = var_1655.roomEngine.getFurnitureTypeId(_loc4_.name);
            _loc9_ = _loc4_.stuffData;
            _loc14_ = 0;
            _loc6_ = parseInt(_loc9_.getLegacyString());
            if(!isNaN(_loc6_))
            {
               _loc14_ = _loc6_;
            }
            var_1655.roomEngine.addObjectFurniture(1,_loc4_.id,_loc13_,_loc1_,_loc5_,_loc14_,_loc9_);
         }
         var_1655.roomUI.visible = false;
         var_1859 = var_1655.context.displayObjectContainer.stage;
         var_1859.addEventListener("mouseMove",onMouseMove);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var_4904 = param1.altKey || param1.shiftKey;
      }
      
      public function initGameUI(param1:int) : void
      {
         var_1735 = new SnowWarUI(var_1655);
         var_1735.init();
         initCountDown();
      }
      
      public function removeGameUI() : void
      {
         if(var_1735)
         {
            var_1735.dispose();
            var_1735 = null;
         }
      }
      
      public function update(param1:uint, param2:Boolean = false) : void
      {
         var _loc11_:Direction8 = null;
         var _loc25_:HumanGameObject = null;
         var _loc16_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc9_:int = 0;
         var _loc18_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:IRoomObject = null;
         var _loc22_:IVector3d = null;
         var _loc21_:int = 0;
         var _loc26_:* = undefined;
         var _loc7_:HumanGameObject = null;
         var _loc4_:* = false;
         var _loc19_:int = 0;
         var _loc24_:SnowBallGameObject = null;
         var _loc6_:SnowballMachineGameObject = null;
         var _loc8_:SnowballPileGameObject = null;
         var _loc20_:TreeGameObject = null;
         if(param2 && var_3335)
         {
            if(_loc11_ = var_3335.direction)
            {
               _loc16_ = (_loc25_ = var_1655.gameArena.getCurrentStage().getGameObject(var_1655.ownId) as HumanGameObject).currentLocation.x / 3200;
               _loc13_ = _loc25_.currentLocation.y / 3200;
               _loc16_ += _loc11_.getUnitVectorXcomponent() * 2;
               _loc13_ += _loc11_.getUnitVectorYcomponent() * 2;
               var_1655.moveOwnAvatarTo(_loc16_,_loc13_);
            }
         }
         var _loc23_:int = getTimer();
         for each(var _loc12_ in var_1655.gameArena.getCurrentStage().resetRemovedGameObjects())
         {
            _loc9_ = int(_loc12_.gameObjectId);
            if((_loc18_ = var_2850.indexOf(_loc9_)) > -1)
            {
               var_1655.roomEngine.disposeObjectUser(1,_loc9_);
               var_2850.splice(_loc18_,1);
            }
            if((_loc5_ = var_2864.indexOf(_loc9_)) > -1)
            {
               _loc22_ = (_loc17_ = var_1655.roomEngine.getRoomObject(1,_loc9_,201)).getLocation();
               var_1655.roomEngine.disposeObjectSnowWar(1,_loc9_,201);
               var_2864.splice(_loc5_,1);
               if(!ISynchronizedGameObject(_loc12_).isActive)
               {
                  var_1655.roomEngine.addObjectSnowWar(1,_loc9_,_loc22_,202);
                  var_3311.push({
                     "id":_loc9_,
                     "time":_loc23_,
                     "category":202
                  });
               }
            }
         }
         _loc21_ = var_3311.length - 1;
         while(_loc21_ > -1)
         {
            _loc26_ = var_3311[_loc21_];
            if(_loc23_ - _loc26_.time >= 500)
            {
               var_1655.roomEngine.disposeObjectSnowWar(1,_loc26_.id,_loc26_.category);
               var_3311.splice(_loc21_,1);
            }
            _loc21_--;
         }
         var _loc10_:Array = var_1655.gameArena.getCurrentStage().getGameObjects();
         var _loc15_:Boolean = false;
         for each(var _loc3_ in _loc10_)
         {
            if(_loc7_ = _loc3_ as HumanGameObject)
            {
               _loc4_ = _loc7_.posture == "swrun";
               _loc15_ ||= _loc4_;
               updateHumanGameObject(_loc7_);
               if(_loc7_.gameObjectId == var_1655.ownId)
               {
                  _loc19_ = (var_1655.gameArena.getExtension() as class_3616).getPulseInterval();
                  var_1735.timer = var_1655.stageLength - var_1655.currentSubTurn * _loc19_ / 1000;
                  var_1735.ownScore = _loc7_.score;
                  var_1735.snowballs = _loc7_.snowballs;
                  var_1735.hitPoints = _loc7_.hitPoints;
               }
            }
            if(_loc24_ = _loc3_ as SnowBallGameObject)
            {
               updateSnowballGameObject(_loc24_);
            }
            if(_loc6_ = _loc3_ as SnowballMachineGameObject)
            {
               updateSnowballMachineGameObject(_loc6_);
            }
            if(_loc8_ = _loc3_ as SnowballPileGameObject)
            {
               updateSnowballPileGameObject(_loc8_);
            }
            if(_loc20_ = _loc3_ as TreeGameObject)
            {
               updateTreeGameObject(_loc20_);
            }
         }
         if(var_1735)
         {
            var_1735.update(param1);
         }
         if(_loc15_ && !var_3387)
         {
            var_3387 = true;
            SnowWarEngine.playSound("HBSTG_snowwar_walk",2147483647);
         }
         else if(!_loc15_ && var_3387)
         {
            var_3387 = false;
            SnowWarEngine.stopSound("HBSTG_snowwar_walk");
         }
         var _loc14_:HumanGameObject = var_1655.getCurrentPlayer();
         var_1655.roomEngine.updateObjectUserEffect(1,_loc14_.gameObjectId,_loc14_.team == 1 ? 96 : 95);
      }
      
      private function updateHumanGameObject(param1:HumanGameObject) : void
      {
         var _loc3_:class_3405 = null;
         var _loc9_:Boolean = false;
         var _loc12_:IRoomObjectSpriteVisualization = null;
         var _loc6_:* = false;
         var _loc7_:Number = param1.currentLocation.x / 3200;
         var _loc4_:Number = param1.currentLocation.y / 3200;
         var _loc5_:int = param1.gameObjectId;
         var _loc10_:int = param1.getBodyDirection();
         var _loc8_:int = Direction360.direction8ToDirection360Value(Direction8.getDirection8(_loc10_));
         var _loc2_:IVector3d = new Vector3d(_loc8_,0,0);
         if(var_2850.indexOf(_loc5_) == -1)
         {
            _loc3_ = var_1655.avatarManager.createFigureContainer(param1.figure);
            switch(param1.team - 1)
            {
               case 0:
                  _loc3_.updatePart("ch",20000,[1]);
                  break;
               case 1:
                  _loc3_.updatePart("ch",20001,[1]);
                  break;
               default:
                  _loc3_.updatePart("ch",20000,[1]);
            }
            _loc3_.removePart("cc");
            var_1655.roomEngine.addObjectUser(1,_loc5_,new Vector3d(_loc7_,_loc4_,0),_loc2_,_loc8_,1,_loc3_.getFigureString());
            var_1655.roomEngine.updateObjectUserPosture(1,_loc5_,"std");
            var_1655.roomEngine.updateObjectUserAction(1,_loc5_,"figure_is_playing_game",1);
            var_2850.push(_loc5_);
            switch(param1.visualizationMode - 1)
            {
               case 0:
                  visualizeAsGhost(getRoomUserObject(_loc5_));
                  break;
               case 1:
                  hideVisualization(getRoomUserObject(_loc5_));
            }
         }
         else
         {
            var_1655.roomEngine.updateObjectUser(1,_loc5_,new Vector3d(_loc7_,_loc4_,0),new Vector3d(_loc7_,_loc4_,0),false,0,_loc2_,_loc8_);
            var_1655.roomEngine.updateObjectUserPosture(1,_loc5_,param1.posture);
            _loc9_ = param1.posture != "swdieback" && param1.posture != "swdiefront";
            var_1655.roomEngine.updateObjectUserAction(1,_loc5_,"figure_is_playing_game",int(_loc9_));
         }
         var _loc11_:IRoomObject;
         if((_loc11_ = getRoomUserObject(_loc5_)) != null)
         {
            (_loc12_ = _loc11_.getVisualization() as IRoomObjectSpriteVisualization).getSprite(0).alpha = param1.invincible ? 100 : 255;
            if(_loc6_ = param1.team != var_1655.getCurrentPlayer().team)
            {
               if((var_1655.roomEngine as IRoomEngineServices).playerUnderCursor == _loc5_ && !param1.invincible && !param1.isStunned())
               {
                  var_1655.roomEngine.updateObjectUserEffect(1,_loc5_,98);
               }
               else
               {
                  var_1655.roomEngine.updateObjectUserEffect(1,_loc5_,0);
               }
            }
         }
      }
      
      private function updateSnowballGameObject(param1:SnowBallGameObject) : void
      {
         var _loc5_:Number = param1.location3D.x / 3200;
         var _loc3_:Number = param1.location3D.y / 3200;
         var _loc4_:Number = param1.location3D.z / Tile.TILE_HALFWIDTH;
         var _loc2_:Vector3d = new Vector3d(_loc5_,_loc3_,_loc4_);
         var _loc6_:int = param1.gameObjectId;
         if(var_2864.indexOf(_loc6_) == -1)
         {
            var_1655.roomEngine.addObjectSnowWar(1,_loc6_,_loc2_,201);
            var_2864.push(_loc6_);
         }
         else
         {
            var_1655.roomEngine.updateObjectSnowWar(1,_loc6_,_loc2_,201);
         }
      }
      
      private function updateSnowballMachineGameObject(param1:SnowballMachineGameObject) : void
      {
         var _loc3_:RoomEngine = var_1655.roomEngine as RoomEngine;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         if(_loc2_.getState(0) != param1.snowballCount)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,param1.snowballCount,null);
            _loc2_.setState(param1.snowballCount,0);
         }
      }
      
      private function updateSnowballPileGameObject(param1:SnowballPileGameObject) : void
      {
         var _loc3_:RoomEngine = var_1655.roomEngine as RoomEngine;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         var _loc4_:int = param1.maxSnowballs - param1.snowballCount;
         if(_loc2_ && _loc2_.getState(0) != _loc4_)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,_loc4_,null);
            _loc2_.setState(_loc4_,0);
         }
      }
      
      private function updateTreeGameObject(param1:TreeGameObject) : void
      {
         var _loc3_:RoomEngine = var_1655.roomEngine as RoomEngine;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         if(_loc2_ && _loc2_.getState(0) != param1.hits)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,param1.hits,null);
            _loc2_.setState(param1.hits,0);
         }
      }
      
      private function getRoomUserObject(param1:int) : IRoomObject
      {
         return var_1655.roomEngine.getRoomObject(1,param1,100);
      }
      
      private function visualizeAsGhost(param1:IRoomObject) : void
      {
         var _loc2_:IRoomObjectSpriteVisualization = null;
         var _loc4_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.spriteCount)
            {
               _loc3_ = _loc2_.getSprite(_loc4_);
               _loc3_.blendMode = "hardlight";
               _loc4_++;
            }
         }
      }
      
      private function hideVisualization(param1:IRoomObject) : void
      {
         var _loc2_:IRoomObjectSpriteVisualization = null;
         var _loc4_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.spriteCount)
            {
               _loc3_ = _loc2_.getSprite(_loc4_);
               _loc3_.visible = false;
               _loc4_++;
            }
         }
      }
      
      public function showChecksumError(param1:uint) : void
      {
         var_1735.showChecksumError(param1);
      }
      
      private function initCountDown() : void
      {
         var_1735.initCounter();
         var_1735.update(1000);
      }
      
      public function updateTileCursor(param1:int) : void
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 3;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 4;
               break;
            case 3:
               _loc2_ = 5;
               break;
            default:
               _loc2_ = 0;
         }
         var_1655.roomEngine.setTileCursorState(1,_loc2_);
      }
      
      public function stopWaitingForSnowball() : void
      {
         if(var_1735)
         {
            var_1735.stopWaitingForSnowball();
         }
      }
      
      public function startWaitingForSnowball() : void
      {
         if(var_1735)
         {
            var_1735.startWaitingForSnowball();
         }
      }
      
      public function flashOwnScore(param1:Boolean) : void
      {
         if(var_1735)
         {
            var_1735.flashOwnScore(param1);
         }
      }
   }
}
