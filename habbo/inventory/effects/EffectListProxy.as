package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   
   public class EffectListProxy implements IThumbListDataProvider
   {
       
      
      private var var_1644:EffectsModel;
      
      private var var_1462:int;
      
      public function EffectListProxy(param1:EffectsModel, param2:int)
      {
         super();
         var_1644 = param1;
         var_1462 = param2;
      }
      
      public function dispose() : void
      {
         var_1644 = null;
      }
      
      public function getDrawableList() : Array
      {
         return var_1644.getEffects(var_1462);
      }
   }
}
