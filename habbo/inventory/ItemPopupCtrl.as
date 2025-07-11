package com.sulake.habbo.inventory
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.*;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import adobe.serialization.json.JSONDecoder;
   
   public class ItemPopupCtrl
   {
      
      public static const const_1059:int = 1;
      
      public static const LOCATION_RIGHT:int = 2;
      
      private static const BOUNDS_MARGIN:int = -5;
      
      private static const OPEN_DELAY_MS:int = 250;
      
      private static const CLOSE_DELAY_MS:int = 100;
      
      private static const IMAGE_MAX_WIDTH:int = 180;
      
      private static const IMAGE_MAX_HEIGHT:int = 200;
       
      
      private var var_2122:Timer;
      
      private var _hideDelayTimer:Timer;
      
      private var _assets:IAssetLibrary;
      
      private var var_1698:IWindowContainer;
      
      private var _parent:IWindowContainer;
      
      private var var_4134:int = 2;
      
      private var var_2564:BitmapData;
      
      private var var_2893:BitmapData;
      
      private var var_1635:TradingModel;
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_3312:Boolean = false;
      
      public function ItemPopupCtrl(param1:IWindowContainer, param2:IAssetLibrary, param3:IHabboWindowManager, param4:TradingModel)
      {
         var_2122 = new Timer(250,1);
         _hideDelayTimer = new Timer(100,1);
         super();
         if(param1 == null || param2 == null)
         {
            throw new Error("Null pointers passed as argument!");
         }
         var_1698 = param1;
         var_1698.visible = false;
         _assets = param2;
         _windowManager = param3;
         var_2122.addEventListener("timer",onDisplayTimer);
         _hideDelayTimer.addEventListener("timer",onHideTimer);
         var_1635 = param4;
         var _loc5_:BitmapDataAsset;
         if((_loc5_ = _assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset) != null && _loc5_.content != null)
         {
            var_2893 = _loc5_.content as BitmapData;
         }
         if((_loc5_ = _assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset) != null && _loc5_.content != null)
         {
            var_2564 = _loc5_.content as BitmapData;
         }
      }
      
      public function dispose() : void
      {
         if(var_2122 != null)
         {
            var_2122.removeEventListener("timer",onDisplayTimer);
            var_2122.stop();
            var_2122 = null;
         }
         if(_hideDelayTimer != null)
         {
            _hideDelayTimer.removeEventListener("timer",onHideTimer);
            _hideDelayTimer.stop();
            _hideDelayTimer = null;
         }
         _assets = null;
         var_1698 = null;
         _parent = null;
         var_2564 = null;
         var_2893 = null;
      }
      
      public function updateContent(param1:IWindowContainer, param2:String, param3:BitmapData, param4:IStuffData = null, param5:int = 2, param6:Boolean = false) : void
      {
         var _loc14_:String = null;
         var _loc12_:String = null;
         var _loc10_:String = null;
         var _loc8_:BitmapData = null;
         var _loc11_:ILimitedItemPreviewOverlayWidget = null;
         if(var_1698 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         if(param3 == null)
         {
            param3 = new BitmapData(1,1,true,16777215);
         }
         if(_parent != null)
         {
            _parent.removeChild(var_1698);
         }
         _parent = param1;
         var_4134 = param5;
         var_3312 = false;
         var _loc13_:ITextWindow;
         if(_loc13_ = ITextWindow(var_1698.findChildByName("item_name_text")))
         {
            _loc13_.text = param2;
         }
         var _loc7_:IWidgetWindow = IWidgetWindow(var_1698.findChildByName("unique_item_overlay_widget"));
         var _loc9_:IBitmapWrapperWindow;
         if(_loc9_ = var_1698.findChildByName("item_image") as IBitmapWrapperWindow)
         {
            if(param6 && var_1635)
            {
               _loc7_.visible = false;
               _loc9_.bitmap = new BitmapData(1,1,true,16777215);
               if(param4 != null)
               {
                  var_3312 = true;
                  _loc14_ = String(param4.getJSONValue("id"));
                  if(!StringUtil.isBlank(_loc14_))
                  {
                     loadExtraData(_loc14_);
                  }
                  else
                  {
                     _loc12_ = String(param4.getJSONValue("w"));
                     if(!StringUtil.isBlank(_loc12_))
                     {
                        _loc10_ = var_1635.getInventory().getProperty("stories.image_url_base") + _loc12_;
                        loadImage(_loc10_);
                     }
                  }
               }
               return;
            }
            (_loc8_ = new BitmapData(Math.min(180,param3.width),Math.min(200,param3.height),true,16777215)).copyPixels(param3,new Rectangle(0,0,_loc8_.width,_loc8_.height),new Point(0,0),null,null,true);
            _loc9_.bitmap = _loc8_;
            _loc9_.width = _loc9_.bitmap.width;
            _loc9_.height = _loc9_.bitmap.height;
            _loc9_.x = (var_1698.width - _loc9_.width) / 2;
            var_1698.height = _loc9_.bottom + 10;
         }
         if(param4 != null && param4.uniqueSerialNumber > 0)
         {
            (_loc11_ = ILimitedItemPreviewOverlayWidget(_loc7_.widget)).serialNumber = param4.uniqueSerialNumber;
            _loc11_.seriesSize = param4.uniqueSeriesSize;
         }
         else
         {
            _loc7_.visible = false;
         }
      }
      
      private function loadExtraData(param1:String) : void
      {
         var _loc3_:String = var_1635.getInventory().getProperty("extra_data_service_url") + param1;
         var _loc2_:URLLoader = new URLLoader(new URLRequest(_loc3_));
         _loc2_.addEventListener("complete",onExtraDataLoaded);
      }
      
      private function onExtraDataLoaded(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = String(URLLoader(param1.target).data);
         if(var_3312 && !StringUtil.isBlank(_loc3_))
         {
            try
            {
               _loc2_ = new JSONDecoder(_loc3_,false).getValue();
               loadImage(_loc2_.url);
            }
            catch(error:Error)
            {
            }
         }
      }
      
      private function loadImage(param1:String) : void
      {
         var _loc2_:BitmapFileLoader = null;
         if(!StringUtil.isBlank(param1))
         {
            _loc2_ = new BitmapFileLoader("image/png",new URLRequest(param1));
            _loc2_.addEventListener("AssetLoaderEventComplete",onExtImageLoaded);
         }
      }
      
      private function onExtImageLoaded(param1:AssetLoaderEvent) : void
      {
         if(!var_1698 || !var_3312)
         {
            return;
         }
         var _loc4_:IBitmapWrapperWindow;
         if(!(_loc4_ = var_1698.findChildByName("item_image") as IBitmapWrapperWindow) || _assets == null)
         {
            return;
         }
         var _loc6_:DisplayObject = BitmapFileLoader(param1.target).content as DisplayObject;
         var _loc2_:BitmapData = new BitmapData(Math.min(180,_loc6_.width),Math.min(200,_loc6_.height),true,16777215);
         var _loc3_:Number = 180 / _loc6_.width;
         var _loc5_:Matrix;
         (_loc5_ = new Matrix()).scale(_loc3_,_loc3_);
         _loc2_.draw(_loc6_,_loc5_);
         _loc4_.bitmap = _loc2_;
         _loc4_.width = _loc4_.bitmap.width;
         _loc4_.height = _loc4_.bitmap.height;
         _loc4_.x = (var_1698.width - _loc4_.width) / 2;
         var_1698.height = _loc4_.bottom + 10;
      }
      
      public function show() : void
      {
         _hideDelayTimer.reset();
         var_2122.reset();
         if(_parent == null)
         {
            return;
         }
         var_1698.visible = true;
         _parent.addChild(var_1698);
         refreshArrow(var_4134);
         switch(var_4134 - 1)
         {
            case 0:
               var_1698.x = -1 * var_1698.width - -5;
               break;
            case 1:
               var_1698.x = _parent.width + -5;
         }
         var_1698.y = (_parent.height - var_1698.height) / 2;
      }
      
      public function hide() : void
      {
         var_1698.visible = false;
         _hideDelayTimer.reset();
         var_2122.reset();
         if(_parent != null)
         {
            _parent.removeChild(var_1698);
         }
      }
      
      public function showDelayed() : void
      {
         _hideDelayTimer.reset();
         var_2122.reset();
         var_2122.start();
      }
      
      public function hideDelayed() : void
      {
         _hideDelayTimer.reset();
         var_2122.reset();
         _hideDelayTimer.start();
      }
      
      private function refreshArrow(param1:int = 2) : void
      {
         if(var_1698 == null || Boolean(var_1698.disposed))
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(var_1698.findChildByName("arrow_pointer"));
         if(!_loc2_)
         {
            return;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc2_.bitmap = var_2893.clone();
               _loc2_.width = var_2893.width;
               _loc2_.height = var_2893.height;
               _loc2_.y = (var_1698.height - var_2893.height) / 2;
               _loc2_.x = var_1698.width - 1;
               break;
            case 1:
               _loc2_.bitmap = var_2564.clone();
               _loc2_.width = var_2564.width;
               _loc2_.height = var_2564.height;
               _loc2_.y = (var_1698.height - var_2564.height) / 2;
               _loc2_.x = -1 * var_2564.width + 1;
         }
         _loc2_.invalidate();
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         show();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         hide();
      }
   }
}
