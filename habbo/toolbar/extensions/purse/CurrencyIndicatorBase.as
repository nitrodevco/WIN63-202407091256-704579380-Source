package com.sulake.habbo.toolbar.extensions.purse
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.class_419;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CurrencyIndicatorBase implements class_3491
   {
      
      protected static const const_854:int = 0;
      
      protected static const const_579:int = 1;
      
      private static const const_1206:Number = 0.025;
       
      
      protected var _window:IWindowContainer;
      
      protected var _windowManager:IHabboWindowManager;
      
      protected var _assets:IAssetLibrary;
      
      private var _disposed:Boolean = false;
      
      private var var_3459:IStaticBitmapWrapperWindow;
      
      private var var_4652:uint;
      
      private var var_4528:uint;
      
      private var _textElementName:String;
      
      private var var_2027:Vector.<String>;
      
      private var var_4322:uint;
      
      private var var_4349:String = null;
      
      private var var_4247:uint = 0;
      
      private var _animOffset:int;
      
      private var var_2367:Timer;
      
      private var _overlayTimer:Timer;
      
      private var _overlayPhase:Number;
      
      private var _overlayStartValue:int;
      
      private var _overlayEndValue:int;
      
      public function CurrencyIndicatorBase(param1:IHabboWindowManager, param2:IAssetLibrary)
      {
         var_2027 = new Vector.<String>();
         super();
         _window = null;
         _windowManager = param1;
         _assets = param2;
         var_2367 = null;
         _overlayTimer = new Timer(40);
         _overlayTimer.addEventListener("timer",onOverlayTimer);
      }
      
      protected function set bgColorLight(param1:uint) : void
      {
         var_4652 = param1;
      }
      
      protected function set bgColorDark(param1:uint) : void
      {
         var_4528 = param1;
      }
      
      protected function set textElementName(param1:String) : void
      {
         _textElementName = param1;
      }
      
      protected function set iconAnimationDelay(param1:uint) : void
      {
         var_4322 = param1;
      }
      
      protected function set amountZeroText(param1:String) : void
      {
         var_4349 = param1;
      }
      
      protected function get amountZeroText() : String
      {
         return var_4349;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_overlayTimer != null)
         {
            _overlayTimer.stop();
            _overlayTimer = null;
         }
         if(var_2367)
         {
            var_2367.stop();
            var_2367 = null;
         }
         if(var_2027)
         {
            var_2027 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      protected function onContainerClick(param1:WindowMouseEvent) : void
      {
      }
      
      protected function createWindow(param1:String, param2:String) : void
      {
         var _loc4_:Array = null;
         var _loc3_:XmlAsset = _assets.getAssetByName(param1) as XmlAsset;
         if(_loc3_)
         {
            _window = _windowManager.buildFromXML(_loc3_.content as XML,1) as IWindowContainer;
            if(_window)
            {
               _window.addEventListener("WME_CLICK",onContainerClick);
               _window.addEventListener("WME_OVER",onContainerMouseOver);
               _window.addEventListener("WME_OUT",onContainerMouseOut);
               _loc4_ = [];
               if(_window.groupChildrenWithTag("ICON",_loc4_,-1) == 1)
               {
                  var_3459 = _loc4_[0] as IStaticBitmapWrapperWindow;
                  setIconBitmap(param2);
               }
            }
         }
      }
      
      protected function animateIcon(param1:int) : void
      {
         var_4247 = param1;
         if(var_3459 && var_2027.length > 0)
         {
            if(var_4247 == 0)
            {
               _animOffset = 0;
            }
            else
            {
               _animOffset = var_2027.length - 1;
            }
            var_2367 = new Timer(var_4322,var_2027.length);
            var_2367.addEventListener("timer",onAnimationTimer);
            var_2367.addEventListener("timerComplete",onAnimationTimerComplete);
            var_2367.start();
            onAnimationTimer(null);
         }
      }
      
      protected function setAmount(param1:int, param2:int = -1) : void
      {
         setText(param1.toString());
      }
      
      protected function setText(param1:String) : void
      {
         if(_window)
         {
            _window.findChildByName(_textElementName).caption = param1;
         }
      }
      
      protected function setTextUnderline(param1:Boolean) : void
      {
         if(_window)
         {
            ITextWindow(_window.findChildByName(_textElementName)).underline = param1;
         }
      }
      
      protected function set iconAnimationSequence(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            var_2027.push(_loc2_);
         }
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         if(var_3459 && var_2027.length > 0)
         {
            setIconBitmap(var_2027[_animOffset]);
            if(var_4247 == 0)
            {
               _animOffset++;
               _animOffset = _animOffset < var_2027.length ? _animOffset : var_2027.length - 1;
            }
            else
            {
               _animOffset--;
               _animOffset = _animOffset >= 0 ? _animOffset : 0;
            }
         }
      }
      
      private function onAnimationTimerComplete(param1:TimerEvent) : void
      {
         if(var_2027.length > 0)
         {
            setIconBitmap(var_2027[0]);
         }
      }
      
      private function setIconBitmap(param1:String) : void
      {
         if(var_3459)
         {
            var_3459.assetUri = param1;
         }
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = var_4652;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = var_4528;
      }
      
      protected function animateChange(param1:int, param2:int) : void
      {
         var _loc3_:IWindow = null;
         _overlayPhase = 0;
         _overlayStartValue = param1;
         _overlayEndValue = param2;
         if(_window != null)
         {
            _loc3_ = _window.findChildByName("change");
            if(_loc3_ != null)
            {
               _loc3_.caption = (param2 > param1 ? "+" : "") + (param2 - param1).toString();
            }
         }
         _overlayTimer.start();
         onOverlayTimer(null);
      }
      
      private function onOverlayTimer(param1:TimerEvent) : void
      {
         var _loc3_:Number = Math.pow(_overlayPhase - 0.5,3) * 4 + 0.5;
         setAmount(int(class_419.lerp(Math.max(0,_overlayPhase * 2 - 1),_overlayStartValue,_overlayEndValue)));
         var _loc2_:IWindowContainer = _window.findChildByName("change_overlay") as IWindowContainer;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         _loc2_.blend = 1 - Math.abs(0.5 - _loc3_) * 2;
         _loc2_.x = class_419.lerp(_loc3_,0,_window.width - _loc2_.width);
         _overlayPhase += 0.025;
         if(_overlayPhase >= 1)
         {
            _loc2_.visible = false;
            _overlayTimer.stop();
            setAmount(_overlayEndValue);
         }
      }
   }
}
