package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.class_3553;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class BundleGridViewCatalogWidget extends CatalogWidget implements class_3558, IItemGrid, class_3553
   {
       
      
      private var _offer:class_3377;
      
      private var _gridItemLayout:XML;
      
      private var _itemGrid:IItemGridWindow;
      
      public function BundleGridViewCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         _itemGrid = IItemGridWindow(_window.findChildByName("bundleGrid"));
         return true;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            events.removeEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
            super.dispose();
         }
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc2_:class_3377 = null;
         if(page.offers.length == 1)
         {
            _loc2_ = page.offers[0];
            if(_loc2_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc2_));
            }
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         _offer = param1.offer;
         _itemGrid.destroyGridItems();
         populateItemGrid();
      }
      
      protected function populateItemGrid() : void
      {
         var _loc5_:IWindowContainer = null;
         var _loc1_:IWindow = null;
         var _loc4_:BitmapData = null;
         var _loc2_:IWindowContainer = _offer.page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as IWindowContainer;
         for each(var _loc3_ in _offer.productContainer.products)
         {
            if(_loc3_.productType != "b")
            {
               _loc1_ = (_loc5_ = _loc2_.clone() as IWindowContainer).findChildByName("clubLevelIcon");
               if(_loc1_ != null)
               {
                  _loc1_.visible = false;
               }
               _itemGrid.addGridItem(_loc5_);
               _loc3_.view = _loc5_;
               if((_loc4_ = _loc3_.initIcon(this)) != null)
               {
                  _loc4_.dispose();
               }
               _loc3_.grid = this;
            }
         }
      }
      
      public function get offer() : class_3377
      {
         return _offer;
      }
      
      public function select(param1:class_3517, param2:Boolean) : void
      {
      }
      
      public function startDragAndDrop(param1:class_3517) : Boolean
      {
         return false;
      }
      
      public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function get products() : Vector.<class_3388>
      {
         return null;
      }
      
      public function get firstProduct() : class_3388
      {
         return null;
      }
      
      public function set view(param1:IWindowContainer) : void
      {
      }
      
      public function get view() : IWindowContainer
      {
         return null;
      }
      
      public function set grid(param1:IItemGrid) : void
      {
      }
      
      public function setClubIconLevel(param1:int) : void
      {
      }
   }
}
