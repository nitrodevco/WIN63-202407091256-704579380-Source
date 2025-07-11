package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.class_3566;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballPileGameObjectData;
   
   public class SnowballPileGameObject extends SnowballGivingGameObject
   {
      
      private static const BOUNDING_DATA_PER_SNOWBALL:int = 100;
       
      
      private var var_3712:Array;
      
      private var _maxSnowballs:int;
      
      public function SnowballPileGameObject(param1:SnowballPileGameObjectData, param2:class_3566)
      {
         super(param1.id,param1.snowballCount,param2.getTileAt(Tile.convertToTileX(param1.locationX3D),Tile.convertToTileY(param1.locationY3D)),param1.fuseObjectId);
         _maxSnowballs = param1.maxSnowballs;
         if(var_1772 > 0)
         {
            param2.addGameObjectToTile(this);
         }
         var_3712 = [var_1772 * 100];
      }
      
      override public function get numberOfVariables() : int
      {
         return 7;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 3;
            case 1:
               return var_2057;
            case 2:
               return var_1706.location.x;
            case 3:
               return var_1706.location.y;
            case 4:
               return _maxSnowballs;
            case 5:
               return var_1772;
            case 6:
               return var_3930;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get boundingData() : Array
      {
         return var_3712;
      }
      
      override protected function onSnowballPickup() : void
      {
         var_3712 = [var_1772 * 100];
         if(var_1772 <= 0)
         {
            var_1706.removeGameObject();
         }
      }
      
      public function get maxSnowballs() : int
      {
         return _maxSnowballs;
      }
   }
}
