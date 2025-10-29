package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1656;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1370;
   import com.sulake.habbo.communication.messages.incoming.users.class_1677;
   import com.sulake.habbo.communication.messages.incoming.catalog.RoomAdPurchaseInfoEvent;
   
   public class RoomAdsCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var _catalog:HabboCatalog;
      
      private var var_2834:IMessageEvent = null;
      
      private var _name:String;
      
      private var var_363:String;
      
      private var _rooms:Array;
      
      private var var_946:Boolean;
      
      private var var_2485:class_3520;
      
      public function RoomAdsCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(_catalog == null)
         {
            return false;
         }
         var _loc4_:IConnection = _catalog.connection;
         if(var_2834 == null)
         {
            var_2834 = new RoomAdPurchaseInfoEvent(onPurchaseInfoEvent);
            _loc4_.addMessageEvent(var_2834);
         }
         _catalog.getRoomAdsPurchaseInfo();
         window.findChildByName("name_input_text").addEventListener("WE_CHANGE",onNameWindowEvent);
         window.findChildByName("desc_input_text").addEventListener("WE_CHANGE",onDescWindowEvent);
         events.addEventListener("PURCHASE",onPurchaseConfirmationEvent);
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         var _loc3_:int = _catalog.getInteger("room_ad.duration.minutes",120);
         var _loc1_:int = getExtensionMinutes(_loc2_,_loc3_);
         _catalog.localization.registerParameter("roomad.catalog_text","duration",String(_loc1_));
         _catalog.roomEngine.events.addEventListener("REE_INITIALIZED",onRoomInitialized);
         populateEventCategories();
         return true;
      }
      
      private function getExtensionMinutes(param1:RoomAdPurchaseData, param2:int) : int
      {
         var _loc6_:Boolean;
         if(!(_loc6_ = _catalog.getBoolean("roomad.limited_extension")) || param1 == null || param1.expirationTime == null)
         {
            return param2;
         }
         var _loc8_:Date;
         var _loc3_:Number = (_loc8_ = new Date()).getTime();
         var _loc7_:Number = param1.expirationTime.getTime();
         var _loc4_:Number;
         var _loc5_:Number;
         return (_loc4_ = (_loc5_ = _loc3_ - _loc7_) / 60000) + param2;
      }
      
      private function populateEventCategories() : void
      {
         if(window == null)
         {
            return;
         }
         var_2485 = window.findChildByName("categories_list") as class_3520;
         var _loc2_:Array = [];
         for each(var _loc1_ in _catalog.navigator.visibleEventCategories)
         {
            _loc2_.push("${navigator.searchcode.title.eventcategory__" + _loc1_.categoryId + "}");
         }
         var_2485.populate(_loc2_);
         var_2485.selection = 0;
         var_2485.addEventListener("WE_SELECTED",onEventCategoryMenuEvent);
      }
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         setDefaultRoom(param1.roomId,false);
      }
      
      private function setDefaultRoom(param1:int, param2:Boolean = false) : void
      {
         var _loc6_:int = 0;
         var _loc3_:class_1677 = null;
         var _loc9_:String = null;
         var _loc7_:RoomAdPurchaseData = null;
         if(window == null)
         {
            return;
         }
         var _loc8_:class_3520 = window.findChildByName("room_drop_menu") as class_3520;
         if(_rooms == null)
         {
            if(_loc8_.numMenuItems > 0)
            {
               _loc8_.selection = 0;
            }
            return;
         }
         var _loc5_:* = 0;
         var _loc4_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _rooms.length)
         {
            _loc3_ = _rooms[_loc6_] as class_1677;
            if(param2)
            {
               if(_loc3_.roomName.length > 25)
               {
                  _loc9_ = _loc3_.roomName.substr(0,25) + "...";
                  _loc4_.push(_loc9_);
               }
               else
               {
                  _loc4_.push(_loc3_.roomName);
               }
            }
            if(_loc3_.roomId == param1)
            {
               _loc5_ = _loc6_;
            }
            _loc6_++;
         }
         if(param2)
         {
            if(_loc4_.length == 0)
            {
               _loc4_.push(_catalog.localization.getLocalization("roomad.no.available.room","roomad.no.available.room"));
            }
            _loc8_.populate(_loc4_);
         }
         var _loc10_:class_1677;
         if((_loc10_ = _rooms[_loc5_] as class_1677) != null)
         {
            _loc8_.selection = _loc5_;
            if((_loc7_ = _catalog.roomAdPurchaseData) == null)
            {
               _loc7_ = new RoomAdPurchaseData();
               _catalog.roomAdPurchaseData = _loc7_;
            }
            _loc7_.flatId = _loc10_.roomId;
         }
         else
         {
            _loc8_.selection = 0;
         }
      }
      
      private function setExtendData() : void
      {
         var _loc1_:class_1677 = null;
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc2_ != null && _loc2_.extended)
         {
            window.findChildByName("name_input_text").caption = _loc2_.name;
            window.findChildByName("desc_input_text").caption = _loc2_.description;
            _loc1_ = new class_1677(_loc2_.flatId,_loc2_.roomName,false);
            if(_rooms != null)
            {
               _rooms.push(_loc1_);
            }
            if(var_2485 == null)
            {
               var_2485 = window.findChildByName("categories_list") as class_3520;
            }
            var_2485.selection = _loc2_.categoryId - 1;
         }
      }
      
      public function onPurchaseInfoEvent(param1:IMessageEvent) : void
      {
         var _loc5_:RoomAdPurchaseData = null;
         var _loc4_:IWindowContainer = null;
         if(!window || Boolean(window.disposed))
         {
            return;
         }
         var _loc7_:RoomAdPurchaseInfoEvent;
         var _loc3_:class_1370 = (_loc7_ = param1 as RoomAdPurchaseInfoEvent).getParser();
         var _loc6_:class_3520 = window.findChildByName("room_drop_menu") as class_3520;
         _rooms = _loc3_.rooms;
         var_946 = _loc3_.isVip;
         var _loc8_:int = _catalog.roomEngine.activeRoomId;
         setExtendData();
         populateEventCategories();
         setDefaultRoom(_loc8_,true);
         var _loc2_:class_3377 = selectedOffer();
         if(_loc2_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc2_));
            if((_loc5_ = _catalog.roomAdPurchaseData) == null)
            {
               _loc5_ = new RoomAdPurchaseData();
               _catalog.roomAdPurchaseData = _loc5_;
            }
            _loc5_.offerId = _loc2_.offerId;
            _catalog.roomAdPurchaseData = _loc5_;
            _loc4_ = window.findChildByName("price_container") as IWindowContainer;
            _catalog.utils.showPriceInContainer(_loc4_,_loc2_);
         }
      }
      
      private function onPurchaseConfirmationEvent(param1:CatalogWidgetEvent) : void
      {
         _catalog.getRoomAdsPurchaseInfo();
         window.findChildByName("name_input_text").caption = "";
         window.findChildByName("desc_input_text").caption = "";
         if(_catalog.roomAdPurchaseData)
         {
            _catalog.roomAdPurchaseData.clear();
         }
      }
      
      private function onNameWindowEvent(param1:WindowEvent) : void
      {
         var _loc3_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc2_ != null)
         {
            _loc2_.name = _loc3_.text;
         }
      }
      
      private function onDescWindowEvent(param1:WindowEvent) : void
      {
         var _loc3_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc2_ != null)
         {
            _loc2_.description = _loc3_.text;
         }
      }
      
      private function onRoomDropMenuEvent(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc5_:int = 0;
         var _loc4_:class_1677 = null;
         var _loc6_:RoomAdPurchaseData = null;
         var _loc3_:int = 0;
         var _loc7_:IWindow = null;
         var _loc8_:String = null;
         if(param1.type == "WE_SELECTED" && _rooms.length > 0)
         {
            _loc5_ = int(class_3520(param2).selection);
            _loc4_ = _rooms[_loc5_] as class_1677;
            if(_loc6_ = _catalog.roomAdPurchaseData)
            {
               _loc6_.flatId = _loc4_.roomId;
               _loc3_ = _catalog.getInteger("room_ad.duration.minutes",120);
               if(_loc4_.roomId == _loc6_.extendedFlatId)
               {
                  _loc3_ = getExtensionMinutes(_loc6_,_loc3_);
               }
               (_loc7_ = window.findChildByName("ctlg_text_1")).caption = "${roomad.catalog_text}";
               _catalog.localization.registerParameter("roomad.catalog_text","duration",String(_loc3_));
               _loc8_ = String(_catalog.localization.getLocalization("roomad.catalog_text"));
               _loc7_.caption = _loc8_;
            }
         }
      }
      
      private function onEventCategoryMenuEvent(param1:WindowEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = -1;
         var _loc6_:int = var_2485.selection;
         for each(var _loc2_ in _catalog.navigator.visibleEventCategories)
         {
            if(_loc2_.visible)
            {
               if(_loc6_ == _loc3_)
               {
                  _loc5_ = _loc2_.categoryId;
                  break;
               }
               _loc3_++;
            }
         }
         var _loc4_:RoomAdPurchaseData;
         if(_loc4_ = _catalog.roomAdPurchaseData)
         {
            _loc4_.categoryId = _loc5_;
         }
      }
      
      private function selectedOffer() : class_3377
      {
         var _loc3_:int = 0;
         var _loc2_:Offer = null;
         var _loc1_:Vector.<class_3377> = page.offers;
         if(_loc1_ != null && _loc1_)
         {
            if(_loc1_.length == 1)
            {
               return _loc1_[0];
            }
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc3_] as Offer;
               if(_loc2_.clubLevel == 2 && var_946 || _loc2_.clubLevel != 2 && !var_946)
               {
                  return _loc2_;
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:IConnection = null;
         super.dispose();
         if(_catalog != null)
         {
            _loc1_ = _catalog.connection;
            if(var_2834 != null)
            {
               _loc1_.removeMessageEvent(var_2834);
               var_2834 = null;
            }
            _catalog.roomEngine.events.removeEventListener("REE_INITIALIZED",onRoomInitialized);
            _catalog = null;
         }
      }
   }
}
