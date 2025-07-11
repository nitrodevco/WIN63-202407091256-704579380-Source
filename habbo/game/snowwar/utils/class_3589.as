package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   
   public interface class_3589 extends IDisposable
   {
       
      
      function distanceTo(param1:class_3589) : int;
      
      function directionTo(param1:class_3589) : Direction8;
      
      function getNodeAt(param1:Direction8) : class_3589;
      
      function directionIsBlocked(param1:Direction8, param2:IGameObject) : Boolean;
      
      function getPathCost(param1:Direction8, param2:IGameObject) : int;
      
      function set nodeDirection(param1:Direction8) : void;
      
      function get nodeDirection() : Direction8;
      
      function set parentNode(param1:class_3589) : void;
      
      function get parentNode() : class_3589;
      
      function set nodeCostFromStart(param1:int) : void;
      
      function get nodeCostFromStart() : int;
      
      function set nodeCostToGoal(param1:int) : void;
      
      function get nodeCostToGoal() : int;
   }
}
