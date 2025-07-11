package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class DimmerViewAlphaSlider
   {
       
      
      private var var_1631:DimmerView;
      
      private var var_2249:IWindowContainer;
      
      private var var_2576:BitmapData;
      
      private var var_2589:BitmapData;
      
      private var _referenceWidth:int;
      
      private var var_4719:int;
      
      private var name_3:int = 0;
      
      private var name_5:int = 255;
      
      public function DimmerViewAlphaSlider(param1:DimmerView, param2:IWindowContainer, param3:IAssetLibrary, param4:int = 0, param5:int = 255)
      {
         super();
         var_1631 = param1;
         var_2249 = param2;
         name_3 = param4;
         name_5 = param5;
         storeAssets(param3);
         displaySlider();
      }
      
      public function dispose() : void
      {
         var_1631 = null;
         var_2249 = null;
         var_2576 = null;
         var_2589 = null;
      }
      
      public function setValue(param1:int) : void
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
      
      public function set min(param1:Number) : void
      {
         name_3 = param1;
         setValue(var_1631.selectedBrightness);
      }
      
      public function set max(param1:Number) : void
      {
         name_5 = param1;
         setValue(var_1631.selectedBrightness);
      }
      
      private function getSliderPosition(param1:int) : int
      {
         return int(_referenceWidth * ((param1 - name_3) / (name_5 - name_3)));
      }
      
      private function getValue(param1:Number) : int
      {
         return int(param1 / _referenceWidth * (name_5 - name_3)) + name_3;
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE")
         {
            return;
         }
         var_1631.selectedBrightness = getValue(param2.x);
      }
      
      private function displaySlider() : void
      {
         var _loc2_:IWindowContainer = null;
         var _loc1_:IBitmapWrapperWindow = null;
         if(var_2249 == null)
         {
            return;
         }
         _loc1_ = var_2249.findChildByName("slider_base") as IBitmapWrapperWindow;
         if(_loc1_ != null && var_2576 != null)
         {
            _loc1_.bitmap = new BitmapData(var_2576.width,var_2576.height,true,16777215);
            _loc1_.bitmap.copyPixels(var_2576,var_2576.rect,new Point(0,0),null,null,true);
         }
         _loc2_ = var_2249.findChildByName("slider_movement_area") as IWindowContainer;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as IBitmapWrapperWindow;
            if(_loc1_ != null && var_2589 != null)
            {
               _loc1_.bitmap = new BitmapData(var_2589.width,var_2589.height,true,16777215);
               _loc1_.bitmap.copyPixels(var_2589,var_2589.rect,new Point(0,0),null,null,true);
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
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
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_base"));
         var_2576 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_button"));
         var_2589 = BitmapData(_loc2_.content);
      }
   }
}
