package com.sulake.habbo.catalog.collectibles.widget
{
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectionsNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.widget.subviews.CollectionView;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1218;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1521;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1692;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_444;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_699;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_767;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_969;
   
   public class CollectionsWidget implements IUpdateReceiver
   {
      
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      public static var var_4332:Number = 90;
       
      
      private var _disposed:Boolean;
      
      private var var_2396:CollectiblesView;
      
      private var var_1754:CollectiblesController;
      
      private var var_1704:IWindowContainer;
      
      private var _navigationList:IItemListWindow;
      
      private var _renderableItems:Vector.<CollectionsNavigationNodeRenderer>;
      
      private var var_4665:IWindow;
      
      private var var_3841:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_2138:CollectionsNavigationNodeRenderer;
      
      private var var_2191:CollectionView;
      
      private var var_3085:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var var_109:Boolean;
      
      private var var_4698:IWindowContainer;
      
      private var var_4723:IWindowContainer;
      
      private var _ignoreWalletSelectionEvents:Boolean;
      
      public function CollectionsWidget(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_2396 = param1;
         var_1754 = param2;
         var_1704 = IWindowContainer(var_2396.window.findChildByName("collectionsContainer"));
         _navigationList = IItemListWindow(var_1704.findChildByName("navigationList"));
         var_4665 = _navigationList.removeListItem(_navigationList.getListItemByName("item_template"));
         _renderableItems = new Vector.<CollectionsNavigationNodeRenderer>();
         var _loc3_:IItemGridWindow = var_1704.findChildByName("itemgrid_collection") as IItemGridWindow;
         var_4698 = _loc3_.getGridItemAt(0) as IWindowContainer;
         _loc3_.removeGridItems();
         var _loc4_:IItemListWindow;
         var_4723 = (_loc4_ = var_1704.findChildByName("product_info_list") as IItemListWindow).getListItemAt(0) as IWindowContainer;
         _loc4_.removeListItems();
         setReady(false);
         addMessageEvents();
         if(var_2396.walletAddresses)
         {
            initializeWallets(var_2396.walletAddresses);
         }
         walletSelection.addEventListener("WE_SELECTED",onSelectAction);
         var_3085 = IStaticBitmapWrapperWindow(var_1704.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(var_1704.findChildByName("loading_icon"));
         controller.registerUpdateReceiver(this,1);
      }
      
      private static function sortCollectionsByBonus(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         for each(var _loc4_ in param1)
         {
            if(_loc4_.canClaimBonus)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_.hasBonusItem && !_loc4_.isBonusSnapshotPassed())
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc2_.concat(_loc3_,_loc5_);
      }
      
      private function addMessageEvents() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_444(onNftCollectionsMessage));
         _messageEvents.push(new class_767(onBonusClaimResult));
         _messageEvents.push(new class_699(onRewardClaimResult));
         for each(var _loc1_ in _messageEvents)
         {
            var_1754.addMessageEvent(_loc1_);
         }
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         initializeWallets(param1);
      }
      
      private function initializeWallets(param1:Array) : void
      {
         if(param1.length == 0)
         {
            walletSelection.color = 13421772;
            walletSelection.disable();
            return;
         }
         walletSelection.color = 16777215;
         walletSelection.enable();
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_ == var_2396.stardustWallet ? "Collector Wallet" : _loc2_);
         }
         walletSelection.populate(_loc3_);
      }
      
      private function onSelectAction(param1:WindowEvent) : void
      {
         if(!_ignoreWalletSelectionEvents)
         {
            var_2396.setActiveWalletIndex(walletSelection.selection);
         }
      }
      
      public function set activeWallet(param1:String) : void
      {
         var _loc3_:int = var_2396.walletAddresses.indexOf(param1);
         if(_loc3_ == -1 && param1 != null)
         {
            class_14.log("selected an unavailable wallet");
            return;
         }
         _ignoreWalletSelectionEvents = true;
         walletSelection.selection = _loc3_;
         _ignoreWalletSelectionEvents = false;
         setReady(false);
         requestCollections(param1);
         var _loc2_:String = String(walletSelection.enumerateSelection()[_loc3_]);
         if(_loc2_ && _loc2_.length > 19)
         {
            walletSelection.caption = _loc2_.substring(0,19) + "...";
         }
      }
      
      private function onNftCollectionsMessage(param1:class_444) : void
      {
         var _loc2_:CollectionsNavigationNodeRenderer = null;
         if(!var_3841 || _navigationList.numListItems != 0)
         {
            return;
         }
         var_3841 = false;
         var _loc3_:Array = sortCollectionsByBonus(param1.getParser().nftCollections);
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new CollectionsNavigationNodeRenderer(this,_loc4_);
            _navigationList.addListItem(_loc2_.window);
            _renderableItems.push(_loc2_);
         }
         if(_renderableItems.length > 0)
         {
            activateCollection(_renderableItems[0]);
         }
         setReady(true);
         collectionContainer.visible = _renderableItems.length > 0;
      }
      
      private function sendClaimNotification(param1:Boolean) : void
      {
         controller.catalog.events.dispatchEvent(new CatalogEvent(param1 ? "COLLECTIBLE_CLAIM_SUCCESS" : "COLLECTIBLES_CLAIM_FAIL"));
      }
      
      public function sendClaimWaitNotification() : void
      {
         controller.catalog.events.dispatchEvent(new CatalogEvent("COLLECTIBLE_CLAIM_WAIT"));
      }
      
      private function onBonusClaimResult(param1:class_767) : void
      {
         var _loc2_:class_1218 = param1.getParser();
         sendClaimNotification(_loc2_.success);
         if(var_2396.activeWallet != _loc2_.walletAddress)
         {
            return;
         }
         var _loc3_:class_1692 = getCollectionById(_loc2_.collectionId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.claimBonusFinished(_loc2_.success);
         if(var_2191 != null && var_2191.nftCollection.collectionId == _loc2_.collectionId)
         {
            var_2191.claimingFinished(true,_loc2_.success);
         }
      }
      
      private function onRewardClaimResult(param1:class_699) : void
      {
         var _loc2_:class_1521 = param1.getParser();
         sendClaimNotification(_loc2_.success);
         if(var_2396.activeWallet != _loc2_.walletAddress)
         {
            return;
         }
         var _loc3_:class_1692 = getCollectionById(_loc2_.collectionId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.claimRewardFinished(_loc2_.success);
         if(var_2191 != null && var_2191.nftCollection.collectionId == _loc2_.collectionId)
         {
            var_2191.claimingFinished(true,_loc2_.success);
         }
      }
      
      private function getCollectionById(param1:String) : class_1692
      {
         var _loc3_:class_1692 = null;
         if(_renderableItems == null)
         {
            return null;
         }
         for each(var _loc2_ in _renderableItems)
         {
            _loc3_ = _loc2_.nftCollection;
            if(_loc3_.collectionId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function setReady(param1:Boolean) : void
      {
         loadedContainer.visible = param1;
         loadingContainer.visible = !param1;
         var_109 = param1;
      }
      
      private function requestCollections(param1:String) : void
      {
         clearNavigationList();
         var_3841 = true;
         var_1754.send(new class_969(param1 == null ? "" : param1));
      }
      
      public function get navigationItemTemplate() : IWindow
      {
         return var_4665;
      }
      
      public function activateCollection(param1:CollectionsNavigationNodeRenderer) : void
      {
         if(var_2138 == param1)
         {
            return;
         }
         if(var_2138 != null)
         {
            var_2138.deactivate();
         }
         if(var_2191 != null)
         {
            var_2191.dispose();
         }
         var_2138 = param1;
         var_2191 = new CollectionView(this,collectionContainer,var_2138.nftCollection);
         var_2138.activate();
      }
      
      private function get collectionContainer() : IWindowContainer
      {
         return var_1704.findChildByName("collection_content") as IWindowContainer;
      }
      
      private function get loadingContainer() : IWindowContainer
      {
         return var_1704.findChildByName("loading_contents") as IWindowContainer;
      }
      
      private function get loadedContainer() : IWindowContainer
      {
         return var_1704.findChildByName("loaded_content") as IWindowContainer;
      }
      
      private function clearNavigationList() : void
      {
         var_2138 = null;
         _navigationList.removeListItems();
         for each(var _loc1_ in _renderableItems)
         {
            _loc1_.dispose();
         }
         _renderableItems.length = 0;
      }
      
      private function removeMessageEvents() : void
      {
         if(!var_1754 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            var_1754.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         controller.removeUpdateReceiver(this);
         clearNavigationList();
         removeMessageEvents();
         if(var_2138 != null)
         {
            var_2138.dispose();
            var_2138 = null;
         }
         super.dispose();
      }
      
      public function get controller() : CollectiblesController
      {
         return var_1754;
      }
      
      public function get activeWallet() : String
      {
         return var_2396.activeWallet;
      }
      
      public function get gridItemTemplate() : IWindowContainer
      {
         return var_4698;
      }
      
      public function get productInfoEntryTemplate() : IWindowContainer
      {
         return var_4723;
      }
      
      private function get walletSelection() : class_3520
      {
         return var_1704.findChildByName("wallet_selection") as class_3520;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(var_109)
         {
            _loc2_ = BG_STAR_ROTATE_SPEED * (param1 / 1000);
            var_3085.rotation += _loc2_;
            var_3085.rotation %= 360;
            var_3085.invalidate();
            if(var_2191 != null)
            {
               var_2191.updateBonusProgressBar(false,param1);
            }
         }
         else
         {
            _loc2_ = var_4332 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}
