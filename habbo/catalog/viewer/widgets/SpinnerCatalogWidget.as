package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SpinnerCatalogWidget extends CatalogWidget implements class_3558
   {
      
      private static const SPIN_BUTTONDOWN_HOLD_VALUE_STEP_DELAY_MS:int = 75;
      
      private static const const_932:int = 35;
       
      
      private var _catalog:HabboCatalog;
      
      private var _value:int = 1;
      
      private var name_3:int = 1;
      
      private var name_5:int = 100;
      
      private var var_2301:Timer;
      
      private var var_3628:Boolean = false;
      
      private var var_3747:Boolean = false;
      
      private var var_2954:Boolean = false;
      
      private var var_3383:int = 1;
      
      private var var_3445:Array;
      
      private var _promoInfo:IWindow;
      
      public function SpinnerCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         var_3445 = new Array(0);
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_2301 != null)
            {
               var_2301.stop();
               var_2301 = null;
            }
            events.removeEventListener("CWSE_RESET",onRequestResetEvent);
            events.removeEventListener("CWSE_SHOW",onShowEvent);
            events.removeEventListener("CWSE_HIDE",onHideEvent);
            events.removeEventListener("CWSE_SET_MAX",onSetMaxEvent);
            events.removeEventListener("CWSE_SET_MIN",onSetMinEvent);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("spinnerWidget");
         window.visible = false;
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         window.procedure = spinnerWindowProcedure;
         var _loc1_:ITextFieldWindow = window.findChildByName("text_value") as ITextFieldWindow;
         if(_loc1_)
         {
            _loc1_.addEventListener("WKE_KEY_UP",onInputEvent);
         }
         events.addEventListener("CWSE_RESET",onRequestResetEvent);
         events.addEventListener("CWSE_SHOW",onShowEvent);
         events.addEventListener("CWSE_HIDE",onHideEvent);
         events.addEventListener("CWSE_SET_MAX",onSetMaxEvent);
         events.addEventListener("CWSE_SET_MIN",onSetMinEvent);
         var_2301 = new Timer(75);
         var_2301.addEventListener("timer",onSpinnerTimerEvent);
         _promoInfo = window.findChildByName("promo.info");
         return true;
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         _value = Math.max(_value,name_3);
         _value = Math.min(_value,name_5);
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_VALUE_CHANGED",_value));
         setValueText(_value.toString());
         if(_promoInfo && _catalog.bundleDiscountEnabled)
         {
            _loc1_ = _catalog.utils.getDiscountItemsCount(_value);
            window.findChildByName("discountContainer").visible = _loc1_ > 0;
            _catalog.localization.registerParameter("shop.bonus.items.count","amount",_loc1_.toString());
         }
      }
      
      private function onRequestResetEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         _value = param1.value;
         if(param1.skipSteps != null)
         {
            var_3445 = param1.skipSteps;
         }
         refresh();
      }
      
      private function onShowEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         window.visible = true;
      }
      
      private function onHideEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         window.visible = false;
      }
      
      private function onSetMaxEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         name_5 = param1.value;
      }
      
      private function onSetMinEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         name_3 = param1.value;
      }
      
      private function onSpinnerTimerEvent(param1:TimerEvent) : void
      {
         if(disposed)
         {
            return;
         }
         var_2954 = true;
         if(var_3628)
         {
            increaseValue();
            if(_value - var_3383 > 35)
            {
               increaseValue();
            }
         }
         if(var_3747)
         {
            decreaseValue();
            if(var_3383 - _value > 35)
            {
               decreaseValue();
            }
         }
         refresh();
      }
      
      private function increaseValue() : void
      {
         var _loc1_:int = _value + 1;
         while(var_3445.indexOf(_loc1_) != -1)
         {
            _loc1_++;
         }
         _value = _loc1_;
      }
      
      private function decreaseValue() : void
      {
         var _loc1_:int = _value - 1;
         while(var_3445.indexOf(_loc1_) != -1)
         {
            _loc1_--;
         }
         _value = _loc1_;
      }
      
      private function setValueText(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.findChildByName("text_value") is ITextFieldWindow)
         {
            if(_window.findChildByName("text_value").caption.length > 0)
            {
               _window.findChildByName("text_value").caption = param1;
            }
         }
         else
         {
            _window.findChildByName("text_value").caption = param1;
         }
      }
      
      private function spinnerWindowProcedure(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOWN" && param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "button_less":
               switch(param1.type)
               {
                  case "WME_DOWN":
                     var_3747 = true;
                     var_3383 = _value;
                     var_2301.start();
                     break;
                  case "WME_UP":
                  case "WME_UP_OUTSIDE":
                     var_3747 = false;
                     var_2301.stop();
                     break;
                  case "WME_CLICK":
                     if(!var_2954)
                     {
                        decreaseValue();
                     }
                     refresh();
                     var_2954 = false;
               }
               break;
            case "button_more":
               switch(param1.type)
               {
                  case "WME_DOWN":
                     var_3628 = true;
                     var_3383 = _value;
                     var_2301.start();
                     break;
                  case "WME_UP":
                  case "WME_UP_OUTSIDE":
                     var_3628 = false;
                     var_2301.stop();
                     break;
                  case "WME_CLICK":
                     if(!var_2954)
                     {
                        increaseValue();
                     }
                     refresh();
                     var_2954 = false;
               }
         }
      }
      
      private function onInputEvent(param1:WindowKeyboardEvent) : void
      {
         _value = parseInt(param1.target.caption);
         refresh();
      }
   }
}
