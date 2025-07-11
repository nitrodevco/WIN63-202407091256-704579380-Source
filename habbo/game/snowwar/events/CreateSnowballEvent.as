package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   
   public class CreateSnowballEvent extends class_3587
   {
       
      
      private var _snowBallGameObject:SnowBallGameObject;
      
      private var var_2970:HumanGameObject;
      
      private var var_932:int;
      
      private var var_1081:int;
      
      private var var_795:int;
      
      public function CreateSnowballEvent(param1:int, param2:HumanGameObject, param3:int, param4:int, param5:int)
      {
         super();
         this._snowBallGameObject = new SnowBallGameObject(param1);
         this.var_2970 = param2;
         this.var_932 = param3;
         this.var_1081 = param4;
         this.var_795 = param5;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _snowBallGameObject = null;
         var_2970 = null;
      }
      
      public function set snowBallGameObject(param1:SnowBallGameObject) : void
      {
         this._snowBallGameObject = param1;
      }
      
      override public function apply(param1:class_3565) : void
      {
         param1.addGameObject(_snowBallGameObject.gameObjectId,_snowBallGameObject);
         _snowBallGameObject.isActive = true;
         var _loc2_:int = var_2970.currentLocation.x;
         var _loc3_:int = var_2970.currentLocation.y;
         var _loc4_:int = 3000;
         _snowBallGameObject.initialize(_loc2_,_loc3_,_loc4_,var_795,var_932,var_1081,var_2970);
      }
   }
}
