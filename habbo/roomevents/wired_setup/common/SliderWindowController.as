package com.sulake.habbo.roomevents.wired_setup.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class SliderWindowController extends EventDispatcherWrapper
   {
       
      
      private var var_2974:Number = 0;
      
      private var var_2249:IWindowContainer;
      
      private var var_2454:Boolean = false;
      
      private var var_2576:BitmapData;
      
      private var var_2589:BitmapData;
      
      private var _referenceWidth:int;
      
      private var name_3:Number = 0;
      
      private var name_5:Number = 1;
      
      private var var_2728:Number = 0;
      
      public function SliderWindowController(param1:HabboUserDefinedRoomEvents, param2:IWindowContainer, param3:IAssetLibrary, param4:Number = 0, param5:Number = 1, param6:Number = 0)
      {
         super();
         var_2249 = IWindowContainer(param1.getXmlWindow("ude_slider"));
         param2.addChild(var_2249);
         name_3 = param4;
         name_5 = param5;
         var_2728 = param6;
         var_2974 = 0;
         storeAssets(param3);
         displaySlider();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_2249 = null;
         var_2576 = null;
         var_2589 = null;
      }
      
      public function setValue(param1:Number, param2:Boolean = true, param3:Boolean = true) : void
      {
         param1 = Math.max(name_3,param1);
         param1 = Math.min(name_5,param1);
         var_2974 = param1;
         if(param2)
         {
            updateSliderPosition();
         }
         if(param3)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function getValue() : Number
      {
         return var_2974;
      }
      
      public function set min(param1:Number) : void
      {
         name_3 = param1;
      }
      
      public function set max(param1:Number) : void
      {
         name_5 = param1;
      }
      
      private function updateSliderPosition() : void
      {
         if(var_2249 == null)
         {
            return;
         }
         var _loc1_:IWindow = var_2249.findChildByName("slider_button");
         if(_loc1_ != null)
         {
            _loc1_.x = getSliderPosition(var_2974);
         }
         _loc1_.parent.invalidate();
      }
      
      private function getSliderPosition(param1:Number) : int
      {
         return int(_referenceWidth * ((param1 - name_3) / (name_5 - name_3)));
      }
      
      private function getValueAtPosition(param1:Number) : Number
      {
         return param1 / _referenceWidth * (name_5 - name_3) + name_3;
      }
      
      private function sliderProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.type == "WME_DOWN")
         {
            var_2454 = true;
         }
         if(var_2454)
         {
            if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
            {
               var_2454 = false;
            }
         }
         if(!var_2454 || param1.type != "WE_RELOCATED")
         {
            return;
         }
         if(var_2728 != 0)
         {
            _loc4_ = getValueAtPosition(param2.x);
            _loc3_ = Math.round(_loc4_ / var_2728) * var_2728;
            setValue(_loc3_,false);
         }
      }
      
      private function sliderButtonRightProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Number = NaN;
         if(param1.type == "WME_CLICK")
         {
            var_2454 = false;
            if(var_2728 != 0)
            {
               _loc3_ = var_2974 + var_2728;
               setValue(_loc3_);
            }
         }
      }
      
      private function sliderButtonLeftProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:Number = NaN;
         if(param1.type == "WME_CLICK")
         {
            var_2454 = false;
            if(var_2728 != 0)
            {
               _loc3_ = var_2974 - var_2728;
               setValue(_loc3_);
            }
         }
      }
      
      private function displaySlider() : void
      {
         var _loc1_:IWindowContainer = null;
         var _loc3_:IBitmapWrapperWindow = null;
         var _loc4_:class_3489 = null;
         var _loc2_:class_3489 = null;
         if(var_2249 == null)
         {
            return;
         }
         _loc3_ = var_2249.findChildByName("slider_base") as IBitmapWrapperWindow;
         if(_loc3_ != null && var_2576 != null)
         {
            _loc3_.bitmap = new BitmapData(var_2576.width,var_2576.height,true,16777215);
            _loc3_.bitmap.copyPixels(var_2576,var_2576.rect,new Point(0,0),null,null,true);
         }
         _loc1_ = var_2249.findChildByName("slider_movement_area") as IWindowContainer;
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.findChildByName("slider_button") as IBitmapWrapperWindow;
            if(_loc3_ != null && var_2589 != null)
            {
               _loc3_.bitmap = new BitmapData(var_2589.width,var_2589.height,true,16777215);
               _loc3_.bitmap.copyPixels(var_2589,var_2589.rect,new Point(0,0),null,null,true);
               _loc3_.procedure = sliderProcedure;
               _referenceWidth = _loc1_.width - _loc3_.width;
            }
         }
         _loc2_ = var_2249.findChildByName("slider_button_left") as class_3489;
         if(_loc2_)
         {
            _loc2_.procedure = sliderButtonLeftProcedure;
         }
         if(_loc4_ = var_2249.findChildByName("slider_button_right") as class_3489)
         {
            _loc4_.procedure = sliderButtonRightProcedure;
         }
      }
      
      private function storeAssets(param1:IAssetLibrary) : void
      {
         var _loc2_:BitmapDataAsset = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = BitmapDataAsset(param1.getAssetByName("slider_bg_png"));
         var_2576 = BitmapData(_loc2_.content);
         _loc2_ = BitmapDataAsset(param1.getAssetByName("slider_obj_png"));
         var_2589 = BitmapData(_loc2_.content);
      }
   }
}
