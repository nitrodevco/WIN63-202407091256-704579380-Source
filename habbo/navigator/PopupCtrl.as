package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class PopupCtrl
   {
       
      
      private var _navigator:HabboNavigator;
      
      private var _xmlFileName:String;
      
      private var var_4472:int;
      
      private var var_4642:int;
      
      private var var_2211:Timer;
      
      private var _hideTimer:Timer;
      
      private var _popup:IWindowContainer;
      
      public function PopupCtrl(param1:HabboNavigator, param2:int, param3:int, param4:String)
      {
         var_2211 = new Timer(500,1);
         _hideTimer = new Timer(100,1);
         super();
         _navigator = param1;
         _xmlFileName = param4;
         var_4472 = param2;
         var_4642 = param3;
         var_2211.addEventListener("timer",onDisplayTimer);
         _hideTimer.addEventListener("timer",onHideTimer);
      }
      
      public function get navigator() : HabboNavigator
      {
         return _navigator;
      }
      
      public function dispose() : void
      {
         _navigator = null;
         if(var_2211)
         {
            var_2211.removeEventListener("timer",onDisplayTimer);
            var_2211.reset();
            var_2211 = null;
         }
         if(_hideTimer)
         {
            _hideTimer.removeEventListener("timer",onHideTimer);
            _hideTimer.reset();
            _hideTimer = null;
         }
      }
      
      public function showPopup(param1:IWindow) : void
      {
         if(_popup == null)
         {
            _popup = IWindowContainer(_navigator.getXmlWindow(_xmlFileName));
            _popup.visible = false;
            _popup.setParamFlag(1,true);
            _popup.procedure = onPopup;
         }
         Util.hideChildren(_popup);
         refreshContent(_popup);
         _popup.height = Util.getLowestPoint(_popup) + 5;
         var _loc2_:Point = new Point();
         param1.getGlobalPosition(_loc2_);
         _popup.x = _loc2_.x + var_4472 + param1.width;
         _popup.y = _loc2_.y - _popup.height * 0.5 + param1.height * 0.5;
         var _loc3_:Point = new Point();
         _popup.getGlobalPosition(_loc3_);
         if(_loc3_.x + _popup.width > _popup.desktop.width)
         {
            _popup.x = -_popup.width + _loc2_.x + var_4642;
            refreshPopupArrows(_popup,false);
         }
         else
         {
            refreshPopupArrows(_popup,true);
         }
         if(!_popup.visible)
         {
            var_2211.reset();
            var_2211.start();
         }
         _hideTimer.reset();
         _popup.activate();
      }
      
      public function closePopup() : void
      {
         _hideTimer.reset();
         var_2211.reset();
         _hideTimer.start();
      }
      
      private function refreshPopupArrows(param1:IWindowContainer, param2:Boolean) : void
      {
         refreshPopupArrow(param1,true,param2);
         refreshPopupArrow(param1,false,!param2);
      }
      
      private function refreshPopupArrow(param1:IWindowContainer, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = "popup_arrow_" + (param2 ? "left" : "right");
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName(_loc4_));
         if(!param3)
         {
            if(_loc5_ != null)
            {
               _loc5_.visible = false;
            }
         }
         else
         {
            if(_loc5_ == null)
            {
               (_loc5_ = _navigator.getButton(_loc4_,_loc4_,null)).setParamFlag(16,false);
               param1.addChild(_loc5_);
            }
            _loc5_.visible = true;
            _loc5_.y = param1.height * 0.5 - _loc5_.height * 0.5;
            _loc5_.x = param2 ? 1 - _loc5_.width : param1.width - 1;
         }
      }
      
      private function onDisplayTimer(param1:TimerEvent) : void
      {
         this._popup.visible = true;
         this._popup.activate();
      }
      
      private function onHideTimer(param1:TimerEvent) : void
      {
         if(_popup != null)
         {
            _popup.visible = false;
         }
      }
      
      public function hideInstantly() : void
      {
         if(_popup != null)
         {
            _popup.visible = false;
         }
         this.var_2211.reset();
         this._hideTimer.reset();
      }
      
      public function get visible() : Boolean
      {
         return this._popup != null && Boolean(this._popup.visible);
      }
      
      public function refreshContent(param1:IWindowContainer) : void
      {
      }
      
      private function onPopup(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1 as WindowMouseEvent == null)
         {
            return;
         }
         if(param1.type == "WME_OVER")
         {
            this._hideTimer.reset();
         }
         else if(param1.type == "WME_OUT")
         {
            if(!Util.containsMouse(_popup))
            {
               this.closePopup();
            }
         }
      }
   }
}
