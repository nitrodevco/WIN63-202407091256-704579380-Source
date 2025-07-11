package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.class_3600;
   import com.sulake.habbo.avatar.common.*;
   
   public class AvatarEditorGridViewEffects implements class_3643
   {
       
      
      private var var_1631:IWindowContainer;
      
      private var var_4545:Boolean = true;
      
      private var var_1644:class_3554;
      
      private var var_634:String;
      
      private var var_2133:IItemGridWindow;
      
      private var _effectItems:Vector.<AvatarEditorGridItemEffect>;
      
      private var var_3274:IWindow;
      
      private var var_617:IWindow;
      
      public function AvatarEditorGridViewEffects(param1:IWindowContainer)
      {
         super();
         var_1631 = param1;
         var_2133 = var_1631.findChildByName("thumbs") as IItemGridWindow;
         var_3274 = var_1631.findChildByName("content_notification");
         var_617 = var_1631.findChildByName("content_title");
      }
      
      public function dispose() : void
      {
         if(var_2133)
         {
            var_2133.dispose();
            var_2133 = null;
         }
         var_1644 = null;
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function get window() : IWindowContainer
      {
         return var_1631;
      }
      
      public function initFromList(param1:class_3554, param2:String) : void
      {
         var _loc5_:AvatarEditorGridItemEffect = null;
         var_1644 = param1;
         var_634 = param2;
         var_1631.visible = true;
         var _loc3_:Array = EffectsModel(var_1644).effects;
         var_2133.removeGridItems();
         _effectItems = new Vector.<AvatarEditorGridItemEffect>();
         if(_loc3_.length == 0)
         {
            var_617.visible = true;
            var_3274.visible = true;
         }
         else
         {
            var_3274.visible = false;
            var_617.visible = false;
            _loc5_ = new AvatarEditorGridItemEffect(null,var_1644.controller.manager.windowManager,var_1644.controller.manager.assets);
            addGridItem(_loc5_);
            for each(var _loc4_ in _loc3_)
            {
               _loc5_ = new AvatarEditorGridItemEffect(_loc4_,var_1644.controller.manager.windowManager,var_1644.controller.manager.assets);
               addGridItem(_loc5_);
            }
         }
         showPalettes(0);
         var_4545 = false;
      }
      
      private function addGridItem(param1:AvatarEditorGridItemEffect) : void
      {
         param1.window.procedure = partEventProc;
         _effectItems.push(param1);
         var_2133.addGridItem(param1.window);
      }
      
      public function showPalettes(param1:int) : void
      {
         var _loc3_:IWindow = var_1631.findChildByName("palette0");
         var _loc2_:IWindow = var_1631.findChildByName("palette1");
         _loc3_.visible = false;
         _loc2_.visible = false;
      }
      
      public function get firstView() : Boolean
      {
         return var_4545;
      }
      
      public function updateSelection(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < _effectItems.length)
         {
            _effectItems[param1].selected = param2;
         }
      }
      
      public function getGridIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _effectItems.length)
         {
            if(_effectItems[_loc2_].effectType == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function partEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN")
         {
            _loc3_ = var_2133.getGridItemIndex(param1.window);
            var_1644.selectPart(var_634,_loc3_);
         }
      }
   }
}
