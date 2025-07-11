package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.class_3566;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   
   public class SnowballGivingGameObject extends SnowWarGameObject
   {
       
      
      protected var var_3930:int;
      
      protected var var_1772:int;
      
      protected var var_1706:Tile;
      
      public function SnowballGivingGameObject(param1:int, param2:int, param3:Tile, param4:int)
      {
         super(param1,false);
         _active = true;
         var_1772 = param2;
         var_1706 = param3;
         var_3930 = param4;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1706 = null;
      }
      
      override public function get direction360() : Direction360
      {
         return null;
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function get location3D() : Location3D
      {
         return var_1706.location;
      }
      
      public function get fuseObjectId() : int
      {
         return var_3930;
      }
      
      public function get snowballCount() : int
      {
         return var_1772;
      }
      
      override public function subturn(param1:class_3565) : void
      {
      }
      
      public function pickupSnowballs(param1:int) : int
      {
         if(var_1772 < param1)
         {
            param1 = var_1772;
         }
         var_1772 -= param1;
         onSnowballPickup();
         return param1;
      }
      
      override public function onSnowBallHit(param1:class_3566, param2:SnowBallGameObject) : void
      {
      }
      
      protected function onSnowballPickup() : void
      {
      }
   }
}
