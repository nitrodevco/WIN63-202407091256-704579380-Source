package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.catalog.viewer.widgets.utils.RentUtils;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.tracking.HabboTracking;
   
   public class PurchaseCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var _stubPurchaseVipXML:XML;
      
      private var var_3028:IWindowContainer;
      
      private var _offer:class_3377;
      
      private var _additionalParameters:String = "";
      
      private var var_4082:IStuffData = null;
      
      private var var_2460:int = 1;
      
      private var _purchaseCallback:Function;
      
      private var _catalog:HabboCatalog;
      
      private var var_3782:Boolean;
      
      private var var_4705:Boolean = false;
      
      private var var_593:Boolean = true;
      
      public function PurchaseCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
         events.removeEventListener("CWE_SET_EXTRA_PARM",onSetParameter);
         events.removeEventListener("PURCHASE_OVERRIDE",onPurchaseOverride);
         events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA",onSetPreviewerStuffData);
         events.removeEventListener("CWE_TOGGLE",onToggleWidget);
         super.dispose();
      }
      
      private function onToggleWidget(param1:CatalogWidgetToggleEvent) : void
      {
         if(param1.widgetId == "purchaseWidget")
         {
            var_593 = param1.enabled;
            window.visible = var_593;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(_catalog.catalogType == "BUILDERS_CLUB")
         {
            _window.visible = false;
            return true;
         }
         attachWidgetView("purchaseWidget");
         _window.findChildByName("selection_information").visible = true;
         _window.findChildByName("default_buttons").visible = false;
         var_3782 = false;
         if(window.tags.indexOf("ROOM_INITIATE_PURCHASE") > -1)
         {
            _catalog.sendRoomAdPurchaseInitiatedEvent();
         }
         _window.findChildByName("buy_button").addEventListener("WME_CLICK",onPurchase);
         var _loc2_:class_3357 = _window.findChildByName("gift_button") as class_3357;
         if(window.tags.indexOf("NO_GIFT_OPTION") > -1)
         {
            var_3782 = true;
            _loc2_.visible = false;
         }
         _loc2_.addEventListener("WME_CLICK",onGift);
         _loc2_.disable();
         var _loc1_:XmlAsset = _catalog.assets.getAssetByName("purchaseWidgetBuyVipStub") as XmlAsset;
         if(_loc1_ != null)
         {
            _stubPurchaseVipXML = _loc1_.content as XML;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("CWE_SET_EXTRA_PARM",onSetParameter);
         events.addEventListener("PURCHASE_OVERRIDE",onPurchaseOverride);
         events.addEventListener("INIT_PURCHASE",initPurchase);
         events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA",onSetPreviewerStuffData);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerValueChanged);
         events.addEventListener("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY",onExtraParamRequired);
         events.addEventListener("CWE_TOGGLE",onToggleWidget);
         return true;
      }
      
      private function onPurchaseOverride(param1:CatalogWidgetPurchaseOverrideEvent) : void
      {
         _purchaseCallback = param1.callback;
      }
      
      private function attachStub(param1:class_3377) : void
      {
         var _loc2_:* = null;
         if(var_3028 != null)
         {
            var_3028.visible = false;
            _window.removeChild(var_3028);
            var_3028.dispose();
            var_3028 = null;
         }
      }
      
      private function get extraParamRequirementsMet() : Boolean
      {
         return !(var_4705 && _additionalParameters == "");
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc2_:IWindow = null;
         var _loc3_:Boolean = false;
         var_2460 = 1;
         _offer = param1.offer;
         _window.findChildByName("selection_information").visible = false;
         _window.findChildByName("default_buttons").visible = true;
         attachStub(_offer);
         _catalog.purchaseWillBeGift(false);
         if(var_3028 == null)
         {
            enableBuyButton(extraParamRequirementsMet);
            enableGiftButton(extraParamRequirementsMet);
            RentUtils.updateBuyCaption(_offer,_window.findChildByName("purchase_label"));
            _loc2_ = _window.findChildByName("gift_button");
            if(_loc2_ != null)
            {
               _loc2_.visible = !_offer.isRentOffer && !var_3782;
            }
            if(!_offer.giftable)
            {
               enableGiftButton(false);
            }
            _loc3_ = isSoldOut(_offer);
            if(_loc3_)
            {
               enableBuyButton(false);
               enableGiftButton(false);
            }
            window.visible = var_593;
         }
         else
         {
            enableBuyButton(false);
            enableGiftButton(false);
         }
      }
      
      private function isSoldOut(param1:class_3377) : Boolean
      {
         var _loc2_:class_3388 = null;
         var _loc3_:Boolean = false;
         if(param1 != null)
         {
            if(param1.pricingModel == "pricing_model_single")
            {
               _loc2_ = _offer.product;
               if(_loc2_ != null && _loc2_.isUniqueLimitedItem)
               {
                  return _loc2_.uniqueLimitedItemsLeft == 0;
               }
            }
         }
         return false;
      }
      
      private function enableBuyButton(param1:Boolean) : void
      {
         if(_catalog.sessionDataManager.isAccountSafetyLocked())
         {
            param1 = false;
         }
         enableButton("buy_button",param1);
      }
      
      private function enableGiftButton(param1:Boolean) : void
      {
         if(_catalog.sessionDataManager.isAccountSafetyLocked())
         {
            param1 = false;
         }
         enableButton("gift_button",param1);
      }
      
      private function enableButton(param1:String, param2:Boolean) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:IWindow = _window.findChildByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         if(param2)
         {
            _loc3_.enable();
            _loc3_.blend = 1;
         }
         else
         {
            _loc3_.disable();
            _loc3_.blend = 0.5;
         }
      }
      
      private function onSetParameter(param1:SetExtraPurchaseParameterEvent) : void
      {
         _additionalParameters = param1.parameter;
         enableBuyButton(extraParamRequirementsMet);
         enableGiftButton(_offer != null && _offer.giftable && extraParamRequirementsMet && var_2460 == 1);
      }
      
      private function onPurchase(param1:WindowMouseEvent, param2:Boolean = false) : void
      {
         var event:WindowMouseEvent = param1;
         var isGift:Boolean = param2;
         if(!_catalog.verifyClubLevel(_offer.clubLevel))
         {
            _catalog.openClubCenter();
            return;
         }
         _catalog.purchaseWillBeGift(isGift);
         if(_purchaseCallback == null)
         {
            if(_offer != null)
            {
               if(_catalog.roomAdPurchaseData != null && _catalog.roomAdPurchaseData.offerId == _offer.offerId)
               {
                  if(_catalog.roomAdPurchaseData.flatId == 0)
                  {
                     _catalog.windowManager.alert("${roomad.error.title}","${roomad.alert.no.available.room}",0,function(param1:class_3348, param2:WindowEvent):void
                     {
                        param1.dispose();
                     });
                     return;
                  }
                  if(_catalog.roomAdPurchaseData.name == null || _catalog.roomAdPurchaseData.name.length < 5 || _catalog.roomAdPurchaseData.name.substr(0,1) == " ")
                  {
                     _catalog.windowManager.alert("${roomad.error.title}","${roomad.alert.name.empty}",0,function(param1:class_3348, param2:WindowEvent):void
                     {
                        param1.dispose();
                     });
                     return;
                  }
               }
               _catalog.showPurchaseConfirmation(_offer,page.pageId,_additionalParameters,var_2460,var_4082,null,true,null);
            }
         }
         else
         {
            _purchaseCallback(event);
         }
      }
      
      private function onGift(param1:WindowMouseEvent) : void
      {
         onPurchase(param1,true);
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.buy_as_gift.clicked");
      }
      
      private function initPurchase(param1:CatalogWidgetInitPurchaseEvent) : void
      {
         if(_offer != null)
         {
            _catalog.showPurchaseConfirmation(_offer,page.pageId,_additionalParameters,var_2460,var_4082,null,true,null);
         }
      }
      
      private function onBuyClub(param1:WindowMouseEvent) : void
      {
         _catalog.rememberPageDuringVipPurchase(page.pageId);
         _catalog.openClubCenter();
         HabboTracking.getInstance().trackEventLog("Catalog","click","BUY_CLUB");
      }
      
      private function onSetPreviewerStuffData(param1:SetRoomPreviewerStuffDataEvent) : void
      {
         var_4082 = param1.stuffData;
      }
      
      private function onSpinnerValueChanged(param1:CatalogWidgetSpinnerEvent) : void
      {
         var_2460 = param1.value;
         if(var_2460 > 1)
         {
            enableGiftButton(false);
         }
         else if(_offer != null && extraParamRequirementsMet)
         {
            enableGiftButton(_offer.giftable);
         }
      }
      
      private function onExtraParamRequired(param1:CatalogWidgetEvent) : void
      {
         var_4705 = true;
         enableBuyButton(extraParamRequirementsMet);
         enableGiftButton(_offer != null && extraParamRequirementsMet && var_2460 == 1);
      }
   }
}
