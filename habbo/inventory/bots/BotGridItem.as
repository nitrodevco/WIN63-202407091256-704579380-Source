package com.sulake.habbo.inventory.bots
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
   import com.sulake.habbo.communication.messages.parser.inventory.bots.class_1726;
   
   public class BotGridItem
   {
      
      private static const THUMB_COLOR_NORMAL:int = 13421772;
      
      private static const THUMB_COLOR_UNSEEN:int = 10275685;
       
      
      private var var_47:class_1726;
      
      private var _window:IWindowContainer;
      
      private var _assets:IAssetLibrary;
      
      private var var_2348:IWindow;
      
      private var var_3588:Boolean;
      
      private var var_1631:BotsView;
      
      private var var_3820:int = -1;
      
      private var var_3229:Boolean;
      
      private var _isUnseen:Boolean;
      
      public function BotGridItem(param1:BotsView, param2:class_1726, param3:IHabboWindowManager, param4:IAssetLibrary, param5:Boolean)
      {
         super();
         if(param1 == null || param2 == null || param3 == null || param4 == null)
         {
            return;
         }
         _assets = param4;
         var_1631 = param1;
         var_47 = param2;
         _isUnseen = param5;
         var _loc7_:XmlAsset;
         if((_loc7_ = param4.getAssetByName("inventory_thumb_xml") as XmlAsset) == null || _loc7_.content == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc7_.content as XML) as IWindowContainer;
         _window.procedure = eventHandler;
         var _loc6_:BitmapData = param1.getGridItemImage(param2);
         setImage(_loc6_);
         updateStatusGraphics();
      }
      
      public function dispose() : void
      {
         _assets = null;
         var_1631 = null;
         var_47 = null;
         var_2348 = null;
         var_3820 = -1;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function eventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case "WME_DOWN":
               var_1631.setSelectedGridItem(this);
               var_3229 = true;
               break;
            case "WME_UP":
               var_3229 = false;
               break;
            case "WME_OUT":
               if(var_3229)
               {
                  var_3229 = false;
                  var_1631.placeItemToRoom(var_47.id,true);
               }
         }
      }
      
      public function setImage(param1:BitmapData) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:IBitmapWrapperWindow = _window.findChildByName("bitmap") as IBitmapWrapperWindow;
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height);
         _loc2_.fillRect(_loc2_.rect,0);
         _loc2_.copyPixels(param1,param1.rect,new Point(_loc2_.width / 2 - param1.width / 2,_loc2_.height / 2 - param1.height / 2));
         if(_loc3_.bitmap)
         {
            _loc3_.bitmap.dispose();
         }
         _loc3_.bitmap = _loc2_;
      }
      
      public function setUnseen(param1:Boolean) : void
      {
         if(_isUnseen != param1)
         {
            _isUnseen = param1;
            updateStatusGraphics();
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         if(var_3588 != param1)
         {
            var_3588 = param1;
            if(!_window || !var_2348)
            {
               return;
            }
            updateStatusGraphics();
         }
      }
      
      private function updateStatusGraphics() : void
      {
         var _loc1_:IWindow = _window.findChildByName("outline");
         if(_loc1_ != null)
         {
            _loc1_.visible = var_3588;
         }
         if(!var_2348)
         {
            var_2348 = _window.findChildByTag("BG_COLOR");
         }
         var_2348.color = _isUnseen ? 10275685 : 13421772;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
      
      public function get data() : class_1726
      {
         return var_47;
      }
   }
}
