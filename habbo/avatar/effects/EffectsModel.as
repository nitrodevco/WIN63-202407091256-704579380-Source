package com.sulake.habbo.avatar.effects
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.class_3600;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.inventory.class_3358;
   import flash.utils.Dictionary;
   
   public class EffectsModel extends CategoryBaseModel implements class_3554
   {
      
      public static const GRIDTYPE_EFFECTS:String = "effects";
       
      
      private var var_2038:Dictionary;
      
      private var var_4048:EffectsParamView;
      
      public function EffectsModel(param1:HabboAvatarEditor)
      {
         var_2038 = new Dictionary();
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         var_1618 = true;
         if(!var_1631)
         {
            var_1631 = new EffectsView(this);
            var_4048 = new EffectsParamView(this,controller.manager.windowManager,controller.manager.assets);
            if(var_1631)
            {
               var_1631.init();
            }
         }
      }
      
      public function get effects() : Array
      {
         if(controller.manager.inventory == null)
         {
            return [];
         }
         return controller.manager.inventory.getAvatarEffects();
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
         var _loc3_:class_3600 = null;
         setSelectionVisual(param1,var_2038[param1],false);
         var _loc5_:int = controller.figureData.avatarEffectType;
         if(param2 == -1 && _loc5_ != -1)
         {
            param2 = int(EffectsView(var_1631).getGridIndex(_loc5_));
            for each(var _loc4_ in effects)
            {
               if(_loc4_.type == _loc5_)
               {
                  _loc3_ = class_3600(_loc4_);
                  _loc3_.isSelected = true;
                  break;
               }
            }
         }
         else if(param2 == -1 && _loc5_ == -1 || param2 == 0)
         {
            param2 = 0;
            controller.setAvatarEffectType(-1);
            var_4048.updateView(null);
         }
         else
         {
            _loc3_ = class_3600(effects[param2 - 1]);
            _loc3_.isSelected = true;
            controller.setAvatarEffectType(_loc3_.type);
         }
         var_2038[param1] = param2;
         setSelectionVisual(param1,param2,true);
         var_4048.updateView(_loc3_);
      }
      
      private function setSelectionVisual(param1:String, param2:int, param3:Boolean) : void
      {
         EffectsView(var_1631).updateSelectionVisual(param1,param2,param3);
      }
   }
}
