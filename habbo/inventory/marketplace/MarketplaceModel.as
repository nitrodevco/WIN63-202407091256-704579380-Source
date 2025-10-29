package com.sulake.habbo.inventory.marketplace
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.furni.FurniModel;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceConfigurationMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.BuyMarketplaceTokensMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceItemStatsComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.GetMarketplaceCanMakeOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.marketplace.MakeOfferMessageComposer;
   
   public class MarketplaceModel implements IInventoryModel
   {
       
      
      private var var_319:HabboInventory;
      
      private var _assets:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _disposed:Boolean = false;
      
      private var var_325:FurnitureItem;
      
      private var var_1479:Boolean;
      
      private var var_1181:int;
      
      private var var_1144:int;
      
      private var var_664:int;
      
      private var _offerMinPrice:int;
      
      private var _offerMaxPrice:int;
      
      private var _expirationHours:int;
      
      private var var_1033:int;
      
      private var var_969:int;
      
      private var var_1259:int;
      
      private var var_1323:int;
      
      private var var_4411:int;
      
      private var var_4695:int;
      
      private var var_1631:MarketplaceView;
      
      private var var_3225:Boolean = false;
      
      public function MarketplaceModel(param1:HabboInventory, param2:IHabboWindowManager, param3:IHabboCommunicationManager, param4:IAssetLibrary, param5:IRoomEngine, param6:IHabboLocalizationManager)
      {
         super();
         var_319 = param1;
         _communication = param3;
         _windowManager = param2;
         _assets = param4;
         _roomEngine = param5;
         var_1631 = new MarketplaceView(this,_windowManager,_assets,param5,param6,param1);
      }
      
      public function get id() : String
      {
         return "marketplace";
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         var_1479 = param1;
      }
      
      public function set commission(param1:int) : void
      {
         var_1181 = param1;
      }
      
      public function set tokenBatchPrice(param1:int) : void
      {
         var_1144 = param1;
      }
      
      public function set tokenBatchSize(param1:int) : void
      {
         var_664 = param1;
      }
      
      public function set offerMinPrice(param1:int) : void
      {
         _offerMinPrice = param1;
      }
      
      public function set offerMaxPrice(param1:int) : void
      {
         _offerMaxPrice = param1;
      }
      
      public function set expirationHours(param1:int) : void
      {
         _expirationHours = param1;
      }
      
      public function set averagePricePeriod(param1:int) : void
      {
         var_1033 = param1;
      }
      
      public function set sellingFeePercentage(param1:int) : void
      {
         var_969 = param1;
      }
      
      public function set revenueLimit(param1:int) : void
      {
         var_1259 = param1;
      }
      
      public function set halfTaxLimit(param1:int) : void
      {
         var_1323 = param1;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_1479;
      }
      
      public function get commission() : int
      {
         return var_1181;
      }
      
      public function get tokenBatchPrice() : int
      {
         return var_1144;
      }
      
      public function get tokenBatchSize() : int
      {
         return var_664;
      }
      
      public function get offerMinPrice() : int
      {
         return _offerMinPrice;
      }
      
      public function get offerMaxPrice() : int
      {
         return _offerMaxPrice;
      }
      
      public function get expirationHours() : int
      {
         return _expirationHours;
      }
      
      public function get sellingFeePercentage() : int
      {
         return var_969;
      }
      
      public function get revenueLimit() : int
      {
         return var_1259;
      }
      
      public function get halfTaxLimit() : int
      {
         return var_1323;
      }
      
      public function get controller() : HabboInventory
      {
         return var_319;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var_319 = null;
         _communication = null;
         _windowManager = null;
         _assets = null;
         _roomEngine = null;
      }
      
      public function releaseItem() : void
      {
         if(var_319 != null && var_319.furniModel != null && var_325 != null)
         {
            var_319.furniModel.removeLockFrom(var_325.id);
            var_325 = null;
         }
      }
      
      public function startOfferMaking(param1:FurnitureItem) : void
      {
         if(var_325 != null || param1 == null)
         {
            return;
         }
         if(var_319 == null)
         {
            return;
         }
         var _loc2_:FurniModel = var_319.furniModel;
         if(_loc2_ == null)
         {
            return;
         }
         var_325 = param1;
         _loc2_.addLockTo(param1.id);
         send(new GetMarketplaceCanMakeOfferMessageComposer());
      }
      
      public function buyMarketplaceTokens() : void
      {
         send(new BuyMarketplaceTokensMessageComposer());
         var_3225 = true;
      }
      
      public function makeOffer(param1:int) : void
      {
         if(var_325 == null)
         {
            return;
         }
         var _loc2_:int = var_325.isWallItem ? 2 : 1;
         send(new MakeOfferMessageComposer(param1,_loc2_,var_325.ref));
         releaseItem();
      }
      
      public function getItemStats() : void
      {
         if(var_325 == null)
         {
            return;
         }
         var _loc1_:int = var_325.isWallItem ? 2 : 1;
         var_4411 = _loc1_;
         var_4695 = var_325.type;
         send(new GetMarketplaceItemStatsComposer(_loc1_,var_325.type));
      }
      
      public function proceedOfferMaking(param1:int, param2:int) : void
      {
         var_3225 = false;
         switch(param1 - 1)
         {
            case 0:
               var_1631.showMakeOffer(var_325);
               break;
            case 1:
               var_1631.showAlert("${inventory.marketplace.no_trading_privilege.title}","${inventory.marketplace.no_trading_privilege.info}");
               break;
            case 2:
               var_1631.showAlert("${inventory.marketplace.no_trading_pass.title}","${inventory.marketplace.no_trading_pass.info}");
               break;
            case 3:
               var_1631.showBuyTokens(var_1144,var_664);
               break;
            case 4:
               break;
            case 5:
               var_1631.showAlert("${inventory.marketplace.trading_lock.title}","${inventory.marketplace.trading_lock.info}");
         }
      }
      
      public function endOfferMaking(param1:int) : void
      {
         if(!var_1631)
         {
            return;
         }
         var_1631.showResult(param1);
      }
      
      public function setAveragePrice(param1:int, param2:int, param3:int) : void
      {
         if(param1 != var_4411 || param2 != var_4695)
         {
            return;
         }
         if(!var_1631)
         {
            return;
         }
         var_1631.updateAveragePrice(param3,var_1033);
      }
      
      public function onNotEnoughCredits() : void
      {
         if(var_3225)
         {
            var_3225 = false;
            releaseItem();
         }
      }
      
      public function requestInitialization() : void
      {
         send(new GetMarketplaceConfigurationMessageComposer());
      }
      
      public function getOfferItem() : class_3393
      {
         return var_325;
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         return null;
      }
      
      public function categorySwitch(param1:String) : void
      {
      }
      
      public function subCategorySwitch(param1:String) : void
      {
      }
      
      public function closingInventoryView() : void
      {
      }
      
      public function updateView() : void
      {
      }
      
      private function send(param1:IMessageComposer) : void
      {
         if(_communication != null && _communication.connection != null)
         {
            _communication.connection.send(param1);
         }
      }
      
      public function selectItemById(param1:String) : void
      {
         class_14.log("NOT SUPPORTED: MARKETPLACE SELECT BY ID");
      }
   }
}
