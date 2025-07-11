package com.sulake.habbo.catalog.viewer
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.AddOnBadgeViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderAddonsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderLoyaltyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderSubscriptionCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuyGuildWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.FeaturedItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.FirstProductSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildBadgeViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildForumSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LoyaltyVipBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RoomAdsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SimplePriceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SoldLtdItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpinnerCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TotalPriceWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.UniqueLimitedItemWidget;
   import com.sulake.habbo.catalog.viewer.widgets.UserBadgeSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.VipBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.WarningCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.class_3558;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
   import flash.events.Event;
   
   public class CatalogPage implements class_3455
   {
      
      protected static const LAYOUT_MAGIC_PREFIX:String = "layout_";
      
      public static const MODE_NORMAL:int = 0;
      
      public static const MODE_SEARCH:int = 1;
       
      
      protected var _layout:XML;
      
      protected var _window:IWindowContainer;
      
      private var var_3499:class_3477;
      
      private var var_562:int;
      
      private var var_529:String;
      
      private var _offers:Vector.<class_3377>;
      
      private var _localization:class_3440;
      
      private var var_1643:Array;
      
      private var _widgetEvents:EventDispatcherWrapper;
      
      private var _catalog:HabboCatalog;
      
      private var var_4897:int;
      
      private var var_3419:ItemGridCatalogWidget;
      
      private var var_433:Boolean;
      
      private var var_1263:int;
      
      public function CatalogPage(param1:class_3477, param2:int, param3:String, param4:class_3440, param5:Vector.<class_3377>, param6:HabboCatalog, param7:Boolean, param8:int = -1)
      {
         var_1643 = [];
         super();
         var_3499 = param1;
         var_562 = param2;
         var_529 = param3;
         _localization = param4;
         _offers = param5;
         _catalog = param6;
         for each(var _loc9_ in param5)
         {
            _loc9_.page = this;
         }
         _widgetEvents = new EventDispatcherWrapper();
         var_1643 = [];
         var_433 = param7;
         if(param8 == -1)
         {
            var_1263 = 0;
         }
         else
         {
            var_1263 = param8;
         }
         init();
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function get viewer() : class_3477
      {
         return var_3499;
      }
      
      public function get pageId() : int
      {
         return var_1263 == 1 ? -12345678 : var_562;
      }
      
      public function get layoutCode() : String
      {
         return var_529;
      }
      
      public function get offers() : Vector.<class_3377>
      {
         return _offers;
      }
      
      public function get localization() : class_3440
      {
         return _localization;
      }
      
      public function get links() : Array
      {
         return _localization.getLinks(var_529);
      }
      
      public function get hasLinks() : Boolean
      {
         return _localization.hasLinks(var_529);
      }
      
      public function get acceptSeasonCurrencyAsCredits() : Boolean
      {
         return var_433;
      }
      
      public function get allowDragging() : Boolean
      {
         return var_529 != "sold_ltd_items";
      }
      
      public function set searchPageId(param1:int) : void
      {
         var_4897 = param1;
      }
      
      public function get mode() : int
      {
         return var_1263;
      }
      
      public function get isBuilderPage() : Boolean
      {
         return _catalog.catalogType == "BUILDERS_CLUB";
      }
      
      public function selectOffer(param1:int) : void
      {
         var _loc3_:class_3517 = null;
         var _loc4_:ITextFieldWindow = null;
         if(var_3419 != null && param1 > -1)
         {
            class_14.log("selecting offer " + param1);
            for each(var _loc2_ in _offers)
            {
               if(_loc2_.offerId == param1)
               {
                  _loc3_ = _loc2_.gridItem;
                  var_3419.select(_loc3_,true);
               }
            }
         }
         if(_window && _window.findChildByName("trophyWidget") != null)
         {
            (_loc4_ = _window.findChildByName("input_text") as ITextFieldWindow).focus();
            _loc4_.activate();
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc2_ in var_1643)
         {
            _loc2_.dispose();
         }
         var_1643 = null;
         _localization.dispose();
         for each(var _loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers = new Vector.<class_3377>(0);
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_widgetEvents != null)
         {
            _widgetEvents.dispose();
            _widgetEvents = null;
         }
         var_3499 = null;
         _layout = null;
         var_562 = 0;
         var_529 = "";
         var_433 = false;
      }
      
      public function init() : void
      {
         if(createWindow(layoutCode))
         {
            createWidgets();
         }
      }
      
      public function closed() : void
      {
         if(var_1643 != null)
         {
            for each(var _loc1_ in var_1643)
            {
               _loc1_.closed();
            }
         }
      }
      
      protected function createWindow(param1:String) : Boolean
      {
         if(param1 == "frontpage4")
         {
            param1 = "frontpage_featured";
         }
         var _loc2_:String = "layout_" + param1;
         if(var_3499.viewerTags.indexOf("UBUNTU") > -1)
         {
            if(!viewer.catalog.assets.hasAsset(_loc2_))
            {
               _loc2_ = "old_" + _loc2_;
            }
         }
         else
         {
            _loc2_ = "old_" + _loc2_;
         }
         var _loc3_:XmlAsset = viewer.catalog.assets.getAssetByName(_loc2_) as XmlAsset;
         if(_loc3_ == null)
         {
            class_14.log("Could not find asset for layout " + _loc2_);
            return false;
         }
         _layout = _loc3_.content as XML;
         _window = viewer.catalog.windowManager.buildFromXML(_layout) as IWindowContainer;
         if(_window == null)
         {
            class_14.log("Could not create layout " + param1);
            return false;
         }
         return true;
      }
      
      private function localize() : void
      {
      }
      
      private function createWidgets() : void
      {
         createWidgetsRecursion(_window);
         initializeWidgets();
      }
      
      private function createWidgetsRecursion(param1:IWindowContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IWindowContainer = null;
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.numChildren)
            {
               _loc3_ = param1.getChildAt(_loc2_) as IWindowContainer;
               if(_loc3_ != null)
               {
                  createWidget(_loc3_);
                  createWidgetsRecursion(_loc3_);
               }
               _loc2_++;
            }
         }
      }
      
      private function createWidget(param1:IWindowContainer) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.name)
         {
            case "itemGridWidget":
               if(var_3419 == null)
               {
                  var_3419 = new ItemGridCatalogWidget(param1,_catalog.sessionDataManager,_catalog.catalogType);
                  var_1643.push(var_3419);
               }
               break;
            case "productViewWidget":
               var_1643.push(new ProductViewCatalogWidget(param1,_catalog));
               break;
            case "songDiskProductViewWidget":
               var_1643.push(new SongDiskProductViewCatalogWidget(param1,_catalog));
               break;
            case "singleViewWidget":
               var_1643.push(new SingleViewCatalogWidget(param1,_catalog));
               break;
            case "purchaseWidget":
               var_1643.push(new PurchaseCatalogWidget(param1,_catalog));
               break;
            case "colourGridWidget":
               var_1643.push(new ColourGridCatalogWidget(param1));
               break;
            case "traxPreviewWidget":
               var_1643.push(new TraxPreviewCatalogWidget(param1,_catalog.soundManager));
               break;
            case "redeemItemCodeWidget":
               var_1643.push(new RedeemItemCodeCatalogWidget(param1));
               break;
            case "spacesNewWidget":
               var_1643.push(new SpacesNewCatalogWidget(param1,_catalog.sessionDataManager,_catalog.catalogType));
               break;
            case "roomPreviewWidget":
               var_1643.push(new RoomPreviewCatalogWidget(param1));
               break;
            case "trophyWidget":
               var_1643.push(new TrophyCatalogWidget(param1,_catalog));
               break;
            case "addOnBadgeViewWidget":
               var_1643.push(new AddOnBadgeViewCatalogWidget(param1));
               break;
            case "petsWidget":
               var_1643.push(new PetsCatalogWidget(param1,_catalog));
               break;
            case "newPetsWidget":
               var_1643.push(new NewPetsCatalogWidget(param1,_catalog));
               break;
            case "roomAdsCatalogWidget":
               var_1643.push(new RoomAdsCatalogWidget(param1,_catalog));
               break;
            case "textInputWidget":
               var_1643.push(new TextInputCatalogWidget(param1));
               break;
            case "specialInfoWidget":
               var_1643.push(new SpecialInfoWidget(param1));
               break;
            case "marketPlaceWidget":
               var_1643.push(new MarketPlaceCatalogWidget(param1));
               break;
            case "marketPlaceOwnItemsWidget":
               var_1643.push(new MarketPlaceOwnItemsCatalogWidget(param1));
               break;
            case "clubGiftWidget":
               var_1643.push(new ClubGiftWidget(param1,_catalog.getClubGiftController(),_catalog));
               break;
            case "clubBuyWidget":
               var_1643.push(new ClubBuyCatalogWidget(param1));
               break;
            case "vipBuyWidget":
               var_1643.push(new VipBuyCatalogWidget(param1,_catalog));
               break;
            case "loyaltyVipBuyWidget":
               var_1643.push(new LoyaltyVipBuyCatalogWidget(param1,_catalog));
               break;
            case "vipGiftWidget":
               var_1643.push(new VipBuyCatalogWidget(param1,_catalog,true));
               break;
            case "activityPointDisplayWidget":
               var_1643.push(new ActivityPointDisplayCatalogWidget(param1));
               break;
            case "madMoneyWidget":
               var_1643.push(new MadMoneyCatalogWidget(param1));
               break;
            case "buyGuildWidget":
               var_1643.push(new BuyGuildWidget(param1));
               break;
            case "guildBadgeViewWidget":
               var_1643.push(new GuildBadgeViewCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "guildSelectorWidget":
               var_1643.push(new GuildSelectorCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "guildForumSelectorWidget":
               var_1643.push(new GuildForumSelectorCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "petPreviewWidget":
               var_1643.push(new PetPreviewCatalogWidget(param1,_catalog));
               break;
            case "spinnerWidget":
               var_1643.push(new SpinnerCatalogWidget(param1,_catalog));
               break;
            case "bundlePurchaseExtraInfoWidget":
               var_1643.push(new BundlePurchaseExtraInfoWidget(param1,_catalog));
               break;
            case "totalPriceWidget":
               var_1643.push(new TotalPriceWidget(param1,_catalog));
               break;
            case "limitedItemWidget":
               var_1643.push(new UniqueLimitedItemWidget(param1,_catalog));
               break;
            case "soldLtdItemsWidget":
               var_1643.push(new SoldLtdItemsCatalogWidget(param1,_catalog));
               break;
            case "userBadgeSelectorWidget":
               var_1643.push(new UserBadgeSelectorCatalogWidget(param1,_catalog));
               break;
            case "bundleGridScrollWidget":
               var_1643.push(new BundleGridViewCatalogWidget(param1));
               break;
            case "simplePriceWidget":
               var_1643.push(new SimplePriceCatalogWidget(param1,_catalog));
               break;
            case "builderWidget":
               var_1643.push(new BuilderCatalogWidget(param1,_catalog));
               break;
            case "builderSubscriptionWidget":
               var_1643.push(new BuilderSubscriptionCatalogWidget(param1,_catalog));
               break;
            case "builderAddonsWidget":
               var_1643.push(new BuilderAddonsCatalogWidget(param1,_catalog));
               break;
            case "builderLoyaltyWidget":
               var_1643.push(new BuilderLoyaltyCatalogWidget(param1,_catalog));
               break;
            case "warningWidget":
               var_1643.push(new WarningCatalogWidget(param1));
               break;
            case "firstProductAutoSelectorWidget":
               var_1643.push(new FirstProductSelectorCatalogWidget(param1));
               break;
            case "featuredItemsWidget":
               var_1643.push(new FeaturedItemsCatalogWidget(param1,_catalog));
         }
      }
      
      private function initializeWidgets() : void
      {
         var _loc3_:* = null;
         var _loc6_:ColourGridCatalogWidget = null;
         var _loc7_:ItemGridCatalogWidget = null;
         var _loc1_:IWindowContainer = null;
         var _loc4_:int = 0;
         var _loc5_:IWindowContainer = null;
         var _loc2_:Array = [];
         if(var_529 == "default_3x3_color_grouping")
         {
            _loc1_ = _window.findChildByName("itemGridWidget") as IWindowContainer;
            _loc4_ = 3;
            _loc1_.height = 64 - _loc4_;
            (_loc5_ = _window.findChildByName("colourGridWidget") as IWindowContainer).visible = true;
            _loc5_.width = 360;
            _loc5_.x = _loc1_.x;
            _loc5_.y = _loc1_.y + _loc1_.height + _loc4_;
            _loc5_.height = 91;
            _loc6_ = new ColourGridCatalogWidget(_loc5_);
            var_1643.push(_loc6_);
         }
         for each(_loc3_ in var_1643)
         {
            _loc3_.page = this;
            if(_loc3_ is ItemGridCatalogWidget)
            {
               _loc7_ = _loc3_ as ItemGridCatalogWidget;
            }
            _loc3_.events = _widgetEvents;
            if(!_loc3_.init())
            {
               _loc2_.push(_loc3_);
            }
         }
         removeWidgets(_loc2_);
         initializeLocalizations();
         _widgetEvents.dispatchEvent(new CatalogWidgetEvent("WIDGETS_INITIALIZED"));
      }
      
      private function initializeLocalizations() : void
      {
         var _loc1_:class_3558 = new LocalizationCatalogWidget(_window,_catalog);
         var_1643.push(_loc1_);
         _loc1_.page = this;
         _loc1_.events = _widgetEvents;
         _loc1_.init();
      }
      
      private function removeWidgets(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         for each(_loc3_ in var_1643)
         {
            if(_loc3_.window != null)
            {
               for each(_loc2_ in param1)
               {
                  if(_loc2_.window != null)
                  {
                     if(_loc2_.window.getChildIndex(_loc3_.window) >= 0)
                     {
                        if(param1.indexOf(_loc3_) < 0)
                        {
                           param1.push(_loc3_);
                        }
                        break;
                     }
                  }
               }
            }
         }
         for each(_loc2_ in param1)
         {
            if(_loc2_.window != null)
            {
               _window.removeChild(_loc2_.window);
               _loc2_.window.dispose();
            }
            if((_loc4_ = var_1643.indexOf(_loc2_)) >= 0)
            {
               var_1643.splice(_loc4_,1);
            }
            _loc2_.dispose();
         }
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         if(_widgetEvents != null)
         {
            return _widgetEvents.dispatchEvent(param1);
         }
         return false;
      }
      
      public function replaceOffers(param1:Vector.<class_3377>, param2:Boolean = false) : void
      {
         if(param2)
         {
            for each(var _loc3_ in _offers)
            {
               _loc3_.dispose();
            }
         }
         _offers = param1;
      }
      
      public function updateLimitedItemsLeft(param1:int, param2:int) : void
      {
         for each(var _loc3_ in _offers)
         {
            if(_loc3_.offerId == param1)
            {
               _loc3_.product.uniqueLimitedItemsLeft = param2;
               _widgetEvents.dispatchEvent(new ProductOfferUpdatedEvent(_loc3_));
               return;
            }
         }
      }
   }
}
