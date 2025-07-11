package com.sulake.habbo.quest.seasonalcalendar
{
    import assets.class_14

    import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_282;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1718;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_714;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_790;
   
   public class CatalogPromo implements IDisposable, IGetImageListener, class_1812
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:IWindowContainer;
      
      private var var_26:IConnection;
      
      private var var_1641:MainWindow;
      
      private var var_1236:class_1718 = null;
      
      private var _offerId:int = -1;
      
      private var var_562:int = -1;
      
      private var var_4011:class_714 = null;
      
      private var var_3251:IMessageEvent = null;
      
      private var var_3151:IMessageEvent = null;
      
      public function CatalogPromo(param1:HabboQuestEngine, param2:MainWindow)
      {
         super();
         _questEngine = param1;
         var_1641 = param2;
      }
      
      public function dispose() : void
      {
         if(var_26)
         {
            if(var_3251)
            {
               var_26.removeMessageEvent(var_3251);
               var_3251 = null;
            }
            if(var_3151)
            {
               var_26.removeMessageEvent(var_3151);
               var_3151 = null;
            }
            var_26 = null;
         }
         _questEngine = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         if(param1 == getActivityPointType())
         {
            _questEngine.localization.registerParameter("quests.seasonalcalendar.promo.balance","amount","" + param2);
            if(_window != null)
            {
               refresh();
            }
         }
      }
      
      private function getActivityPointType() : int
      {
         var _loc1_:String = String(_questEngine.configuration.getProperty("seasonalQuestCalendar.currency"));
         return isNaN(Number(_loc1_)) ? 0 : int(_loc1_);
      }
      
      public function prepare(param1:class_3514) : void
      {
         _window = IWindowContainer(param1.findChildByName("catalog_promo_cont"));
         _window.findChildByName("buy_button").disable();
         _window.findChildByName("buy_button").procedure = onBuyButton;
         var_26 = _questEngine.communication.connection;
         if(var_26 != null)
         {
            var_3251 = new class_714(onDailyOfferMessage);
            var_3151 = new class_790(onCatalogPublished);
            var_26.addMessageEvent(var_3251);
            var_26.addMessageEvent(var_3151);
            var_26.send(new class_282());
         }
      }
      
      public function refresh() : void
      {
         var _loc5_:String = null;
         var _loc2_:class_3499 = null;
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("your_balance_txt"));
         var _loc1_:IWindowContainer = IWindowContainer(_window.findChildByName("currency_icon_cont"));
         _loc1_.x = _loc4_.x + _loc4_.width;
         Util.hideChildren(_loc1_);
         var _loc3_:IWindow = _loc1_.findChildByName("currency_icon_" + getActivityPointType());
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
         if(var_1236 != null)
         {
            _loc5_ = null;
            _loc2_ = null;
            if(var_1236.productType == "i")
            {
               _loc2_ = _questEngine.roomEngine.getWallItemImage(var_1236.furniClassId,new Vector3d(90,0,0),64,this,0,var_1236.extraParam);
            }
            else if(var_1236.productType == "s")
            {
               _loc2_ = _questEngine.roomEngine.getFurnitureImage(var_1236.furniClassId,new Vector3d(90,0,0),64,this);
            }
            if(_loc2_ != null && _loc2_.data != null)
            {
               setPromoFurniImage(_loc2_.data);
            }
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setPromoFurniImage(param2);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onBuyButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            class_14.log("Buy button clicked");
            if(_offerId != -1)
            {
               _questEngine.catalog.openCatalogPageById(var_562,_offerId,"NORMAL");
            }
         }
      }
      
      private function onDailyOfferMessage(param1:class_714) : void
      {
         _window.findChildByName("buy_button").enable();
         var _loc2_:class_3423 = _questEngine.sessionDataManager.getProductData(param1.offer.localizationId);
         if(_loc2_ != null)
         {
            ITextWindow(_window.findChildByName("promo_info")).text = _loc2_.name;
            var_562 = param1.pageId;
            _offerId = param1.offer.offerId;
            if(param1.offer.products.length > 0)
            {
               var_1236 = class_1718(param1.offer.products[0]);
               refresh();
            }
         }
         else if(var_4011 == null)
         {
            var_4011 = param1;
            _questEngine.sessionDataManager.addProductsReadyEventListener(this);
         }
      }
      
      public function productDataReady() : void
      {
         onDailyOfferMessage(var_4011);
      }
      
      private function setPromoFurniImage(param1:BitmapData) : void
      {
         var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(_window.findChildByName("furni_preview"));
         var _loc2_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc3_:Rectangle = param1.rect;
         if(_loc3_.width > _loc2_.rect.width)
         {
            _loc3_.x = (_loc3_.width - _loc2_.rect.width) / 2;
            _loc3_.width = _loc2_.rect.width;
         }
         if(_loc3_.height > _loc2_.rect.height)
         {
            _loc3_.y = (_loc3_.height - _loc2_.rect.height) / 2;
            _loc3_.height = _loc2_.rect.height;
         }
         var _loc4_:Point = new Point(0,0);
         if(_loc2_.rect.width > _loc3_.width)
         {
            _loc4_.x = (_loc2_.rect.width - _loc3_.width) / 2;
         }
         if(_loc2_.rect.height > _loc3_.height)
         {
            _loc4_.y = (_loc2_.rect.height - _loc3_.height) / 2;
         }
         _loc2_.copyPixels(param1,_loc3_,_loc4_);
         _loc5_.bitmap = _loc2_;
      }
      
      private function onCatalogPublished(param1:IMessageEvent) : void
      {
         if(var_26 != null)
         {
            var_26.send(new class_282());
         }
      }
   }
}
