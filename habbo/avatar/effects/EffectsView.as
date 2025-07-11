package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.class_3554;
   import com.sulake.habbo.avatar.common.class_3676;
   
   public class EffectsView extends CategoryBaseView implements class_3676
   {
       
      
      public function EffectsView(param1:class_3554)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = var_1644.controller.view.getCategoryContainer("effects") as IWindowContainer;
            _window.visible = false;
         }
         if(var_1644 && var_1713 == "")
         {
            var_1644.switchCategory("effects");
         }
         var_1618 = true;
         updateGridView(var_1713);
      }
      
      override public function reset() : void
      {
         updateGridView(var_1713);
         var_1644.selectPart(var_1713,-1);
      }
      
      public function switchCategory(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         param1 = param1 == "" ? var_1713 : param1;
         var_1713 = param1;
         if(!var_1618)
         {
            init();
         }
         updateGridView(var_1713);
      }
      
      public function updateSelectionVisual(param1:String, param2:int, param3:Boolean) : void
      {
         AvatarEditorGridViewEffects(var_1644.controller.view.effectsGridView).updateSelection(param2,param3);
      }
      
      public function getGridIndex(param1:int) : int
      {
         return AvatarEditorGridViewEffects(var_1644.controller.view.effectsGridView).getGridIndex(param1);
      }
      
      override protected function updateGridView(param1:String) : void
      {
         var_1644.controller.view.effectsGridView.initFromList(var_1644,param1);
      }
   }
}
