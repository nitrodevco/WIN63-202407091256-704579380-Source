package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MarketPlaceOwnItemsCatalogWidget extends CatalogWidget implements class_3558, IGetImageListener, IMarketPlaceVisualization
   {
       
      
      private const STATUS_SEARCHING:int = 1;
      
      private const STATUS_LIST_AVAILABLE:int = 2;
      
      private var var_3306:Map;
      
      private var _itemList:IItemListWindow;
      
      private var _offers:Map;
      
      public function MarketPlaceOwnItemsCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
         var_3306 = new Map();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(marketPlace == null)
         {
            return false;
         }
         var _loc2_:IHabboWindowManager = marketPlace.windowManager;
         if(_loc2_ == null)
         {
            return false;
         }
         displayMainView();
         var _loc1_:IItemListWindow = _window.findChildByName("item_list") as IItemListWindow;
         var_3306.add(1,_loc1_.removeListItem(_loc1_.getListItemByName("ongoing_item")));
         var_3306.add(2,_loc1_.removeListItem(_loc1_.getListItemByName("sold_item")));
         var_3306.add(3,_loc1_.removeListItem(_loc1_.getListItemByName("expired_item")));
         marketPlace.registerVisualization(this);
         marketPlace.requestOwnItems();
         updateStatusDisplay(1);
         showRedeemInfo(false);
         return true;
      }
      
      private function showRedeemInfo(param1:Boolean) : void
      {
         if(!window)
         {
            return;
         }
         var _loc2_:IWindowContainer = window.findChildByName("redeem_border") as IWindowContainer;
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      public function listUpdatedNotify() : void
      {
         if(marketPlace == null)
         {
            return;
         }
         updateList(marketPlace.latestOwnOffers());
      }
      
      private function updateStatusDisplay(param1:int, param2:int = -1) : void
      {
         var _loc5_:String = null;
         if(!marketPlace || !window)
         {
            return;
         }
         var _loc3_:IHabboLocalizationManager = marketPlace.localization;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:IWindow;
         if((_loc4_ = window.findChildByName("status_text")) == null)
         {
            return;
         }
         if(param1 == 1)
         {
            _loc5_ = String(_loc3_.getLocalization("catalog.marketplace.searching"));
         }
         else if(param2 > 0)
         {
            _loc5_ = (_loc5_ = String(_loc3_.getLocalization("catalog.marketplace.items_found"))).replace("%count%",param2);
         }
         else
         {
            _loc5_ = String(_loc3_.getLocalization("catalog.marketplace.no_items"));
         }
         _loc4_.caption = _loc5_;
      }
      
      private function get marketPlace() : IMarketPlace
      {
         if(!page || !page.viewer || !page.viewer.catalog)
         {
            return null;
         }
         return page.viewer.catalog.getMarketPlace();
      }
      
      private function updateList(param1:Map) : void
      {
         var _loc24_:IWindowContainer = null;
         var _loc21_:int = 0;
         var _loc14_:int = 0;
         var _loc17_:MarketPlaceOfferData = null;
         var _loc4_:IWindowContainer = null;
         var _loc8_:IWindow = null;
         var _loc11_:IWindow = null;
         var _loc31_:IWindow = null;
         var _loc12_:String = null;
         var _loc10_:IWindow = null;
         var _loc26_:int = 0;
         var _loc18_:int = 0;
         var _loc20_:int = 0;
         var _loc13_:String = null;
         var _loc29_:String = null;
         var _loc22_:IWindow = null;
         var _loc16_:IWindow = null;
         var _loc6_:class_3499 = null;
         var _loc23_:IBitmapWrapperWindow = null;
         var _loc9_:Point = null;
         var _loc28_:IWindow = null;
         var _loc19_:IWidgetWindow = null;
         var _loc27_:ILimitedItemGridOverlayWidget = null;
         var _loc25_:IWidgetWindow = null;
         var _loc3_:IRarityItemGridOverlayWidget = null;
         if(!param1 || !marketPlace || !window)
         {
            return;
         }
         _offers = param1;
         var _loc2_:IHabboLocalizationManager = marketPlace.localization;
         if(!_loc2_)
         {
            return;
         }
         var _loc30_:IItemListWindow;
         if(!(_loc30_ = window.findChildByName("item_list") as IItemListWindow))
         {
            return;
         }
         _loc30_.destroyListItems();
         var _loc7_:int = 0;
         var _loc5_:Array;
         if(!(_loc5_ = param1.getKeys()))
         {
            return;
         }
         updateStatusDisplay(2,_loc5_.length);
         _loc21_ = 0;
         while(_loc21_ < _loc5_.length)
         {
            _loc14_ = int(_loc5_[_loc21_]);
            if((_loc17_ = param1.getValue(_loc14_) as MarketPlaceOfferData).status == 2)
            {
               _loc7_++;
            }
            if(_loc24_ = var_3306.getValue(_loc17_.status))
            {
               if(!(!(_loc4_ = _loc24_.clone() as IWindowContainer) || Boolean(_loc4_.disposed)))
               {
                  if((_loc8_ = _loc4_.findChildByName("item_name")) != null)
                  {
                     _loc8_.caption = marketPlace != null ? "${" + marketPlace.getNameLocalizationKey(_loc17_) + "}" : "";
                  }
                  if((_loc11_ = _loc4_.findChildByName("item_desc")) != null)
                  {
                     _loc11_.caption = marketPlace != null ? "${" + marketPlace.getDescriptionLocalizationKey(_loc17_) + "}" : "";
                  }
                  if((_loc31_ = _loc4_.findChildByName("item_price")) != null)
                  {
                     _loc12_ = (_loc12_ = String(_loc2_.getLocalization("catalog.marketplace.offer.price_own_item"))).replace("%price%",_loc17_.price);
                     _loc31_.caption = _loc12_;
                  }
                  if(_loc17_.status == 1)
                  {
                     if((_loc10_ = _loc4_.findChildByName("item_time")) != null)
                     {
                        _loc26_ = Math.max(1,_loc17_.timeLeftMinutes);
                        _loc18_ = Math.floor(_loc26_ / 60);
                        _loc13_ = (_loc20_ = _loc26_ - _loc18_ * 60) + " " + _loc2_.getLocalization("catalog.marketplace.offer.minutes");
                        if(_loc18_ > 0)
                        {
                           _loc13_ = _loc18_ + " " + _loc2_.getLocalization("catalog.marketplace.offer.hours") + " " + _loc13_;
                        }
                        _loc29_ = (_loc29_ = String(_loc2_.getLocalization("catalog.marketplace.offer.time_left"))).replace("%time%",_loc13_);
                        _loc10_.caption = _loc29_;
                     }
                  }
                  if(_loc17_.status == 2)
                  {
                     if((_loc22_ = _loc4_.findChildByName("item_sold")) != null)
                     {
                        _loc22_.caption = _loc2_.getLocalization("catalog.marketplace.offer.sold");
                     }
                  }
                  if(_loc17_.status == 3)
                  {
                     if((_loc16_ = _loc4_.findChildByName("item_expired")) != null)
                     {
                        _loc16_.caption = _loc2_.getLocalization("catalog.marketplace.offer.expired");
                     }
                  }
                  if(_loc17_.image == null)
                  {
                     if((_loc6_ = getFurniImageResult(_loc17_.furniId,_loc17_.furniType,_loc17_.extraData)) != null && _loc6_.data != null)
                     {
                        _loc17_.image = _loc6_.data as BitmapData;
                        _loc17_.imageCallback = _loc6_.id;
                        _loc4_.id = _loc6_.id;
                     }
                  }
                  if(_loc17_.image != null)
                  {
                     if((_loc23_ = _loc4_.findChildByName("item_image") as IBitmapWrapperWindow) != null)
                     {
                        _loc9_ = new Point((_loc23_.width - _loc17_.image.width) / 2,(_loc23_.height - _loc17_.image.height) / 2);
                        if(_loc23_.bitmap == null)
                        {
                           _loc23_.bitmap = new BitmapData(_loc23_.width,_loc23_.height,true,0);
                        }
                        _loc23_.bitmap.copyPixels(_loc17_.image,_loc17_.image.rect,_loc9_);
                     }
                  }
                  if(_loc17_.isUniqueLimitedItem)
                  {
                     _loc28_ = _loc4_.findChildByName("unique_item_background_bitmap");
                     _loc19_ = IWidgetWindow(_loc4_.findChildByName("unique_item_overlay_widget"));
                     (_loc27_ = ILimitedItemGridOverlayWidget(_loc19_.widget)).serialNumber = _loc17_.stuffData.uniqueSerialNumber;
                     _loc27_.animated = true;
                     _loc28_.visible = true;
                     _loc19_.visible = true;
                  }
                  if(_loc17_.stuffData && _loc17_.stuffData.rarityLevel >= 0)
                  {
                     _loc25_ = IWidgetWindow(_loc4_.findChildByName("rarity_item_overlay_widget"));
                     _loc3_ = IRarityItemGridOverlayWidget(_loc25_.widget);
                     _loc25_.visible = true;
                     _loc3_.rarityLevel = _loc17_.stuffData.rarityLevel;
                  }
                  _loc30_.addListItem(_loc4_);
                  _loc4_.procedure = onGridEvent;
               }
            }
            _loc21_++;
         }
         showRedeemInfo(true);
         var _loc15_:IWindow;
         if(_loc15_ = window.findChildByName("redeem_info"))
         {
            if(_loc7_ > 0)
            {
               _loc2_.registerParameter("catalog.marketplace.redeem.get_credits","count",_loc7_.toString());
               _loc2_.registerParameter("catalog.marketplace.redeem.get_credits","credits",marketPlace.creditsWaiting.toString());
               _loc15_.caption = "${catalog.marketplace.redeem.get_credits}";
            }
            else
            {
               _loc15_.caption = "${catalog.marketplace.redeem.no_sold_items}";
            }
         }
      }
      
      public function displayMainView() : void
      {
         attachWidgetView("marketPlaceOwnItemsWidget");
         window.procedure = onWidgetEvent;
         _itemList = window.findChildByName("item_list") as IItemListWindow;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc5_:* = null;
         var _loc7_:IBitmapWrapperWindow = null;
         var _loc6_:Point = null;
         if(disposed || !marketPlace || !param2 || !_itemList || !_offers)
         {
            return;
         }
         var _loc4_:Array = [];
         if(_itemList.groupListItemsWithID(param1,_loc4_))
         {
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_)
               {
                  if((_loc7_ = _loc5_.findChildByName("item_image") as IBitmapWrapperWindow) != null)
                  {
                     _loc7_.bitmap = new BitmapData(_loc7_.width,_loc7_.height,true,16777215);
                     _loc6_ = new Point((_loc7_.width - param2.width) / 2,(_loc7_.height - param2.height) / 2);
                     _loc7_.bitmap.copyPixels(param2,param2.rect,_loc6_,null,null,true);
                  }
                  _loc5_.id = 0;
               }
            }
         }
         for each(var _loc3_ in _offers)
         {
            if(_loc3_.imageCallback == param1)
            {
               _loc3_.imageCallback = 0;
               _loc3_.image = param2;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getFurniImageResult(param1:int, param2:int, param3:String = null) : class_3499
      {
         if(!page || !page.viewer || !page.viewer.roomEngine)
         {
            return null;
         }
         if(param2 == 1)
         {
            return page.viewer.roomEngine.getFurnitureIcon(param1,this);
         }
         if(param2 == 2)
         {
            return page.viewer.roomEngine.getWallItemIcon(param1,this,param3);
         }
         return null;
      }
      
      private function onGridEvent(param1:WindowEvent, param2:IWindow = null) : void
      {
         var _loc5_:IItemListWindow = null;
         var _loc6_:int = 0;
         var _loc3_:Map = null;
         var _loc4_:MarketPlaceOfferData = null;
         if(param1.type == "WME_CLICK")
         {
            if(!marketPlace || !param2 || !window)
            {
               return;
            }
            if(param2.name == "pick_button")
            {
               if((_loc5_ = window.findChildByName("item_list") as IItemListWindow) == null)
               {
                  return;
               }
               _loc6_ = _loc5_.getListItemIndex(param1.window.parent);
               _loc3_ = marketPlace.latestOwnOffers();
               if(!_loc3_)
               {
                  return;
               }
               if(_loc4_ = _loc3_.getWithIndex(_loc6_) as MarketPlaceOfferData)
               {
                  marketPlace.redeemExpiredOffer(_loc4_.offerId);
               }
            }
         }
      }
      
      private function onWidgetEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(param2 == null)
         {
            param2 = param1.target as IWindow;
         }
         if(param1.type == "WME_CLICK")
         {
         }
      }
      
      public function updateStats() : void
      {
      }
   }
}
