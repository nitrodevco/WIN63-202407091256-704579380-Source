package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   
   public class class_3590 implements class_3589
   {
       
      
      private var _referenceNumber:int = -1;
      
      private var _nodeDirection8:Direction8;
      
      private var var_4143:class_3589;
      
      private var var_3491:int;
      
      private var var_3454:int;
      
      private var var_318:Boolean = false;
      
      public function class_3590()
      {
         super();
      }
      
      public function dispose() : void
      {
         _nodeDirection8 = null;
         var_4143 = null;
         var_3491 = 0;
         var_3454 = 0;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      public function get nodeDirection() : Direction8
      {
         return _nodeDirection8;
      }
      
      public function set nodeDirection(param1:Direction8) : void
      {
         _nodeDirection8 = param1;
      }
      
      public function get parentNode() : class_3589
      {
         return var_4143;
      }
      
      public function set parentNode(param1:class_3589) : void
      {
         this.var_4143 = param1;
      }
      
      public function get nodeCostToGoal() : int
      {
         return var_3491;
      }
      
      public function set nodeCostToGoal(param1:int) : void
      {
         this.var_3491 = param1;
      }
      
      public function get nodeCostFromStart() : int
      {
         return var_3454;
      }
      
      public function set nodeCostFromStart(param1:int) : void
      {
         this.var_3454 = param1;
      }
      
      public function compareTo(param1:class_3590) : int
      {
         var _loc3_:int = var_3454 + var_3491;
         var _loc2_:int = param1.var_3454 + param1.var_3491;
         if(_loc3_ < _loc2_)
         {
            return -1;
         }
         if(_loc3_ > _loc2_)
         {
            return 1;
         }
         return 0;
      }
      
      public function distanceTo(param1:class_3589) : int
      {
         return 0;
      }
      
      public function directionTo(param1:class_3589) : Direction8
      {
         return null;
      }
      
      public function getNodeAt(param1:Direction8) : class_3589
      {
         return null;
      }
      
      public function directionIsBlocked(param1:Direction8, param2:IGameObject) : Boolean
      {
         return false;
      }
      
      public function getPathCost(param1:Direction8, param2:IGameObject) : int
      {
         return 0;
      }
   }
}
