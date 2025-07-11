package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.class_3566;
   import com.sulake.habbo.game.snowwar.class_3616;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.class_3757;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
   
   public class HumanGameObject extends SnowWarGameObject
   {
      
      public static const const_1136:int = 534;
      
      public static const INITIAL_SNOWBALL_COUNT:int = 5;
      
      public static const MAXIMUM_SNOWBALL_COUNT:int = 5;
      
      public static const INITIAL_HIT_POINTS:int = 5;
      
      public static const SNOWBALL_CREATE_TIME:int = 20;
      
      public static const STUN_TIME:int = 100;
      
      public static const INVINCIBLE_AFTER_STUN_TIME:int = 60;
      
      public static const ACTIVITY_STATE_NORMAL:int = 0;
      
      public static const ACTIVITY_STATE_MAKING_SNOWBALL:int = 1;
      
      public static const ACTIVITY_STATE_STUNNED:int = 2;
      
      public static const ACTIVITY_STATE_INVINCIBLE_AFTER_STUN:int = 3;
      
      public static const SNOWBALL_THROW_INTERVAL:int = 5;
      
      public static const BOUNDING_DATA:Array = [1600];
      
      public static const PLAYER_HEIGHT:int = 5000;
      
      private static const SCORE_ON_KNOCK_DOWN:int = 5;
      
      private static const SCORE_ON_HIT:int = 1;
       
      
      private var var_1706:Tile;
      
      private var var_1652:Tile;
      
      private var var_1257:Boolean;
      
      private var var_1712:Location3D;
      
      private var var_1842:Location3D;
      
      private var var_822:Direction8;
      
      private var _hitPoints:int;
      
      private var var_1772:int;
      
      protected var var_4160:int;
      
      private var var_1839:int;
      
      private var var_1683:int;
      
      private var var_367:int;
      
      private var var_2530:int;
      
      private var var_2495:int;
      
      private var _name:String;
      
      private var var_1047:String;
      
      private var var_426:String;
      
      private var var_139:String;
      
      private var var_418:int;
      
      private var var_4802:int = 0;
      
      private var var_1655:SnowWarEngine;
      
      private var var_3273:Map;
      
      public function HumanGameObject(param1:class_3566, param2:HumanGameObjectData, param3:Boolean, param4:SnowWarEngine)
      {
         var_1712 = new Location3D(0,0,0);
         var_1842 = new Location3D(0,0,0);
         var_822 = Direction8.SE;
         super(param2.id,param3);
         var_139 = param2.sex;
         _name = param2.name;
         var_1047 = param2.mission;
         var_426 = param2.figure;
         var_2530 = param2.team;
         var_418 = param2.userId;
         var_1683 = param2.activityState;
         var_1839 = param2.activityTimer;
         var_1712.change2DLocation(param2.currentLocationX,param2.currentLocationY);
         var_822 = Direction8.getDirection8(param2.bodyDirection);
         _hitPoints = param2.hitPoints;
         var_1842.change2DLocation(param2.moveTargetX,param2.moveTargetY);
         var_1772 = param2.snowBallCount;
         var_367 = param2.score;
         var_1706 = param1.getTileAt(param2.currentTileX,param2.currentTileY);
         var_1706.addGameObject(this);
         var _loc5_:Tile;
         if((_loc5_ = param1.getTileAt(param2.nextTileX,param2.nextTileY)) != var_1706)
         {
            var_1652 = _loc5_;
            var_1652.addGameObject(this);
            var_1706.removeOccupyingHuman();
            var_1257 = true;
         }
         var_1655 = param4;
         var_3273 = new Map();
      }
      
      public function get visualizationMode() : int
      {
         return var_4802;
      }
      
      public function set visualizationMode(param1:int) : void
      {
         var_4802 = param1;
      }
      
      public function get invincible() : Boolean
      {
         return var_1683 == 3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_139 = "";
         _name = "";
         var_1047 = "";
         var_426 = "";
         var_2530 = 0;
         var_418 = 0;
         var_1712 = null;
         var_822 = null;
         var_1842 = null;
         var_1772 = 0;
         var_367 = 0;
         var_1257 = false;
         var_1655 = null;
         var_3273 = null;
      }
      
      override public function get numberOfVariables() : int
      {
         return 19;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 5;
            case 1:
               return var_2057;
            case 2:
               return var_1712.x;
            case 3:
               return var_1712.y;
            case 4:
               return var_1706.fuseLocation[0];
            case 5:
               return var_1706.fuseLocation[1];
            case 6:
               return var_822.intValue();
            case 7:
               return _hitPoints;
            case 8:
               return var_1772;
            case 9:
               return var_4160;
            case 10:
               return var_1839;
            case 11:
               return var_1683;
            case 12:
               return var_1652 != null ? var_1652.fuseLocation[0] : var_1706.fuseLocation[0];
            case 13:
               return var_1652 != null ? var_1652.fuseLocation[1] : var_1706.fuseLocation[1];
            case 14:
               return var_1842.x;
            case 15:
               return var_1842.y;
            case 16:
               return var_367;
            case 17:
               return var_2530;
            case 18:
               return var_418;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      public function reinitGhost(param1:HumanGameObject) : void
      {
         var_1712.change2DLocation(param1.var_1712.x,param1.var_1712.y);
         var_1706 = param1.var_1706;
         var_822 = param1.var_822;
         _hitPoints = param1._hitPoints;
         var_1772 = param1.var_1772;
         var_4160 = param1.var_4160;
         var_1839 = param1.var_1839;
         var_1683 = param1.var_1683;
         var_1652 = param1.var_1652;
         var_1842.change2DLocation(param1.var_1842.x,param1.var_1842.y);
         var_367 = param1.var_367;
         var_2530 = param1.var_2530;
         var_418 = param1.var_418;
      }
      
      public function isInGhostDistance(param1:int, param2:Location3D) : Boolean
      {
         var _loc3_:Location3D = var_3273[param1];
         if(_loc3_)
         {
            return _loc3_.isInDistance(param2,Tile.TILE_ONEANDHALFWIDTH);
         }
         return false;
      }
      
      public function addGhostLocation(param1:int) : void
      {
         var _loc2_:Location3D = new Location3D(0,0,0);
         _loc2_.change2DLocation(var_1712.x,var_1712.y);
         var_3273[param1] = _loc2_;
      }
      
      public function removeGhostLocation(param1:int) : void
      {
         var_3273.remove(param1);
      }
      
      public function setBodyDirection(param1:Direction8) : void
      {
         var_822 = param1;
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function get boundingData() : Array
      {
         return BOUNDING_DATA;
      }
      
      override public function get location3D() : Location3D
      {
         return var_1712;
      }
      
      override public function get direction360() : Direction360
      {
         return null;
      }
      
      override public function onRemove() : void
      {
         if(var_1706 && var_1706.occupyingHuman == this)
         {
            var_1706.removeOccupyingHuman();
         }
         if(var_1652 && var_1652.occupyingHuman == this)
         {
            var_1652.removeOccupyingHuman();
         }
         var_1257 = false;
      }
      
      public function activityTimerTriggered() : void
      {
         if(var_1683 == 2)
         {
            _hitPoints = 5;
            var_1683 = 3;
            var_1839 = 60;
            return;
         }
         if(var_1683 == 1)
         {
            var_1772++;
         }
         var_1683 = 0;
         var_1655.stopWaitingForSnowball(gameObjectId);
      }
      
      override public function subturn(param1:class_3565) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Direction8 = null;
         var _loc4_:class_3566 = param1 as class_3566;
         if(var_1839 > 0)
         {
            if(var_1839 == 1)
            {
               activityTimerTriggered();
            }
            var_1839--;
         }
         if(var_2495 > 0)
         {
            var_2495--;
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " currentTile:" + var_1706 + " nextTile:" + var_1652);
         }
         if(canMove() && var_1706 != null)
         {
            if(var_1652 != null)
            {
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log(gameObjectId + " Moving towards next tile:" + var_1652 + " _currentLocation:" + var_1712);
               }
               moveTowardsNextTile();
            }
            else if(!var_1706.locationIsInTileRange(var_1842))
            {
               _loc2_ = Direction360.getAngleFromComponents(var_1842.x - var_1706.location.x,var_1842.y - var_1706.location.y);
               _loc3_ = Direction360.direction360ValueToDirection8(_loc2_);
               var_1652 = var_1706.getTileInDirection(_loc3_);
               if(var_1652 == null || !var_1652.canMoveTo(this))
               {
                  if(var_1652 != null && !var_1652.canMoveTo(this))
                  {
                     if(var_1842.equals(var_1652.location))
                     {
                        var_1652 = null;
                        stopMovement();
                        return;
                     }
                  }
                  _loc3_ = _loc3_.rotateDirection(-1);
                  var_1652 = var_1706.getTileInDirection(_loc3_);
                  if(var_1652 == null || !var_1652.canMoveTo(this))
                  {
                     _loc3_ = _loc3_.rotateDirection(2);
                     var_1652 = var_1706.getTileInDirection(_loc3_);
                     if(var_1652 != null && !var_1652.canMoveTo(this))
                     {
                        var_1652 = null;
                     }
                  }
               }
               if(var_1652 != null)
               {
                  if(!isGhost)
                  {
                     var_1706.removeOccupyingHuman();
                     var_1652.addGameObject(this);
                  }
                  setBodyDirection(_loc3_);
                  moveTowardsNextTile();
               }
               else
               {
                  var_1257 = false;
               }
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log(gameObjectId + " Starting to move to next tile in direction360:" + _loc2_ + ", nextTile is now " + var_1652 + "_currentLocationn:" + var_1712 + ", moveTarget:" + var_1842);
               }
            }
            else
            {
               var_1257 = false;
            }
         }
         else
         {
            var_1257 = false;
         }
      }
      
      private function moveTowardsNextTile() : void
      {
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " [MoveTowardsNextTile], currentX: " + var_1712.x + " currentY: " + var_1712.y);
         }
         var _loc5_:int = var_1652.location.x;
         var _loc1_:* = var_1712.x;
         var _loc2_:int = _loc1_ - _loc5_;
         if(_loc2_ != 0)
         {
            if(_loc2_ < 0)
            {
               if(_loc2_ > -534)
               {
                  _loc1_ = _loc5_;
               }
               else
               {
                  _loc1_ += 534;
               }
            }
            else if(_loc2_ < 534)
            {
               _loc1_ = _loc5_;
            }
            else
            {
               _loc1_ -= 534;
            }
         }
         var _loc3_:int = var_1652.location.y;
         var _loc4_:int;
         var _loc6_:*;
         if((_loc4_ = (_loc6_ = var_1712.y) - _loc3_) != 0)
         {
            if(_loc4_ < 0)
            {
               if(_loc4_ > -534)
               {
                  _loc6_ = _loc3_;
               }
               else
               {
                  _loc6_ += 534;
               }
            }
            else if(_loc4_ < 534)
            {
               _loc6_ = _loc3_;
            }
            else
            {
               _loc6_ -= 534;
            }
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " [MoveTowardsNextTile], nextX: " + _loc1_ + " nextY: " + _loc6_);
         }
         var_1712.change2DLocation(_loc1_,_loc6_);
         if(var_1712.distanceTo(var_1652.location) < class_3757.javaDiv(534 / 2))
         {
            var_1706 = var_1652;
            var_1652 = null;
         }
         var_1257 = true;
      }
      
      public function changeMoveTarget(param1:int, param2:int) : void
      {
         if(var_1683 == 1)
         {
            var_1683 = 0;
            var_1839 = 0;
            var_1655.stopWaitingForSnowball(gameObjectId);
         }
         if(var_1683 == 0 || var_1683 == 3)
         {
            var_1842.change2DLocation(param1,param2);
         }
      }
      
      public function get currentLocation() : Location3D
      {
         return var_1712;
      }
      
      public function playerIsHitBySnowball(param1:class_3566, param2:HumanGameObject, param3:int) : void
      {
         if(var_3952)
         {
            return;
         }
         if(var_2530 == param2.team)
         {
            return;
         }
         if(_hitPoints > 0)
         {
            if(_hitPoints == 1)
            {
               playerFallsDown(param3);
               param2.onKnockDownHuman(param1,this);
               SnowWarEngine.playSound("HBSTG_snowwar_hit3");
            }
            _hitPoints--;
            var_1655.registerHit(this,param2);
         }
      }
      
      public function onHitHuman(param1:class_3566, param2:HumanGameObject) : void
      {
         if(!param2.isGhost && (team != param2.team || Boolean(class_3616(param1.gameArena.getExtension()).isDeathMatch())))
         {
            addScore(param1.gameArena,1);
         }
      }
      
      public function onKnockDownHuman(param1:class_3566, param2:HumanGameObject) : void
      {
         if(!param2.isGhost && (team != param2.team || Boolean(class_3616(param1.gameArena.getExtension()).isDeathMatch())))
         {
            addScore(param1.gameArena,5);
         }
      }
      
      public function addScore(param1:SynchronizedGameArena, param2:int) : void
      {
         var_367 += param2;
         param1.addTeamScore(team,param2);
      }
      
      public function playerFallsDown(param1:int) : void
      {
         var_1683 = 2;
         var_1839 = 100;
         setBodyDirection(Direction360.direction360ValueToDirection8(param1).oppositeDirection());
         stopMovement();
         var_1655.stopWaitingForSnowball(gameObjectId);
      }
      
      public function stopMovement() : void
      {
         if(var_1652 == null)
         {
            var_1842.changeLocationToLocation(var_1706.location);
            var_1712.changeLocationToLocation(var_1706.location);
         }
         else
         {
            var_1706 = var_1652;
            var_1712.changeLocationToLocation(var_1652.location);
            var_1842.changeLocationToLocation(var_1652.location);
            var_1652 = null;
         }
         var_1257 = false;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Stopped. dir:" + var_822 + "_currentTilee:" + var_1706 + "_nextTilee:" + var_1652 + "_currentLocationn:" + var_1712 + "_moveTargett:" + var_1842);
         }
      }
      
      public function getBodyDirection() : int
      {
         return var_822.intValue();
      }
      
      public function canThrowSnowballs() : Boolean
      {
         return var_1772 > 0 && var_2495 < 1 && (var_1683 == 0 || var_1683 == 3);
      }
      
      public function startThrowTimer() : void
      {
         var_2495 = 5;
      }
      
      public function throwSnowball(param1:int, param2:int) : Boolean
      {
         if(var_1772 < 1)
         {
            return false;
         }
         stopMovement();
         var _loc4_:int = Direction360.getAngleFromComponents(param1 - var_1712.x,param2 - var_1712.y);
         var _loc3_:int = Direction360.direction360ValueToDirection8(_loc4_).intValue();
         setBodyDirection(Direction8.getDirection8(_loc3_));
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Turning to:" + _loc3_ + " 360 value:" + _loc4_ + " target:" + param1 + "," + param2 + " location:" + var_1712.x + "," + var_1712.y);
         }
         var_1772--;
         return true;
      }
      
      public function canMove() : Boolean
      {
         return var_1683 == 0 || var_1683 == 3;
      }
      
      public function canMakeSnowballs() : Boolean
      {
         return (var_1683 == 0 || var_1683 == 3) && (var_1772 < 5 || isGhost);
      }
      
      public function startMakingSnowball() : void
      {
         if(canMakeSnowballs())
         {
            var_1683 = 1;
            var_1839 = 20;
            stopMovement();
         }
      }
      
      public function getRemainingSnowballCapacity() : int
      {
         return 5 - var_1772;
      }
      
      public function addSnowballs(param1:int) : void
      {
         var_1772 += param1;
      }
      
      public function isStunned() : Boolean
      {
         return var_1683 == 2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get mission() : String
      {
         return var_1047;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function get sex() : String
      {
         return var_139;
      }
      
      public function get score() : int
      {
         return var_367;
      }
      
      public function get team() : int
      {
         return var_2530;
      }
      
      public function get snowballs() : int
      {
         return var_1772;
      }
      
      public function get hitPoints() : int
      {
         return _hitPoints;
      }
      
      public function get posture() : String
      {
         if(var_2495 > 0)
         {
            return "swthrow";
         }
         switch(var_1683 - 1)
         {
            case 0:
               return "swpick";
            case 1:
               return "swdieback";
            default:
               if(var_1257)
               {
                  return "swrun";
               }
               return "std";
         }
      }
      
      public function get action() : String
      {
         switch(var_1683 - 3)
         {
            case 0:
               return "figure_dance";
            default:
               return "figure_dance";
         }
      }
      
      public function get parameter() : int
      {
         if(var_2495 > 1)
         {
            return 1;
         }
         if(var_2495 == 1)
         {
            return 0;
         }
         switch(var_1683 - 3)
         {
            case 0:
               return 1;
            default:
               return 0;
         }
      }
      
      override public function testSnowBallCollision(param1:SnowBallGameObject) : Boolean
      {
         if(!var_3952 && var_1683 != 2 && var_1683 != 3 && param1.throwingHuman != this && super.testSnowBallCollision(param1))
         {
            return true;
         }
         return false;
      }
      
      override public function onSnowBallHit(param1:class_3566, param2:SnowBallGameObject) : void
      {
         var _loc3_:HumanGameObject = param2.throwingHuman;
         playerIsHitBySnowball(param1,_loc3_,param2.direction360.intValue());
         _loc3_.onHitHuman(param1,this);
         SnowWarEngine.playSound("HBSTG_snowwar_hit1");
      }
      
      override public function get collisionHeight() : int
      {
         return 5000;
      }
      
      public function toString() : String
      {
         return " ref:" + var_2057 + "_name:" + _name;
      }
   }
}
