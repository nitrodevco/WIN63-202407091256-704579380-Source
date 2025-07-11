package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class CalendarArrowButton
   {
      
      public static const DIRECTION_BACK:int = 0;
      
      public static const const_904:int = 1;
      
      public static const STATE_INACTIVE:int = 0;
      
      public static const STATE_ACTIVE:int = 1;
      
      public static const STATE_HILITE:int = 2;
      
      private static const PRESSED_OFFSET_PIXELS:Point = new Point(1,1);
       
      
      private var _window:IBitmapWrapperWindow;
      
      private var _callback:Function;
      
      private var var_149:int = 0;
      
      private var _pressed:Boolean = false;
      
      private var var_3685:Point;
      
      private var var_3178:BitmapData;
      
      private var var_3125:BitmapData;
      
      private var var_3205:BitmapData;
      
      public function CalendarArrowButton(param1:IAssetLibrary, param2:IBitmapWrapperWindow, param3:int, param4:Function)
      {
         super();
         _window = param2;
         _window.procedure = procedure;
         _callback = param4;
         switch(param3)
         {
            case 0:
               var_3125 = BitmapData(param1.getAssetByName("arrow_back_active").content).clone();
               var_3178 = BitmapData(param1.getAssetByName("arrow_back_inactive").content).clone();
               var_3205 = BitmapData(param1.getAssetByName("arrow_back_hilite").content).clone();
               break;
            case 1:
               var_3125 = BitmapData(param1.getAssetByName("arrow_next_active").content).clone();
               var_3178 = BitmapData(param1.getAssetByName("arrow_next_inactive").content).clone();
               var_3205 = BitmapData(param1.getAssetByName("arrow_next_hilite").content).clone();
         }
         var_3685 = new Point(_window.x,_window.y);
         updateWindow();
      }
      
      public function dispose() : void
      {
         var_3125 = null;
         var_3205 = null;
         var_3178 = null;
         _window.procedure = null;
         _window = null;
         _callback = null;
      }
      
      public function activate() : void
      {
         if(var_149 != 1 && var_149 != 2)
         {
            var_149 = 1;
         }
         updateWindow();
      }
      
      public function deactivate() : void
      {
         var_149 = 0;
         updateWindow();
      }
      
      public function isInactive() : Boolean
      {
         return var_149 == 0;
      }
      
      private function updateWindow() : void
      {
         switch(var_149)
         {
            case 0:
               _window.bitmap = var_3178;
               break;
            case 1:
               _window.bitmap = var_3125;
               break;
            case 2:
               _window.bitmap = var_3205;
         }
         if(_pressed)
         {
            _window.x = var_3685.x + PRESSED_OFFSET_PIXELS.x;
            _window.y = var_3685.y + PRESSED_OFFSET_PIXELS.y;
         }
         else
         {
            _window.position = var_3685;
         }
      }
      
      private function procedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1 as WindowMouseEvent != null)
         {
            switch(param1.type)
            {
               case "WME_OVER":
                  if(var_149 != 0)
                  {
                     var_149 = 2;
                  }
                  break;
               case "WME_OUT":
                  if(var_149 != 0)
                  {
                     var_149 = 1;
                  }
                  break;
               case "WME_DOWN":
                  _pressed = true;
                  break;
               case "WME_UP":
               case "WME_UP_OUTSIDE":
                  _pressed = false;
            }
            updateWindow();
            _callback(param1,param2);
         }
      }
   }
}
