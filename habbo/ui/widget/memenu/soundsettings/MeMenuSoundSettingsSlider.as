package com.sulake.habbo.ui.widget.memenu.soundsettings
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MeMenuSoundSettingsSlider
   {
       
      
      private var var_3759:MeMenuSoundSettingsItem;
      
      private var var_2249:IWindowContainer;
      
      private var var_2576:BitmapData;
      
      private var var_2589:BitmapData;
      
      private var _referenceWidth:int;
      
      private var name_3:Number = 0;
      
      private var name_5:Number = 1;
      
      public function MeMenuSoundSettingsSlider(param1:MeMenuSoundSettingsItem, param2:IWindowContainer, param3:IAssetLibrary, param4:Number = 0, param5:Number = 1)
      {
         super();
         var_3759 = param1;
         var_2249 = param2;
         name_3 = param4;
         name_5 = param5;
         storeAssets(param3);
         displaySlider();
      }
      
      public function dispose() : void
      {
         var_3759 = null;
         var_2249 = null;
         var_2576 = null;
         var_2589 = null;
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
         var _loc3_:IWindowContainer = null;
         var _loc1_:IWindowContainer = null;
         var _loc2_:IBitmapWrapperWindow = null;
         if(var_2249 == null)
         {
            return;
         }
         _loc2_ = var_2249.findChildByName("slider_base") as IBitmapWrapperWindow;
         if(_loc2_ != null && var_2576 != null)
         {
            _loc2_.bitmap = new BitmapData(var_2576.width,var_2576.height,true,16777215);
            _loc2_.bitmap.copyPixels(var_2576,var_2576.rect,new Point(0,0),null,null,true);
         }
         _loc3_ = var_2249.findChildByName("slider_movement_area") as IWindowContainer;
         if(_loc3_ != null)
         {
            _loc1_ = _loc3_.findChildByName("slider_button") as IWindowContainer;
            if(_loc1_ != null)
            {
               _loc2_ = _loc1_.findChildByName("slider_bitmap") as IBitmapWrapperWindow;
               if(_loc2_ != null && var_2589 != null)
               {
                  _loc2_.bitmap = new BitmapData(var_2589.width,var_2589.height,true,16777215);
                  _loc2_.bitmap.copyPixels(var_2589,var_2589.rect,new Point(0,0),null,null,true);
                  _loc1_.procedure = buttonProcedure;
                  _referenceWidth = _loc3_.width - _loc2_.width;
               }
            }
         }
      }
      
      private function storeAssets(param1:IAssetLibrary) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = BitmapDataAsset(param1.getAssetByName("memenu_settings_slider_base"));
         var_2576 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("memenu_settings_slider_button"));
         var_2589 = BitmapData(_loc2_.content);
      }
   }
}
