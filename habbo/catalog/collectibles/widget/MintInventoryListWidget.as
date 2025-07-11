package com.sulake.habbo.catalog.collectibles.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3404;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.MintInventoryItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.model.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.renderer.model.MintableItemWrapper;
   import com.sulake.habbo.catalog.collectibles.widget.subviews.CollectibleProductPreviewer;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1172;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1661;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1685;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_160;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_175;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_321;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_593;
   import com.sulake.habbo.communication.messages.incoming.collectibles.class_829;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_425;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_562;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_626;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_727;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_815;
   
   public class MintInventoryListWidget implements IUpdateReceiver
   {
      
      private static var PROGRESS_BAR_UPDATE_THRESHOLD:int = 1000;
       
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var var_3021:IItemGridWindow;
      
      private var var_2396:CollectiblesView;
      
      private var var_1704:IWindowContainer;
      
      private var var_1754:CollectiblesController;
      
      private var var_4256:IWindowContainer;
      
      private var var_3728:Boolean;
      
      private var var_3742:Boolean;
      
      private var var_3816:Boolean;
      
      private var var_3880:Boolean;
      
      private var var_3959:Boolean;
      
      private var var_109:Boolean;
      
      private var var_4163:int;
      
      private var _productItems:Vector.<class_1661>;
      
      private var var_4640:Boolean;
      
      private var _tokenOffers:Vector.<class_1685>;
      
      private var var_3616:Boolean;
      
      private var var_1741:MintInventoryItemRenderer;
      
      private var var_2992:CollectibleProductPreviewer;
      
      private var var_3085:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var var_3292:Number;
      
      private var _items:Vector.<MintInventoryItemRenderer>;
      
      private var var_3798:Boolean;
      
      public function MintInventoryListWidget(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         var_2396 = param1;
         var_1754 = param2;
         _items = new Vector.<MintInventoryItemRenderer>(0);
         var_1704 = var_2396.window.findChildByName("mintingContainer") as IWindowContainer;
         var_3021 = var_1704.findChildByName("itemgrid_inventory") as IItemGridWindow;
         var_4256 = var_3021.getGridItemAt(0) as IWindowContainer;
         var_3021.removeGridItem(var_4256);
         var_3085 = IStaticBitmapWrapperWindow(var_1704.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(var_1704.findChildByName("loading_icon"));
         var_2992 = new CollectibleProductPreviewer(productPreviewBitmap,null,null,null,avatarImageWidget,placeholderImage);
         var_2992.setPlaceholder();
         addMessageEvents();
         initializeData();
         updateReadyState(false);
         param2.registerUpdateReceiver(this,1);
         createWalletButton.addEventListener("WME_CLICK",onClickCreateWallet);
         moreInfoButton.addEventListener("WME_CLICK",onClickMoreInfo);
         stampsPurchaseDropdown.addEventListener("WE_SELECTED",onSelectTokenOffer);
         stampBuyButton.addEventListener("WME_CLICK",onBuyStampsClicked);
         collectButton.addEventListener("WME_CLICK",onCollectClicked);
      }
      
      private function addMessageEvents() : void
      {
         if(!var_1754)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new class_593(onCollectibleMintTokensMessage));
         _messageEvents.push(new class_321(onCollectibleMintingEnabledMessage));
         _messageEvents.push(new class_829(onCollectableMintableItemTypesMessage));
         _messageEvents.push(new class_160(onMintTokenOffersMessage));
         _messageEvents.push(new class_175(onMintItemResult));
         for each(var _loc1_ in _messageEvents)
         {
            var_1754.addMessageEvent(_loc1_);
         }
      }
      
      private function updateReadyState(param1:Boolean) : void
      {
         var _loc2_:Boolean = !var_3880 && !var_3959 && !var_3742 && !var_3816 && !var_3728;
         if(_loc2_)
         {
            if(!var_109 && !var_3798)
            {
               populateItems(_productItems);
            }
            else if(param1)
            {
               reloadPreview();
            }
         }
         var_109 = _loc2_;
         loadedContainer.visible = var_109;
         loadingContainer.visible = !var_109;
      }
      
      private function onCollectibleMintTokensMessage(param1:class_593) : void
      {
         var_3728 = false;
         var_4163 = param1.getParser().totalTokens;
         mintTokenBalanceText.caption = String(var_4163);
         updateReadyState(true);
      }
      
      private function onCollectibleMintingEnabledMessage(param1:class_321) : void
      {
         var_3816 = false;
         var_4640 = param1.getParser().enabled;
         updateReadyState(true);
      }
      
      public function set activeWallet(param1:String) : void
      {
         var_3880 = false;
         if(param1 != null)
         {
            var_3728 = true;
            var_1754.send(new class_562(param1));
         }
         updateReadyState(true);
         stampPurchasingContainer.visible = param1 != null;
         noWalletContainer.visible = param1 == null;
      }
      
      private function onCollectableMintableItemTypesMessage(param1:class_829) : void
      {
         var_3742 = false;
         _productItems = param1.getParser().collectibleProductItems;
         updateReadyState(true);
      }
      
      private function onMintTokenOffersMessage(param1:class_160) : void
      {
         _tokenOffers = param1.getParser().tokenOffers;
         var _loc3_:Vector.<String> = new Vector.<String>();
         for each(var _loc2_ in _tokenOffers)
         {
            _loc3_.push(_loc2_.amountTokens);
         }
         stampsPurchaseDropdown.populateWithVector(_loc3_);
         if(_loc3_.length > 0)
         {
            stampsPurchaseDropdown.selection = 0;
            onSelectTokenOffer(null);
         }
      }
      
      private function onSelectTokenOffer(param1:WindowEvent) : void
      {
         var _loc2_:class_1685 = selectedTokenOffer;
         silverCost.caption = String(_loc2_.silverPrice);
         if(_loc2_.silverPrice <= var_1754.catalog.getPurse().silverBalance)
         {
            stampBuyButton.enable();
         }
         else
         {
            stampBuyButton.disable();
         }
      }
      
      private function get selectedTokenOffer() : class_1685
      {
         var _loc1_:int = stampsPurchaseDropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= _tokenOffers.length)
         {
            return null;
         }
         return _tokenOffers[_loc1_];
      }
      
      private function onBuyStampsClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1685 = selectedTokenOffer;
         var _loc3_:String = var_2396.activeWallet;
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc4_:MintTokenPurchaseOffer = new MintTokenPurchaseOffer(_loc2_);
         HabboCatalog(var_1754.catalog).showPurchaseConfirmation(_loc4_,-1,_loc3_);
      }
      
      public function onInventoryInitialize(param1:String) : void
      {
         if(param1 != "furni")
         {
            return;
         }
         var_3959 = false;
         updateReadyState(true);
      }
      
      public function amountChangedForItem(param1:String, param2:int, param3:Boolean) : void
      {
         var _loc5_:class_1661 = null;
         var _loc6_:Boolean = false;
         var _loc7_:Array = null;
         if(param1 != "furni")
         {
            return;
         }
         if(var_109 && _items != null && _items.length > 0)
         {
            for each(var _loc4_ in _items)
            {
               if((_loc6_ = (_loc5_ = _loc4_.item).itemType == "i" && param3 || _loc5_.itemType == "s" && !param3) && _loc5_.itemTypeId == param2)
               {
                  _loc7_ = getIdsInInventory(_loc5_);
                  (_loc4_.renderableItem as MintableItemWrapper).amount = _loc7_.length;
                  _loc4_.updateVisuals();
                  if(_loc4_ == var_1741)
                  {
                     reloadPreview();
                  }
                  return;
               }
            }
         }
      }
      
      private function initializeData() : void
      {
         var_3742 = true;
         var_1754.send(new class_425());
         var_3816 = true;
         var_1754.send(new class_727());
         if(!var_1754.inventory.checkCategoryInitilization("furni"))
         {
            var_3959 = true;
         }
         var_3880 = true;
         if(var_2396.walletsLoaded())
         {
            activeWallet = var_2396.activeWallet;
         }
         stampBuyButton.disable();
         var_1754.send(new class_815());
      }
      
      public function populateItems(param1:Vector.<class_1661>) : void
      {
         var _loc4_:IWindowContainer = null;
         var _loc3_:MintInventoryItemRenderer = null;
         for each(var _loc2_ in param1)
         {
            _loc4_ = var_4256.clone() as IWindowContainer;
            _loc3_ = new MintInventoryItemRenderer(var_1754,_loc2_,_loc4_,this,getIdsInInventory(_loc2_).length);
            var_3021.addGridItem(_loc4_);
            _items.push(_loc3_);
         }
         var_3798 = true;
         if(_items.length > 0)
         {
            var_1741 = _items[0];
            var_1741.activate();
            initMintItemPreview();
         }
         previewWindow.visible = _items.length > 0;
      }
      
      private function getIdsInInventory(param1:class_1661) : Array
      {
         var _loc4_:String = param1.itemType;
         var _loc2_:Boolean = false;
         if(_loc4_ == "i")
         {
            _loc2_ = true;
         }
         else if(_loc4_ != "s")
         {
            return [];
         }
         var _loc5_:class_1814;
         var _loc3_:Array = (_loc5_ = var_1754.inventory).getNonRentedInventoryIds("furni",param1.itemTypeId,_loc2_);
         return _loc3_ == null ? [] : _loc3_;
      }
      
      public function selectItem(param1:MintInventoryItemRenderer) : void
      {
         if(var_1741 != null)
         {
            var_1741.deactivate();
            var_1741 = null;
         }
         if(param1 != null)
         {
            var_1741 = param1;
            var_1741.activate();
            initMintItemPreview();
         }
         else
         {
            var_1741 = null;
         }
      }
      
      private function reloadPreview() : void
      {
         initMintItemPreview();
      }
      
      private function initMintItemPreview() : void
      {
         if(var_1741 == null)
         {
            return;
         }
         var _loc3_:MintInventoryItemRenderer = var_1741;
         var_2992.clearPreviewer();
         var_1754.previewImage(_loc3_.renderableItem,var_2992);
         productNameText.caption = var_1754.getProductName(_loc3_.renderableItem);
         var _loc5_:IRenderableCollectibleItem = _loc3_.renderableItem;
         var _loc1_:class_1661 = _loc3_.item;
         var _loc2_:* = var_2396.activeWallet == null;
         var _loc4_:* = _loc5_.amount == 0;
         var _loc6_:* = var_4163 < _loc1_.price;
         var _loc7_:Boolean = isMintPeriodExpired();
         stampPricingText.caption = String(_loc1_.price);
         noFurniNotification.visible = _loc4_;
         if(_loc1_.regionLocked)
         {
            mintLockedText.caption = localization.getLocalization("shop.minting.region_locked");
            mintLockClosedImage.visible = true;
            mintLockOpenImage.visible = false;
         }
         else
         {
            mintLockedText.caption = localization.getLocalization("shop.minting.region_unlocked");
            mintLockClosedImage.visible = false;
            mintLockOpenImage.visible = true;
         }
         updateProgressBar(true);
         if(_loc2_ || _loc4_ || _loc6_ || _loc7_ || !var_4640 || var_3616)
         {
            collectButton.disable();
         }
         else
         {
            collectButton.enable();
         }
      }
      
      private function onCollectClicked(param1:WindowMouseEvent) : void
      {
         collectButton.disable();
         var _loc2_:class_3441 = var_1754.windowManager.confirm("${shop.minting.confirm.title}","${shop.minting.confirm.description}",0,onCollectConfirmDialogConfirm);
         _loc2_.titleBarColor = 2763306;
      }
      
      private function onCollectConfirmDialogConfirm(param1:class_3441, param2:WindowEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _loc3_ = var_2396.activeWallet;
            if(var_1741 == null || _loc3_ == null)
            {
               return;
            }
            if((_loc4_ = getIdsInInventory(var_1741.item)).length == 0)
            {
               return;
            }
            var_3616 = true;
            var_1754.send(new class_626(_loc4_[0],_loc3_));
         }
         reloadPreview();
      }
      
      private function onMintItemResult(param1:class_175) : void
      {
         var _loc2_:* = param1.getParser().mintResult == class_1172.var_1612;
         var_1754.catalog.events.dispatchEvent(new CatalogEvent(_loc2_ ? "COLLECTIBLES_MINT_SUCCESS" : "COLLECTIBLES_MINT_FAIL"));
         var_3616 = false;
         reloadPreview();
      }
      
      public function updateProgressBar(param1:Boolean = true, param2:uint = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:* = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         var_3292 += param2;
         var _loc9_:Boolean;
         if(!(_loc9_ = param1 || var_3292 >= PROGRESS_BAR_UPDATE_THRESHOLD) || !var_1741)
         {
            return;
         }
         var_3292 = 0;
         var _loc5_:Number = var_1741.item.startTime * 1000;
         var _loc8_:Number = var_1741.item.endTime * 1000;
         if(_loc5_ > 0 && _loc8_ > 0)
         {
            _loc6_ = new Date().time;
            _loc10_ = Math.max(0,_loc8_ - _loc6_);
            _loc3_ = _loc8_ - _loc5_;
            _loc4_ = (_loc7_ = Math.min(1,_loc10_ / _loc3_)) <= 0;
            _loc7_ = Math.max(0,_loc7_);
            _loc12_ = (_loc11_ = int(completionProgressBarPadded.width)) * _loc7_;
            completionProgressBarTop.width = _loc12_;
            completionProgressBarBottom.width = _loc12_;
            if(!_loc4_)
            {
               _loc13_ = FriendlyTime.getFriendlyTime(localization,_loc10_ / 1000);
               completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_left") + ": " + _loc13_;
            }
            else
            {
               completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_ended");
               collectButton.disable();
            }
         }
      }
      
      private function isMintPeriodExpired() : Boolean
      {
         if(var_1741 == null)
         {
            return true;
         }
         return var_1741.item.endTime * 1000 < new Date().time;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return var_1754.localizationManager;
      }
      
      private function onClickCreateWallet(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_1754.getProperty("nft.wallet.create.url"));
      }
      
      private function onClickMoreInfo(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_1754.getProperty("web.settings.wallet.relativeUrl"));
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
      
      public function clearItems() : void
      {
         if(_items)
         {
            for each(var _loc1_ in _items)
            {
               _loc1_.dispose();
            }
            _items.length = 0;
         }
         if(var_3021)
         {
            var_3021.destroyGridItems();
         }
         var_3798 = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         clearItems();
         removeMessageEvents();
         var_1754.removeUpdateReceiver(this);
         super.dispose();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(var_109)
         {
            _loc2_ = CollectionsWidget.BG_STAR_ROTATE_SPEED * (param1 / 1000);
            var_3085.rotation += _loc2_;
            var_3085.rotation %= 360;
            var_3085.invalidate();
            updateProgressBar(false,param1);
         }
         else
         {
            _loc2_ = CollectionsWidget.var_4332 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      private function get loadingContainer() : IWindowContainer
      {
         return var_1704.findChildByName("loading_contents") as IWindowContainer;
      }
      
      private function get loadedContainer() : IWindowContainer
      {
         return var_1704.findChildByName("loaded_content") as IWindowContainer;
      }
      
      private function get previewWindow() : IWindowContainer
      {
         return var_1704.findChildByName("preview_container") as IWindowContainer;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperWindow
      {
         return var_1704.findChildByName("product_preview") as IBitmapWrapperWindow;
      }
      
      private function get avatarImageWidget() : IWidgetWindow
      {
         return var_1704.findChildByName("avatar_image_widget") as IWidgetWindow;
      }
      
      private function get productNameText() : ITextWindow
      {
         return var_1704.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return var_1704.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get stampPricingText() : ITextWindow
      {
         return var_1704.findChildByName("stamp_pricing") as ITextWindow;
      }
      
      private function get collectButton() : class_3357
      {
         return var_1704.findChildByName("collect_button") as class_3357;
      }
      
      private function get noFurniNotification() : class_3437
      {
         return var_1704.findChildByName("no_furni_notify") as class_3437;
      }
      
      private function get mintLockedText() : class_3404
      {
         return var_1704.findChildByName("mint_lock_text") as class_3404;
      }
      
      private function get mintLockOpenImage() : IStaticBitmapWrapperWindow
      {
         return var_1704.findChildByName("mint_lock_open_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get mintLockClosedImage() : IStaticBitmapWrapperWindow
      {
         return var_1704.findChildByName("mint_lock_closed_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get completionProgressBar() : IWindowContainer
      {
         return var_1704.findChildByName("progress_bar") as IWindowContainer;
      }
      
      private function get completionProgressBarPadded() : IWindowContainer
      {
         return var_1704.findChildByName("progress_padded_bar") as IWindowContainer;
      }
      
      private function get completionProgressBarTop() : IWindowContainer
      {
         return var_1704.findChildByName("progress_bar_top") as IWindowContainer;
      }
      
      private function get completionProgressBarBottom() : IWindowContainer
      {
         return var_1704.findChildByName("progress_bar_bottom") as IWindowContainer;
      }
      
      private function get completionProgressBarText() : ITextWindow
      {
         return var_1704.findChildByName("progress_bar_text") as ITextWindow;
      }
      
      private function get stampPurchasingContainer() : IWindowContainer
      {
         return var_1704.findChildByName("stamp_purchasing_container") as IWindowContainer;
      }
      
      private function get noWalletContainer() : IWindowContainer
      {
         return var_1704.findChildByName("no_wallet_container") as IWindowContainer;
      }
      
      private function get createWalletButton() : class_3357
      {
         return var_1704.findChildByName("create_wallet_button") as class_3357;
      }
      
      private function get moreInfoButton() : class_3357
      {
         return var_1704.findChildByName("more_info_button") as class_3357;
      }
      
      private function get mintTokenBalanceText() : ITextWindow
      {
         return var_1704.findChildByName("mint_token_balance") as ITextWindow;
      }
      
      private function get silverCost() : ITextWindow
      {
         return var_1704.findChildByName("silver_cost_text") as ITextWindow;
      }
      
      private function get stampBuyButton() : class_3357
      {
         return var_1704.findChildByName("silver_buy_button") as class_3357;
      }
      
      private function get stampsPurchaseDropdown() : class_3520
      {
         return var_1704.findChildByName("stamps_purchase_dropdown") as class_3520;
      }
   }
}
