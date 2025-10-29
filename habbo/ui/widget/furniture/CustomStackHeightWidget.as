package com.sulake.habbo.ui.widget.furniture
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_3586;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetCustomStackingHeightComposer;
   
   public class CustomStackHeightWidget extends RoomWidgetBase
   {
      
      private static const SLIDER_RANGE:int = 10;
      
      private static const MAX_HEIGHT:int = 80;
      
      private static const SLIDER_BUTTON_WIDTH:int = 20;
       
      
      private var _window:IWindowContainer;
      
      private var var_603:int;
      
      public function CustomStackHeightWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
         class_3586(param1).widget = this;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      override public function get mainWindow() : IWindow
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = IWindowContainer(windowManager.buildFromXML(XML(assets.getAssetByName("custom_stack_height_xml").content)));
            _window.procedure = windowProcedure;
            _window.center();
         }
      }
      
      public function open(param1:int, param2:Number) : void
      {
         var_603 = param1;
         param2 = Math.min(param2,80);
         if(_window == null)
         {
            createWindow();
         }
         _window.findChildByName("input_height").caption = param2.toString();
         updateSlider();
         _window.visible = true;
      }
      
      public function hide() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            _window.procedure = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_floor_level":
                  altitude = 0;
                  sendCurrentHeight();
                  break;
               case "button_above_stack":
                  handler.container.connection.send(new SetCustomStackingHeightComposer(var_603));
                  break;
               case "header_button_close":
                  destroyWindow();
                  break;
               case "slider":
                  _window.findChildByName("slider_button").x = WindowMouseEvent(param1).localX;
                  sendCurrentHeight();
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            var _loc3_:* = param2.name;
            if("slider_button" === _loc3_)
            {
               sendCurrentHeight();
            }
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               updateHeightSelection(true);
               sendCurrentHeight();
            }
         }
         else if(param1.type == "WE_RELOCATED")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               updateHeightSelection();
            }
         }
         else if(param1.type == "WKE_KEY_DOWN")
         {
            if(param2.name == "input_height")
            {
               if(WindowKeyboardEvent(param1).keyCode == 13)
               {
                  updateSlider();
                  sendCurrentHeight();
               }
            }
         }
      }
      
      private function sendCurrentHeight() : void
      {
         var _loc1_:int = parseFloat(_window.findChildByName("input_height").caption) * 100;
         handler.container.connection.send(new SetCustomStackingHeightComposer(var_603,_loc1_));
      }
      
      private function updateSlider() : void
      {
         var _loc3_:Number = parseFloat(_window.findChildByName("input_height").caption);
         var _loc1_:Number = _loc3_ / 10;
         _loc1_ = Math.min(_loc1_,1);
         var _loc2_:Number = _window.findChildByName("slider").width - 20;
         _window.procedure = null;
         _window.findChildByName("slider_button").x = _loc2_ * _loc1_;
         _window.procedure = windowProcedure;
      }
      
      private function updateHeightSelection(param1:Boolean = false) : void
      {
         var _loc4_:int = param1 ? 1 : 100;
         var _loc3_:Number = _window.findChildByName("slider").width - 20;
         var _loc2_:Number = _window.findChildByName("slider_button").x / _loc3_;
         var _loc5_:Number = _loc2_ * 10 * _loc4_;
         _window.findChildByName("input_height").caption = (int(_loc5_) / (_loc4_ * 1)).toString();
      }
      
      private function get handler() : class_3586
      {
         return var_1653 as class_3586;
      }
      
      private function set altitude(param1:Number) : void
      {
         if(_window != null)
         {
            _window.findChildByName("input_height").caption = param1.toString();
            updateSlider();
         }
      }
      
      public function updateHeight(param1:int, param2:Number) : void
      {
         if(var_603 == param1)
         {
            altitude = param2;
         }
      }
   }
}
