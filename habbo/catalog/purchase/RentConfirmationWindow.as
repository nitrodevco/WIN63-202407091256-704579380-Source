package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.parser.room.furniture.class_1381;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_1003;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_287;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.class_584;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.FurniRentOrBuyoutOfferMessageEvent;
   
   public class RentConfirmationWindow implements IDisposable, IGetImageListener
   {
      
      private static const MODE_INFOSTAND:int = 1;
      
      private static const MODE_INVENTORY:int = 2;
      
      private static const MODE_CATALOGUE:int = 3;
       
      
      private var _disposed:Boolean;
      
      private var _offerMessageEvent:FurniRentOrBuyoutOfferMessageEvent;
      
      private var _window:IWindowContainer;
      
      private var _isBuyout:Boolean;
      
      private var var_280:int = -1;
      
      private var _catalog:HabboCatalog;
      
      private var var_1691:class_3365;
      
      private var var_1263:int;
      
      private var var_4077:int = -1;
      
      private var var_1495:int;
      
      public function RentConfirmationWindow(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
         _offerMessageEvent = new FurniRentOrBuyoutOfferMessageEvent(onFurniRentOrBuyoutOffer);
         _catalog.connection.addMessageEvent(_offerMessageEvent);
      }
      
      private function onFurniRentOrBuyoutOffer(param1:FurniRentOrBuyoutOfferMessageEvent) : void
      {
         var _loc3_:class_3499 = null;
         if(var_1691 == null)
         {
            return;
         }
         var _loc2_:class_1381 = param1.getParser();
         if(var_1691.fullName != _loc2_.furniTypeName)
         {
            return;
         }
         _isBuyout = _loc2_.buyout;
         if(_catalog.getPurse().credits < _loc2_.priceInCredits)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         if(_catalog.getPurse().getActivityPointsForType(_loc2_.activityPointType) < _loc2_.priceInActivityPoints)
         {
            _catalog.showNotEnoughActivityPointsAlert(_loc2_.activityPointType);
            return;
         }
         _window = _catalog.windowManager.buildFromXML(_catalog.assets.getAssetByName("rent_confirmation").content as XML) as IWindowContainer;
         if(_loc2_.priceInCredits > 0)
         {
            _window.findChildByName("price_amount").caption = _loc2_.priceInCredits.toString();
            IStaticBitmapWrapperWindow(_window.findChildByName("price_type")).assetUri = "toolbar_credit_icon_0";
         }
         else
         {
            _window.findChildByName("price_amount").caption = _loc2_.priceInActivityPoints.toString();
         }
         if(_isBuyout)
         {
            _window.caption = "${rent.confirmation.title.buyout}";
            _window.findChildByName("rental_description").visible = false;
            _window.findChildByName("ok_button").caption = "${catalog.purchase_confirmation.buy}";
         }
         _window.findChildByName("furni_name").caption = var_1691.localizedName;
         IItemListWindow(_window.findChildByName("content_list")).arrangeListItems();
         _window.center();
         _window.procedure = windowProcedure;
         switch(var_1691.type)
         {
            case "s":
               _loc3_ = roomEngine.getFurnitureImage(var_1691.id,new Vector3d(90,0,0),64,this);
               break;
            case "i":
               _loc3_ = roomEngine.getWallItemImage(var_1691.id,new Vector3d(90,0,0),64,this);
         }
         IBitmapWrapperWindow(_window.findChildByName("image")).bitmap = _loc3_.data;
         var_280 = _loc3_.id;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         close();
         if(_offerMessageEvent != null)
         {
            _catalog.connection.removeMessageEvent(_offerMessageEvent);
            _offerMessageEvent = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show(param1:class_3365, param2:Boolean, param3:int = -1, param4:int = -1, param5:Boolean = false) : void
      {
         close();
         var_1691 = param1;
         var_4077 = param3;
         var_1495 = param4;
         if(param5)
         {
            var_1263 = 3;
         }
         else if(var_4077 > -1)
         {
            var_1263 = 1;
         }
         else
         {
            var_1263 = 2;
         }
         var _loc6_:* = param1.type == "i";
         _catalog.connection.send(new class_287(_loc6_,param1.fullName,param2));
      }
      
      private function get roomEngine() : IRoomEngine
      {
         return _catalog.roomEngine;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK" || _window == null)
         {
            return;
         }
         switch(param2.name)
         {
            case "cancel_button":
            case "header_button_close":
               close();
               break;
            case "ok_button":
               switch(var_1263 - 1)
               {
                  case 0:
                     _catalog.connection.send(new class_1003(var_1691.type == "i",var_4077,_isBuyout));
                     break;
                  case 1:
                     _catalog.connection.send(new class_584(var_1495,_isBuyout));
                     break;
                  case 2:
                     _catalog.purchaseOffer(var_1691.rentOfferId);
               }
               close();
         }
      }
      
      private function close() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
         var_280 = -1;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(_window != null && param1 == var_280)
         {
            IBitmapWrapperWindow(_window.findChildByName("image")).bitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}
