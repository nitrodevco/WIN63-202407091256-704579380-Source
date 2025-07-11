package com.sulake.habbo.toolbar.memenu.soundsettings
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   
   public class MeMenuSoundSettingsSlider
   {
       
      
      private var var_3759:*;
      
      private var var_2249:IWindowContainer;
      
      private var _referenceWidth:int;
      
      private var name_3:Number = 0;
      
      private var name_5:Number = 1;
      
      public function MeMenuSoundSettingsSlider(param1:*, param2:IWindowContainer, param3:IAssetLibrary, param4:Number = 0, param5:Number = 1)
      {
         super();
         var_3759 = param1;
         var_2249 = param2;
         name_3 = param4;
         name_5 = param5;
         displaySlider();
      }
      
      public function dispose() : void
      {
         var_3759 = null;
         var_2249 = null;
      }
      
      public function setValue(param1:Number) : void
      {
         if(var_2249 == null)
         {
            return;
         }
         var _loc2_:IWindow = var_2249.findChildByName("slider_button");
         if(_loc2_ != null)
         {
            _loc2_.x = getSliderPosition(param1);
         }
      }
      
      private function getSliderPosition(param1:Number) : int
      {
         return int(_referenceWidth * ((param1 - name_3) / (name_5 - name_3)));
      }
      
      private function getValue(param1:Number) : Number
      {
         return param1 / _referenceWidth * (name_5 - name_3) + name_3;
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_RELOCATED")
         {
            return;
         }
         var_3759.saveVolume(getValue(param2.x),false);
      }
      
      private function displaySlider() : void
      {
         var _loc2_:IWindowContainer = null;
         var _loc1_:IWindowContainer = null;
         if(var_2249 == null)
         {
            return;
         }
         _loc2_ = var_2249.findChildByName("slider_movement_area") as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as IWindowContainer;
            if(_loc1_ != null)
            {
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
            }
         }
      }
   }
}
