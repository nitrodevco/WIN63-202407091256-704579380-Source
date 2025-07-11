package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoViewManager;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.UpdateableExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BundlePurchaseExtraInfoWidget extends CatalogWidget implements class_3558
   {
      
      private static const PROMO_ITEM_DROP_DELAY_MS:uint = 4000;
       
      
      private var _catalog:HabboCatalog;
      
      private var var_2044:ExtraInfoViewManager;
      
      private var var_3485:int = 1;
      
      private var var_3641:int;
      
      private var var_3318:int;
      
      private var var_4506:int;
      
      private var var_4917:String;
      
      private var var_2308:int = -1;
      
      private var var_2364:int = -1;
      
      private var var_2777:int = -1;
      
      private var var_3721:Boolean = false;
      
      private var var_2908:Timer;
      
      public function BundlePurchaseExtraInfoWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_2044.dispose();
            var_2044 = null;
            _catalog = null;
            var_2908.stop();
            var_2908.removeEventListener("timerComplete",onPromoItemDropDownTimerEvent);
            var_2908 = null;
            events.removeEventListener("CWPPEIE_RESET",onResetEvent);
            events.removeEventListener("CWPPEIE_HIDE",onHideEvent);
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
            events.removeEventListener("CWPPEIE_ITEM_CLICKED",onExtraInfoItemClickedEvent);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         var_2044 = new ExtraInfoViewManager(this,_catalog);
         events.addEventListener("CWPPEIE_RESET",onResetEvent);
         events.addEventListener("CWPPEIE_HIDE",onHideEvent);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
         events.addEventListener("CWPPEIE_ITEM_CLICKED",onExtraInfoItemClickedEvent);
         var_2908 = new Timer(4000,1);
         var_2908.addEventListener("timerComplete",onPromoItemDropDownTimerEvent);
         return true;
      }
      
      private function createPromoItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(0);
         _loc1_.quantity = var_3485;
         var_2308 = var_2044.addItem(_loc1_);
      }
      
      private function updatePromoItem(param1:int) : void
      {
         var _loc3_:UpdateableExtraInfoListItem = null;
         var _loc2_:ExtraInfoItemData = null;
         if(var_2308 != -1)
         {
            _loc3_ = UpdateableExtraInfoListItem(var_2044.getItem(var_2308));
            _loc2_ = _loc3_.data;
            _loc2_.quantity = param1;
            _loc3_.update(_loc2_);
         }
      }
      
      private function removePromoItem() : void
      {
         if(var_2308 != -1)
         {
            var_2044.removeItem(var_2308);
            var_2308 = -1;
         }
      }
      
      private function createDiscountValueItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(2);
         _loc1_.quantity = var_3485;
         _loc1_.priceActivityPoints = var_3318;
         _loc1_.activityPointType = var_4506;
         _loc1_.priceCredits = var_3641;
         var_2364 = var_2044.addItem(_loc1_);
         _catalog.utils.discountShownEventTrack();
      }
      
      private function updateDiscountValueItem(param1:int) : void
      {
         var _loc2_:UpdateableExtraInfoListItem = null;
         var _loc3_:ExtraInfoItemData = null;
         if(var_2364 != -1)
         {
            _loc2_ = UpdateableExtraInfoListItem(var_2044.getItem(var_2364));
            _loc3_ = _loc2_.data;
            _loc3_.quantity = param1;
            _loc3_.discountPriceCredits = _catalog.utils.calculateBundlePrice(true,var_3641,param1);
            _loc3_.discountPriceActivityPoints = _catalog.utils.calculateBundlePrice(true,var_3318,param1);
            _loc2_.update(_loc3_);
         }
      }
      
      private function removeDiscountValueItem() : void
      {
         if(var_2364 != -1)
         {
            var_2044.removeItem(var_2364);
            var_2364 = -1;
         }
      }
      
      private function createBundleInfoItem() : void
      {
         var _loc1_:ExtraInfoItemData = new ExtraInfoItemData(1);
         var_2777 = var_2044.addItem(_loc1_);
         _catalog.utils.bundlesInfoShownEventTrack();
      }
      
      private function removeBundleInfoItem() : void
      {
         if(var_2777 != -1)
         {
            var_2044.removeItem(var_2777);
            var_2777 = -1;
         }
      }
      
      private function onResetEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         if(disposed)
         {
            return;
         }
         window.visible = true;
         var_3641 = param1.data.priceCredits;
         var_3318 = param1.data.priceActivityPoints;
         var_4506 = param1.data.activityPointType;
         var_4917 = param1.data.badgeCode;
         var_2044.clear();
         var_2364 = -1;
         var_2308 = -1;
         var_2908.start();
      }
      
      private function onSpinnerEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_catalog.bundleDiscountEnabled)
         {
            return;
         }
         if(param1.type == "CWSE_VALUE_CHANGED")
         {
            if(param1.value != var_3485)
            {
               if(param1.value >= _catalog.bundleDiscountRuleset.bundleSize && var_2364 == -1)
               {
                  createDiscountValueItem();
               }
               else if(param1.value < _catalog.bundleDiscountRuleset.bundleSize)
               {
                  removeDiscountValueItem();
               }
               updatePromoItem(param1.value);
               updateDiscountValueItem(param1.value);
               var_3485 = param1.value;
               removeBundleInfoItem();
               if(var_3485 >= _catalog.utils.bundleDiscountHighestFlatPriceStep)
               {
                  removePromoItem();
                  var_3721 = true;
               }
               else if(var_3721)
               {
                  createPromoItem();
                  var_3721 = false;
               }
               _catalog.utils.spinnerValueChangedEventTrack();
            }
         }
      }
      
      private function onHideEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         window.visible = false;
      }
      
      private function onExtraInfoItemClickedEvent(param1:CatalogWidgetBundleDisplayExtraInfoEvent) : void
      {
         switch(param1.id)
         {
            case var_2308:
               if(var_2777 == -1)
               {
                  createBundleInfoItem();
               }
               break;
            case var_2777:
               removeBundleInfoItem();
         }
      }
      
      private function onPromoItemDropDownTimerEvent(param1:TimerEvent) : void
      {
         createPromoItem();
      }
   }
}
