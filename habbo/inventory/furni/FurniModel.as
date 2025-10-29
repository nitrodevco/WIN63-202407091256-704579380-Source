package com.sulake.habbo.inventory.furni
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IInventoryModel;
   import com.sulake.habbo.inventory.class_3425;
   import com.sulake.habbo.inventory.events.HabboInventoryCategoryInitializeEvent;
   import com.sulake.habbo.inventory.items.CreditTradingItem;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.trading.TradingModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.sound.class_2240;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.room.session.OpenFlatConnectionMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.inventory.furni.class_1707;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryWhenNotInRoomComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestRoomPropertySet;
   
   public class FurniModel implements IInventoryModel
   {
      
      private static const IMAGE_UPDATE_DELAY_MS:int = 50;
       
      
      private var var_319:HabboInventory;
      
      private var var_1631:FurniView;
      
      private var var_1691:Vector.<GroupItem>;
      
      private var _assets:IAssetLibrary;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _roomEngine:IRoomEngine;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _soundManager:class_2240;
      
      private var _disposed:Boolean = false;
      
      private var var_3099:int = -1;
      
      private var var_2052:Boolean;
      
      private var var_2423:Timer;
      
      private var var_4340:Boolean;
      
      private var _catalog:IHabboCatalog;
      
      private var var_2853:Dictionary;
      
      private var _localization:IHabboLocalizationManager;
      
      private var var_4775:Array;
      
      private var var_4384:Boolean;
      
      private var var_3408:Dictionary;
      
      private var var_638:String;
      
      private var _imageUpdateCumulativeTime:int = 0;
      
      private var _roomItemToSelect:FurnitureItem = null;
      
      private var _isInRoom:Boolean = false;
      
      public function FurniModel(param1:HabboInventory, param2:MarketplaceModel, param3:IHabboWindowManager, param4:IHabboCommunicationManager, param5:IAssetLibrary, param6:IRoomEngine, param7:IHabboCatalog, param8:class_2240, param9:IHabboLocalizationManager)
      {
         super();
         var_319 = param1;
         _communication = param4;
         _windowManager = param3;
         _assets = param5;
         _roomEngine = param6;
         _roomEngine.events.addEventListener("REOE_PLACED",onObjectPlaced);
         _catalog = param7;
         _soundManager = param8;
         _localization = param9;
         var_2853 = new Dictionary();
         var_4775 = var_319.getProperty("catalog.preview.alignment.bottom").split(",");
         var_2423 = new Timer(50);
         var_2423.addEventListener("timer",onImageUpdateTimerEvent);
         var_3408 = new Dictionary();
         var_3408["furni"] = null;
         var_3408["rentables"] = null;
         clearFurniList();
         var_1631 = new FurniView(this,param2,_windowManager,_assets,_roomEngine);
      }
      
      private static function arrayToSet(param1:Array) : Dictionary
      {
         var _loc2_:Dictionary = new Dictionary();
         for each(var _loc3_ in param1)
         {
            _loc2_[_loc3_] = true;
         }
         return _loc2_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get controller() : HabboInventory
      {
         return var_319;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get isTradingOpen() : Boolean
      {
         return var_319.getSubCategoryViewId() == "trading";
      }
      
      public function get isPrivateRoom() : Boolean
      {
         if(!var_319 || !var_319.roomSession)
         {
            return false;
         }
         return var_319.roomSession.isPrivateRoom;
      }
      
      public function get furniData() : Vector.<GroupItem>
      {
         return var_1691;
      }
      
      public function get soundManager() : class_2240
      {
         return _soundManager;
      }
      
      public function get showingRentedFurni() : Boolean
      {
         return var_4384;
      }
      
      public function set categorySelection(param1:GroupItem) : void
      {
         var_3408[var_638] = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_319 = null;
            if(var_1691 != null)
            {
               var_1691 = null;
            }
            if(var_1631 != null)
            {
               var_1631.dispose();
               var_1631 = null;
            }
            if(_roomEngine != null)
            {
               if(_roomEngine.events != null)
               {
                  _roomEngine.events.removeEventListener("REOE_PLACED",onObjectPlaced);
               }
               _roomEngine = null;
            }
            _communication = null;
            _assets = null;
            _windowManager = null;
            _catalog = null;
            _soundManager = null;
            _localization = null;
            if(var_2423 != null)
            {
               var_2423.removeEventListener("timerComplete",onImageUpdateTimerEvent);
               var_2423.stop();
               var_2423 = null;
            }
            for each(var _loc1_ in var_2853)
            {
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
            }
            var_2853 = null;
            _disposed = true;
         }
      }
      
      public function createItemWindow(param1:*) : IWindowContainer
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:XML = null;
         if(var_2853[param1] == null)
         {
            _loc4_ = _assets.getAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = XML(_loc2_.content);
            var_2853[param1] = _windowManager.buildFromXML(_loc3_) as IWindowContainer;
         }
         return var_2853[param1].clone();
      }
      
      public function insertFurniture(param1:Map) : void
      {
         var _loc2_:FurnitureItem = null;
         var _loc4_:class_1707 = null;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc14_:HabboInventoryCategoryInitializeEvent = null;
         var _loc5_:Boolean = var_319.setInventoryCategoryInit("furni");
         var _loc12_:Dictionary = getAllStripIds();
         var _loc9_:Array = param1.getKeys();
         var _loc10_:Dictionary = arrayToSet(_loc9_);
         var _loc3_:Vector.<int> = new Vector.<int>(0);
         var _loc13_:Vector.<int> = new Vector.<int>(0);
         for each(var _loc6_ in _loc9_)
         {
            if(!(_loc6_ in _loc12_))
            {
               _loc3_.push(_loc6_);
            }
         }
         for(_loc11_ in _loc12_)
         {
            if(!(_loc11_ in _loc10_))
            {
               _loc13_.push(_loc11_);
            }
         }
         var _loc8_:* = _loc12_.length == 0;
         for each(_loc11_ in _loc13_)
         {
            removeFurni(_loc11_);
         }
         for each(_loc11_ in _loc3_)
         {
            _loc4_ = class_1707(param1.getValue(_loc11_));
            _loc2_ = new FurnitureItem(_loc4_);
            addOrUpdateItem(_loc2_,true);
         }
         if(!_loc8_)
         {
            if(_loc3_.length > 0)
            {
               updateItemLocks();
            }
         }
         setListInitialized();
         var_1631.addItems(var_1691);
         if(_loc8_)
         {
            selectFirstItem();
         }
         else if(getSelectedItem() == null)
         {
            selectFirstItem();
         }
         setViewToState();
         initListImages();
         if(_loc5_)
         {
            _loc14_ = new HabboInventoryCategoryInitializeEvent("furni");
            var_319.events.dispatchEvent(_loc14_);
         }
      }
      
      public function isListInited() : Boolean
      {
         return var_4340;
      }
      
      public function setListInitialized() : void
      {
         var_4340 = true;
      }
      
      public function createGroupItem(param1:int, param2:int, param3:IStuffData, param4:Number = NaN, param5:Boolean = false) : GroupItem
      {
         var _loc8_:BitmapData = null;
         var _loc7_:IAsset = null;
         if(param2 == 2)
         {
            if((_loc7_ = _windowManager.assets.getAssetByName("inventory_furni_icon_wallpaper")) != null)
            {
               _loc8_ = (_loc7_.content as BitmapData).clone();
            }
         }
         else if(param2 == 3)
         {
            if((_loc7_ = _windowManager.assets.getAssetByName("inventory_furni_icon_floor")) != null)
            {
               _loc8_ = (_loc7_.content as BitmapData).clone();
            }
         }
         else if(param2 == 4)
         {
            if((_loc7_ = _windowManager.assets.getAssetByName("inventory_furni_icon_landscape")) != null)
            {
               _loc8_ = (_loc7_.content as BitmapData).clone();
            }
         }
         var _loc9_:String = "center";
         var _loc6_:String = _roomEngine.getFurnitureType(param1);
         if(var_4775.indexOf(_loc6_) > -1)
         {
            _loc9_ = "bottom";
         }
         return new GroupItem(this,param1,param2,_roomEngine,param3,param4,_loc8_,param5,_loc9_);
      }
      
      public function createCreditGroupItem(param1:int) : GroupItem
      {
         return new CreditTradingItem(this,_windowManager.assets,_roomEngine,param1);
      }
      
      public function requestInitialization() : void
      {
         var _loc1_:IConnection = _communication.connection;
         if(_loc1_ != null)
         {
            _loc1_.send(new RequestFurniInventoryWhenNotInRoomComposer());
         }
      }
      
      public function categorySwitch(param1:String) : void
      {
         if(var_319.isVisible)
         {
            class_14.log("FurniMode.categorySwitch: " + param1);
            switch(param1)
            {
               case "furni":
               case "rentables":
                  var_638 = param1;
                  var_4384 = var_638 == "rentables";
                  var_1631.resetFilters(param1);
                  updateCategorySelection();
                  updateItemLocks();
            }
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         var_319.checkCategoryInitilization("marketplace");
         return var_1631.getWindowContainer();
      }
      
      public function closingInventoryView() : void
      {
         if(var_1631.isVisible)
         {
            resetUnseenItems();
         }
      }
      
      public function updateItemLocks() : void
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         var _loc1_:TradingModel = var_319.tradingModel;
         if(_loc1_ != null)
         {
            _loc3_ = _loc3_.concat(_loc1_.getOwnItemIdsInTrade());
         }
         var _loc4_:MarketplaceModel;
         if((_loc4_ = var_319.marketplaceModel) != null && _loc4_.getOfferItem() != null)
         {
            _loc3_ = _loc3_.concat([_loc4_.getOfferItem().ref]);
         }
         if(_loc3_.length == 0)
         {
            removeAllLocks();
            return;
         }
         for each(_loc2_ in var_1691)
         {
            _loc2_.updateLocks(_loc3_);
         }
         var_1631.updateActionView();
      }
      
      public function addLockTo(param1:int) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_1691)
         {
            _loc2_.addLockTo(param1);
         }
         var_1631.updateActionView();
      }
      
      public function removeLockFrom(param1:int) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in var_1691)
         {
            _loc2_.removeLockFrom(param1);
         }
         var_1631.updateActionView();
      }
      
      public function clearFurniList() : void
      {
         var_1691 = new Vector.<GroupItem>(0);
         if(var_1631 != null)
         {
            var_1631.clearViews();
         }
      }
      
      public function removeUnseenFurniCounter(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc6_:class_3425;
         if((_loc6_ = var_319.unseenItemTracker) == null)
         {
            return false;
         }
         var _loc4_:GroupItem;
         if((_loc4_ = getItemById(param1)) == null)
         {
            return false;
         }
         if(var_638 == "rentables")
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 1;
         }
         var _loc5_:Boolean;
         if(_loc5_ = var_319.unseenItemTracker.isUnseen(_loc3_,param1))
         {
            _loc2_ = _loc6_.removeUnseen(_loc3_,param1);
         }
         if(_loc2_)
         {
            _loc6_.resetCategoryIfEmpty(_loc3_);
         }
         return _loc2_;
      }
      
      public function getItemWithStripId(param1:int) : GroupItem
      {
         var _loc2_:class_3393 = null;
         for each(var _loc3_ in var_1691)
         {
            _loc2_ = _loc3_.getItem(param1);
            if(_loc2_)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getGroupItemByItemTypeId(param1:int, param2:Boolean) : GroupItem
      {
         for each(var _loc3_ in var_1691)
         {
            if(_loc3_.type == param1 && param2 == _loc3_.isWallItem)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function addOrUpdateItem(param1:FurnitureItem, param2:Boolean) : void
      {
         var _loc3_:GroupItem = null;
         if(!param1.groupable && param1.category != 19)
         {
            _loc3_ = addOrUpdateNonGroupableItem(param1,param2);
         }
         else
         {
            _loc3_ = addOrUpdateGroupableItem(param1,param2);
         }
         if(!param2)
         {
            _loc3_.hasUnseenItems = true;
         }
         if(_loc3_.isSelected)
         {
            var_1631.updateActionView();
         }
         _catalog.itemAddedToInventory(param1.type,param1.id,param1.category);
         _catalog.collectorHub.itemAddedToInventory(param1.type,param1.id,param1.isWallItem);
      }
      
      public function setViewToState() : void
      {
         var_1631.setViewToState();
      }
      
      public function removeFurni(param1:int) : GroupItem
      {
         var _loc3_:GroupItem = null;
         var _loc4_:int = 0;
         var _loc2_:class_3393 = null;
         _loc4_ = 0;
         while(_loc4_ < var_1691.length)
         {
            _loc3_ = var_1691[_loc4_] as GroupItem;
            _loc2_ = _loc3_.remove(param1);
            if(_loc2_)
            {
               if(_loc3_.getTotalCount() <= 0)
               {
                  var_1691.splice(_loc4_,1);
                  if(var_1631 && var_1631.grid)
                  {
                     var_1631.grid.itemWasUpdated(_loc3_);
                  }
                  if(_loc3_.isSelected)
                  {
                     selectFirstItem();
                  }
                  _loc3_.dispose();
               }
               else
               {
                  var_1631.updateActionView();
               }
               var_1631.setViewToState();
               _catalog.collectorHub.itemRemovedFromInventory(_loc2_.type,_loc2_.id,_loc2_.isWallItem);
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function updatePostItCount(param1:int, param2:int) : void
      {
         var _loc3_:FurnitureItem = null;
         var _loc5_:LegacyStuffData = null;
         for each(var _loc4_ in var_1691)
         {
            _loc3_ = _loc4_.getItem(param1) as FurnitureItem;
            if(_loc3_ != null)
            {
               (_loc5_ = _loc3_.stuffData as LegacyStuffData).setString(String(param2));
               _loc3_.stuffData = _loc5_;
               _loc4_.replaceItem(param1,_loc3_);
            }
         }
      }
      
      public function selectFirstItem() : void
      {
         var _loc2_:IWindowContainer = var_1631.getFirstThumb();
         if(_loc2_ == null)
         {
            return;
         }
         for each(var _loc1_ in var_1691)
         {
            if(_loc1_.window == _loc2_)
            {
               _loc1_.isSelected = true;
               _loc1_.selectedItemIndex = -1;
               break;
            }
         }
         var_1631.updateActionView();
      }
      
      public function displayItemInfo(param1:GroupItem) : void
      {
         if(var_1631 && !var_1631.disposed)
         {
            var_1631.displayItemInfo(param1);
         }
      }
      
      public function getSelectedItem() : GroupItem
      {
         for each(var _loc1_ in var_1691)
         {
            if(_loc1_.isSelected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function removeSelections() : void
      {
         for each(var _loc1_ in var_1691)
         {
            _loc1_.isSelected = false;
         }
      }
      
      public function canUserOfferToTrade() : Boolean
      {
         return var_319.canUserOfferToTrade();
      }
      
      public function removeAllLocks() : void
      {
         for each(var _loc1_ in var_1691)
         {
            _loc1_.removeAllLocks();
         }
         if(var_1631 != null)
         {
            var_1631.updateActionView();
         }
      }
      
      public function cancelFurniInMover() : void
      {
         if(var_3099 > -1)
         {
            _roomEngine.cancelRoomObjectInsert();
            var_2052 = false;
            var_3099 = -1;
         }
      }
      
      public function requestSelectedFurniPlacement(param1:Boolean = false, param2:Boolean = true) : Boolean
      {
         var _loc4_:GroupItem;
         if((_loc4_ = getSelectedItem()) == null)
         {
            return false;
         }
         if(_loc4_.getUnlockedCount() == 0)
         {
            return false;
         }
         if(_loc4_.selectedItemIndex < 0 && param2)
         {
            _loc4_.selectedItemIndex = _loc4_.getTotalCount() - 1;
         }
         var _loc3_:FurnitureItem = _loc4_.getAt(_loc4_.selectedItemIndex);
         if(_loc3_ == null)
         {
            return false;
         }
         if(_loc3_.isRented && _loc3_.flatId > -1)
         {
            return false;
         }
         if(_loc3_.category == 3 || _loc3_.category == 2 || _loc3_.category == 4)
         {
            if(param1)
            {
               return false;
            }
            _communication.connection.send(new RequestRoomPropertySet(_loc3_.id));
         }
         else
         {
            requestSelectedFurniToMover(_loc3_);
         }
         var_1631.updateActionView();
         return true;
      }
      
      public function requestSelectedFurniToTrading(param1:int = 1, param2:ITextFieldWindow = null) : void
      {
         var itemsInTrade:Vector.<class_3393>;
         var coreItem:class_3393;
         var itemIds:Vector.<int>;
         var furnitureItem:class_3393;
         var trading:TradingModel;
         var ownItemCount:int;
         var itemsToTrade:int = param1;
         var offerInTradingCount:ITextFieldWindow = param2;
         var groupItem:GroupItem = getSelectedItem();
         if(groupItem == null)
         {
            return;
         }
         itemsInTrade = groupItem.getItemsForTrade(itemsToTrade);
         if(itemsInTrade.length == 0)
         {
            return;
         }
         coreItem = null;
         itemIds = new Vector.<int>();
         for each(furnitureItem in itemsInTrade)
         {
            itemIds.push(furnitureItem.id);
            if(coreItem == null)
            {
               coreItem = furnitureItem;
            }
         }
         if(coreItem == null)
         {
            return;
         }
         trading = var_319.tradingModel;
         if(trading != null)
         {
            ownItemCount = int(trading.getOwnItemIdsInTrade().length);
            if(ownItemCount + itemIds.length <= 1500)
            {
               if(offerInTradingCount != null)
               {
                  offerInTradingCount.caption = String(itemIds.length);
               }
               trading.requestAddItemsToTrading(itemIds,coreItem.isWallItem,coreItem.type,coreItem.category,coreItem.groupable,coreItem.stuffData);
            }
            else
            {
               if(offerInTradingCount != null)
               {
                  offerInTradingCount.caption = "1";
               }
               _windowManager.alert("${trading.items.too_many_items.title}","${trading.items.too_many_items.desc}",0,function(param1:class_3348, param2:WindowEvent):void
               {
                  param1.dispose();
               });
            }
         }
         else if(offerInTradingCount != null)
         {
            offerInTradingCount.caption = "1";
         }
         var_1631.updateActionView();
      }
      
      public function gotoRoom() : void
      {
         var _loc2_:GroupItem = getSelectedItem();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:FurnitureItem = _loc2_.peek();
         if(_loc1_ == null)
         {
            return;
         }
         if(_communication == null)
         {
            return;
         }
         var _loc3_:IConnection = _communication.connection;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.send(new OpenFlatConnectionMessageComposer(_loc1_.flatId));
         _roomItemToSelect = _loc1_;
      }
      
      public function requestSelectedFurniSelling() : void
      {
         var _loc2_:GroupItem = getSelectedItem();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:FurnitureItem = _loc2_.getOneForTrade();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc3_:MarketplaceModel = var_319.marketplaceModel;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.startOfferMaking(_loc1_);
      }
      
      public function requestCurrentActionOnSelection() : void
      {
         if(isTradingOpen)
         {
            requestSelectedFurniToTrading();
         }
         else
         {
            requestSelectedFurniPlacement(false);
         }
      }
      
      public function requestClose() : void
      {
         var_319.closeView();
      }
      
      public function showUseProductSelection() : void
      {
         var _loc1_:class_3393 = null;
         var _loc2_:GroupItem = getSelectedItem();
         if(_loc2_ != null && _loc2_.peek() != null)
         {
            _loc1_ = _loc2_.peek();
            if(_loc1_)
            {
               _roomEngine.showUseProductSelection(_loc1_.ref,_loc1_.type);
            }
         }
      }
      
      public function subCategorySwitch(param1:String) : void
      {
         switch(param1)
         {
            case "trading":
               cancelFurniInMover();
               if(var_1631 != null)
               {
                  var_1631.updateActionView();
               }
               break;
            case "empty":
               removeAllLocks();
               if(var_1631 != null)
               {
                  var_1631.updateActionView();
               }
         }
      }
      
      public function updateActionView() : void
      {
         var_1631.updateActionView();
      }
      
      public function updateView() : void
      {
         if(var_1631 != null)
         {
            var_1631.updateActionView();
            var_1631.updateGridFilters();
         }
      }
      
      public function resetUnseenItems() : void
      {
         if(!var_1631)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(var_638 == "rentables")
         {
            var_319.unseenItemTracker.resetCategory(2);
            _loc2_ = true;
         }
         else
         {
            var_319.unseenItemTracker.resetCategory(1);
         }
         for each(var _loc1_ in var_1691)
         {
            if(_loc1_.hasUnseenItems && _loc1_.isRented == _loc2_)
            {
               _loc1_.hasUnseenItems = false;
            }
         }
         var_319.updateUnseenItemCounts();
      }
      
      public function updateUnseenItemsThumbs() : void
      {
         var _loc2_:Array = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(!var_1631 || !var_1631.grid)
         {
            return;
         }
         var _loc1_:Array = [];
         var _loc5_:Array = var_319.unseenItemTracker.getIds(1);
         var _loc6_:Array = var_319.unseenItemTracker.getIds(2);
         _loc1_ = _loc1_.concat(_loc5_);
         _loc1_ = _loc1_.concat(_loc6_);
         if(!_loc1_ || _loc1_.length == 0)
         {
            return;
         }
         for each(_loc3_ in var_1691)
         {
            _loc2_ = _loc3_.getFurniIds();
            for each(_loc4_ in _loc2_)
            {
               if(_loc1_.indexOf(_loc4_) != -1)
               {
                  _loc3_.hasUnseenItems = true;
                  moveItemToTop(_loc3_);
                  var_1631.grid.itemWasUpdated(_loc3_);
                  break;
               }
            }
         }
      }
      
      public function extendRentPeriod() : void
      {
         var _loc2_:GroupItem = getSelectedItem();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:FurnitureItem = _loc2_.peek();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc3_:class_3365 = var_319.getFurnitureData(_loc1_.type,_loc1_.isWallItem ? "i" : "s");
         _catalog.openRentConfirmationWindow(_loc3_,false,-1,_loc1_.id);
      }
      
      public function buyRentedItem() : void
      {
         var _loc2_:GroupItem = getSelectedItem();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:FurnitureItem = _loc2_.peek();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc3_:class_3365 = var_319.getFurnitureData(_loc1_.type,_loc1_.isWallItem ? "i" : "s");
         _catalog.openRentConfirmationWindow(_loc3_,true,-1,_loc1_.id);
      }
      
      private function addItemToTop(param1:GroupItem) : void
      {
         var_1691.unshift(param1);
      }
      
      private function addItemToBottom(param1:GroupItem) : void
      {
         var_1691.push(param1);
      }
      
      private function removeItem(param1:GroupItem) : void
      {
         var _loc2_:int = var_1691.indexOf(param1);
         if(_loc2_ > -1)
         {
            var_1691.splice(_loc2_,1);
         }
      }
      
      private function moveItemToTop(param1:GroupItem) : void
      {
         removeItem(param1);
         addItemToTop(param1);
      }
      
      private function getAllStripIds() : Dictionary
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Dictionary = new Dictionary();
         for each(var _loc2_ in var_1691)
         {
            _loc4_ = _loc2_.getTotalCount();
            if(_loc2_.category == 5)
            {
               _loc4_ = 1;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc1_[_loc2_.getAt(_loc3_).id] = true;
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      private function initListImages() : void
      {
         var _loc1_:* = null;
         if(!var_2423.running)
         {
            var_2423.start();
         }
         if(var_1631 && var_1631.currentPageItems)
         {
            for each(_loc1_ in var_1631.currentPageItems)
            {
               if(!_loc1_.isImageInited)
               {
                  if(_loc1_.initImage(false))
                  {
                     break;
                  }
               }
            }
         }
      }
      
      private function getItemById(param1:int) : GroupItem
      {
         for each(var _loc2_ in var_1691)
         {
            if(_loc2_.getItem(param1) !== null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function isUnseen(param1:FurnitureItem) : Boolean
      {
         var _loc2_:int = 0;
         if(param1.isRented)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 1;
         }
         return var_319.unseenItemTracker.isUnseen(_loc2_,param1.id);
      }
      
      private function addOrUpdateNonGroupableItem(param1:FurnitureItem, param2:Boolean) : GroupItem
      {
         var _loc3_:GroupItem = null;
         var _loc4_:Vector.<GroupItem> = new Vector.<GroupItem>(0);
         for each(_loc3_ in var_1691)
         {
            if(_loc3_.type == param1.type)
            {
               _loc4_.push(_loc3_);
            }
         }
         for each(_loc3_ in _loc4_)
         {
            if(_loc3_.getItem(param1.id) != null)
            {
               return _loc3_;
            }
         }
         var _loc5_:Boolean = isUnseen(param1);
         _loc3_ = createGroupItem(param1.type,param1.category,param1.stuffData,param1.extra,param2);
         _loc3_.push(param1,_loc5_);
         if(_loc5_)
         {
            _loc3_.hasUnseenItems = true;
            addItemToTop(_loc3_);
         }
         else
         {
            addItemToBottom(_loc3_);
         }
         if(var_1631 && var_1631.grid)
         {
            var_1631.grid.itemWasUpdated(_loc3_);
         }
         return _loc3_;
      }
      
      private function addOrUpdateGroupableItem(param1:FurnitureItem, param2:Boolean) : GroupItem
      {
         var _loc4_:* = null;
         var _loc5_:Boolean = isUnseen(param1);
         for each(var _loc3_ in var_1691)
         {
            if(_loc3_.type == param1.type && _loc3_.isWallItem == param1.isWallItem)
            {
               if(param1.category == 19)
               {
                  if(_loc3_.stuffData.rarityLevel == param1.stuffData.rarityLevel)
                  {
                     _loc4_ = _loc3_;
                     break;
                  }
               }
               if(_loc3_.isGroupable)
               {
                  if(param1.category == 6)
                  {
                     if(_loc3_.stuffData.getLegacyString() == param1.stuffData.getLegacyString())
                     {
                        _loc4_ = _loc3_;
                        break;
                     }
                  }
                  else
                  {
                     if(param1.category != 17)
                     {
                        _loc4_ = _loc3_;
                        break;
                     }
                     if(param1.stuffData.compare(_loc3_.stuffData))
                     {
                        _loc4_ = _loc3_;
                        break;
                     }
                  }
               }
            }
         }
         if(_loc4_)
         {
            _loc4_.push(param1,_loc5_);
            if(_loc5_)
            {
               _loc4_.hasUnseenItems = true;
               moveItemToTop(_loc4_);
            }
            if(var_1631 && var_1631.grid)
            {
               var_1631.grid.itemWasUpdated(_loc4_);
            }
            return _loc4_;
         }
         _loc3_ = createGroupItem(param1.type,param1.category,param1.stuffData,param1.extra,param2);
         _loc3_.push(param1,_loc5_);
         if(_loc5_)
         {
            _loc3_.hasUnseenItems = true;
            addItemToTop(_loc3_);
         }
         else
         {
            addItemToBottom(_loc3_);
         }
         if(var_1631 && var_1631.grid)
         {
            var_1631.grid.itemWasUpdated(_loc3_);
         }
         return _loc3_;
      }
      
      private function requestSelectedFurniToMover(param1:FurnitureItem) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(param1.isWallItem)
         {
            _loc3_ = 20;
         }
         else
         {
            _loc3_ = 10;
         }
         if(param1.category == 6 || isExternalImageItem(param1))
         {
            _loc2_ = _roomEngine.initializeRoomObjectInsert("inventory",param1.id,_loc3_,param1.type,param1.stuffData.getLegacyString(),null,-1,-1,null,true);
         }
         else
         {
            _loc2_ = _roomEngine.initializeRoomObjectInsert("inventory",param1.id,_loc3_,param1.type,param1.extra.toString(),param1.stuffData,-1,-1,null,true);
         }
         if(_loc2_)
         {
            var_3099 = param1.ref;
            requestClose();
            var_2052 = true;
         }
         var_1631.updateActionView();
      }
      
      private function attemptPlaceNextFurni() : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:FurnitureItem = null;
         var _loc1_:* = false;
         var _loc3_:GroupItem = getSelectedItem();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:* = -1;
         if(_loc3_.category == 5)
         {
            if(_loc3_.getTotalCount() > 1)
            {
               _loc4_ = 0;
            }
         }
         else
         {
            _loc5_ = (_loc6_ = _loc3_.selectedItemIndex) - 1;
            while(_loc5_ >= 0)
            {
               _loc2_ = _loc3_.getAt(_loc5_);
               if(_loc2_ && !_loc2_.locked)
               {
                  _loc4_ = _loc5_;
                  break;
               }
               _loc5_ -= 1;
            }
         }
         if(_loc4_ != -1)
         {
            _loc3_.selectedItemIndex = _loc4_;
            _loc1_ = !requestSelectedFurniPlacement(false);
         }
         else
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc3_.selectedItemIndex = -1;
            cancelFurniInMover();
            var_319.showView();
         }
      }
      
      private function isExternalImageItem(param1:FurnitureItem) : Boolean
      {
         var _loc2_:class_3365 = _catalog.getFurnitureData(param1.type,"i");
         return _loc2_ && _loc2_.isExternalImageType;
      }
      
      private function updateCategorySelection() : void
      {
         var _loc2_:int = 0;
         removeSelections();
         var _loc1_:GroupItem = var_3408[var_638];
         if(_loc1_ != null)
         {
            _loc2_ = var_1691.indexOf(_loc1_);
            if(_loc2_ > -1)
            {
               _loc1_.isSelected = true;
               _loc1_.selectedItemIndex = -1;
            }
         }
         else
         {
            selectFirstItem();
         }
         var_1631.updateActionView();
      }
      
      public function onObjectPlaced(param1:Event) : void
      {
         var _loc2_:RoomEngineObjectPlacedEvent = param1 as RoomEngineObjectPlacedEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(var_2052 && param1.type == "REOE_PLACED")
         {
            var_2052 = false;
            if(!_loc2_.placedInRoom)
            {
               var_319.showView();
               cancelFurniInMover();
            }
            else if(var_638 == "rentables")
            {
               var_319.showView();
            }
            else if(_loc2_.placedInRoom && (_loc2_.placedOnFloor && -_loc2_.objectId == var_3099) || _loc2_.placedOnWall && _loc2_.objectId == var_3099)
            {
               attemptPlaceNextFurni();
            }
         }
      }
      
      private function onImageUpdateTimerEvent(param1:TimerEvent) : void
      {
         var _loc5_:* = undefined;
         var _loc3_:FurnitureItem = null;
         initListImages();
         _imageUpdateCumulativeTime += 50;
         if(_imageUpdateCumulativeTime >= 200)
         {
            _loc5_ = new Vector.<int>(0);
            for each(var _loc2_ in var_1691)
            {
               _loc3_ = _loc2_.getAt(0);
               if(_loc3_ && _loc3_.isRented && _loc3_.hasRentPeriodStarted && _loc3_.secondsToExpiration <= 0)
               {
                  _loc5_.push(_loc3_.id);
               }
            }
            for each(var _loc4_ in _loc5_)
            {
               removeFurni(_loc4_);
            }
            if(_loc5_.length > 0)
            {
               var_1631.updateGridFilters();
            }
            var_1631.updateRentedItem();
            _imageUpdateCumulativeTime = 0;
         }
      }
      
      public function roomEntered() : void
      {
         var _loc1_:int = 0;
         _isInRoom = true;
         if(_roomItemToSelect == null)
         {
            return;
         }
         if(_roomEngine != null)
         {
            _loc1_ = _roomItemToSelect.isWallItem ? 20 : 10;
            _roomEngine.selectRoomObject(_roomItemToSelect.flatId,Math.abs(_roomItemToSelect.id),_loc1_);
         }
         _roomItemToSelect = null;
      }
      
      public function roomLeft() : void
      {
         _isInRoom = false;
      }
      
      public function selectItemById(param1:String) : void
      {
         var _loc2_:GroupItem = getItemById(-int(param1));
         if(_loc2_ != null)
         {
            categorySelection = _loc2_;
         }
      }
   }
}
