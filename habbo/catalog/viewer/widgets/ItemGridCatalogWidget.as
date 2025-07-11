package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.class_3458;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.class_3553;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.session.ISessionDataManager;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class ItemGridCatalogWidget extends CatalogWidget implements class_3558, IItemGrid, class_3458
   {
       
      
      protected var _itemGrid:IItemGridWindow;
      
      protected var _gridItemLayout:XML;
      
      protected var var_3621:XML;
      
      protected var var_3884:XML;
      
      protected var var_2003:class_3517;
      
      private var _bundleCounter:int = 0;
      
      protected var var_1883:Timer;
      
      protected var var_3194:Function;
      
      protected var var_4947:Boolean = true;
      
      private var _offerInitIndex:int = 0;
      
      protected var var_52:ISessionDataManager;
      
      private var var_4189:int = -1;
      
      private var _selectedGuildColor1:String;
      
      private var _selectedGuildColor2:String;
      
      private var var_4305:String;
      
      private var var_395:String;
      
      public var itemColors:Dictionary;
      
      public var chosenItemColorIndex:int = 0;
      
      public function ItemGridCatalogWidget(param1:IWindowContainer, param2:ISessionDataManager, param3:String)
      {
         itemColors = new Dictionary();
         super(param1);
         var_52 = param2;
         var_395 = param3;
      }
      
      override public function dispose() : void
      {
         if(var_1883 != null)
         {
            var_1883.stop();
            if(var_3194 != null)
            {
               var_1883.removeEventListener("timer",var_3194);
               var_3194 = null;
            }
            var_1883 = null;
         }
         if(_itemGrid != null)
         {
            _itemGrid.destroyGridItems();
            _itemGrid = null;
         }
         _gridItemLayout = null;
         var_3621 = null;
         var_3884 = null;
         var_2003 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         var isFixed:Boolean;
         var gridAsset:XmlAsset;
         var loadGraphics:Vector.<class_3377>;
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("itemGridWidget");
         isFixed = _window.tags.indexOf("FIXED") > -1;
         _itemGrid = _window.findChildByName("itemGrid") as IItemGridWindow;
         if(!isFixed)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         _itemGrid.verticalSpacing = 0;
         gridAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = gridAsset.content as XML;
         gridAsset = page.viewer.catalog.assets.getAssetByName("grid_item_with_price_single") as XmlAsset;
         var_3884 = gridAsset.content as XML;
         gridAsset = page.viewer.catalog.assets.getAssetByName("grid_item_with_price_multi") as XmlAsset;
         var_3621 = gridAsset.content as XML;
         loadGraphics = populateItemGrid();
         if(var_4947)
         {
            var_1883 = new Timer(25);
            var_3194 = function(param1:TimerEvent):void
            {
               loadItemGridGraphics(param1,loadGraphics);
            };
            var_1883.addEventListener("timer",var_3194);
            var_1883.start();
         }
         else
         {
            loadItemGridGraphics(null,loadGraphics);
         }
         events.addEventListener("GUILD_SELECTED",onGuildSelected);
         events.addEventListener("COLOUR_INDEX",onColourIndex);
         return true;
      }
      
      public function select(param1:class_3517, param2:Boolean) : void
      {
         if(var_2003 != null)
         {
            var_2003.deactivate();
         }
         var_2003 = param1;
         param1.activate();
         if(var_2003.view)
         {
            var_2003.view.findChildByName("border_outline").color = var_395 == "NORMAL" ? 6538729 : 16758076;
         }
         var _loc4_:ProductContainer;
         if(!(_loc4_ = param1 as ProductContainer))
         {
            return;
         }
         if(_loc4_.isLazy)
         {
            return;
         }
         var _loc3_:class_3377 = _loc4_.offer;
         if(_loc3_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc3_));
            if(_loc3_.product && _loc3_.product.productType == "i")
            {
               events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc3_.product.extraParam));
            }
         }
         if(param2)
         {
            events.dispatchEvent(new CatalogWidgetColoursEvent(getCurrentItemColors(),"ctlg_clr_27x22_1","ctlg_clr_27x22_2","ctlg_clr_27x22_3",getCurrentItemColourIndex()));
         }
      }
      
      public function startDragAndDrop(param1:class_3517) : Boolean
      {
         var _loc2_:class_3377 = (param1 as ProductContainer).offer;
         if(_loc2_ != null)
         {
            if(var_52.clubLevel >= _loc2_.clubLevel)
            {
               (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this,_loc2_);
            }
         }
         return true;
      }
      
      public function onDragAndDropDone(param1:Boolean, param2:String) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1)
         {
            events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false,param2));
         }
      }
      
      public function stopDragAndDrop() : void
      {
      }
      
      protected function populateItemGrid() : Vector.<class_3377>
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:IWindowContainer = null;
         var _loc3_:* = false;
         var _loc11_:Dictionary = new Dictionary();
         var _loc10_:Vector.<class_3377> = new Vector.<class_3377>();
         var _loc12_:*;
         if(_loc12_ = page.layoutCode == "default_3x3_color_grouping")
         {
            for each(_loc1_ in page.offers)
            {
               if(!_loc1_.product.furnitureData || !_loc1_.product.isColorable)
               {
                  _loc10_.push(_loc1_);
               }
               else
               {
                  _loc6_ = String(_loc1_.product.furnitureData.fullName.split("*")[0]);
                  _loc7_ = int(_loc1_.product.furnitureData.fullName.split("*")[1]);
                  if(!itemColors[_loc6_])
                  {
                     itemColors[_loc6_] = [];
                  }
                  if(_loc1_.product.furnitureData.colours)
                  {
                     _loc5_ = 16777215;
                     for each(_loc4_ in _loc1_.product.furnitureData.colours)
                     {
                        if(_loc4_ != 16777215)
                        {
                           _loc5_ = _loc4_;
                        }
                     }
                     if(itemColors[_loc6_].indexOf(_loc5_) == -1)
                     {
                        itemColors[_loc6_][_loc7_] = _loc5_;
                     }
                  }
                  if(_loc11_[_loc6_] == null)
                  {
                     _loc11_[_loc6_] = _loc10_.length;
                     _loc10_.push(_loc1_);
                  }
                  else if(_loc6_.indexOf("bc_") == 0 && (_loc5_ == 16777215 || _loc5_ == 16777214))
                  {
                     _loc8_ = int(_loc11_[_loc6_]);
                     _loc10_[_loc8_] = _loc1_;
                  }
               }
            }
         }
         else
         {
            _loc10_ = page.offers;
         }
         var _loc2_:Vector.<class_3377> = new Vector.<class_3377>();
         for each(_loc1_ in page.offers)
         {
            if(_loc12_ && _loc1_.product.furnitureData && _loc1_.product.isColorable)
            {
               if(_loc10_.indexOf(_loc1_) != -1)
               {
                  _loc9_ = createGridItem(_loc1_.gridItem);
                  _loc1_.gridItem.view = _loc9_;
               }
            }
            else
            {
               _loc9_ = createGridItem(_loc1_.gridItem);
               _loc1_.gridItem.view = _loc9_;
            }
            _loc1_.gridItem.grid = this;
            _loc3_ = _loc10_.indexOf(_loc1_) != -1;
            if(_loc3_)
            {
               _loc2_.push(_loc1_);
            }
            if(_loc1_.pricingModel == "pricing_model_bundle")
            {
               _bundleCounter++;
               if(_loc1_.productContainer is BundleProductContainer)
               {
                  (_loc1_.productContainer as BundleProductContainer).setBundleCounter(_bundleCounter);
               }
            }
         }
         return _loc2_;
      }
      
      protected function resetTimer() : void
      {
         if(var_1883 != null)
         {
            var_1883.reset();
         }
         _offerInitIndex = 0;
      }
      
      protected function loadItemGridGraphics(param1:TimerEvent = null, param2:Vector.<class_3377> = null) : void
      {
         var _loc5_:int = 0;
         var _loc3_:class_3377 = null;
         if(disposed)
         {
            return;
         }
         if(param1 != null)
         {
         }
         if(param2 == null)
         {
            param2 = page.offers;
         }
         var _loc4_:int;
         if((_loc4_ = int(param2.length)) > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               if(_offerInitIndex >= 0 && _offerInitIndex < _loc4_)
               {
                  _loc3_ = param2[_offerInitIndex];
                  loadGraphics(_loc3_);
               }
               _offerInitIndex++;
               if(_offerInitIndex >= _loc4_)
               {
                  resetTimer();
                  break;
               }
               _loc5_++;
            }
         }
      }
      
      protected function createGridItem(param1:class_3517, param2:Boolean = true) : IWindowContainer
      {
         var _loc3_:XML = null;
         var _loc6_:Boolean;
         var _loc4_:class_3553;
         if((_loc6_ = (_loc4_ = param1 as class_3553) != null && _loc4_.offer != null && (_loc4_.offer.priceInCredits > 0 || _loc4_.offer.priceInActivityPoints > 0 || _loc4_.offer.priceInSilver > 0)) && var_395 != "BUILDERS_CLUB")
         {
            if(_loc4_.offer && _loc4_.offer.priceInCredits > 0 && _loc4_.offer.priceInActivityPoints > 0)
            {
               _loc3_ = var_3621;
            }
            else
            {
               _loc3_ = var_3884;
            }
         }
         else
         {
            _loc3_ = _gridItemLayout;
         }
         var _loc5_:IWindowContainer = page.viewer.catalog.windowManager.buildFromXML(_loc3_) as IWindowContainer;
         _itemGrid.addGridItem(_loc5_);
         param1.view = _loc5_;
         if(var_395 != "BUILDERS_CLUB" && _loc4_ is ProductContainer)
         {
            (_loc4_ as ProductContainer).createCurrencyIndicators(page.viewer.catalog as HabboCatalog);
         }
         return _loc5_;
      }
      
      protected function loadGraphics(param1:class_3377) : void
      {
         var _loc3_:IStuffData = null;
         var _loc2_:Array = null;
         var _loc4_:StringArrayStuffData = null;
         if(param1 != null && !param1.disposed)
         {
            _loc3_ = null;
            if(var_4189 != -1)
            {
               _loc2_ = [];
               _loc2_.push("0");
               _loc2_.push(var_4189.toString());
               _loc2_.push(var_4305);
               _loc2_.push(_selectedGuildColor1);
               _loc2_.push(_selectedGuildColor2);
               (_loc4_ = new StringArrayStuffData()).setArray(_loc2_);
               _loc3_ = _loc4_;
            }
            param1.productContainer.initProductIcon(page.viewer.roomEngine,_loc3_);
         }
         param1.productContainer.grid = this;
      }
      
      private function onGuildSelected(param1:CatalogWidgetGuildSelectedEvent) : void
      {
         var _loc3_:IWindowContainer = null;
         if(disposed)
         {
            return;
         }
         var_4189 = param1.guildId;
         _selectedGuildColor1 = param1.color1;
         _selectedGuildColor2 = param1.color2;
         var_4305 = param1.badgeCode;
         _itemGrid.destroyGridItems();
         for each(var _loc2_ in page.offers)
         {
            _loc3_ = createGridItem(_loc2_.gridItem);
            _loc2_.gridItem.view = _loc3_;
            _loc2_.gridItem.grid = this;
            loadGraphics(_loc2_);
         }
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         for each(_loc2_ in page.offers)
         {
            if(_loc2_.gridItem == var_2003 && _loc2_.gridItem.view != null)
            {
               _loc4_ = _loc2_;
            }
         }
         if(!_loc4_ || !_loc4_.product.isColorable)
         {
            return;
         }
         var _loc3_:IWindowContainer = _loc4_.gridItem.view;
         _loc4_.gridItem.view = null;
         var _loc5_:String = _loc4_.product.furnitureData.fullName.split("*")[0] + "*" + (param1.index + 1);
         for each(_loc2_ in page.offers)
         {
            if(_loc2_.product.furnitureData.fullName == _loc5_)
            {
               _loc2_.gridItem.view = _loc3_;
               select(_loc2_.gridItem,false);
               loadGraphics(_loc2_);
            }
         }
      }
      
      public function getCurrentItemColors() : Array
      {
         var _loc2_:* = null;
         for each(var _loc1_ in page.offers)
         {
            if(_loc1_.gridItem == var_2003)
            {
               _loc2_ = _loc1_;
            }
         }
         if(!_loc2_ || !_loc2_.product.isColorable)
         {
            return [];
         }
         var _loc3_:String = String(_loc2_.product.furnitureData.fullName.split("*")[0]);
         return itemColors[_loc3_];
      }
      
      private function getCurrentItemColourIndex() : int
      {
         var _loc2_:* = null;
         for each(var _loc1_ in page.offers)
         {
            if(_loc1_.gridItem == var_2003)
            {
               _loc2_ = _loc1_;
            }
         }
         if(!_loc2_ || !_loc2_.product.isColorable)
         {
            return 0;
         }
         return Math.max(_loc2_.product.furnitureData.colourIndex - 1,0);
      }
   }
}
