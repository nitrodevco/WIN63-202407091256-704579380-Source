package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3460;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ContextInfoView implements IDisposable
   {
      
      protected static const CONTEXT_INFO_DELAY:uint = 3000;
      
      protected static const BUTTON_COLOR_DEFAULT:uint = 4281149991;
      
      protected static const BUTTON_COLOR_HOVER:uint = 4282950861;
      
      protected static const const_1171:uint = 4288230144;
      
      protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 16777215;
      
      protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
      
      protected static const const_639:uint = 16777215;
      
      protected static const const_1096:uint = 5789011;
      
      protected static const ICON_COLOR_ENABLED:uint = 13947341;
      
      protected static const ICON_COLOR_DISABLED:uint = 5789011;
      
      private static const const_786:int = 25;
      
      public static const const_461:int = 3;
      
      protected static var var_1974:Boolean = false;
       
      
      protected var _window:IWindowContainer;
      
      protected var var_2111:IWindowContainer;
      
      protected var var_1701:IWindowContainer;
      
      private var _forcedPositionUpdate:Boolean;
      
      protected var var_1629:class_3386;
      
      protected var var_1762:Boolean;
      
      protected var var_3107:FixedSizeStack;
      
      protected var var_3364:int = -1000000;
      
      protected var _disposed:Boolean = false;
      
      private var _forceActivateOnUpdate:Boolean = true;
      
      protected var var_2330:Timer;
      
      protected var var_4076:int = 3000;
      
      protected var var_3571:Boolean;
      
      protected var var_3515:Boolean;
      
      protected var var_2314:Number;
      
      protected var _fadeTime:int;
      
      protected var _fadeLength:int = 500;
      
      protected var var_1782:Boolean;
      
      public function ContextInfoView(param1:class_3386)
      {
         var_3107 = new FixedSizeStack(25);
         super();
         var_1629 = param1;
         var_1782 = true;
         var_3571 = false;
         var_3515 = false;
      }
      
      public static function setupContext(param1:ContextInfoView) : void
      {
         param1.var_3571 = false;
         param1._fadeLength = 500;
         param1.var_3515 = false;
         param1.var_2314 = 1;
         if(param1.var_1782)
         {
            if(!param1.var_2330)
            {
               param1.var_2330 = new Timer(param1.var_4076,1);
               param1.var_2330.addEventListener("timerComplete",param1.onTimerComplete);
            }
            param1.var_2330.reset();
            param1.var_2330.start();
         }
         param1.updateWindow();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get maximumBlend() : Number
      {
         return 1;
      }
      
      public function dispose() : void
      {
         var_1629 = null;
         var_1701 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2111)
         {
            var_2111.dispose();
            var_2111 = null;
         }
         if(var_2330)
         {
            var_2330.removeEventListener("timerComplete",onTimerComplete);
            var_2330.reset();
            var_2330 = null;
         }
         _disposed = true;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         var_3515 = true;
         _fadeTime = 0;
         hide(true);
      }
      
      protected function addMouseClickListener(param1:IWindow, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      protected function updateWindow() : void
      {
      }
      
      protected function clickHandler(param1:WindowMouseEvent) : void
      {
         var_1629.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE"));
         var_1629.removeView(this,false);
      }
      
      public function setImageAsset(param1:IBitmapWrapperWindow, param2:String, param3:Boolean = false) : void
      {
         var _loc6_:Point = null;
         if(!param1 || !var_1629 || !var_1629.assets)
         {
            return;
         }
         var _loc5_:BitmapDataAsset;
         if(!(_loc5_ = var_1629.assets.getAssetByName(param2) as BitmapDataAsset))
         {
            return;
         }
         var _loc4_:BitmapData;
         if(!(_loc4_ = _loc5_.content as BitmapData))
         {
            return;
         }
         if(param1.bitmap)
         {
            param1.bitmap.fillRect(param1.bitmap.rect,0);
         }
         else
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
         if(param3)
         {
            _loc6_ = new Point((param1.bitmap.width - _loc4_.width) / 2,(param1.bitmap.height - _loc4_.height) / 2);
         }
         else
         {
            _loc6_ = new Point(0,0);
         }
         param1.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc6_,null,null,true);
         param1.invalidate();
      }
      
      public function show() : void
      {
         if(var_1701 != null)
         {
            var_1701.visible = true;
            if(!(var_1701.parent is class_3460))
            {
               var_1629.windowManager.getDesktop(0).addChild(var_1701);
            }
            if(_forceActivateOnUpdate)
            {
               var_1701.activate();
            }
         }
      }
      
      public function hide(param1:Boolean) : void
      {
         if(var_1701 != null)
         {
            if(!var_3571 && param1)
            {
               var_3571 = true;
               var_2330.start();
            }
            else
            {
               var_1701.visible = false;
               var_1701.parent = null;
            }
         }
      }
      
      protected function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -var_1701.height;
         return _loc2_ - 4;
      }
      
      public function update(param1:Rectangle, param2:Point, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!param1)
         {
            return;
         }
         if(!var_1701)
         {
            updateWindow();
         }
         if(var_3515)
         {
            _fadeTime += param3;
            var_2314 = (1 - _fadeTime / _fadeLength) * maximumBlend;
         }
         else
         {
            var_2314 = maximumBlend;
         }
         if(var_2314 <= 0)
         {
            var_1629.removeView(this,false);
            return;
         }
         if(!var_1762 || _forcedPositionUpdate)
         {
            _loc4_ = getOffset(param1);
            _loc5_ = param2.y - param1.top;
            var_3107.addValue(_loc5_);
            if((_loc6_ = var_3107.getMax()) < var_3364 - 3)
            {
               _loc6_ = var_3364 - 3;
            }
            _loc7_ = param2.y - _loc6_;
            var_3364 = _loc6_;
            var_1701.x = param2.x - var_1701.width / 2;
            var_1701.y = _loc7_ + _loc4_;
            _forcedPositionUpdate = false;
         }
         var_1701.blend = var_2314;
         show();
      }
      
      protected function onMouseHoverEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OVER")
         {
            var_1762 = true;
         }
         else if(param1.type == "WME_OUT")
         {
            if(!param1.window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               var_1762 = false;
            }
         }
      }
      
      protected function setMinimized(param1:Boolean) : void
      {
         var_1974 = param1;
         _forcedPositionUpdate = true;
         updateWindow();
      }
      
      protected function getMinimizedView() : IWindowContainer
      {
         var _loc1_:XML = null;
         if(!var_2111)
         {
            _loc1_ = XmlAsset(var_1629.assets.getAssetByName("minimized_menu")).content as XML;
            var_2111 = var_1629.windowManager.buildFromXML(_loc1_,0) as IWindowContainer;
            var_2111.findChildByName("minimize").addEventListener("WME_CLICK",onMaximize);
            var_2111.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
            var_2111.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            var_2111.addEventListener("WME_OVER",onMouseHoverEvent);
            var_2111.addEventListener("WME_OUT",onMouseHoverEvent);
         }
         return var_2111;
      }
      
      private function onMaximize(param1:WindowMouseEvent) : void
      {
         setMinimized(false);
      }
      
      protected function set activeView(param1:IWindowContainer) : void
      {
         if(!param1)
         {
            return;
         }
         if(var_1701)
         {
            var_1701.parent = null;
         }
         var_1701 = param1;
      }
      
      protected function onMinimize(param1:WindowMouseEvent) : void
      {
         setMinimized(true);
      }
      
      protected function onMinimizeHover(param1:WindowMouseEvent) : void
      {
         var _loc3_:IWindow = null;
         var _loc2_:IWindowContainer = param1.window as IWindowContainer;
         if(_loc2_)
         {
            _loc3_ = _loc2_.findChildByName("icon");
            if(_loc3_)
            {
               if(param1.type == "WME_OVER")
               {
                  _loc3_.color = 4282950861;
               }
               else
               {
                  _loc3_.color = 16777215;
               }
            }
         }
      }
      
      public function set forceActivateOnUpdate(param1:Boolean) : void
      {
         _forceActivateOnUpdate = param1;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
   }
}
