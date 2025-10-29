package com.sulake.habbo.catalog.targetedoffers
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.purse.PurseUpdateEvent;
   import com.sulake.habbo.catalog.targetedoffers.data.HabboMallOffer;
   import com.sulake.habbo.catalog.targetedoffers.data.TargetedOffer;
   import com.sulake.habbo.catalog.targetedoffers.util.MallOfferExternalInterfaceHelper;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1402;
   import com.sulake.habbo.communication.messages.outgoing.catalog.ShopTargetedOfferViewedComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.SetTargetedOfferStateComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetNextTargetedOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.PurchaseTargetedOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.TargetedOfferNotFoundEvent;
   
   public class OfferController implements class_1812
   {
       
      
      private var _offerDialog:TargetedOfferDialogView;
      
      private var var_3134:MallOfferDialogView;
      
      private var var_2926:IDisposable;
      
      private var var_2994:TargetedOfferPurchaseConfirmationView;
      
      private var var_3559:MallOfferExternalInterfaceHelper;
      
      private var _catalog:HabboCatalog;
      
      private var _disposed:Boolean;
      
      public function OfferController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
         _catalog.connection.addMessageEvent(new TargetedOfferEvent(onTargetedOffer));
         _catalog.connection.addMessageEvent(new TargetedOfferNotFoundEvent(onTargetedOfferNotFound));
         _catalog.events.addEventListener("catalog_purse_update",onPurseUpdate);
         _catalog.sessionDataManager.addProductsReadyEventListener(this);
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         destroyView();
         if(var_3559)
         {
            var_3559.dispose();
            var_3559 = null;
         }
      }
      
      public function productDataReady() : void
      {
         _catalog.connection.send(new GetNextTargetedOfferComposer());
      }
      
      private function onTargetedOffer(param1:TargetedOfferEvent) : void
      {
         var _loc3_:class_1402 = param1.getParser();
         var _loc2_:TargetedOffer = new TargetedOffer(_loc3_.data);
         if(_loc2_.trackingState == 4)
         {
            minimizeOffer(_loc2_);
         }
         else
         {
            maximizeOffer(_loc2_);
         }
      }
      
      private function onTargetedOfferNotFound(param1:TargetedOfferNotFoundEvent) : void
      {
         var_3559 = new MallOfferExternalInterfaceHelper(this);
      }
      
      public function onHabboMallOffer(param1:HabboMallOffer) : void
      {
         if(param1.trackingState == 2)
         {
            return;
         }
         switch(param1.trackingState)
         {
            case 0:
            case 5:
            case 6:
               maximizeMallOffer(param1);
               break;
            case 2:
               return;
            default:
               minimizeMallOffer(param1);
         }
      }
      
      public function maximizeMallOffer(param1:HabboMallOffer) : void
      {
         if(var_3134)
         {
            return;
         }
         destroyView();
         var_3134 = new MallOfferDialogView(this,param1);
         _catalog.connection.send(new ShopTargetedOfferViewedComposer(param1.targetedOfferId,6));
      }
      
      public function minimizeMallOffer(param1:HabboMallOffer, param2:Boolean = false) : void
      {
         destroyView();
         var_2926 = new MallOfferMinimizedView(this,param1);
      }
      
      public function onHabboMallOfferOpened(param1:HabboMallOffer) : void
      {
         _catalog.connection.send(new ShopTargetedOfferViewedComposer(param1.targetedOfferId,1));
         _catalog.openCreditsHabblet();
         minimizeMallOffer(param1);
      }
      
      public function onHabboMallOfferClosed(param1:HabboMallOffer) : void
      {
         _catalog.connection.send(new ShopTargetedOfferViewedComposer(param1.targetedOfferId,4));
         minimizeMallOffer(param1);
      }
      
      public function minimizeOffer(param1:TargetedOffer) : void
      {
         destroyView();
         var_2926 = new TargetedOfferMinimizedView(this,param1);
         _catalog.connection.send(new SetTargetedOfferStateComposer(param1.id,4));
      }
      
      public function maximizeOffer(param1:TargetedOffer) : void
      {
         var _loc2_:String = null;
         if(_offerDialog)
         {
            return;
         }
         destroyView();
         if(!param1.isExpired())
         {
            _loc2_ = getLayoutOverride(param1);
            _offerDialog = new TargetedOfferDialogView(this,param1);
            if(_loc2_ != null && _loc2_.length > 0 && Boolean(_catalog.assets.hasAsset(_loc2_)))
            {
               _offerDialog.buildWindow(_loc2_);
            }
            else
            {
               _offerDialog.buildWindow("targeted_offer_dialog_xml");
            }
            _catalog.connection.send(new SetTargetedOfferStateComposer(param1.id,1));
         }
      }
      
      public function purchaseTargetedOffer(param1:TargetedOffer, param2:int) : void
      {
         _catalog.connection.send(new PurchaseTargetedOfferComposer(param1.id,param2));
         param1.purchased(param2);
         if(param1.purchaseLimit > 0)
         {
            minimizeOffer(param1);
         }
         else
         {
            destroyView();
         }
      }
      
      public function sendLogEvent(param1:String, param2:String = "") : void
      {
         if(!_catalog || !_catalog.connection)
         {
            return;
         }
         _catalog.connection.send(new EventLogMessageComposer("TargetedOffers","FLASH.UNKNOWN",param1,param2));
      }
      
      public function purchaseCredits(param1:TargetedOffer) : void
      {
         sendLogEvent("targeted.offer.open.credits.page.clicked",param1.identifier);
         _catalog.openCreditsHabblet();
      }
      
      public function attachExtension(param1:IWindow) : void
      {
         _catalog.toolbar.extensionView.attachExtension("targeted_offer",param1,13);
      }
      
      public function showConfirmation(param1:TargetedOffer, param2:int) : void
      {
         if(var_2994)
         {
            return;
         }
         destroyView();
         var_2994 = new TargetedOfferPurchaseConfirmationView(this,param1,param2);
      }
      
      private function onPurseUpdate(param1:PurseUpdateEvent) : void
      {
         if(_offerDialog)
         {
            _offerDialog.updateButtonStates();
         }
      }
      
      public function destroyView() : void
      {
         if(_offerDialog)
         {
            _offerDialog.dispose();
            _offerDialog = null;
         }
         if(var_3134)
         {
            var_3134.dispose();
            var_3134 = null;
         }
         if(var_2926)
         {
            _catalog.toolbar.extensionView.detachExtension("targeted_offer");
            var_2926.dispose();
            var_2926 = null;
         }
         if(var_2994)
         {
            var_2994.dispose();
            var_2994 = null;
         }
      }
      
      private function getLayoutOverride(param1:TargetedOffer) : String
      {
         return _catalog.getProperty("targeted.offer.override.layout." + param1.id);
      }
   }
}
