package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class CameraFxStrengthSlider
   {
       
      
      private var var_1631:CameraPhotoLab;
      
      private var var_2249:IWindowContainer;
      
      private var var_2576:BitmapData;
      
      private var var_2589:BitmapData;
      
      private var _activeBaseArea:IBitmapWrapperWindow;
      
      private var _sliderBaseWidth:int;
      
      private var _referenceWidth:int;
      
      private var var_4719:int = 0;
      
      public function CameraFxStrengthSlider(param1:CameraPhotoLab, param2:IWindowContainer, param3:IAssetLibrary)
      {
         super();
         var_1631 = param1;
         var_2249 = param2;
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
      
      public function disable() : void
      {
         var_2249.visible = false;
      }
      
      public function enable() : void
      {
         var_2249.visible = true;
      }
      
      public function getScale() : int
      {
         return _referenceWidth;
      }
      
      public function setValue(param1:int) : void
      {
         var _loc2_:IWindow = null;
         if(var_2249 != null)
         {
            _loc2_ = var_2249.findChildByName("slider_button");
            if(_loc2_ != null)
            {
               _loc2_.x = param1;
            }
         }
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WE_RELOCATED")
         {
            if(_activeBaseArea)
            {
               _activeBaseArea.width = param2.x / _referenceWidth * _sliderBaseWidth;
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            var_1631.setSelectedFxValue(param2.x);
         }
      }
      
      private function shaftProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_DOWN" && param2.name == "shaft_click_area")
         {
            _loc3_ = WindowMouseEvent(param1).localX - var_4719;
            setValue(_loc3_);
            var_1631.setSelectedFxValue(_loc3_);
         }
      }
      
      private function displaySlider() : void
      {
         var _loc3_:IWindowContainer = null;
         var _loc2_:IBitmapWrapperWindow = null;
         if(var_2249 == null)
         {
            return;
         }
         var _loc1_:IRegionWindow = var_2249.findChildByName("shaft_click_area") as IRegionWindow;
         if(_loc1_)
         {
            _loc1_.procedure = shaftProcedure;
         }
         _loc2_ = var_2249.findChildByName("slider_base") as IBitmapWrapperWindow;
         if(_loc2_ != null && var_2576 != null)
         {
            _sliderBaseWidth = _loc2_.width;
            _loc2_.bitmap = new BitmapData(var_2576.width,var_2576.height,true,16777215);
            _loc2_.bitmap.copyPixels(var_2576,var_2576.rect,new Point(0,0),null,null,true);
            _activeBaseArea = _loc2_;
         }
         _loc3_ = var_2249.findChildByName("slider_movement_area") as IWindowContainer;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.findChildByName("slider_button") as IBitmapWrapperWindow;
            if(_loc2_ != null && var_2589 != null)
            {
               _loc2_.bitmap = new BitmapData(var_2589.width,var_2589.height,true,16777215);
               _loc2_.bitmap.copyPixels(var_2589,var_2589.rect,new Point(0,0),null,null,true);
               _loc2_.procedure = buttonProcedure;
               _referenceWidth = _loc3_.width - _loc2_.width;
               var_4719 = (_sliderBaseWidth - _referenceWidth) / 2;
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
         _loc2_ = BitmapDataAsset(param1.getAssetByName("camera_fx_slider_bottom_active"));
         var_2576 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("camera_fx_slider_button"));
         var_2589 = BitmapData(_loc2_.content);
      }
   }
}
