package com.sulake.habbo.inventory.marketplace
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.core.window.utils.class_3441;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class MarketplaceView implements IGetImageListener
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var var_2286:IAssetLibrary;
      
      private var var_1631:class_3514;
      
      private var var_1644:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _disposed:Boolean = false;
      
      private var var_4496:int;
      
      private var var_4146:int;
      
      private var _furniName:String;
      
      private var var_4764:HabboInventory;
      
      public function MarketplaceView(param1:MarketplaceModel, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IRoomEngine, param5:IHabboLocalizationManager, param6:HabboInventory)
      {
         super();
         var_1644 = param1;
         var_2286 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _localization = param5;
         var_4764 = param6;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_1644 = null;
            var_2286 = null;
            _windowManager = null;
            _roomEngine = null;
            _localization = null;
            disposeView();
            _disposed = true;
         }
      }
      
      private function disposeView() : void
      {
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function showBuyTokens(param1:int, param2:int) : void
      {
         if(_localization)
         {
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","price",param1.toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","count",param2.toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","free",(param2 - 1).toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.buy","price",param1.toString());
         }
         var_1631 = createWindow("buy_marketplace_tokens_xml") as class_3514;
         if(var_1631 == null)
         {
            return;
         }
         var_1631.procedure = clickHandler;
         var_1631.center();
      }
      
      public function showMakeOffer(param1:FurnitureItem) : void
      {
         var _loc8_:class_3499 = null;
         var _loc11_:String = null;
         var _loc5_:String = null;
         var _loc7_:IWidgetWindow = null;
         var _loc4_:ILimitedItemPreviewOverlayWidget = null;
         var _loc10_:IWidgetWindow = null;
         var _loc9_:IRarityItemGridOverlayWidget = null;
         if(!param1 || !_localization || !_roomEngine || !var_1644)
         {
            return;
         }
         var_1631 = createWindow("make_marketplace_offer_xml") as class_3514;
         if(!var_1631)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = var_1631.findChildByName("price_input") as ITextFieldWindow;
         if(_loc2_ != null)
         {
            _loc2_.restrict = "0-9";
         }
         checkPrice();
         _localization.registerParameter("inventory.marketplace.make_offer.expiration_info","time",var_1644.expirationHours.toString());
         _localization.registerParameter("inventory.marketplace.make_offer.min_price","minprice",var_1644.offerMinPrice.toString());
         _localization.registerParameter("inventory.marketplace.make_offer.max_price","maxprice",var_1644.offerMaxPrice.toString());
         var _loc6_:Number = 4293848814;
         if(!param1.isWallItem)
         {
            _loc8_ = _roomEngine.getFurnitureImage(param1.type,new Vector3d(90,0,0),64,this,_loc6_,String(param1.extra));
         }
         else
         {
            _loc8_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(90,0,0),64,this,_loc6_,param1.stuffData.getLegacyString());
         }
         if(!_loc8_)
         {
            return;
         }
         var_4496 = _loc8_.id;
         setFurniImage(_loc8_.data);
         if(param1.isWallItem)
         {
            _loc11_ = "wallItem.name." + param1.type;
            _loc5_ = "wallItem.desc." + param1.type;
         }
         else
         {
            _loc11_ = "roomItem.name." + param1.type;
            _loc5_ = "roomItem.desc." + param1.type;
         }
         if(param1.category == 6)
         {
            _loc11_ = "poster_" + param1.stuffData.getLegacyString() + "_name";
            _loc5_ = "poster_" + param1.stuffData.getLegacyString() + "_desc";
         }
         _furniName = _localization.getLocalization(_loc11_);
         setText("furni_name","${" + _loc11_ + "}");
         setText("furni_desc","${" + _loc5_ + "}");
         var_1631.procedure = clickHandler;
         var_1631.center();
         var _loc3_:ITextWindow = var_1631.findChildByName("average_price") as ITextWindow;
         if(_loc3_)
         {
            _loc3_.visible = false;
         }
         if(param1.stuffData != null && param1.stuffData.uniqueSerialNumber > 0)
         {
            (_loc7_ = IWidgetWindow(var_1631.findChildByName("unique_item_overlay_widget"))).visible = true;
            (_loc4_ = ILimitedItemPreviewOverlayWidget(_loc7_.widget)).serialNumber = param1.stuffData.uniqueSerialNumber;
            _loc4_.seriesSize = param1.stuffData.uniqueSeriesSize;
         }
         if(param1.stuffData != null && param1.stuffData.rarityLevel >= 0)
         {
            (_loc10_ = IWidgetWindow(var_1631.findChildByName("rarity_item_overlay_widget"))).visible = true;
            (_loc9_ = IRarityItemGridOverlayWidget(_loc10_.widget)).rarityLevel = param1.stuffData.rarityLevel;
         }
         var_1644.getItemStats();
      }
      
      private function setFurniImage(param1:BitmapData) : void
      {
         if(param1 == null || var_1631 == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperWindow;
         if((_loc5_ = var_1631.findChildByName("furni_image") as IBitmapWrapperWindow) == null)
         {
            return;
         }
         var _loc2_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc3_:int = (_loc2_.width - param1.width) * 0.5;
         var _loc4_:int = (_loc2_.height - param1.height) * 0.5;
         _loc2_.draw(param1,new Matrix(1,0,0,1,_loc3_,_loc4_));
         _loc5_.bitmap = _loc2_;
      }
      
      private function setText(param1:String, param2:String) : void
      {
         if(var_1631 == null)
         {
            return;
         }
         var _loc3_:ITextWindow = var_1631.findChildByName(param1) as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param2;
      }
      
      public function showNoCredits(param1:int) : void
      {
         if(_localization)
         {
            _localization.registerParameter("inventory.marketplace.no_credits.info","price",param1.toString());
         }
         var_1631 = createWindow("marketplace_no_credits_xml") as class_3514;
         if(var_1631 == null)
         {
            return;
         }
         var_1631.procedure = clickHandler;
         var_1631.center();
      }
      
      private function showConfirmation() : void
      {
         _localization.registerParameter("inventory.marketplace.confirm_offer.info","furniname",_furniName);
         _localization.registerParameter("inventory.marketplace.confirm_offer.info","price",calculateFinalPrice(var_4146).toString());
         var _loc2_:String = "${inventory.marketplace.confirm_offer.title}";
         var _loc1_:String = "${inventory.marketplace.confirm_offer.info}";
         _windowManager.confirm(_loc2_,_loc1_,0,confirmationCallback);
      }
      
      private function confirmationCallback(param1:class_3441, param2:WindowEvent) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param1.dispose();
         if(var_1644 == null)
         {
            return;
         }
         if(param2.type == "WE_OK")
         {
            var_1644.makeOffer(var_4146);
         }
         var_1644.releaseItem();
      }
      
      private function createWindow(param1:String) : IWindow
      {
         if(var_2286 == null || _windowManager == null)
         {
            return null;
         }
         var _loc2_:XmlAsset = var_2286.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function clickHandler(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:ITextFieldWindow = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "buy_tokens_button":
                  var_1644.buyMarketplaceTokens();
                  disposeView();
                  break;
               case "cancel_buy_tokens_button":
               case "cancel_make_offer_button":
               case "cancel_no_credits_button":
               case "header_button_close":
                  var_1644.releaseItem();
                  disposeView();
                  break;
               case "make_offer_button":
                  _loc3_ = var_1631.findChildByName("price_input") as ITextFieldWindow;
                  if(_loc3_ != null)
                  {
                     var_4146 = parseInt(_loc3_.text);
                     showConfirmation();
                  }
                  disposeView();
                  break;
               case "get_credits_button":
                  var_1644.releaseItem();
                  openCreditsPage();
                  disposeView();
            }
         }
         if(param1.type == "WE_CHANGE")
         {
            if(param2.name == "price_input")
            {
               checkPrice();
            }
         }
      }
      
      private function openCreditsPage() : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_4764.getProperty("web.shop.relativeUrl"));
      }
      
      private function calculateFinalPrice(param1:int) : int
      {
         var _loc2_:int = Math.ceil(Math.round(1000 * (param1 * (var_1644.sellingFeePercentage / 100 + 0.5 * param1 / var_1644.halfTaxLimit))) / 1000);
         return param1 - _loc2_;
      }
      
      private function checkPrice() : void
      {
         if(var_1631 == null)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = var_1631.findChildByName("price_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = parseInt(_loc2_.text);
         if(_loc3_ > var_1644.offerMaxPrice)
         {
            _loc2_.text = var_1644.offerMaxPrice.toString();
            _loc3_ = var_1644.offerMaxPrice;
         }
         var _loc4_:int = calculateFinalPrice(_loc3_);
         var _loc1_:class_3357 = var_1631.findChildByName("make_offer_button") as class_3357;
         var _loc5_:ITextWindow = var_1631.findChildByName("final_price") as ITextWindow;
         if(_loc1_ == null || _loc5_ == null)
         {
            return;
         }
         if(_loc3_ < var_1644.offerMinPrice)
         {
            _localization.registerParameter("shop.marketplace.invalid.price","minPrice",var_1644.offerMinPrice.toString());
            _localization.registerParameter("shop.marketplace.invalid.price","maxPrice",var_1644.offerMaxPrice.toString());
            _loc5_.text = "${shop.marketplace.invalid.price}";
            _loc1_.disable();
         }
         else
         {
            _loc5_.text = _localization.getLocalization("sell.in.marketplace.revenue.label") + ": " + _loc4_;
            _loc1_.enable();
         }
      }
      
      public function showResult(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 == 1)
         {
            _loc2_ = "${inventory.marketplace.result.title.success}";
         }
         else
         {
            _loc2_ = "${inventory.marketplace.result.title.failure}";
         }
         var _loc3_:String = "${inventory.marketplace.result." + param1 + "}";
         _windowManager.alert(_loc2_,_loc3_,0,closeAlert);
      }
      
      private function closeAlert(param1:class_3348, param2:WindowEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_1644.releaseItem();
         param1.dispose();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(var_4496 == param1)
         {
            setFurniImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function showAlert(param1:String, param2:String) : void
      {
         _windowManager.alert(param1,param2,0,closeAlert);
      }
      
      public function updateAveragePrice(param1:int, param2:int) : void
      {
         if(!var_1631 || !_localization || !var_1644)
         {
            return;
         }
         var _loc3_:ITextWindow = var_1631.findChildByName("average_price") as ITextWindow;
         if(!_loc3_)
         {
            return;
         }
         var _loc6_:int = Math.floor(param1 / (1 + var_1644.commission * 0.01));
         _localization.registerParameter("inventory.marketplace.make_offer.average_price","days",param2.toString());
         var _loc4_:String = param1 == 0 ? " - " : param1.toString();
         _localization.registerParameter("inventory.marketplace.make_offer.average_price","price",_loc4_);
         var _loc5_:String = _loc6_ == 0 ? " - " : _loc6_.toString();
         _localization.registerParameter("inventory.marketplace.make_offer.average_price","price_no_commission",_loc5_);
         _loc3_.visible = true;
      }
   }
}
