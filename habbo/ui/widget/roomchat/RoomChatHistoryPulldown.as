package com.sulake.habbo.ui.widget.roomchat
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomChatHistoryPulldown
   {
      
      public static const STATE_FADE_OUT:int = 3;
      
      public static const STATE_FADE_IN:int = 2;
      
      public static const STATE_VISIBLE:int = 1;
      
      public static const STATE_HIDDEN:int = 0;
      
      public static const PULLDOWN_WINDOW_HEIGHT:int = 39;
      
      private static const FADE_OUT_MS:int = 150;
      
      private static const FADE_IN_MS:int = 250;
       
      
      private var var_1629:RoomChatWidget;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _window:IWindowContainer;
      
      private var var_1726:IBitmapWrapperWindow;
      
      private var var_1675:IWindowContainer;
      
      private var var_1819:IRegionWindow;
      
      private var var_2286:IAssetLibrary;
      
      private var _lastWidth:int = 0;
      
      private var var_149:int = -1;
      
      private var var_4295:BitmapData;
      
      private var var_3993:BitmapData;
      
      private var var_4522:BitmapData;
      
      private var var_4007:BitmapData;
      
      private var var_4060:BitmapData;
      
      private var var_4659:BitmapData;
      
      private var var_4706:BitmapData;
      
      private var _regionRightMargin:int = 30;
      
      public function RoomChatHistoryPulldown(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IWindowContainer, param4:IAssetLibrary)
      {
         super();
         var_1629 = param1;
         _windowManager = param2;
         var_2286 = param4;
         var_1675 = param3;
         var_4295 = (var_2286.getAssetByName("chat_grapbar_bg") as BitmapDataAsset).content as BitmapData;
         var_3993 = (var_2286.getAssetByName("chat_grapbar_grip") as BitmapDataAsset).content as BitmapData;
         var_4522 = (var_2286.getAssetByName("chat_grapbar_handle") as BitmapDataAsset).content as BitmapData;
         var_4007 = (var_2286.getAssetByName("chat_grapbar_x") as BitmapDataAsset).content as BitmapData;
         var_4060 = (var_2286.getAssetByName("chat_grapbar_x_hi") as BitmapDataAsset).content as BitmapData;
         var_4659 = (var_2286.getAssetByName("chat_grapbar_x_pr") as BitmapDataAsset).content as BitmapData;
         var_4706 = (var_2286.getAssetByName("chat_history_bg") as BitmapDataAsset).content as BitmapData;
         var_1726 = _windowManager.createWindow("chat_history_bg","",21,0,16,new Rectangle(0,0,param3.width,param3.height - 39),null,0,0) as IBitmapWrapperWindow;
         var_1675.addChild(var_1726);
         _window = _windowManager.createWindow("chat_pulldown","",4,0,1 | 16,new Rectangle(0,var_1675.height - 39,param3.width,39),null,0) as IWindowContainer;
         var_1675.addChild(_window);
         var_1819 = _windowManager.createWindow("REGIONchat_pulldown","",5,0,1 | 16 | 0 | 0,new Rectangle(0,0,param3.width,param3.height - 39),null,0) as IRegionWindow;
         if(var_1819 != null)
         {
            var_1819.background = true;
            var_1819.mouseThreshold = 0;
            var_1819.addEventListener("WME_DOWN",onPulldownMouseDown);
            var_1675.addChild(var_1819);
            var_1819.toolTipCaption = "${chat.history.drag.tooltip}";
            var_1819.toolTipDelay = 250;
         }
         var _loc6_:XmlAsset = param4.getAssetByName("chat_history_pulldown") as XmlAsset;
         _window.buildFromXML(_loc6_.content as XML);
         _window.addEventListener("WME_DOWN",onPulldownMouseDown);
         var _loc5_:IBitmapWrapperWindow;
         if((_loc5_ = _window.findChildByName("GrapBarX") as IBitmapWrapperWindow) != null)
         {
            _loc5_.mouseThreshold = 0;
            _loc5_.addEventListener("WME_CLICK",onCloseButtonClicked);
            _loc5_.addEventListener("WME_UP",onCloseButtonMouseUp);
            _loc5_.addEventListener("WME_DOWN",onCloseButtonMouseDown);
            _loc5_.addEventListener("WME_OVER",onCloseButtonMouseOver);
            _loc5_.addEventListener("WME_OUT",onCloseButtonMouseOut);
         }
         _window.background = true;
         _window.color = 0;
         _window.mouseThreshold = 0;
         this.state = 0;
         buildWindowGraphics();
      }
      
      public function dispose() : void
      {
         if(var_1819 != null)
         {
            var_1819.dispose();
            var_1819 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1726 != null)
         {
            var_1726.dispose();
            var_1726 = null;
         }
      }
      
      public function update(param1:uint) : void
      {
         switch(state - 2)
         {
            case 0:
               var_1726.blend += param1 / 250;
               _window.blend += param1 / 250;
               if(_window.blend >= 1)
               {
                  state = 1;
               }
               break;
            case 1:
               var_1726.blend -= param1 / 150;
               _window.blend -= param1 / 150;
               if(_window.blend <= 0)
               {
                  state = 0;
                  break;
               }
         }
      }
      
      public function set state(param1:int) : void
      {
         if(param1 == var_149)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               if(_window == null || var_1726 == null)
               {
                  return;
               }
               _window.visible = false;
               var_1726.visible = false;
               var_1819.visible = false;
               var_149 = param1;
               break;
            case 1:
               if(var_149 == 0)
               {
                  this.state = 2;
               }
               else
               {
                  if(_window == null || var_1726 == null)
                  {
                     return;
                  }
                  _window.visible = true;
                  var_1726.visible = true;
                  var_1819.visible = true;
                  var_149 = param1;
               }
               break;
            case 2:
               if(_window == null || var_1726 == null)
               {
                  return;
               }
               _window.blend = 0;
               var_1726.blend = 0;
               _window.visible = true;
               var_1726.visible = true;
               var_149 = param1;
               break;
            case 3:
               if(_window == null || var_1726 == null)
               {
                  return;
               }
               _window.blend = 1;
               var_1726.blend = 1;
               var_149 = param1;
               break;
         }
      }
      
      public function get state() : int
      {
         return var_149;
      }
      
      public function containerResized(param1:Rectangle) : void
      {
         if(_window != null)
         {
            _window.x = 0;
            _window.y = var_1675.height - 39;
            _window.width = var_1675.width;
         }
         if(var_1819 != null)
         {
            var_1819.x = 0;
            var_1819.y = var_1675.height - 39;
            var_1819.width = var_1675.width - _regionRightMargin;
         }
         if(var_1726 != null)
         {
            var_1726.rectangle = var_1675.rectangle;
            var_1726.height -= 39;
         }
         buildWindowGraphics();
      }
      
      private function buildWindowGraphics() : void
      {
         var _loc12_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc5_:BitmapData = null;
         if(_window == null)
         {
            return;
         }
         if(_lastWidth == _window.width)
         {
            return;
         }
         _lastWidth = _window.width;
         var _loc6_:IBitmapWrapperWindow = _window.findChildByName("grapBarBg") as IBitmapWrapperWindow;
         var _loc8_:IBitmapWrapperWindow = _window.findChildByName("GrapBarX") as IBitmapWrapperWindow;
         var _loc1_:IBitmapWrapperWindow = _window.findChildByName("grapBarGripL") as IBitmapWrapperWindow;
         var _loc9_:IBitmapWrapperWindow = _window.findChildByName("grapBarGripR") as IBitmapWrapperWindow;
         var _loc4_:IBitmapWrapperWindow = _window.findChildByName("grapBarHandle") as IBitmapWrapperWindow;
         var _loc11_:int = 5;
         if(_loc8_ != null && _loc4_ != null)
         {
            _loc4_.bitmap = var_4522;
            _loc4_.disposesBitmap = false;
            _loc8_.bitmap = var_4007;
            _loc8_.disposesBitmap = false;
            _regionRightMargin = _window.width - _loc8_.x;
         }
         _loc1_.width = _loc4_.x - _loc11_;
         _loc1_.x = 0;
         _loc9_.x = _loc4_.x + _loc4_.width + _loc11_;
         _loc9_.width = _loc8_.x - _loc11_ - _loc9_.x;
         if(_loc1_.width < 0)
         {
            _loc1_.width = 0;
         }
         if(_loc9_.width < 0)
         {
            _loc9_.width = 0;
         }
         var _loc10_:int = 0;
         if(_loc6_ != null && _loc1_ != null && _loc9_ != null)
         {
            try
            {
               _loc10_ = 1;
               _loc2_ = int(_loc6_.width);
               _loc12_ = int(_loc6_.height);
               if(_loc2_ > 0 && _loc12_ > 0)
               {
                  _loc7_ = new TrackedBitmapData(this,_loc2_,_loc12_);
                  tileBitmapHorz(var_4295,_loc7_);
                  _loc6_.disposesBitmap = true;
                  _loc6_.bitmap = _loc7_;
               }
               _loc10_ = 2;
               _loc2_ = int(_loc1_.width);
               _loc12_ = int(_loc1_.height);
               if(_loc2_ > 0 && _loc12_ > 0)
               {
                  _loc3_ = new TrackedBitmapData(this,_loc2_,_loc12_);
                  tileBitmapHorz(var_3993,_loc3_);
                  _loc1_.disposesBitmap = true;
                  _loc1_.bitmap = _loc3_;
               }
               _loc10_ = 3;
               _loc2_ = int(_loc9_.width);
               _loc12_ = int(_loc9_.height);
               if(_loc2_ > 0 && _loc12_ > 0)
               {
                  _loc5_ = new TrackedBitmapData(this,_loc2_,_loc12_);
                  tileBitmapHorz(var_3993,_loc5_);
                  _loc9_.disposesBitmap = true;
                  _loc9_.bitmap = _loc5_;
               }
            }
            catch(e:Error)
            {
               throw new Error(e.message + " width:" + _loc2_ + " height:" + _loc12_ + " state:" + _loc10_,e.errorID);
            }
         }
         if(var_1726 == null)
         {
            return;
         }
         var_1726.bitmap = var_4706;
         var_1726.disposesBitmap = false;
      }
      
      private function tileBitmapHorz(param1:BitmapData, param2:BitmapData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param2.width / param1.width;
         var _loc5_:Point = new Point();
         _loc4_ = 0;
         while(_loc4_ < _loc3_ + 1)
         {
            _loc5_.x = _loc4_ * param1.width;
            param2.copyPixels(param1,param1.rect,_loc5_);
            _loc4_++;
         }
      }
      
      private function onPulldownMouseDown(param1:WindowMouseEvent) : void
      {
         if(var_1629 != null)
         {
            var_1629.onPulldownMouseDown(param1);
         }
      }
      
      private function onCloseButtonClicked(param1:WindowMouseEvent) : void
      {
         if(var_1629 != null)
         {
            var_1629.onPulldownCloseButtonClicked(param1);
         }
      }
      
      private function onCloseButtonMouseOver(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("GrapBarX") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_4060;
         }
      }
      
      private function onCloseButtonMouseOut(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("GrapBarX") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_4007;
         }
      }
      
      private function onCloseButtonMouseDown(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("GrapBarX") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_4659;
         }
      }
      
      private function onCloseButtonMouseUp(param1:WindowMouseEvent) : void
      {
         if(_window == null)
         {
            return;
         }
         if(!_window.visible)
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("GrapBarX") as IBitmapWrapperWindow;
         if(_loc2_ != null)
         {
            _loc2_.disposesBitmap = false;
            _loc2_.bitmap = var_4060;
         }
      }
   }
}
