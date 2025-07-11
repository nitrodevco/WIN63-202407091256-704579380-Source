package com.sulake.habbo.catalog.collectibles.widget.subviews
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectibleItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.class_3861;
   import com.sulake.habbo.catalog.collectibles.renderer.model.CollectionItemWrapper;
   import com.sulake.habbo.catalog.collectibles.renderer.model.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.widget.CollectionsWidget;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1692;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_1786;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.class_827;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimRewardItemMessageComposer;
   
   public class CollectionView implements IDisposable
   {
      
      private static var PREVIEW_STATUS_NONE:int = 0;
      
      private static var PREVIEW_STATUS_BONUS:int = 1;
      
      private static var PREVIEW_STATUS_REWARD:int = 2;
      
      private static var PREVIEW_STATUS_COLLECTION:int = 3;
      
      private static var PREVIEW_STATUS_ITEM:int = 4;
      
      private static var PROGRESS_BAR_UPDATE_THRESHOLD:int = 1000;
       
      
      private var var_318:Boolean;
      
      private var var_1900:CollectionsWidget;
      
      private var _container:IWindowContainer;
      
      private var var_1734:class_1692;
      
      private var _previewStatus:int;
      
      private var var_3292:Number;
      
      private var _gridItems:Vector.<CollectibleItemRenderer>;
      
      private var var_1741:CollectibleItemRenderer;
      
      private var var_2992:CollectibleProductPreviewer;
      
      public function CollectionView(param1:CollectionsWidget, param2:IWindowContainer, param3:class_1692)
      {
         super();
         var_1900 = param1;
         _container = param2;
         var_1734 = param3;
         _gridItems = new Vector.<CollectibleItemRenderer>();
         _previewStatus = PREVIEW_STATUS_NONE;
         var_2992 = new CollectibleProductPreviewer(productPreviewBitmap,badgeImageWidget,petImageWidget,unknownImageWindow,avatarImageWidget,placeholderImage,effectImageWidget,param1.controller.avatarRenderManager);
         initHeader();
         initCollectionPreview();
         populateGridItems();
         productNameContainer.addEventListener("WME_OVER",onProductNameHover);
         productNameContainer.addEventListener("WME_OUT",onProductNameUnhover);
         claimButton.addEventListener("WME_CLICK",onClickClaim);
      }
      
      private function initHeader() : void
      {
         titleText.caption = localization.getLocalization("collectibles.set." + var_1734.collectionId,var_1734.collectionName);
         var _loc1_:int = var_1734.collectedItemCount;
         var _loc2_:int = var_1734.totalItemCount;
         progressText.caption = _loc1_ + "/" + _loc2_;
         var _loc3_:uint = class_3861.getColor(_loc1_,_loc2_);
         progressColorContainer.color = _loc3_;
      }
      
      private function initCollectionPreview() : void
      {
         var _loc2_:class_1786 = initRewardClaim();
         var _loc1_:* = var_1734.collectedItemCount == var_1734.totalItemCount;
         collectionProgressContainer.visible = true;
         collectionProgressScoreText.caption = localization.getLocalizationWithParams("collectibles.preview.score","","progress","<font color=\"#00FF12\">" + var_1734.collectionScore + "</font>","goal",var_1734.collectionTotalScore + "");
         collectionProgressRewardText.caption = localization.getLocalizationWithParams(_loc1_ ? "collectibles.preview.reward_collected" : "collectibles.preview.reward","","amount","<font color=\"#FFC800\">" + var_1734.collectionBoostScore + "</font>");
         productNameContainer.visible = false;
         productProgressContainer.visible = false;
         setProductInfoVisible(false);
         if(_loc2_ == null)
         {
            var_2992.setPlaceholder();
         }
         else
         {
            var_1900.controller.previewImage(new CollectionItemWrapper(_loc2_),var_2992);
         }
      }
      
      private function initRewardClaim() : class_1786
      {
         var _loc5_:Boolean = nftCollection.hasRewardItem;
         var _loc4_:Boolean = nftCollection.hasBonusItem;
         var _loc3_:Boolean = nftCollection.rewardClaimed;
         var _loc2_:Boolean = nftCollection.canClaimReward;
         var _loc1_:Boolean = nftCollection.bonusClaimed;
         var _loc6_:Boolean;
         if(_loc6_ = nftCollection.canClaimBonus)
         {
            initRewardItem(var_1734.bonusItem,true,true);
            return var_1734.bonusItem;
         }
         if(_loc2_)
         {
            initRewardItem(var_1734.rewardItem,true,false);
            return var_1734.rewardItem;
         }
         if(_loc4_ && !_loc1_)
         {
            initRewardItem(var_1734.bonusItem,_loc6_,true);
            return var_1734.bonusItem;
         }
         if(_loc5_ && !_loc3_)
         {
            initRewardItem(var_1734.rewardItem,_loc2_,false);
            return var_1734.rewardItem;
         }
         _previewStatus = PREVIEW_STATUS_COLLECTION;
         completionContainer.visible = false;
         return null;
      }
      
      private function initRewardItem(param1:class_1786, param2:Boolean, param3:Boolean) : void
      {
         _previewStatus = param3 ? PREVIEW_STATUS_BONUS : PREVIEW_STATUS_REWARD;
         completionContainer.visible = true;
         completionRewardNameText.caption = var_1900.controller.getProductName(new CollectionItemWrapper(param1));
         completionProgressBar.visible = param3;
         completionHeaderContainer.height = param3 ? 60 : 38;
         if(param3)
         {
            updateBonusProgressBar();
         }
         var _loc4_:int;
         if((_loc4_ = param3 ? nftCollection.claimingBonusStatus : nftCollection.claimingRewardStatus) == class_1692.var_232)
         {
            claimButton.enable();
         }
         else
         {
            claimButton.disable();
         }
         claimButton.visible = param2;
      }
      
      private function onClickClaim(param1:WindowMouseEvent) : void
      {
         if(var_1900.activeWallet == null)
         {
            return;
         }
         if(_previewStatus == PREVIEW_STATUS_BONUS)
         {
            var_1734.claimBonusAwaiting();
            var_1900.controller.send(new class_827(nftCollection.collectionId,var_1900.activeWallet));
            var_1900.sendClaimWaitNotification();
         }
         else
         {
            if(_previewStatus != PREVIEW_STATUS_REWARD)
            {
               return;
            }
            var_1734.claimRewardAwaiting();
            var_1900.controller.send(new NftCollectiblesClaimRewardItemMessageComposer(nftCollection.collectionId,var_1900.activeWallet));
            var_1900.sendClaimWaitNotification();
         }
         claimButton.disable();
      }
      
      public function claimingFinished(param1:Boolean, param2:Boolean) : void
      {
         if(_previewStatus == PREVIEW_STATUS_REWARD || _previewStatus == PREVIEW_STATUS_BONUS)
         {
            initCollectionPreview();
         }
      }
      
      public function updateBonusProgressBar(param1:Boolean = true, param2:uint = 0) : void
      {
         var _loc4_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var_3292 += param2;
         if(_previewStatus != PREVIEW_STATUS_BONUS)
         {
            return;
         }
         var _loc8_:Boolean;
         if(!(_loc8_ = param1 || var_3292 >= PROGRESS_BAR_UPDATE_THRESHOLD))
         {
            return;
         }
         var_3292 = 0;
         if(var_1734.isBonusSnapshotPassed())
         {
            completionProgressBarTop.width = 0;
            completionProgressBarBottom.width = 0;
            completionProgressBarText.caption = localization.getLocalization("shop.minting.time_ended");
            return;
         }
         var _loc5_:Number = var_1734.releasedTime;
         var _loc7_:Number = var_1734.snapshotTime;
         if(_loc5_ > 0 && _loc7_ > 0)
         {
            _loc4_ = new Date().time;
            _loc9_ = Math.max(0,_loc7_ - _loc4_);
            _loc3_ = _loc7_ - _loc5_;
            _loc6_ = Math.min(1,Math.max(0,_loc9_ / _loc3_));
            _loc11_ = (_loc10_ = int(completionProgressBarPadded.width)) * _loc6_;
            completionProgressBarTop.width = _loc11_;
            completionProgressBarBottom.width = _loc11_;
            _loc12_ = FriendlyTime.getFriendlyTime(localization,_loc9_ / 1000);
            completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_left","") + ": " + _loc12_;
         }
      }
      
      private function initMintedItemPreview(param1:class_1786) : void
      {
         _previewStatus = PREVIEW_STATUS_ITEM;
         completionContainer.visible = false;
         collectionProgressContainer.visible = false;
         var_2992.clearPreviewer();
         var _loc2_:IRenderableCollectibleItem = new CollectionItemWrapper(param1);
         var_1900.controller.previewImage(_loc2_,var_2992);
         productNameContainer.visible = true;
         productNameText.caption = var_1900.controller.getProductName(_loc2_);
         productProgressContainer.visible = true;
         productProgressScoreText.caption = localization.getLocalizationWithParams(param1.amount > 0 ? "collectibles.preview.product.complete" : "collectibles.preview.product.incomplete","","amount","<font color=\"#FFC800\">" + param1.score + "</font>");
         initInfoEntries(param1);
      }
      
      private function initInfoEntries(param1:class_1786) : void
      {
         var _loc5_:String = null;
         clearInfoEntries();
         var _loc3_:String = String(localization.getLocalization("collectibles.item.type"));
         var _loc6_:String = String(localization.getLocalization("collectibles.item.rarity"));
         var _loc7_:String = String(localization.getLocalization("collectibles.item.xp"));
         switch(param1.productTypeId)
         {
            case 0:
               _loc5_ = String(localization.getLocalization("product.type.wall"));
               break;
            case 1:
               _loc5_ = String(localization.getLocalization("product.type.room"));
               break;
            case 2:
               _loc5_ = String(localization.getLocalization("product.type.effect"));
               break;
            case 4:
               _loc5_ = String(localization.getLocalization("product.type.badge"));
               break;
            case 9:
               _loc5_ = String(localization.getLocalization("product.type.chatstyle"));
               break;
            case 10:
               _loc5_ = String(localization.getLocalization("product.type.pets"));
               break;
            case 11:
               _loc5_ = String(localization.getLocalization("product.type.clothing"));
               break;
            default:
               _loc5_ = "Unknown";
         }
         var _loc2_:String = param1.rarity;
         var _loc4_:String = String(param1.score);
         addInfoEntry(_loc3_,_loc5_);
         addInfoEntry(_loc6_,_loc2_);
         addInfoEntry(_loc7_,_loc4_);
      }
      
      private function addInfoEntry(param1:String, param2:String) : void
      {
         var _loc3_:IWindowContainer = var_1900.productInfoEntryTemplate.clone() as IWindowContainer;
         _loc3_.findChildByName("product_info_key").caption = param1;
         _loc3_.findChildByName("product_info_value").caption = param2;
         productInfoList.addListItem(_loc3_);
      }
      
      private function clearInfoEntries() : void
      {
         productInfoList.removeListItems();
      }
      
      private function setProductInfoVisible(param1:Boolean) : void
      {
         productInfoContainer.visible = param1;
      }
      
      private function onProductNameUnhover(param1:WindowMouseEvent) : void
      {
         setProductInfoVisible(false);
      }
      
      private function onProductNameHover(param1:WindowMouseEvent) : void
      {
         setProductInfoVisible(true);
      }
      
      public function populateGridItems() : void
      {
         var _loc4_:IWindowContainer = null;
         var _loc3_:CollectibleItemRenderer = null;
         clearGridItems();
         var _loc1_:IWindowContainer = var_1900.gridItemTemplate;
         for each(var _loc2_ in var_1734.items)
         {
            _loc4_ = _loc1_.clone() as IWindowContainer;
            _loc3_ = new CollectibleItemRenderer(var_1900.controller,_loc2_,_loc4_,this);
            itemGrid.addGridItem(_loc4_);
            _gridItems.push(_loc3_);
         }
      }
      
      public function clearGridItems() : void
      {
         if(_gridItems)
         {
            for each(var _loc1_ in _gridItems)
            {
               _loc1_.dispose();
            }
            _gridItems.length = 0;
         }
         if(itemGrid)
         {
            itemGrid.destroyGridItems();
         }
      }
      
      public function get nftCollection() : class_1692
      {
         return var_1734;
      }
      
      public function selectItem(param1:CollectibleItemRenderer) : void
      {
         if(var_1741 == param1)
         {
            var_1741.deactivate();
            var_1741 = null;
            initCollectionPreview();
            return;
         }
         if(var_1741 != null)
         {
            var_1741.deactivate();
            var_1741 = null;
         }
         if(param1 != null)
         {
            var_1741 = param1;
            var_1741.activate();
            initMintedItemPreview(param1.item);
         }
         else
         {
            var_1741 = null;
            initCollectionPreview();
         }
      }
      
      public function dispose() : void
      {
         if(var_318)
         {
            return;
         }
         var_2992.clearPreviewer();
         clearInfoEntries();
         clearGridItems();
         productNameContainer.removeEventListener("WME_OVER",onProductNameHover);
         productNameContainer.removeEventListener("WME_OUT",onProductNameUnhover);
         claimButton.removeEventListener("WME_CLICK",onClickClaim);
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return var_1900.controller.localizationManager;
      }
      
      private function get titleText() : ITextWindow
      {
         return _container.findChildByName("collection_name") as ITextWindow;
      }
      
      private function get progressColorContainer() : class_3437
      {
         return _container.findChildByName("progress_color") as class_3437;
      }
      
      private function get progressText() : ITextWindow
      {
         return _container.findChildByName("progress_text") as ITextWindow;
      }
      
      private function get completionContainer() : IWindowContainer
      {
         return _container.findChildByName("bonus_or_reward_container") as IWindowContainer;
      }
      
      private function get completionHeaderContainer() : IWindowContainer
      {
         return _container.findChildByName("completion_header_container") as IWindowContainer;
      }
      
      private function get completionRewardNameText() : ITextWindow
      {
         return _container.findChildByName("reward_furni_name") as ITextWindow;
      }
      
      private function get completionProgressBar() : IWindowContainer
      {
         return _container.findChildByName("progress_bar") as IWindowContainer;
      }
      
      private function get completionProgressBarPadded() : IWindowContainer
      {
         return _container.findChildByName("progress_padded_bar") as IWindowContainer;
      }
      
      private function get completionProgressBarTop() : IWindowContainer
      {
         return _container.findChildByName("progress_bar_top") as IWindowContainer;
      }
      
      private function get completionProgressBarBottom() : IWindowContainer
      {
         return _container.findChildByName("progress_bar_bottom") as IWindowContainer;
      }
      
      private function get completionProgressBarText() : ITextWindow
      {
         return _container.findChildByName("progress_bar_text") as ITextWindow;
      }
      
      private function get claimButton() : class_3357
      {
         return _container.findChildByName("claim_button") as class_3357;
      }
      
      private function get collectionProgressContainer() : IWindowContainer
      {
         return _container.findChildByName("collection_progress_container") as IWindowContainer;
      }
      
      private function get collectionProgressScoreText() : ITextWindow
      {
         return _container.findChildByName("preview_score_text") as ITextWindow;
      }
      
      private function get collectionProgressRewardText() : ITextWindow
      {
         return _container.findChildByName("preview_reward_text") as ITextWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperWindow
      {
         return _container.findChildByName("product_preview") as IBitmapWrapperWindow;
      }
      
      private function get productNameContainer() : IWindowContainer
      {
         return _container.findChildByName("product_name_container") as IWindowContainer;
      }
      
      private function get productNameText() : ITextWindow
      {
         return _container.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get productInfoContainer() : IWindowContainer
      {
         return _container.findChildByName("product_info_container") as IWindowContainer;
      }
      
      private function get productInfoList() : IItemListWindow
      {
         return _container.findChildByName("product_info_list") as IItemListWindow;
      }
      
      private function get productProgressContainer() : IWindowContainer
      {
         return _container.findChildByName("product_progress_container") as IWindowContainer;
      }
      
      private function get productProgressScoreText() : ITextWindow
      {
         return _container.findChildByName("procuct_score_text") as ITextWindow;
      }
      
      private function get itemGrid() : IItemGridWindow
      {
         return _container.findChildByName("itemgrid_collection") as IItemGridWindow;
      }
      
      private function get avatarImageWidget() : IWidgetWindow
      {
         return _container.findChildByName("avatar_image_widget") as IWidgetWindow;
      }
      
      private function get badgeImageWidget() : IWidgetWindow
      {
         return _container.findChildByName("badge_image_widget") as IWidgetWindow;
      }
      
      private function get petImageWidget() : IWidgetWindow
      {
         return _container.findChildByName("pet_image_widget") as IWidgetWindow;
      }
      
      private function get effectImageWidget() : IWidgetWindow
      {
         return _container.findChildByName("effect_image_widget") as IWidgetWindow;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
   }
}
