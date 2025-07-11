package com.sulake.habbo.ui.widget.furniture.present
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.inventory.class_1814;
   import com.sulake.habbo.inventory.items.class_3393;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.object.IRoomObject;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;
   
   public class PresentFurniWidget extends RoomWidgetBase implements IAvatarImageListener
   {
      
      private static const const_465:String = "floor";
      
      private static const TYPE_WALLPAPER:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
       
      
      private var var_3752:ICoreConfiguration;
      
      private var _catalog:IHabboCatalog;
      
      private var _inventory:class_1814;
      
      private var _roomEngine:IRoomEngine;
      
      private var _window:class_3514;
      
      private var var_455:int = -1;
      
      private var var_390:int = 0;
      
      private var var_125:String;
      
      private var _text:String;
      
      private var var_319:Boolean;
      
      private var var_1940:Boolean = false;
      
      private var var_1283:String;
      
      private var _senderName:String;
      
      private var var_1155:int = -1;
      
      private var var_1103:String = "";
      
      private var _placedInRoom:Boolean = false;
      
      private var var_1451:Boolean = false;
      
      private var var_4869:Boolean = true;
      
      public function PresentFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:ICoreConfiguration, param6:IHabboCatalog, param7:class_1814, param8:IRoomEngine)
      {
         super(param1,param2,param3,param4);
         var_3752 = param5;
         _catalog = param6;
         _inventory = param7;
         _roomEngine = param8;
      }
      
      override public function dispose() : void
      {
         hideInterface();
         var_3752 = null;
         _catalog = null;
         _inventory = null;
         _roomEngine = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPDUE_PACKAGEINFO",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_IMAGE",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_CLUB",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_FLOOR",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_LANDSCAPE",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_WALLPAPER",onObjectUpdate);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWEBDUE_PACKAGEINFO",onEcotronUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPDUE_PACKAGEINFO",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_IMAGE",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_CLUB",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_FLOOR",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_LANDSCAPE",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_WALLPAPER",onObjectUpdate);
         param1.removeEventListener("RWEBDUE_PACKAGEINFO",onEcotronUpdate);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
      }
      
      private function onObjectUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         switch(param1.type)
         {
            case "RWPDUE_PACKAGEINFO":
               hideInterface();
               var_1940 = false;
               var_455 = param1.objectId;
               _text = param1.text;
               var_319 = param1.controller;
               _senderName = param1.purchaserName;
               var_1283 = param1.purchaserFigure;
               var_1451 = param1.trustedSender;
               showInterface();
               showIcon(param1.iconBitmapData);
               break;
            case "RWPDUE_CONTENTS_FLOOR":
               if(!var_1940)
               {
                  return;
               }
               var_455 = param1.objectId;
               var_390 = param1.classId;
               var_125 = param1.itemType;
               _text = param1.text;
               var_319 = param1.controller;
               var_1155 = param1.placedItemId;
               var_1103 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_floor");
               break;
            case "RWPDUE_CONTENTS_LANDSCAPE":
               if(!var_1940)
               {
                  return;
               }
               var_455 = param1.objectId;
               var_390 = param1.classId;
               var_125 = param1.itemType;
               _text = param1.text;
               var_319 = param1.controller;
               var_1155 = param1.placedItemId;
               var_1103 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_landscape");
               break;
            case "RWPDUE_CONTENTS_WALLPAPER":
               if(!var_1940)
               {
                  return;
               }
               var_455 = param1.objectId;
               var_390 = param1.classId;
               var_125 = param1.itemType;
               _text = param1.text;
               var_319 = param1.controller;
               var_1155 = param1.placedItemId;
               var_1103 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_wallpaper");
               break;
            case "RWPDUE_CONTENTS_CLUB":
               if(!var_1940)
               {
                  return;
               }
               var_455 = param1.objectId;
               var_390 = param1.classId;
               var_125 = param1.itemType;
               _text = param1.text;
               var_319 = param1.controller;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_hc");
               break;
            case "RWPDUE_CONTENTS":
               if(!var_1940)
               {
                  return;
               }
               var_455 = param1.objectId;
               var_390 = param1.classId;
               var_125 = param1.itemType;
               _text = param1.text;
               var_319 = param1.controller;
               var_1155 = param1.placedItemId;
               var_1103 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showIcon(param1.iconBitmapData);
               break;
            case "RWPDUE_CONTENTS_IMAGE":
               if(!var_1940)
               {
                  return;
               }
               showIcon(param1.iconBitmapData);
               break;
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == var_455)
         {
            hideInterface();
         }
         if(param1.id == var_1155)
         {
            if(_placedInRoom)
            {
               _placedInRoom = false;
               updateRoomAndInventoryButtons();
            }
         }
      }
      
      private function onEcotronUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWEBDUE_PACKAGEINFO" === _loc2_)
         {
            hideInterface();
         }
      }
      
      private function showCustomIcon(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapDataAsset = assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.content as BitmapData;
         }
         showIcon(_loc2_);
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc2_:IBitmapWrapperWindow = _window.findChildByName("gift_image") as IBitmapWrapperWindow;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap != null)
         {
            _loc2_.bitmap.dispose();
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_);
      }
      
      private function showGiftOpenedInterface() : void
      {
         var _loc11_:String = null;
         var _loc3_:BitmapDataAsset = null;
         var _loc1_:BitmapData = null;
         var _loc2_:String = null;
         var _loc10_:Boolean = false;
         var _loc4_:String = null;
         if(var_455 < 0)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc9_:XmlAsset = assets.getAssetByName("packagecard_new_opened") as XmlAsset;
         _window = windowManager.buildFromXML(_loc9_.content as XML) as class_3514;
         _window.center();
         if(!isUnknownSender())
         {
            _loc11_ = "widget.furni.present.window.title_from";
            var_44.registerParameter(_loc11_,"name",_senderName);
            _window.caption = var_44.getLocalization(_loc11_,_senderName);
         }
         var _loc6_:IWindow;
         if((_loc6_ = _window.findChildByName("header_button_close")) != null)
         {
            _loc6_.addEventListener("WME_CLICK",onClose);
         }
         var _loc7_:IBitmapWrapperWindow;
         if((_loc7_ = _window.findChildByName("image_bg") as IBitmapWrapperWindow) != null)
         {
            _loc3_ = assets.getAssetByName("gift_icon_background") as BitmapDataAsset;
            if(_loc3_ != null)
            {
               _loc1_ = _loc3_.content as BitmapData;
               if(_loc7_.bitmap)
               {
                  _loc7_.bitmap.dispose();
               }
               _loc7_.bitmap = _loc1_.clone();
            }
         }
         var _loc5_:ITextWindow;
         if((_loc5_ = _window.findChildByName("gift_message") as ITextWindow) != null)
         {
            _loc5_.text = "";
            if(_text != null)
            {
               _loc2_ = "widget.furni.present.message_opened";
               if(_loc10_ = isSpacesItem())
               {
                  _loc2_ = "widget.furni.present.spaces.message_opened";
               }
               var_44.registerParameter(_loc2_,"product",_text);
               if(var_125 == "h")
               {
                  _loc5_.text = _text;
               }
               else
               {
                  _loc5_.text = var_44.getLocalization(_loc2_,_text);
               }
            }
            else
            {
               _loc5_.visible = false;
            }
         }
         var _loc8_:IWindow;
         if((_loc8_ = _window.findChildByName("give_gift_button")) != null)
         {
            if(!isUnknownSender())
            {
               _loc4_ = "widget.furni.present.give_gift";
               var_44.registerParameter(_loc4_,"name",_senderName);
               _loc8_.caption = var_44.getLocalization(_loc4_,_senderName);
               _loc8_.addEventListener("WME_CLICK",onGiveGiftOpened);
            }
            else
            {
               _loc8_.visible = false;
            }
         }
         prepareAvatarImageContainer();
         updateGiftDialogAvatarImage(var_1283);
         updateRoomAndInventoryButtons();
         selectGiftedObject();
      }
      
      private function isSpacesItem() : Boolean
      {
         var _loc2_:class_3365 = null;
         var _loc3_:String = null;
         var _loc1_:Boolean = false;
         if(var_125 == "i")
         {
            _loc2_ = (var_1653 as FurniturePresentWidgetHandler).container.sessionDataManager.getWallItemData(var_390);
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.className;
               _loc1_ = _loc3_ == "floor" || _loc2_.className == "landscape" || _loc2_.className == "wallpaper";
            }
         }
         return _loc1_;
      }
      
      private function isClubItem() : Boolean
      {
         return var_125 == "h";
      }
      
      private function updateRoomAndInventoryButtons() : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc4_:Boolean = isSpacesItem();
         var _loc7_:Boolean = isClubItem();
         var _loc10_:IWindow;
         if((_loc10_ = _window.findChildByName("keep_in_room_button")) != null)
         {
            _loc10_.addEventListener("WME_CLICK",onKeepInRoom);
            _loc10_.visible = _placedInRoom;
            if(_loc4_ || _loc7_)
            {
               _loc10_.visible = false;
            }
         }
         var _loc1_:IWindow = _window.findChildByName("place_in_room_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onPlaceInRoom);
            _loc1_.visible = !_placedInRoom;
            if(_loc4_)
            {
               _loc1_.disable();
            }
            if(_loc4_ || _loc7_)
            {
               _loc1_.visible = false;
            }
         }
         var _loc2_:IWindow = _window.findChildByName("put_in_inventory_button");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onPutInInventory);
            _loc2_.enable();
            if(_loc4_ || _loc7_)
            {
               _loc2_.visible = false;
            }
         }
         var _loc8_:IWindow;
         if((_loc8_ = _window.findChildByName("separator")) != null)
         {
            _loc8_.visible = isUnknownSender();
         }
         var _loc5_:IWindow;
         if((_loc5_ = _window.findChildByName("give_container") as IWindow) != null)
         {
            _loc5_.visible = !isUnknownSender();
         }
         var _loc6_:IItemListWindow;
         if((_loc6_ = _window.findChildByName("button_list") as IItemListWindow) != null)
         {
            _loc6_.arrangeListItems();
         }
         var _loc3_:IItemListWindow = _window.findChildByName("give_element_list") as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc3_.arrangeListItems();
         }
         var _loc9_:IItemListWindow;
         if((_loc9_ = _window.findChildByName("element_list") as IItemListWindow) != null)
         {
            _loc9_.arrangeListItems();
         }
         _window.resizeToFitContent();
      }
      
      private function resetAndHideInterface() : void
      {
         var_1940 = false;
         var_1155 = -1;
         _placedInRoom = false;
         hideInterface();
      }
      
      private function onKeepInRoom(param1:WindowEvent) : void
      {
         resetAndHideInterface();
      }
      
      private function onPlaceInRoom(param1:WindowEvent) : void
      {
         var _loc3_:class_3393 = null;
         var _loc2_:IWindow = param1.target;
         _loc2_.disable();
         if(var_1155 > 0 && !_placedInRoom)
         {
            _loc3_ = null;
            switch(var_1103)
            {
               case "s":
                  _loc3_ = _inventory.getFloorItemById(-var_1155);
                  if(requestSelectedFurniPlacement(_loc3_))
                  {
                     _inventory.removeUnseenFurniCounter(var_1155);
                  }
                  break;
               case "i":
                  _loc3_ = _inventory.getWallItemById(var_1155);
                  if(requestSelectedFurniPlacement(_loc3_))
                  {
                     _inventory.removeUnseenFurniCounter(var_1155);
                  }
                  break;
               case "p":
                  if(_inventory.placePetToRoom(var_1155,false))
                  {
                     _inventory.removeUnseenPetCounter(var_1155);
                  }
            }
         }
         resetAndHideInterface();
      }
      
      public function requestSelectedFurniPlacement(param1:class_3393) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         if(param1.category == 3 || param1.category == 2 || param1.category == 4)
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = _inventory.requestSelectedFurniToMover(param1);
         }
         return _loc2_;
      }
      
      private function onPutInInventory(param1:WindowEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = null;
         var _loc2_:IWindow = param1.target;
         _loc2_.disable();
         if(var_1155 > 0 && _placedInRoom)
         {
            if(var_1103 == "p")
            {
               (var_1653 as FurniturePresentWidgetHandler).container.roomSession.pickUpPet(var_1155);
            }
            else
            {
               _loc4_ = (var_1653 as FurniturePresentWidgetHandler).container.roomSession.roomId;
               _loc5_ = 10;
               _loc3_ = _roomEngine.getRoomObject(_loc4_,var_1155,_loc5_);
               if(_loc3_ != null)
               {
                  _roomEngine.modifyRoomObject(_loc3_.getId(),_loc5_,"OBJECT_PICKUP");
               }
            }
         }
         resetAndHideInterface();
      }
      
      private function showInterface() : void
      {
         var _loc7_:String = null;
         var _loc16_:String = null;
         var _loc9_:class_3437 = null;
         var _loc15_:IStaticBitmapWrapperWindow = null;
         var _loc13_:String = null;
         var _loc17_:ITextWindow = null;
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc14_:IWindowContainer = null;
         var _loc2_:String = null;
         var _loc4_:IWindow = null;
         var _loc10_:String = null;
         var _loc8_:IWindow = null;
         if(var_455 < 0)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc12_:XmlAsset = assets.getAssetByName("packagecard_new") as XmlAsset;
         _window = windowManager.buildFromXML(_loc12_.content as XML) as class_3514;
         _window.center();
         if(!isUnknownSender())
         {
            _loc7_ = "widget.furni.present.window.title_from";
            var_44.registerParameter(_loc7_,"name",_senderName);
            _window.caption = var_44.getLocalization(_loc7_,_senderName);
         }
         var _loc11_:IWindow;
         if((_loc11_ = _window.findChildByName("header_button_close")) != null)
         {
            _loc11_.addEventListener("WME_CLICK",onClose);
         }
         var _loc6_:IStaticBitmapWrapperWindow;
         if(_loc6_ = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow)
         {
            if((_loc16_ = String(var_3752.getProperty("catalog.gift_wrapping_new.gift_card"))) != "")
            {
               _loc6_.assetUri = "${image.library.url}Giftcards/" + _loc16_ + ".png";
            }
         }
         prepareAvatarImageContainer();
         if(isUnknownSender())
         {
            updateUnknownSenderAvatarImage();
         }
         else
         {
            updateGiftDialogAvatarImage(var_1283);
         }
         if(var_4869)
         {
            if(!var_1451)
            {
               if((_loc9_ = _window.findChildByName("warning_foreground_border") as class_3437) != null)
               {
                  _loc9_.color = 11599948;
               }
               if((_loc15_ = _window.findChildByName("warning_icon") as IStaticBitmapWrapperWindow) != null)
               {
                  _loc15_.assetUri = "catalogue_icon_alert_s";
                  _loc15_.width = 26;
                  _loc15_.height = 26;
                  _loc15_.x = 22;
                  _loc15_.y = 12;
               }
               _loc13_ = "gift.untrusted.banner.text";
               var_44.registerParameter(_loc13_,"name","not trusted gift sender");
               if((_loc17_ = _window.findChildByName("warning_text") as ITextWindow) != null)
               {
                  _loc17_.text = var_44.getLocalization(_loc13_,_senderName);
               }
            }
            else
            {
               _loc3_ = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow;
               _loc3_.assetUri = "catalogue_giftcard_staff";
            }
         }
         else
         {
            ((_loc14_ = _window.findChildByName("warning") as IWindowContainer).parent as IWindowContainer).removeChild(_loc14_);
         }
         var _loc1_:ITextWindow = _window.findChildByName("message_text") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.text = _text;
         }
         var _loc19_:ITextWindow;
         if((_loc19_ = _window.findChildByName("message_from") as ITextWindow) != null)
         {
            _loc19_.text = "";
            if(!isUnknownSender())
            {
               _loc2_ = "widget.furni.present.message_from";
               var_44.registerParameter(_loc2_,"name",_senderName);
               _loc19_.text = var_44.getLocalization(_loc2_,_senderName);
               _loc19_.addEventListener("WME_CLICK",onSenderNameClick);
            }
            else
            {
               _loc19_.visible = false;
            }
         }
         var _loc5_:IItemListWindow;
         if((_loc5_ = _window.findChildByName("button_list") as IItemListWindow) != null)
         {
            if((_loc4_ = _loc5_.getListItemByName("give_gift_button")) != null)
            {
               if(!isUnknownSender())
               {
                  _loc10_ = "widget.furni.present.give_gift";
                  var_44.registerParameter(_loc10_,"name",_senderName);
                  _loc4_.caption = var_44.getLocalization(_loc10_,_senderName);
               }
               if(var_319)
               {
                  _loc4_.addEventListener("WME_CLICK",onGiveGift);
               }
               if(!var_319 || isUnknownSender())
               {
                  _loc4_.visible = false;
               }
            }
            if((_loc8_ = _window.findChildByName("open_gift_button")) != null)
            {
               if(var_319)
               {
                  _loc8_.addEventListener("WME_CLICK",onOpenGift);
               }
               else
               {
                  _loc8_.visible = false;
               }
            }
            _loc5_.arrangeListItems();
         }
         var _loc18_:IItemListWindow = _window.findChildByName("element_list") as IItemListWindow;
         _loc18_.x = _loc18_.spacing;
         _window.resizeToFitContent();
         _loc18_.parent.height = _loc18_.x + _loc18_.height;
      }
      
      private function isUnknownSender() : Boolean
      {
         return _senderName == null || _senderName.length == 0;
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         var_1940 = false;
         hideInterface();
      }
      
      private function onGiveGift(param1:WindowEvent) : void
      {
         openGiftShop();
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.return_gift_from_open_giftcard.clicked");
      }
      
      private function onGiveGiftOpened(param1:WindowEvent) : void
      {
         openGiftShop();
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.return_gift_from_opened_present.clicked");
      }
      
      private function openGiftShop() : void
      {
         if(!isUnknownSender())
         {
            _catalog.giftReceiver = _senderName;
         }
         _catalog.openCatalogPage("gift_shop");
      }
      
      private function send(param1:IMessageComposer) : void
      {
         var _loc2_:IConnection = null;
         if(_catalog != null)
         {
            _loc2_ = _catalog.connection;
            if(_loc2_ != null)
            {
               _loc2_.send(param1);
            }
         }
      }
      
      private function getExtendedProfile() : void
      {
         if(!isUnknownSender())
         {
            send(new GetExtendedProfileByNameMessageComposer(_senderName));
         }
      }
      
      private function onSenderImageClick(param1:WindowEvent) : void
      {
         getExtendedProfile();
      }
      
      private function onSenderNameClick(param1:WindowEvent) : void
      {
         getExtendedProfile();
      }
      
      private function onOpenGift(param1:WindowEvent) : void
      {
         sendOpen();
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         var _loc3_:IAvatarRenderManager = (var_1653 as FurniturePresentWidgetHandler).container.avatarRenderManager;
         if(_loc3_ == null || param1 == null || param1.length == 0)
         {
            return null;
         }
         var _loc2_:BitmapData = null;
         var _loc4_:class_3374;
         if((_loc4_ = _loc3_.createAvatarImage(param1,"h",null,this)) != null)
         {
            _loc2_ = _loc4_.getCroppedImage("head");
            _loc4_.dispose();
         }
         return _loc2_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         if(param1 == var_1283)
         {
            updateGiftDialogAvatarImage(param1);
         }
      }
      
      private function prepareAvatarImageContainer() : void
      {
         var _loc1_:IRegionWindow = _window.findChildByName("avatar_image_region") as IRegionWindow;
         if(_loc1_ != null)
         {
            if(!isUnknownSender())
            {
               _loc1_.addEventListener("WME_CLICK",onSenderImageClick);
            }
            else
            {
               _loc1_.disable();
            }
         }
      }
      
      private function updateGiftDialogAvatarImage(param1:String) : void
      {
         var _loc2_:BitmapData = getAvatarFaceBitmap(param1);
         if(_loc2_ != null)
         {
            updateAvatarImageContainer(_loc2_);
         }
      }
      
      private function updateUnknownSenderAvatarImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapDataAsset = _assets.getAssetByName("gift_incognito") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.content as BitmapData;
            if(_loc1_ != null)
            {
               updateAvatarImageContainer(_loc1_.clone());
            }
         }
      }
      
      private function updateAvatarImageContainer(param1:BitmapData) : void
      {
         var _loc5_:IWindowContainer = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:IBitmapWrapperWindow;
         if((_loc4_ = _window.findChildByName("avatar_image") as IBitmapWrapperWindow) == null)
         {
            return;
         }
         _loc4_.bitmap = param1;
         _loc4_.width = param1.width;
         _loc4_.height = param1.height;
         var _loc2_:IWindowContainer = _window.findChildByName("avatar_image_container") as IWindowContainer;
         var _loc3_:Boolean = var_4869 && var_1451;
         _loc4_.x = _loc2_.width / 2 - _loc4_.width / 2;
         _loc4_.y = _loc2_.height / (_loc3_ ? 1.5 : 2) - _loc4_.height / 2;
         if(!_loc3_)
         {
            if((_loc5_ = _window.findChildByName("staff_image") as IWindowContainer) != null)
            {
               (_loc5_.parent as IWindowContainer).removeChild(_loc5_);
            }
         }
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(!var_1940)
         {
            var_455 = -1;
         }
         _text = "";
         var_319 = false;
      }
      
      private function sendOpen() : void
      {
         var _loc1_:RoomWidgetPresentOpenMessage = null;
         if(var_1940 || var_455 == -1 || !var_319)
         {
            return;
         }
         var_1940 = true;
         hideInterface();
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetPresentOpenMessage("RWPOM_OPEN_PRESENT",var_455);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function selectGiftedObject() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc1_:class_3490 = null;
         if(var_1155 > 0 && _placedInRoom)
         {
            _loc5_ = _roomEngine.activeRoomId;
            if(var_1103 == "p")
            {
               _loc3_ = _roomEngine.getRoomObjectCount(_loc5_,100);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_ = _roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
                  _loc1_ = (var_1653 as FurniturePresentWidgetHandler).container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
                  if(_loc1_ != null && _loc1_.webID == var_1155)
                  {
                     _roomEngine.selectRoomObject(_loc5_,_loc1_.roomObjectId,100);
                     break;
                  }
                  _loc4_++;
               }
            }
            else
            {
               _roomEngine.selectRoomObject(_loc5_,var_1155,10);
            }
         }
      }
   }
}
