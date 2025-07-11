package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.filters.GlowFilter;
   
   public class FurniView implements IInventoryView, IUpdateReceiver
   {
      
      private static const STATE_NULL:int = 0;
      
      private static const STATE_INITIALIZING:int = 1;
      
      private static const STATE_EMPTY:int = 2;
      
      private static const STATE_CONTENT:int = 3;
      
      private static const UNSEEN_SYMBOL_MARGIN:int = 4;
       
      
      private var var_4512:String = "";
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var var_1631:IWindowContainer;
      
      private var var_2176:FurniGridView;
      
      private var var_1644:FurniModel;
      
      private var _marketplace:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _disposed:Boolean = false;
      
      private var var_3249:int = 0;
      
      private var var_2587:ILimitedItemPreviewOverlayWidget;
      
      private var var_2897:IRarityItemPreviewOverlayWidget;
      
      private var var_1716:IItemListWindow;
      
      private var var_3238:class_3357;
      
      private var var_4182:class_3357;
      
      private var var_4181:class_3357;
      
      private var _offerInTradingButton:class_3357;
      
      private var _offerInTradingCountButton:ITextFieldWindow;
      
      private var var_4195:class_3357;
      
      private var var_3980:class_3357;
      
      private var var_4023:class_3357;
      
      private var var_1618:Boolean = false;
      
      private var var_1799:RoomPreviewer;
      
      private var var_3733:int = 0;
      
      public function FurniView(param1:FurniModel, param2:MarketplaceModel, param3:IHabboWindowManager, param4:IAssetLibrary, param5:IRoomEngine)
      {
         super();
         var_1644 = param1;
         _marketplace = param2;
         var_2286 = param4;
         _windowManager = param3;
         _roomEngine = param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return var_1631 && var_1631.parent != null && var_1631.visible;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_1618;
      }
      
      public function get currentPageItems() : Vector.<GroupItem>
      {
         return !!var_2176 ? var_2176.currentPageItems : null;
      }
      
      public function get grid() : FurniGridView
      {
         return var_2176;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_1644 && var_1644.controller)
            {
               var_1644.controller.removeUpdateReceiver(this);
            }
            var_1644 = null;
            _marketplace = null;
            var_2286 = null;
            _windowManager = null;
            _roomEngine = null;
            if(var_2587)
            {
               var_2587.dispose();
               var_2587 = null;
            }
            if(var_2897)
            {
               var_2897.dispose();
               var_2897 = null;
            }
            if(var_1631)
            {
               var_1631.dispose();
               var_1631 = null;
            }
            _disposed = true;
         }
      }
      
      public function getWindowContainer() : IWindowContainer
      {
         if(!var_1618)
         {
            init();
         }
         if(var_1631 == null)
         {
            return null;
         }
         if(var_1631.disposed)
         {
            return null;
         }
         updateActionButtons(false);
         return var_1631;
      }
      
      public function setViewToState() : void
      {
         var _loc1_:int = 0;
         if(!var_1644.isListInited())
         {
            _loc1_ = 1;
         }
         else if(!var_1644.furniData || var_1644.furniData.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(var_3249 == _loc1_)
         {
            return;
         }
         var_3249 = _loc1_;
         updateContainerVisibility();
      }
      
      public function clearViews() : void
      {
         updateActionView();
      }
      
      public function getFirstThumb() : IWindowContainer
      {
         return var_2176 != null ? var_2176.getFirstThumb() : null;
      }
      
      public function updateActionView() : void
      {
         var _loc4_:FurnitureItem = null;
         var _loc14_:IStaticBitmapWrapperWindow = null;
         var _loc18_:ITextWindow = null;
         var _loc16_:IRegionWindow = null;
         var _loc5_:String = null;
         var _loc10_:String = null;
         var _loc19_:String = null;
         var _loc8_:String = null;
         var _loc17_:String = null;
         var _loc3_:String = null;
         var _loc20_:String = null;
         var _loc12_:class_3365 = null;
         var _loc9_:int = 0;
         var _loc1_:IWidgetWindow = null;
         var _loc11_:IWidgetWindow = null;
         var _loc13_:String = null;
         if(var_1631 == null)
         {
            return;
         }
         if(var_1631.disposed)
         {
            return;
         }
         updateContainerVisibility();
         var _loc6_:Boolean = false;
         var _loc7_:GroupItem;
         if((_loc7_ = var_1644.getSelectedItem()) != null && _loc7_.peek() != null)
         {
            if(_loc7_.selectedItemIndex >= 0)
            {
               if(!(_loc4_ = _loc7_.getAt(_loc7_.selectedItemIndex)))
               {
                  _loc4_ = _loc7_.peek();
               }
            }
            else
            {
               _loc4_ = _loc7_.peek();
            }
            _loc6_ = true;
            _loc5_ = _roomEngine.getWallItemType(_loc4_.type);
            var_1631.findChildByName("nextItemButton").visible = var_1631.findChildByName("viewItemButton").visible = _loc5_ && _loc5_.indexOf("external_image_wallitem") != -1;
            var_1631.findChildByName("furni_preview_widget").visible = true;
            _loc10_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
            _loc19_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
            _loc8_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
            _loc10_ = _loc10_ && _loc10_.length > 0 ? _loc10_ : "101";
            _loc19_ = _loc19_ && _loc19_.length > 0 ? _loc19_ : "101";
            _loc8_ = _loc8_ && _loc8_.length > 0 ? _loc8_ : "1.1";
            var_1799.reset(false);
            var_1799.updateObjectRoom(_loc19_,_loc10_,_loc8_);
            if(_loc4_.category == 2 || _loc4_.category == 3 || _loc4_.category == 4)
            {
               var_1799.updateRoomWallsAndFloorVisibility(true,true);
               _loc17_ = String(_loc4_.category == 3 ? _loc7_.stuffData.getLegacyString() : _loc19_);
               _loc3_ = String(_loc4_.category == 2 ? _loc7_.stuffData.getLegacyString() : _loc10_);
               _loc20_ = String(_loc4_.category == 4 ? _loc7_.stuffData.getLegacyString() : _loc8_);
               var_1799.updateObjectRoom(_loc17_,_loc3_,_loc20_);
               if(_loc4_.category == 4)
               {
                  _loc12_ = var_1644.controller.getFurnitureDataByName("ads_twi_windw","i");
                  var_1799.addWallItemIntoRoom(_loc12_.id,new Vector3d(90,0,0),_loc12_.customParams);
               }
            }
            else if(_loc7_.isWallItem)
            {
               var_1799.updateRoomWallsAndFloorVisibility(true,true);
               var_1799.addWallItemIntoRoom(_loc7_.type,new Vector3d(90,0,0),_loc4_.stuffData.getLegacyString());
            }
            else
            {
               var_1799.updateRoomWallsAndFloorVisibility(false,true);
               var_1799.addFurnitureIntoRoom(_loc7_.type,new Vector3d(90,0,0),_loc7_.stuffData,_loc7_.extra.toString());
            }
            _loc14_ = var_1631.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = var_1631.findChildByName("tradeable_number") as ITextWindow;
            _loc16_ = var_1631.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc14_ != null && _loc18_ != null && _loc16_ != null)
            {
               if((_loc9_ = _loc7_.getTradeableCount()) == 0)
               {
                  _loc14_.assetUri = "inventory_furni_no_trade_icon";
                  _loc18_.visible = false;
                  _loc16_.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
                  _loc18_.filters = [];
               }
               else
               {
                  _loc14_.assetUri = "inventory_furni_trade_icon";
                  _loc18_.visible = true;
                  _loc18_.text = String(_loc9_);
                  _loc16_.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
                  _loc18_.filters = [new GlowFilter(16777215,1,3,3,300)];
               }
            }
            _loc1_ = IWidgetWindow(var_1631.findChildByName("unique_limited_item_overlay_widget"));
            if(_loc4_.stuffData && _loc4_.stuffData.uniqueSerialNumber > 0)
            {
               if(var_2587 == null)
               {
                  var_2587 = ILimitedItemPreviewOverlayWidget(_loc1_.widget);
               }
               var_2587.serialNumber = _loc4_.stuffData.uniqueSerialNumber;
               var_2587.seriesSize = _loc4_.stuffData.uniqueSeriesSize;
               _loc1_.visible = true;
            }
            else
            {
               _loc1_.visible = false;
            }
            _loc11_ = IWidgetWindow(var_1631.findChildByName("rarity_item_overlay_widget"));
            if(_loc4_.stuffData && _loc4_.stuffData.rarityLevel >= 0)
            {
               if(var_2897 == null)
               {
                  var_2897 = IRarityItemPreviewOverlayWidget(_loc11_.widget);
               }
               var_2897.rarityLevel = _loc4_.stuffData.rarityLevel;
               _loc11_.visible = true;
            }
            else
            {
               _loc11_.visible = false;
            }
         }
         else
         {
            var_1631.findChildByName("furni_preview_widget").visible = var_1631.findChildByName("nextItemButton").visible = var_1631.findChildByName("viewItemButton").visible = false;
            _loc14_ = var_1631.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = var_1631.findChildByName("tradeable_number") as ITextWindow;
            _loc16_ = var_1631.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc14_ && _loc18_ && _loc16_)
            {
               _loc14_.assetUri = "";
               _loc18_.visible = false;
            }
         }
         var _loc2_:Boolean = var_1644.isTradingOpen;
         updateActionButtons(_loc6_);
         if(_loc7_ && _loc4_)
         {
            var_1631.findChildByName("furni_name").caption = _loc7_.name;
            if(_loc4_ && _roomEngine.getWallItemType(_loc4_.type) == "external_image_wallitem")
            {
               var_1631.findChildByName("furni_description").caption = _loc4_.stuffData.getJSONValue("m");
            }
            else
            {
               var_1631.findChildByName("furni_description").caption = _loc7_.description;
            }
         }
         else
         {
            var_1631.findChildByName("furni_name").caption = "";
            var_1631.findChildByName("furni_description").caption = "";
         }
         var _loc15_:ITextWindow;
         if((_loc15_ = var_1631.findChildByName("furni_extra") as ITextWindow) != null)
         {
            if(_loc4_ != null && _loc4_.stuffData != null && _loc4_.stuffData.rarityLevel >= 0)
            {
               if((_loc13_ = (_loc4_.stuffData as MapStuffData).getValue("rarity")) != null)
               {
                  _windowManager.registerLocalizationParameter("inventory.rarity","rarity",String(_loc4_.stuffData.rarityLevel));
                  _loc15_.text = var_1644.localization.getLocalization("inventory.rarity");
                  _loc15_.visible = true;
               }
            }
            else
            {
               _loc15_.text = "";
            }
         }
         updateRentedItem();
      }
      
      public function displayItemInfo(param1:GroupItem) : void
      {
         if(var_1631 == null)
         {
            return;
         }
         if(var_1631.disposed)
         {
            return;
         }
         var _loc2_:FurnitureItem = param1.peek();
         if(_loc2_.isWallItem)
         {
            var_1799.addWallItemIntoRoom(_loc2_.type,new Vector3d(90,0,0),_loc2_.stuffData.getLegacyString());
         }
         else
         {
            var_1799.addFurnitureIntoRoom(_loc2_.type,new Vector3d(90,0,0),_loc2_.stuffData);
         }
         var_3238.disable();
         _offerInTradingButton.disable();
         _offerInTradingCountButton.disable();
      }
      
      public function addItems(param1:Vector.<GroupItem>) : void
      {
         if(var_2176)
         {
            var_2176.setItems(param1);
         }
      }
      
      public function updateGridFilters() : void
      {
         if(var_1631 == null || Boolean(var_1631.disposed))
         {
            return;
         }
         var _loc4_:class_3520 = var_1631.findChildByName("filter.options") as class_3520;
         var _loc2_:class_3520 = var_1631.findChildByName("placement.options") as class_3520;
         var _loc3_:String = String(var_1631.findChildByName("filter").caption);
         var _loc1_:String = String(_loc4_.enumerateSelection()[_loc4_.selection]);
         var_2176.setFilter(_loc4_.selection,_loc1_,var_1644.showingRentedFurni,_loc3_,_loc2_.selection);
      }
      
      public function resetFilters(param1:String) : void
      {
         var _loc3_:class_3520 = var_1631.findChildByName("filter.options") as class_3520;
         var _loc2_:class_3520 = var_1631.findChildByName("placement.options") as class_3520;
         _loc3_.selection = 0;
         switch(param1)
         {
            case "furni":
               _loc2_.selection = _loc2_.numMenuItems > 2 ? 2 : 0;
               _loc2_.disable();
               break;
            case "rentables":
               _loc2_.selection = var_3733;
               _loc2_.enable();
         }
         if(var_4512 != param1)
         {
            var_1631.findChildByName("filter").caption = "";
            var_1631.findChildByName("clear_filter_button").visible = false;
         }
         var_4512 = param1;
         updateGridFilters();
      }
      
      private function init() : void
      {
         var_1631 = var_1644.controller.view.getView("furni");
         var_1631.visible = false;
         var_1631.procedure = windowEventProc;
         var _loc1_:IItemGridWindow = var_1631.findChildByName("item_grid") as IItemGridWindow;
         var _loc3_:IItemListWindow = var_1631.findChildByName("item_grid_pages") as IItemListWindow;
         var_2176 = new FurniGridView(_loc1_,_loc3_);
         populateFilterOptions();
         var_1716 = var_1631.findChildByName("preview_element_list") as IItemListWindow;
         var_3238 = var_1716.removeListItem(var_1716.getListItemByName("placeinroom_btn")) as class_3357;
         var_3980 = var_1716.removeListItem(var_1716.getListItemByName("extendrent_btn")) as class_3357;
         var_4023 = var_1716.removeListItem(var_1716.getListItemByName("buyrenteditem_btn")) as class_3357;
         var_4182 = var_1716.removeListItem(var_1716.getListItemByName("goto_room_btn")) as class_3357;
         var_4195 = var_1716.removeListItem(var_1716.getListItemByName("use_btn")) as class_3357;
         _offerInTradingCountButton = var_1716.removeListItem(var_1716.getListItemByName("offertotrade_cnt")) as ITextFieldWindow;
         _offerInTradingButton = var_1716.removeListItem(var_1716.getListItemByName("offertotrade_btn")) as class_3357;
         var_4181 = var_1716.removeListItem(var_1716.getListItemByName("sell_btn")) as class_3357;
         var _loc2_:IRoomPreviewerWidget = (var_1631.findChildByName("furni_preview_widget") as IWidgetWindow).widget as IRoomPreviewerWidget;
         var_1799 = _loc2_.roomPreviewer;
         var_1644.controller.registerUpdateReceiver(this,1);
         setViewToState();
         var_1618 = true;
      }
      
      private function fixPreviewHeightInTrading() : void
      {
         var _loc1_:IWidgetWindow = var_1631.findChildByName("furni_preview_widget") as IWidgetWindow;
         var _loc2_:IRoomPreviewerWidget = (var_1631.findChildByName("furni_preview_widget") as IWidgetWindow).widget as IRoomPreviewerWidget;
         _loc2_.roomPreviewer.modifyRoomCanvas(_loc1_.width,_loc1_.height);
      }
      
      private function updateActionButtons(param1:Boolean) : void
      {
         if(var_1644.isTradingOpen)
         {
            fixPreviewHeightInTrading();
         }
         removeButtons();
         var _loc2_:Boolean = var_1644.isTradingOpen;
         var _loc6_:GroupItem = var_1644.getSelectedItem();
         var _loc3_:FurnitureItem = null;
         if(_loc6_)
         {
            _loc3_ = _loc6_.peek();
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc10_:class_3365 = var_1644.controller.getFurnitureData(_loc3_.type,_loc3_.isWallItem ? "i" : "s");
         var _loc9_:Boolean = param1 && _marketplace && _marketplace.isEnabled && _loc3_.sellable && !var_1644.controller.sessionData.isAccountSafetyLocked() && !_loc2_;
         var _loc5_:Boolean = var_1644.isPrivateRoom && param1 && (_loc3_.category == 16 || _loc3_.category == 14 || _loc3_.category == 15 || _loc3_.category == 13 || _loc3_.category == 20);
         var _loc4_:Boolean = true;
         if(_loc3_.isRented)
         {
            if(_loc3_.flatId > -1)
            {
               _loc4_ = false;
            }
         }
         var _loc11_:* = _loc3_.flatId > -1;
         var _loc7_:Boolean = _loc3_.isRented && _loc4_ && _loc10_ && _loc10_.rentCouldBeUsedForBuyout;
         var _loc8_:Boolean = _loc3_.isRented && _loc4_ && _loc10_ && _loc10_.purchaseCouldBeUsedForBuyout;
         if(_loc10_ && _loc10_.isExternalImageType)
         {
            _loc9_ = false;
         }
         updateButtonAvailability(var_3238,!_loc2_ && _loc4_);
         updateButtonAvailability(var_3980,!_loc2_ && _loc7_);
         updateButtonAvailability(var_4023,!_loc2_ && _loc8_);
         updateButtonAvailability(var_4182,!_loc2_ && _loc11_);
         updateButtonAvailability(_offerInTradingCountButton,_loc2_ && var_1644.controller.getBoolean("multi.item.trading.enabled"));
         updateButtonAvailability(_offerInTradingButton,_loc2_);
         updateButtonAvailability(var_4181,_loc9_);
         updateButtonAvailability(var_4195,_loc5_);
         if(param1 && var_1644.isPrivateRoom)
         {
            var_3238.enable();
         }
         else
         {
            var_3238.disable();
         }
         if(param1 && _loc6_ != null && _loc3_ != null && var_1644.canUserOfferToTrade())
         {
            if(_loc6_.getUnlockedCount() && _loc3_.tradeable)
            {
               _offerInTradingButton.enable();
               _offerInTradingCountButton.enable();
            }
            else
            {
               _offerInTradingButton.disable();
               _offerInTradingCountButton.disable();
            }
         }
         else
         {
            _offerInTradingButton.disable();
            _offerInTradingCountButton.disable();
         }
      }
      
      private function updateButtonAvailability(param1:IInteractiveWindow, param2:Boolean) : void
      {
         if(var_1716.getListItemByName(param1.name) == null)
         {
            if(param2)
            {
               var_1716.addListItem(param1);
            }
         }
         else if(!param2)
         {
            var_1716.removeListItem(param1);
         }
      }
      
      private function removeButtons() : void
      {
         var_1716.removeListItem(var_3238);
         var_1716.removeListItem(var_3980);
         var_1716.removeListItem(var_4023);
         var_1716.removeListItem(var_4182);
         var_1716.removeListItem(var_4195);
         var_1716.removeListItem(_offerInTradingCountButton);
         var_1716.removeListItem(_offerInTradingButton);
         var_1716.removeListItem(var_4181);
      }
      
      private function updateContainerVisibility() : void
      {
         if(!var_1618)
         {
            return;
         }
         if(var_1644.controller.currentCategoryId != "furni" && var_1644.controller.currentCategoryId != "rentables")
         {
            return;
         }
         var _loc1_:IWindowContainer = var_1644.controller.view.loadingContainer;
         var _loc4_:IWindowContainer = var_1644.controller.view.emptyContainer;
         var _loc5_:IWindowContainer = var_1631.findChildByName("grid_container") as IWindowContainer;
         var _loc2_:IWindowContainer = var_1631.findChildByName("preview_container") as IWindowContainer;
         var _loc3_:IWindowContainer = var_1631.findChildByName("options_container") as IWindowContainer;
         switch(var_3249 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = false;
               _loc2_.visible = false;
               _loc3_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = true;
               }
               _loc5_.visible = false;
               _loc2_.visible = false;
               _loc3_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = true;
               _loc2_.visible = true;
               _loc3_.visible = true;
         }
      }
      
      private function showNextPreviewItem() : void
      {
         var_1644.getSelectedItem().selectedItemIndex++;
         updateActionView();
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc4_:GroupItem = null;
         var _loc5_:FurnitureItem = null;
         var _loc8_:int = 0;
         var _loc9_:GroupItem = null;
         var _loc3_:class_3393 = null;
         var _loc6_:WindowKeyboardEvent = null;
         var _loc7_:class_3520 = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "placeinroom_btn":
               case "furni_preview_region":
                  if(!var_1644.isTradingOpen)
                  {
                     var_1644.requestSelectedFurniPlacement(false);
                  }
                  break;
               case "nextItemButton":
                  showNextPreviewItem();
                  break;
               case "viewItemButton":
                  _loc4_ = var_1644.getSelectedItem();
                  if(!(_loc5_ = _loc4_.getAt(_loc4_.selectedItemIndex)))
                  {
                     _loc5_ = _loc4_.peek();
                  }
                  _roomEngine.showUseProductSelection(_loc5_.ref,_loc5_.type,_loc5_.id);
                  break;
               case "goto_room_btn":
                  var_1644.gotoRoom();
                  break;
               case "offertotrade_btn":
                  if((_loc8_ = Math.max(1,int(_offerInTradingCountButton.caption))) != int(_offerInTradingCountButton.caption))
                  {
                     _offerInTradingCountButton.caption = String(_loc8_);
                  }
                  var_1644.requestSelectedFurniToTrading(_loc8_,_offerInTradingCountButton);
                  break;
               case "sell_btn":
                  var_1644.requestSelectedFurniSelling();
                  break;
               case "use_btn":
                  var_1644.showUseProductSelection();
                  break;
               case "extendrent_btn":
                  var_1644.extendRentPeriod();
                  break;
               case "buyrenteditem_btn":
                  var_1644.buyRentedItem();
                  break;
               case "clear_filter_button":
                  var_1631.findChildByName("filter").caption = "";
                  param2.visible = false;
                  updateGridFilters();
                  break;
               default:
                  var_1644.cancelFurniInMover();
            }
         }
         else if(param1.type == "WME_DOWN")
         {
            var _loc10_:* = param2.name;
            if("furni_preview_region" === _loc10_)
            {
               if((_loc9_ = var_1644.getSelectedItem()) == null)
               {
                  return;
               }
               _loc3_ = _loc9_.peek();
               if(_loc3_.category == 2 || _loc3_.category == 3 || _loc3_.category == 4)
               {
                  return;
               }
               if(!var_1644.isTradingOpen)
               {
                  var_1644.requestSelectedFurniPlacement(false);
               }
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc6_ = param1 as WindowKeyboardEvent;
            _loc10_ = param2.name;
            if("filter" === _loc10_)
            {
               var_1631.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc6_.keyCode == 13)
               {
                  updateGridFilters();
               }
            }
         }
         if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "filter.options":
                  updateGridFilters();
                  break;
               case "placement.options":
                  _loc7_ = var_1631.findChildByName("placement.options") as class_3520;
                  if(var_1644.controller.currentCategoryId == "rentables")
                  {
                     var_3733 = _loc7_.selection;
                  }
                  updateGridFilters();
            }
         }
      }
      
      private function populateFilterOptions() : void
      {
         var _loc3_:class_3520 = var_1631.findChildByName("filter.options") as class_3520;
         var _loc1_:Array = [];
         _loc1_.push(var_1644.controller.localization.getLocalization("inventory.filter.option.everything","Everything"));
         _loc1_.push(var_1644.controller.localization.getLocalization("inventory.furni.tab.floor","Floor"));
         _loc1_.push(var_1644.controller.localization.getLocalization("inventory.furni.tab.wall","Wall"));
         _loc3_.populate(_loc1_);
         _loc3_.selection = 0;
         var _loc2_:class_3520 = var_1631.findChildByName("placement.options") as class_3520;
         _loc1_ = [];
         _loc1_.push(var_1644.controller.localization.getLocalization("inventory.placement.option.anywhere","Anywhere"));
         _loc1_.push(var_1644.controller.localization.getLocalization("inventory.placement.option.inroom","In room"));
         _loc1_.push(var_1644.controller.localization.getLocalization("inventory.placement.option.notinroom","Not in room"));
         _loc2_.populate(_loc1_);
         _loc2_.selection = 2;
         var_3733 = 2;
         var_1631.findChildByName("filter").caption = "";
         var_1631.findChildByName("items.shown").visible = false;
         var_1631.invalidate();
      }
      
      public function updateRentedItem() : void
      {
         if(var_1644 == null)
         {
            return;
         }
         var _loc2_:GroupItem = var_1644.getSelectedItem();
         var _loc1_:FurnitureItem = null;
         if(_loc2_)
         {
            _loc1_ = _loc2_.peek();
         }
         if(_loc1_ == null)
         {
            return;
         }
         if(!_loc1_.isRented)
         {
            return;
         }
         var _loc3_:IWindow = var_1631.findChildByName("furni_extra") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = true;
         if(_loc1_.hasRentPeriodStarted)
         {
            var_1644.controller.localization.registerParameter("inventory.rent.expiration","time",FriendlyTime.getFriendlyTime(var_1644.controller.localization,_loc1_.secondsToExpiration));
            _loc3_.caption = var_1644.controller.localization.getLocalization("inventory.rent.expiration");
         }
         else
         {
            var_1644.controller.localization.registerParameter("inventory.rent.inactive","time",FriendlyTime.getFriendlyTime(var_1644.controller.localization,_loc1_.secondsToExpiration));
            _loc3_.caption = var_1644.controller.localization.getLocalization("inventory.rent.inactive");
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_1799 != null)
         {
            var_1799.updatePreviewRoomView();
         }
      }
   }
}
