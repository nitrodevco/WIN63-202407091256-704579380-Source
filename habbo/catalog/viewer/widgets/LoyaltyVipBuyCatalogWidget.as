package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.club.ClubBuyController;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.club.VipBuyItem;
   import com.sulake.habbo.catalog.purse.class_3378;
   import com.sulake.habbo.catalog.viewer.CatalogPage;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.text.TextFormat;
   
   public class LoyaltyVipBuyCatalogWidget extends CatalogWidget implements class_3558, IVipBuyCatalogWidget
   {
       
      
      private var var_319:ClubBuyController;
      
      private var _offers:Array;
      
      private var _catalog:HabboCatalog;
      
      public function LoyaltyVipBuyCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      public function get isGift() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         if(var_319 != null)
         {
            var_319.unRegisterVisualization(this);
            var_319 = null;
         }
         reset();
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _offers = [];
         var_319 = _catalog.getClubBuyController();
         var_319.registerVisualization(this);
         var_319.requestOffers(6);
         return true;
      }
      
      public function reset() : void
      {
         for each(var _loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers = [];
      }
      
      public function initClubType(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc2_:IHabboLocalizationManager = _catalog.localization;
         var _loc6_:class_3378;
         if((_loc6_ = _catalog.getPurse()) != null && _loc2_ != null)
         {
            _loc5_ = _loc6_.clubDays;
            _loc3_ = (_loc4_ = _loc6_.clubPeriods) * 31 + _loc5_;
            _loc2_.registerParameter("catalog.vip.extend.info","days",String(_loc3_));
         }
         if(_window != null && param1 == 2)
         {
            _window.findChildByName("vip_title").caption = "${catalog.vip.extend.title}";
            _window.findChildByName("vip_info").caption = "${catalog.vip.extend.info}";
         }
         if(_window != null)
         {
            fixFormatting(_window.findChildByName("vip_title") as ITextWindow);
            fixFormatting(_window.findChildByName("vip_info") as ITextWindow,3);
         }
         initLinks();
      }
      
      private function fixFormatting(param1:ITextWindow, param2:Number = 0) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.align = "center";
         _loc3_.leading = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private function initLinks() : void
      {
         var _loc1_:IWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("vip_link");
            if(_loc1_)
            {
               _loc1_.addEventListener("WME_CLICK",onBenefits);
               _loc1_.mouseThreshold = 0;
            }
         }
      }
      
      public function onBenefits(param1:WindowMouseEvent) : void
      {
         _catalog.utils.showVipBenefits();
      }
      
      public function showOffer(param1:ClubBuyOfferData) : void
      {
         var _loc2_:VipBuyItem = null;
         if(disposed || !param1.vip)
         {
            return;
         }
         class_14.log("Offer: " + [param1.offerId,param1.productCode,param1.priceCredits,param1.vip,param1.months,param1.daysLeftAfterPurchase,param1.year,param1.month,param1.day,param1.upgradeHcPeriodToVip]);
         param1.page = page;
         try
         {
            _loc2_ = new VipBuyItem(param1,_catalog,"HabboCatalogBuy");
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("ClubBuyCatalogWidget","showOffer - new ClubBuyItem(" + String(param1) + ", " + (String(page as CatalogPage)) + ") crashed!");
            return;
         }
         var _loc3_:IItemListWindow = _window.findChildByName("item_list_vip") as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc3_.addListItem(_loc2_.window);
         }
         _offers.push(_loc2_);
      }
   }
}
