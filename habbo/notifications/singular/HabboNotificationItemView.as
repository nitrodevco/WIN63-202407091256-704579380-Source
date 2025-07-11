package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class HabboNotificationItemView implements IUpdateReceiver
   {
      
      public static const ITEM_HEIGHT:int = 70;
      
      public static const SIDE_MARGIN:int = 5;
      
      private static const STATE_IDLE:int = 0;
      
      private static const STATE_FADE_IN:int = 1;
      
      private static const STATE_DISPLAY:int = 2;
      
      private static const STATE_FADE_OUT:int = 3;
       
      
      private var _window:IWindow;
      
      private var var_325:HabboNotificationItem;
      
      private var _hovering:Boolean = false;
      
      private var _styleConfig:Map;
      
      private var _viewConfig:Map;
      
      private var var_3216:uint;
      
      private var var_3208:uint;
      
      private var var_3337:uint;
      
      private var _margin:int;
      
      private var var_2314:Number;
      
      private var _resizeMargin:int;
      
      private var var_4204:int;
      
      private var var_149:int;
      
      public function HabboNotificationItemView(param1:IAsset, param2:IHabboWindowManager, param3:Map, param4:Map, param5:HabboNotificationItem)
      {
         super();
         _styleConfig = param3;
         _viewConfig = param4;
         var _loc6_:XmlAsset;
         if((_loc6_ = param1 as XmlAsset) == null)
         {
            return;
         }
         _window = param2.buildFromXML(_loc6_.content as XML,1);
         _window.tags.push("notificationview");
         _window.context.getDesktopWindow().addEventListener("WE_RESIZED",onRoomViewResized);
         _window.procedure = onWindowEvent;
         _window.blend = 0;
         _window.visible = false;
         var _loc7_:ITextWindow;
         if((_loc7_ = IWindowContainer(_window).findChildByTag("notification_text") as ITextWindow) != null)
         {
            _resizeMargin = _window.height - _loc7_.bottom;
         }
         else
         {
            _resizeMargin = 15;
         }
         var_4204 = _window.height;
         _margin = 4;
         var_2314 = 0;
         var_149 = 0;
         showItem(param5);
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get ready() : Boolean
      {
         return var_149 == 0;
      }
      
      public function get verticalPosition() : int
      {
         return _margin;
      }
      
      private function showItem(param1:HabboNotificationItem) : void
      {
         var _loc2_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:String = param1.content;
         setNotificationText(_loc3_);
         if(param1.style.iconAssetUri == null)
         {
            _loc2_ = param1.style.icon;
            setNotificationIcon(_loc2_);
         }
         else
         {
            IStaticBitmapWrapperWindow(IWindowContainer(_window).findChildByTag("notification_icon_static")).assetUri = param1.style.iconAssetUri;
         }
         var_325 = param1;
         reposition();
         startFadeIn();
      }
      
      public function replaceIcon(param1:BadgeImageReadyEvent) : void
      {
         if(param1.badgeId != var_325.style.iconSrc)
         {
            return;
         }
         if(param1.badgeImage != null)
         {
            setNotificationIcon(param1.badgeImage);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         switch(var_149)
         {
            case 0:
               break;
            case 1:
               var_3216 += param1;
               _loc2_ = var_3216 / Number(_viewConfig["time_fade_in"]);
               if(var_3216 > int(_viewConfig["time_fade_in"]))
               {
                  startDisplay();
               }
               adjustBlend(_loc2_);
               break;
            case 2:
               var_3337 += param1;
               if(var_3337 > int(_viewConfig["time_display"]) && !_hovering)
               {
                  startFadeOut();
               }
               break;
            case 3:
               var_3208 += param1;
               _loc3_ = 1 - var_3208 / Number(_viewConfig["time_fade_out"]);
               adjustBlend(_loc3_);
               if(var_3208 > int(_viewConfig["time_fade_in"]))
               {
                  startIdling();
                  break;
               }
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(var_325 != null)
         {
            var_325.dispose();
            var_325 = null;
         }
      }
      
      private function setNotificationText(param1:String) : void
      {
         var _loc2_:ITextWindow = IWindowContainer(_window).findChildByTag("notification_text") as ITextWindow;
         if(_loc2_ == null || param1 == null)
         {
            return;
         }
         _window.height = 0;
         _loc2_.text = param1;
         _loc2_.height = _loc2_.textHeight + _resizeMargin;
         if(_window.height < var_4204)
         {
            _window.height = var_4204;
         }
      }
      
      private function setNotificationIcon(param1:BitmapData) : void
      {
         var _loc6_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IBitmapWrapperWindow;
         if((_loc4_ = IWindowContainer(_window).findChildByTag("notification_icon") as IBitmapWrapperWindow) == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc4_.bitmap = null;
            return;
         }
         if(param1.width < _loc4_.width && param1.height < _loc4_.height)
         {
            _loc6_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc2_ = (_loc4_.width - param1.width) / 2;
            _loc3_ = (_loc4_.height - param1.height) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
         }
         else if(param1.width < param1.height)
         {
            _loc6_ = new BitmapData(param1.height,param1.height,true,0);
            _loc5_ = (param1.height - param1.width) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(_loc5_,0));
         }
         else if(param1.width > param1.height)
         {
            _loc6_ = new BitmapData(param1.width,param1.width,true,0);
            _loc5_ = (param1.width - param1.height) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(0,_loc5_));
         }
         else
         {
            (_loc6_ = new BitmapData(param1.width,param1.height)).copyPixels(param1,param1.rect,new Point(0,0));
         }
         _loc4_.bitmap = _loc6_;
      }
      
      private function startFadeIn() : void
      {
         var_3216 = 0;
         var_149 = 1;
         _window.visible = true;
      }
      
      private function startFadeOut() : void
      {
         var_3208 = 0;
         var_149 = 3;
      }
      
      private function startDisplay() : void
      {
         var_3337 = 0;
         var_149 = 2;
      }
      
      private function startIdling() : void
      {
         var_149 = 0;
         _window.visible = false;
      }
      
      public function reposition(param1:int = -1) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:class_3460 = _window.context.getDesktopWindow();
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 != -1)
         {
            _margin = param1;
         }
         _window.x = _loc2_.width - _window.width - 5;
         _window.y = _margin;
      }
      
      public function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "WME_OVER")
         {
            _hovering = true;
         }
         else if(param1.type == "WME_OUT")
         {
            _hovering = false;
         }
         else if(param1.type == "WME_CLICK")
         {
            if(var_325 != null)
            {
               var_325.ExecuteUiLinks();
               startFadeOut();
            }
         }
      }
      
      private function onRoomViewResized(param1:WindowEvent) : void
      {
         reposition();
      }
      
      private function adjustBlend(param1:Number) : void
      {
         var_2314 = param1;
         if(var_2314 > 1)
         {
            var_2314 = 1;
         }
         if(var_2314 < 0)
         {
            var_2314 = 0;
         }
         _window.blend = var_2314;
      }
   }
}
