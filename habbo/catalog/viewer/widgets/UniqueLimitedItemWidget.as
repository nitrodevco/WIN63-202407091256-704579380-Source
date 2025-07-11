package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.window.utils.ILimitedItemOverlay;
   import com.sulake.habbo.window.widgets.ILimitedItemSupplyLeftOverlayWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UniqueLimitedItemWidget extends CatalogWidget implements class_3558
   {
      
      private static const SUPPLY_REFRESH_PERIOD_MS:int = 20000;
       
      
      private var _catalog:HabboCatalog;
      
      private var _overlay:ILimitedItemOverlay;
      
      private var var_2879:class_3377;
      
      private var var_2507:Timer;
      
      private var _overlayWidget:ILimitedItemSupplyLeftOverlayWidget;
      
      public function UniqueLimitedItemWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_2507 != null)
            {
               var_2507.stop();
               var_2507.removeEventListener("timer",onSupplyLeftTimer);
               var_2507 = null;
            }
            window.visible = false;
            _catalog = null;
            var_2879 = null;
            if(_overlay)
            {
               _overlay.dispose();
               _overlay = null;
            }
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            events.removeEventListener("CWE_PRODUCT_OFFER_UPDATED",onOfferUpdated);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var _loc1_:IWidgetWindow = IWidgetWindow(_window.findChildByName("unique_item_overlay_container"));
         _overlayWidget = ILimitedItemSupplyLeftOverlayWidget(_loc1_.widget);
         window.visible = false;
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("CWE_PRODUCT_OFFER_UPDATED",onOfferUpdated);
         var_2507 = new Timer(20000);
         var_2507.addEventListener("timer",onSupplyLeftTimer);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_2879 = param1.offer;
         update(param1.offer,true);
      }
      
      private function onOfferUpdated(param1:ProductOfferUpdatedEvent) : void
      {
         var_2879 = param1.offer;
         update(param1.offer);
      }
      
      private function update(param1:class_3377, param2:Boolean = false) : void
      {
         var _loc3_:class_3388 = null;
         if(param1.pricingModel == "pricing_model_single" && param1.product.isUniqueLimitedItem)
         {
            _loc3_ = param1.product;
            _overlayWidget.supplyLeft = _loc3_.uniqueLimitedItemsLeft;
            _overlayWidget.seriesSize = _loc3_.uniqueLimitedItemSeriesSize;
            window.visible = true;
            if(param2)
            {
               _catalog.sendGetProductOffer(param1.offerId);
            }
            var_2507.start();
         }
         else
         {
            window.visible = false;
            var_2507.stop();
         }
      }
      
      private function onSupplyLeftTimer(param1:TimerEvent) : void
      {
         if(_window.visible && var_2879 != null)
         {
            update(var_2879,true);
         }
      }
   }
}
