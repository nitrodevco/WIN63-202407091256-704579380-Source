package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.class_3565;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballGivingGameObject;
   
   public class HumanGetsSnowballsFromMachineEvent extends class_3587
   {
       
      
      private var var_2970:HumanGameObject;
      
      private var var_3566:SnowballGivingGameObject;
      
      public function HumanGetsSnowballsFromMachineEvent(param1:HumanGameObject, param2:SnowballGivingGameObject)
      {
         super();
         var_2970 = param1;
         var_3566 = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2970 = null;
         var_3566 = null;
      }
      
      override public function apply(param1:class_3565) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HumanGameObject = null;
         var _loc4_:int;
         if((_loc4_ = var_2970.getRemainingSnowballCapacity()) > 0)
         {
            _loc3_ = var_3566.pickupSnowballs(1);
            if(_loc3_ > 0)
            {
               var_2970.addSnowballs(_loc3_);
               _loc2_ = param1.getGameObject(var_2970.ghostObjectId) as HumanGameObject;
               if(_loc2_)
               {
                  _loc2_.addSnowballs(_loc3_);
               }
               SnowWarEngine.playSound("HBSTG_snowwar_get_snowball");
            }
         }
      }
      
      public function get human() : HumanGameObject
      {
         return var_2970;
      }
   }
}
