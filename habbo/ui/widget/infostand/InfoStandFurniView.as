package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.class_3521;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.room.object.IRoomObject;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class InfoStandFurniView
   {
      
      private static const const_879:int = -12345678;
       
      
      protected var _window:IItemListWindow;
      
      protected var var_1928:IWindowContainer;
      
      protected var var_4367:IWindow;
      
      protected var var_1638:class_3437;
      
      protected var var_1640:IItemListWindow;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _habboTracking:IHabboTracking;
      
      protected var var_1884:IWindow;
      
      protected var var_1869:IWindow;
      
      protected var var_1858:IWindow;
      
      protected var var_1854:IWindow;
      
      private var var_2082:int;
      
      private var var_876:int = 0;
      
      protected var var_1629:InfoStandWidget;
      
      protected var var_1693:IItemListWindow;
      
      private const const_454:int = 0;
      
      private const const_984:int = 1;
      
      private const const_1156:int = 2;
      
      public function InfoStandFurniView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         var_2082 = const_454;
         super();
         var_1629 = param1;
         _catalog = param3;
         _habboTracking = HabboTracking.getInstance();
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         _catalog = null;
         var_1629 = null;
         _window.dispose();
         _window = null;
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      protected function createWindow(param1:String) : void
      {
         var _loc2_:IWindow = null;
         var _loc5_:int = 0;
         var _loc4_:XmlAsset = var_1629.assets.getAssetByName("furni_view") as XmlAsset;
         _window = var_1629.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_1638 = _window.getListItemByName("info_border") as class_3437;
         var_1640 = _window.getListItemByName("button_list") as IItemListWindow;
         var_1928 = _window.getListItemByName("custom_variables") as IWindowContainer;
         if(!var_1629.handler.container.sessionDataManager.hasSecurity(5))
         {
            var_1928.dispose();
            var_1928 = null;
         }
         if(var_1928 != null)
         {
            var_1928.procedure = customVarsWindowProcedure;
            var_4367 = IItemListWindow(var_1928.findChildByName("variable_list")).removeListItemAt(0);
         }
         if(var_1638 != null)
         {
            var_1693 = var_1638.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_1629.mainContainer.addChild(_window);
         var _loc3_:IWindow = var_1638.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         if(var_1640 != null)
         {
            _loc5_ = 0;
            while(_loc5_ < var_1640.numListItems)
            {
               _loc2_ = var_1640.getListItemAt(_loc5_);
               _loc2_.addEventListener("WME_CLICK",onButtonClicked);
               _loc5_++;
            }
         }
         var_1884 = var_1638.findChildByTag("catalog");
         if(var_1884 != null)
         {
            var_1884.addEventListener("WME_CLICK",onCatalogButtonClicked);
         }
         var_1869 = var_1638.findChildByName("rent_button");
         if(var_1869 != null)
         {
            var_1869.addEventListener("WME_CLICK",onRentButtonClicked);
         }
         var_1858 = var_1638.findChildByName("extend_button");
         if(var_1858 != null)
         {
            var_1858.addEventListener("WME_CLICK",onExtendButtonClicked);
         }
         var_1854 = var_1638.findChildByName("buyout_button");
         if(var_1854 != null)
         {
            var_1854.addEventListener("WME_CLICK",onBuyoutButtonClicked);
         }
         var _loc6_:IRegionWindow;
         if((_loc6_ = var_1693.getListItemByName("owner_region") as IRegionWindow) != null)
         {
            _loc6_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc6_.addEventListener("WME_OVER",onOwnerRegion);
            _loc6_.addEventListener("WME_OUT",onOwnerRegion);
         }
         var _loc7_:IWindow;
         if(_loc7_ = var_1638.findChildByName("group_details_container"))
         {
            _loc7_.addEventListener("WME_CLICK",onGroupInfoClicked);
         }
      }
      
      private function customVarsWindowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc5_:Map = null;
         var _loc3_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc6_:IWindowContainer = null;
         if(param1.type != "WME_CLICK" || var_1928 == null)
         {
            return;
         }
         var _loc7_:* = param2.name;
         if("set_values" === _loc7_)
         {
            _loc5_ = new Map();
            _loc3_ = var_1928.findChildByName("variable_list") as IItemListWindow;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numListItems)
            {
               _loc6_ = _loc3_.getListItemAt(_loc4_) as IWindowContainer;
               _loc5_[_loc6_.name] = _loc6_.findChildByName("value").caption;
               _loc4_++;
            }
            var_1629.handler.setObjectData(_loc5_);
         }
      }
      
      protected function onBuyoutButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_3365 = null;
         if(_catalog != null && var_1629 && var_1629.furniData)
         {
            _loc2_ = getFurnitureData(var_1629.furniData);
            if(_loc2_)
            {
               _catalog.openRentConfirmationWindow(_loc2_,true,var_1629.furniData.id);
            }
         }
      }
      
      protected function onExtendButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_3365 = null;
         if(_catalog != null && var_1629 && var_1629.furniData)
         {
            _loc2_ = getFurnitureData(var_1629.furniData);
            if(_loc2_)
            {
               _catalog.openRentConfirmationWindow(_loc2_,false,var_1629.furniData.id);
            }
         }
      }
      
      private function getRoomObject(param1:int) : IRoomObject
      {
         var _loc3_:int = var_1629.handler.container.roomSession.roomId;
         var _loc2_:IRoomObject = var_1629.handler.container.roomEngine.getRoomObject(_loc3_,param1,10);
         if(_loc2_ == null)
         {
            _loc2_ = var_1629.handler.container.roomEngine.getRoomObject(_loc3_,param1,20);
         }
         return _loc2_;
      }
      
      private function getFurnitureData(param1:InfoStandFurniData) : class_3365
      {
         var _loc4_:class_3365 = null;
         var _loc2_:IRoomObject = getRoomObject(param1.id);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:* = var_1629.furniData.category == 20;
         var _loc5_:int = int(_loc2_.getModel().getNumber("furniture_type_id"));
         if(_loc3_)
         {
            _loc4_ = var_1629.handler.container.sessionDataManager.getWallItemData(_loc5_);
         }
         else
         {
            _loc4_ = var_1629.handler.container.sessionDataManager.getFloorItemData(_loc5_);
         }
         return _loc4_;
      }
      
      protected function onRentButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_catalog != null)
         {
            _catalog.openCatalogPageByOfferId(var_1629.furniData.rentOfferId,"NORMAL");
         }
      }
      
      protected function onClose(param1:WindowMouseEvent) : void
      {
         var_1629.close();
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:ITextWindow = var_1693.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      public function set isNft(param1:Boolean) : void
      {
         var _loc2_:IBitmapWrapperWindow = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         var _loc5_:IWindowContainer;
         if((_loc5_ = var_1693.getListItemByName("nft_indicator") as IWindowContainer) == null)
         {
            return;
         }
         _loc5_.height = param1 ? 22 : 0;
         _loc5_.visible = param1;
         if(param1)
         {
            _loc2_ = var_1638.findChildByName("nft_icon") as IBitmapWrapperWindow;
            if(_loc2_ != null)
            {
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc3_ = (_loc4_ = var_1629.assets.getAssetByName("icon_nft") as BitmapDataAsset).content as BitmapData;
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            }
         }
         updateWindow();
      }
      
      public function set furniImage(param1:BitmapData) : void
      {
         setImage(param1,"image");
      }
      
      private function setImage(param1:BitmapData, param2:String) : void
      {
         var _loc3_:IBitmapWrapperWindow = var_1638.findChildByName(param2) as IBitmapWrapperWindow;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc3_.width,40,true);
         }
         _loc3_.height = Math.min(param1.height,200);
         _loc3_.bitmap = param1.clone();
         _loc3_.visible = true;
         updateWindow();
      }
      
      public function set description(param1:String) : void
      {
         var _loc2_:ITextWindow = var_1693.getListItemByName("description_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      public function setOwnerInfo(param1:int, param2:String) : void
      {
         var _loc4_:IRegionWindow = null;
         var _loc5_:ITextWindow = null;
         var _loc3_:IWindow = null;
         var _loc6_:IWindow = null;
         var_876 = param1;
         if(var_876 == 0)
         {
            showWindow("owner_region",false);
            showWindow("owner_spacer",false);
         }
         else
         {
            _loc5_ = (_loc4_ = var_1693.getListItemByName("owner_region") as IRegionWindow).findChildByName("owner_name") as ITextWindow;
            _loc3_ = _loc4_.findChildByName("owner_link");
            _loc6_ = _loc4_.findChildByName("bcw_icon");
            if(var_876 != -12345678)
            {
               _loc5_.text = param2;
               _loc4_.toolTipCaption = var_1629.localizations.getLocalization("infostand.profile.link.tooltip","");
               _loc4_.toolTipDelay = 100;
               _loc3_.visible = true;
               if(_loc6_ != null)
               {
                  _loc6_.visible = false;
               }
            }
            else
            {
               _loc5_.text = "${builder.catalog.title}";
               _loc4_.toolTipCaption = "";
               _loc3_.visible = false;
               if(_loc6_ != null)
               {
                  _loc6_.visible = true;
               }
            }
            showWindow("owner_region",true);
            showWindow("owner_spacer",true);
         }
         updateWindow();
      }
      
      private function set expiration(param1:int) : void
      {
         var _loc2_:IWindow = var_1693.getListItemByName("expiration_text");
         if(_loc2_ == null)
         {
            return;
         }
         var_1629.localizations.registerParameter("infostand.rent.expiration","time",FriendlyTime.getFriendlyTime(var_1629.handler.container.localization,param1));
         _loc2_.visible = param1 >= 0 && var_876 == var_1629.handler.container.sessionDataManager.userId;
         updateWindow();
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc4_:RoomWidgetMessage = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc2_:IWindow = param1.target as IWindow;
         switch(_loc2_.name)
         {
            case "rotate":
               _loc5_ = "RWFUAM_ROTATE";
               break;
            case "move":
               _loc5_ = "RWFAM_MOVE";
               break;
            case "pickup":
               if(var_2082 == 2)
               {
                  _loc5_ = "RWFAM_PICKUP";
               }
               else
               {
                  _loc5_ = "RWFAM_EJECT";
               }
               var_1629.close();
               break;
            case "save_branding_configuration":
               if(var_1629.handler.container.sessionDataManager.hasSecurity(4))
               {
                  _loc5_ = "RWFAM_SAVE_STUFF_DATA";
                  _loc3_ = getVisibleAdFurnitureExtraParams();
                  break;
               }
            case "use":
               _loc5_ = "RWFAM_USE";
               break;
            case "wired_inspect":
               _loc5_ = "RWFAM_WIRED_INSPECT";
         }
         if(_loc5_ != null)
         {
            _loc4_ = new RoomWidgetFurniActionMessage(_loc5_,var_1629.furniData.id,var_1629.furniData.category,var_1629.furniData.purchaseOfferId,_loc3_);
            var_1629.messageListener.processWidgetMessage(_loc4_);
         }
      }
      
      private function onGroupInfoClicked(param1:WindowMouseEvent) : void
      {
         var_1629.messageListener.processWidgetMessage(new RoomWidgetGetBadgeDetailsMessage(false,var_1629.furniData.groupId));
      }
      
      protected function onCatalogButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_catalog != null)
         {
            _catalog.openCatalogPageByOfferId(var_1629.furniData.purchaseOfferId,"NORMAL");
            if(_habboTracking && !_habboTracking.disposed)
            {
               _habboTracking.trackGoogle("infostandCatalogButton","offer",var_1629.furniData.purchaseOfferId);
            }
         }
      }
      
      protected function onOwnerRegion(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(var_876 == -12345678)
            {
               var_1629.handler.container.catalog.toggleBuilderCatalog();
            }
            else
            {
               var_1629.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_876,"infoStand_furniView"));
            }
         }
         if(param1.type == "WME_OUT")
         {
            IIconWindow(IRegionWindow(param1.target).findChildByName("owner_link")).style = 21;
         }
         if(param1.type == "WME_OVER")
         {
            IIconWindow(IRegionWindow(param1.target).findChildByName("owner_link")).style = 22;
         }
      }
      
      protected function updateWindow() : void
      {
         if(var_1693 == null || var_1638 == null || var_1640 == null)
         {
            return;
         }
         var_1693.arrangeListItems();
         var_1640.width = var_1640.scrollableRegion.width;
         var_1693.height = var_1693.scrollableRegion.height;
         var_1638.height = var_1693.height + 20;
         _window.width = Math.max(var_1638.width,var_1640.width);
         _window.height = _window.scrollableRegion.height;
         if(var_1638.width < var_1640.width)
         {
            var_1638.x = _window.width - var_1638.width;
            var_1640.x = 0;
         }
         else
         {
            var_1640.x = _window.width - var_1640.width;
            var_1638.x = 0;
         }
         if(var_1928 != null)
         {
            var_1928.x = var_1638.x;
         }
         var_1629.refreshContainer();
      }
      
      public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         if(var_1638 != null)
         {
            var_1638.color = class_3521.isBuilderClubId(param1.id) ? 14121216 : 16777215;
         }
         var _loc8_:IRoomSession;
         var _loc4_:Boolean = (_loc8_ = var_1629.handler.container.roomSession) != null && _loc8_.playTestMode;
         name = param1.name;
         description = param1.description;
         furniImage = param1.image;
         expiration = param1.expiration;
         isNft = param1.isNft;
         setOwnerInfo(class_3521.isBuilderClubId(param1.id) ? -12345678 : param1.ownerId,param1.ownerName);
         var _loc3_:Boolean = false;
         var _loc6_:* = false;
         var _loc7_:Boolean = false;
         var _loc2_:Boolean = false;
         if(!_loc4_ && (param1.roomControllerLevel >= 1 || param1.isOwner || param1.isRoomOwner || param1.isAnyRoomController))
         {
            _loc3_ = true;
            _loc6_ = !param1.isWallItem;
         }
         if(param1.isAnyRoomController)
         {
            _loc7_ = true;
         }
         var _loc9_:* = param1.roomControllerLevel >= 1;
         var _loc5_:Boolean;
         if(_loc5_ = Boolean(var_1629.config.getBoolean("infostand.use.button.enabled")))
         {
            if(param1.usagePolicy == 2)
            {
               _loc2_ = true;
            }
            if(!_loc4_ && (param1.usagePolicy == 1 && _loc9_ || param1.extraParam == "RWEIEP_JUKEBOX" && _loc9_ || param1.extraParam == "RWEIEP_USABLE_PRODUCT" && _loc9_))
            {
               _loc2_ = true;
            }
         }
         updatePickupMode(param1,_loc4_);
         showButton("move",_loc3_);
         showButton("rotate",_loc6_);
         showButton("use",_loc2_);
         showButton("wired_inspect",!_loc4_ && var_1629.handler.container.userDefinedRoomEvents.showInspectButton());
         showAdFurnitureDetails(_loc7_);
         showGroupInfo(param1.groupId > 0);
         updatePurchaseButtonVisibility(param1.isOwner,param1.expiration >= 0,param1.purchaseOfferId >= 0,param1.rentOfferId >= 0,param1.purchaseCouldBeUsedForBuyout,param1.rentCouldBeUsedForBuyout);
         showLimitedItem(param1.stuffData.uniqueSerialNumber > 0,param1.stuffData);
         showRarityItem(param1.stuffData.rarityLevel >= 0,param1.stuffData);
         var_1640.visible = _loc3_ || _loc6_ || var_2082 != 0 || _loc2_;
         updateCustomVarsWindow();
         updateWindow();
      }
      
      private function updateCustomVarsWindow() : void
      {
         var _loc1_:IWindowContainer = null;
         if(var_1928 == null || var_1629.furniData == null)
         {
            return;
         }
         var _loc6_:IRoomObject;
         if((_loc6_ = getRoomObject(var_1629.furniData.id)) == null)
         {
            return;
         }
         var _loc3_:Array = _loc6_.getModel().getStringArray("furniture_custom_variables");
         var_1928.visible = _loc3_ != null && _loc3_.length > 0;
         if(!var_1928.visible)
         {
            return;
         }
         var _loc5_:IItemListWindow;
         (_loc5_ = var_1928.findChildByName("variable_list") as IItemListWindow).destroyListItems();
         var _loc4_:Map = _loc6_.getModel().getStringToStringMap("furniture_data");
         for each(var _loc2_ in _loc3_)
         {
            _loc1_ = var_4367.clone() as IWindowContainer;
            _loc1_.name = _loc2_;
            _loc1_.findChildByName("name").caption = _loc2_;
            _loc1_.findChildByName("value").caption = _loc4_[_loc2_];
            _loc5_.addListItem(_loc1_);
         }
      }
      
      private function updatePickupMode(param1:RoomWidgetFurniInfoUpdateEvent, param2:Boolean) : void
      {
         var_2082 = 0;
         if(!param2)
         {
            if(param1.isOwner || param1.isAnyRoomController)
            {
               var_2082 = 2;
            }
            else if(param1.isRoomOwner || param1.roomControllerLevel >= 3)
            {
               var_2082 = 1;
            }
            if(param1.isStickie)
            {
               var_2082 = 0;
            }
         }
         showButton("pickup",var_2082 != 0);
         localizePickupButton(var_2082);
      }
      
      private function localizePickupButton(param1:int) : void
      {
         if(var_1640 == null)
         {
            return;
         }
         var _loc2_:IWindow = var_1640.getListItemByName("pickup");
         if(_loc2_ != null)
         {
            if(param1 == 1)
            {
               _loc2_.caption = "${infostand.button.eject}";
            }
            else
            {
               _loc2_.caption = "${infostand.button.pickup}";
            }
         }
      }
      
      private function createAdElement(param1:String, param2:String) : void
      {
         var _loc4_:XmlAsset = null;
         var _loc5_:IWindowContainer = null;
         var _loc6_:IWindow = null;
         var _loc3_:IWindow = null;
         if(var_1693 != null)
         {
            if((_loc4_ = var_1629.assets.getAssetByName("furni_view_branding_element") as XmlAsset) != null)
            {
               if((_loc5_ = var_1629.windowManager.buildFromXML(_loc4_.content as XML) as IWindowContainer) != null)
               {
                  if((_loc6_ = _loc5_.findChildByName("element_name")) != null)
                  {
                     _loc6_.caption = param1;
                  }
                  _loc3_ = _loc5_.findChildByName("element_value");
                  if(_loc3_ != null)
                  {
                     _loc3_.caption = param2;
                     _loc3_.addEventListener("WKE_KEY_DOWN",adElementKeyEventProc);
                  }
                  if(_loc6_ != null && _loc3_ != null)
                  {
                     var_1693.addListItem(_loc5_);
                  }
               }
            }
         }
      }
      
      private function getAdFurnitureExtraParams() : Map
      {
         var _loc5_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc1_:Map = new Map();
         if(var_1629 != null)
         {
            _loc3_ = (_loc5_ = var_1629.furniData.extraParam.substr("RWEIEP_BRANDING_OPTIONS".length)).split("\t");
            if(_loc3_ != null)
            {
               for each(var _loc2_ in _loc3_)
               {
                  if((_loc4_ = _loc2_.split("=",2)) != null && _loc4_.length == 2)
                  {
                     _loc7_ = String(_loc4_[0]);
                     _loc6_ = String(_loc4_[1]);
                     _loc1_.add(_loc7_,_loc6_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function getVisibleAdFurnitureExtraParams() : String
      {
         var _loc2_:Array = null;
         var _loc7_:IWindow = null;
         var _loc3_:IWindow = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc1_:String = "";
         if(var_1638 != null)
         {
            _loc2_ = [];
            var_1638.groupChildrenWithTag("branding_element",_loc2_,-1);
            if(_loc2_.length > 0)
            {
               for each(var _loc6_ in _loc2_)
               {
                  _loc7_ = _loc6_.findChildByName("element_name");
                  _loc3_ = _loc6_.findChildByName("element_value");
                  if(_loc7_ != null && _loc3_ != null)
                  {
                     _loc5_ = trimAdFurnitureExtramParam(_loc7_.caption);
                     _loc4_ = trimAdFurnitureExtramParam(_loc3_.caption);
                     _loc1_ += _loc5_ + "=" + _loc4_ + "\t";
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function trimAdFurnitureExtramParam(param1:String) : String
      {
         if(param1 != null)
         {
            if(param1.indexOf("\t") != -1)
            {
               return param1.replace("\t","");
            }
         }
         return param1;
      }
      
      private function showAdFurnitureDetails(param1:Boolean) : void
      {
         var _loc5_:String = null;
         var _loc8_:Map = null;
         var _loc9_:String = null;
         if(var_1629 == null || var_1638 == null)
         {
            return;
         }
         var _loc4_:IWindow;
         if((_loc4_ = var_1638.findChildByName("furni_details_spacer")) != null)
         {
            _loc4_.visible = param1;
         }
         var _loc2_:Array = [];
         var_1638.groupChildrenWithTag("branding_element",_loc2_,-1);
         if(_loc2_.length > 0)
         {
            for each(var _loc6_ in _loc2_)
            {
               var_1638.removeChild(_loc6_);
               _loc6_.dispose();
            }
         }
         var _loc3_:Boolean = false;
         var _loc7_:IWindow;
         if((_loc7_ = var_1638.findChildByName("furni_details_text") as ITextWindow) != null)
         {
            _loc7_.visible = param1;
            _loc5_ = "id: " + var_1629.furniData.id;
            if((_loc8_ = getAdFurnitureExtraParams()).length > 0)
            {
               _loc3_ = true;
               for each(var _loc10_ in _loc8_.getKeys())
               {
                  _loc9_ = _loc8_.getValue(_loc10_);
                  createAdElement(_loc10_,_loc9_);
               }
            }
            _loc7_.caption = _loc5_;
         }
         showButton("save_branding_configuration",_loc3_);
      }
      
      private function showGroupInfo(param1:Boolean) : void
      {
         showWindow("group_details_spacer",param1);
         showWindow("group_details_container",param1);
         showWindow("group_badge_image",false);
         showWindow("group_name",false);
      }
      
      private function showWindow(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindow = var_1638.findChildByName(param1);
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      private function adElementKeyEventProc(param1:WindowEvent = null, param2:IWindow = null) : void
      {
      }
      
      protected function showButton(param1:String, param2:Boolean) : void
      {
         if(var_1640 == null)
         {
            return;
         }
         var _loc3_:IWindow = var_1640.getListItemByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            var_1640.arrangeListItems();
         }
      }
      
      private function updatePurchaseButtonVisibility(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void
      {
         var _loc11_:* = false;
         var _loc9_:Boolean;
         var _loc8_:Boolean = (_loc9_ = param1 && param2) && param6;
         var _loc10_:Boolean = _loc9_ && param5;
         var _loc12_:Boolean = !_loc9_ && param3;
         var _loc13_:Boolean = !_loc9_ && param4;
         if(var_1884 != null)
         {
            var_1884.visible = _loc12_;
            if(!_loc11_)
            {
               _loc11_ = _loc12_;
            }
         }
         if(var_1869 != null)
         {
            var_1869.visible = _loc13_;
            if(!_loc11_)
            {
               _loc11_ = _loc13_;
            }
         }
         if(var_1858 != null)
         {
            var_1858.visible = _loc8_;
            if(!_loc11_)
            {
               _loc11_ = _loc8_;
            }
         }
         if(var_1854 != null)
         {
            var_1854.visible = _loc10_;
            if(!_loc11_)
            {
               _loc11_ = _loc10_;
            }
         }
         var _loc7_:IItemListWindow;
         if((_loc7_ = var_1693.getListItemByName("purchase_buttons") as IItemListWindow) != null)
         {
            _loc7_.arrangeListItems();
            _loc7_.visible = _loc11_;
         }
         var_1693.arrangeListItems();
      }
      
      public function set groupName(param1:String) : void
      {
         var _loc2_:IWindow = var_1638.findChildByName("group_name");
         if(_loc2_)
         {
            _loc2_.caption = param1;
            _loc2_.visible = true;
         }
      }
      
      private function showLimitedItem(param1:Boolean, param2:IStuffData) : void
      {
         var _loc3_:IWidgetWindow = null;
         var _loc4_:ILimitedItemPreviewOverlayWidget = null;
         var _loc6_:IWindowContainer = var_1638.findChildByName("unique_item_background_container") as IWindowContainer;
         var _loc5_:IWindowContainer = var_1638.findChildByName("unique_item_overlay_container") as IWindowContainer;
         if(!_loc6_ || !_loc5_)
         {
            return;
         }
         if(!param1)
         {
            _loc6_.visible = false;
            _loc5_.visible = false;
         }
         else
         {
            _loc6_.visible = true;
            _loc5_.visible = true;
            _loc3_ = IWidgetWindow(_loc5_.findChildByName("unique_item_plaque_widget"));
            (_loc4_ = ILimitedItemPreviewOverlayWidget(_loc3_.widget)).serialNumber = param2.uniqueSerialNumber;
            _loc4_.seriesSize = param2.uniqueSeriesSize;
         }
      }
      
      private function showRarityItem(param1:Boolean, param2:IStuffData) : void
      {
         var _loc3_:IWidgetWindow = null;
         var _loc4_:IRarityItemPreviewOverlayWidget = null;
         var _loc5_:IWindowContainer;
         if(!(_loc5_ = var_1638.findChildByName("rarity_item_overlay_container") as IWindowContainer))
         {
            return;
         }
         if(!param1)
         {
            _loc5_.visible = false;
         }
         else
         {
            _loc5_.visible = true;
            _loc3_ = IWidgetWindow(_loc5_.findChildByName("rarity_item_overlay_widget"));
            (_loc4_ = IRarityItemPreviewOverlayWidget(_loc3_.widget)).rarityLevel = param2.rarityLevel;
         }
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var _loc3_:IWidgetWindow = var_1638.findChildByName("group_badge_image") as IWidgetWindow;
         var _loc2_:IBadgeImageWidget = _loc3_.widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
         _loc2_.groupId = var_1629.furniData.groupId;
         _loc3_.visible = true;
      }
   }
}
