package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class OutfitView
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var _window:IWindowContainer;
      
      private var var_1743:IBitmapWrapperWindow;
      
      public function OutfitView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:Boolean)
      {
         super();
         _windowManager = param1;
         var_2286 = param2;
         var _loc4_:XmlAsset = var_2286.getAssetByName("Outfit") as XmlAsset;
         _window = IWindowContainer(_windowManager.buildFromXML(_loc4_.content as XML));
         if(_window != null)
         {
            var_1743 = _window.findChildByName("bitmap") as IBitmapWrapperWindow;
         }
         if(!param3)
         {
            _window.findChildByName("button").disable();
         }
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         var_2286 = null;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
         if(var_1743)
         {
            var_1743.dispose();
         }
         var_1743 = null;
      }
      
      public function update(param1:BitmapData) : void
      {
         var_1743.bitmap = new BitmapData(var_1743.width,var_1743.height,true,16777215);
         var _loc2_:int = (var_1743.width - param1.width) / 2;
         var _loc3_:int = var_1743.height - param1.height;
         var_1743.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type != "WME_CLICK")
         {
            if(param1.type == "WME_OVER")
            {
               _window.color = 13421772;
            }
            else if(param1.type == "WME_OUT")
            {
               _window.color = 6710886;
            }
         }
      }
   }
}
