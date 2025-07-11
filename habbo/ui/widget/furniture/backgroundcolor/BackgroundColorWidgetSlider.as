package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BackgroundColorWidgetSlider
   {
      
      private static const name_3:int = 0;
      
      private static const name_5:int = 255;
       
      
      private var var_1629:BackgroundColorFurniWidget;
      
      private var var_2249:IWindowContainer;
      
      private var var_215:String;
      
      private var var_2576:BitmapData;
      
      private var var_2589:BitmapData;
      
      private var _referenceWidth:int;
      
      private var var_4719:int;
      
      public function BackgroundColorWidgetSlider(param1:BackgroundColorFurniWidget, param2:String, param3:IWindowContainer, param4:int = 0)
      {
         var _loc5_:BitmapDataAsset = null;
         super();
         var_1629 = param1;
         var_215 = param2;
         var_2249 = param3;
         _loc5_ = BitmapDataAsset(param1.assets.getAssetByName("dimmer_slider_base"));
         var_2576 = BitmapData(_loc5_.content);
         _loc5_ = BitmapDataAsset(param1.assets.getAssetByName("dimmer_slider_button"));
         var_2589 = BitmapData(_loc5_.content);
         displaySlider();
         setValue(param4);
      }
      
      public function dispose() : void
      {
         var_1629 = null;
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
      
      private function getSliderPosition(param1:int) : int
      {
         return int(_referenceWidth * ((param1 - 0) / (255 - 0)));
      }
      
      private function getValue(param1:Number) : int
      {
         return int(param1 / _referenceWidth * (255 - 0)) + 0;
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var_1629.setParameterCallback(var_215,getValue(param2.x));
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
   }
}
