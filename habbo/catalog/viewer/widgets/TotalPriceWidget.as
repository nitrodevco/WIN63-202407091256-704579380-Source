package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.purse.class_3473;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import flash.events.Event;
   
   public class TotalPriceWidget extends CatalogWidget implements class_3558
   {
      
      private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
      
      private static const ELEMENT_PLUS:String = "plus";
      
      private static const const_1014:String = "amount_text_left";
      
      private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
      
      private static const const_820:String = "total_left";
      
      private static const ELEMENT_TOTAL_RIGHT:String = "total_right";
      
      private static const const_1036:String = "currency_indicator_bitmap_left";
      
      private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";
       
      
      private var _catalog:HabboCatalog;
      
      private var var_3641:int;
      
      private var var_3318:int;
      
      private var var_2795:int;
      
      private var var_4506:int;
      
      private var var_2691:IWindow;
      
      private var var_2730:IWindow;
      
      private var var_1993:IWindowContainer;
      
      private var var_1830:IWindowContainer;
      
      private var var_2460:int = 1;
      
      public function TotalPriceWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _catalog = null;
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChangedEvent);
            events.removeEventListener("SELECT_PRODUCT",onSelectProductEvent);
            clear();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("totalPriceWidget");
         window.visible = false;
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChangedEvent);
         events.addEventListener("SELECT_PRODUCT",onSelectProductEvent);
         events.dispatchEvent(new Event("TOTAL_PRICE_WIDGET_INITIALIZED"));
         return true;
      }
      
      private function onSpinnerValueChangedEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         var_2460 = param1.value;
         updateCurrencyIndicators();
      }
      
      private function onSelectProductEvent(param1:SelectProductEvent) : void
      {
         window.visible = param1.offer.bundlePurchaseAllowed;
         var_3641 = param1.offer.priceInCredits;
         var_3318 = param1.offer.priceInActivityPoints;
         var_2795 = param1.offer.priceInSilver;
         var_4506 = param1.offer.activityPointType;
         var_2460 = 1;
         clear();
         createCurrencyIndicators();
         updateCurrencyIndicators();
      }
      
      private function clear() : void
      {
         var_2691 = null;
         var_2730 = null;
         var_1993 = null;
         var_1830 = null;
         _window.findChildByName("plus").visible = false;
         _window.findChildByName("amount_text_left").visible = false;
         if(_window.findChildByName("total_left"))
         {
            _window.findChildByName("total_left").visible = false;
         }
         if(_window.findChildByName("total_right"))
         {
            _window.findChildByName("total_right").visible = false;
         }
         _window.findChildByName("currency_indicator_bitmap_left").visible = false;
      }
      
      private function updateCurrencyIndicators() : void
      {
         var _loc4_:IWindow = null;
         var _loc8_:IWindow = null;
         _loc8_ = null;
         var _loc3_:int = var_2460 * var_3641;
         var _loc7_:int = var_2460 * var_3318;
         var _loc6_:int = var_2460 * var_2795;
         var _loc1_:* = _loc3_;
         var _loc2_:* = _loc7_;
         var _loc5_:* = _loc6_;
         if(_catalog.bundleDiscountEnabled)
         {
            _loc1_ = _catalog.utils.calculateBundlePrice(true,var_3641,var_2460);
            _loc2_ = _catalog.utils.calculateBundlePrice(true,var_3318,var_2460);
            _loc5_ = _catalog.utils.calculateBundlePrice(true,var_2795,var_2460);
         }
         if(var_2691 != null)
         {
            var_2691.caption = _catalog.bundleDiscountEnabled ? _loc1_.toString() : _loc3_.toString();
         }
         if(var_2730 != null)
         {
            if(var_2795 > 0)
            {
               var_2730.caption = _catalog.bundleDiscountEnabled ? _loc5_.toString() : _loc6_.toString();
            }
            else
            {
               var_2730.caption = _catalog.bundleDiscountEnabled ? _loc2_.toString() : _loc7_.toString();
            }
         }
         if(var_1993)
         {
            var_1993.visible = _loc3_ != _loc1_;
            (_loc4_ = var_1993.findChildByName("text")).caption = !!var_1993.visible ? _loc3_.toString() : "0";
            var_1993.findChildByName("strike").width = _loc4_.width;
         }
         if(var_1830)
         {
            if(var_2795 > 0)
            {
               var_1830.visible = _loc6_ != _loc5_;
               (_loc8_ = var_1830.findChildByName("text")).caption = !!var_1830.visible ? _loc6_.toString() : "0";
               var_1830.findChildByName("strike").width = _loc8_.width;
            }
            else
            {
               var_1830.visible = _loc7_ != _loc2_;
               (_loc8_ = var_1830.findChildByName("text")).caption = !!var_1830.visible ? _loc7_.toString() : "0";
               var_1830.findChildByName("strike").width = _loc8_.width;
            }
         }
      }
      
      private function createCurrencyIndicators() : void
      {
         var _loc2_:IWindow = null;
         var _loc3_:IWindow = null;
         var _loc1_:IWindow = null;
         if(var_3641 > 0)
         {
            if(var_3318 > 0 || var_2795 > 0)
            {
               var_2691 = _window.findChildByName("amount_text_left");
               var_2691.visible = true;
               var_1993 = _window.findChildByName("total_left") as IWindowContainer;
               if(var_1993)
               {
                  var_1993.visible = false;
               }
               _loc2_ = _window.findChildByName("currency_indicator_bitmap_left");
               _loc2_.visible = true;
               _window.findChildByName("plus").visible = true;
            }
            else
            {
               var_2691 = _window.findChildByName("amount_text_right");
               var_1993 = _window.findChildByName("total_right") as IWindowContainer;
               if(var_1993)
               {
                  var_1993.visible = false;
               }
               _loc2_ = _window.findChildByName("currency_indicator_bitmap_right");
            }
            if(page.acceptSeasonCurrencyAsCredits)
            {
               _loc2_.style = class_3473.getIconStyleFor(_catalog.getSeasonalCurrencyActivityPointType(),_catalog,true,true);
               _loc2_.width = 53;
            }
            else
            {
               _loc2_.style = class_3473.getIconStyleFor(-1,_catalog,true);
               _loc2_.width = 22;
            }
         }
         if(var_3318 > 0)
         {
            var_2730 = ITextWindow(_window.findChildByName("amount_text_right"));
            var_1830 = _window.findChildByName("total_left") as IWindowContainer;
            if(var_1830)
            {
               var_1830.visible = false;
            }
            _loc3_ = _window.findChildByName("currency_indicator_bitmap_right");
            _loc3_.style = class_3473.getIconStyleFor(var_4506,_catalog,true);
         }
         else if(var_2795 > 0)
         {
            var_2730 = ITextWindow(_window.findChildByName("amount_text_right"));
            var_1830 = _window.findChildByName("total_left") as IWindowContainer;
            if(var_1830)
            {
               var_1830.visible = false;
            }
            _loc1_ = _window.findChildByName("currency_indicator_bitmap_right");
            _loc1_.style = class_3473.getIconStyleFor(1000,_catalog,true);
         }
         IItemListWindow(_window.findChildByName("totalprice_container")).arrangeListItems();
      }
   }
}
