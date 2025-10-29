package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureBackgroundColorWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.ColorConverter;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRoomBackgroundColorDataComposer;
   
   public class BackgroundColorFurniWidget extends RoomWidgetBase
   {
      
      private static const PARAMETER_HUE:String = "hue";
      
      private static const PARAMETER_SATURATION:String = "saturation";
      
      private static const PARAMETER_LIGHTNESS:String = "lightness";
       
      
      private var _window:class_3514;
      
      private var var_603:int;
      
      private var _sliders:Vector.<BackgroundColorWidgetSlider>;
      
      private var var_1235:int;
      
      private var var_1010:int;
      
      private var var_1227:int;
      
      public function BackgroundColorFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         _sliders = new Vector.<BackgroundColorWidgetSlider>();
         super(param1,param2,param3,param4);
         this.handler.widget = this;
      }
      
      public function get handler() : FurnitureBackgroundColorWidgetHandler
      {
         return var_1653 as FurnitureBackgroundColorWidgetHandler;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      public function open(param1:int, param2:int, param3:int, param4:int) : void
      {
         var_603 = param1;
         var_1235 = Math.max(param2,0);
         var_1010 = Math.max(param3,0);
         var_1227 = Math.max(param4,0);
         createWindow();
      }
      
      public function setParameterCallback(param1:String, param2:int) : void
      {
         switch(param1)
         {
            case "hue":
               var_1235 = param2;
               break;
            case "saturation":
               var_1010 = param2;
               break;
            case "lightness":
               var_1227 = param2;
         }
         renderColorPreview();
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = class_3514(windowManager.buildFromXML(assets.getAssetByName("background_color_ui_xml").content as XML));
            _window.procedure = windowProcedure;
            _window.center();
            _sliders.push(new BackgroundColorWidgetSlider(this,"hue",IWindowContainer(_window.findChildByName("hue_container")),var_1235));
            _sliders.push(new BackgroundColorWidgetSlider(this,"saturation",IWindowContainer(_window.findChildByName("saturation_container")),var_1010));
            _sliders.push(new BackgroundColorWidgetSlider(this,"lightness",IWindowContainer(_window.findChildByName("lightness_container")),var_1227));
         }
      }
      
      private function destroyWindow() : void
      {
         for each(var _loc1_ in _sliders)
         {
            _loc1_.dispose();
         }
         _sliders = new Vector.<BackgroundColorWidgetSlider>();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function renderColorPreview() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("color_preview_bitmap"));
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,false);
         var _loc1_:uint = uint(ColorConverter.hslToRGB(((var_1235 & 255) << 16) + ((var_1010 & 255) << 8) + (var_1227 & 255)));
         _loc2_.fillRect(_loc2_.rect,_loc1_);
         _loc3_.bitmap = _loc2_;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param2 != null && param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "apply_button":
                  handler.container.connection.send(new SetRoomBackgroundColorDataComposer(var_603,var_1235,var_1010,var_1227));
                  break;
               case "on_off_button":
                  handler.container.connection.send(new UseFurnitureMessageComposer(var_603));
                  break;
               case "header_button_close":
                  destroyWindow();
            }
         }
      }
   }
}
