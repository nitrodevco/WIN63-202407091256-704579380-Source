package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.IItemGrid;
   import com.sulake.habbo.catalog.viewer.ProductContainer;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3517;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.session.ISessionDataManager;
   
   public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IDisposable, class_3558, IItemGrid
   {
       
      
      private var var_3507:Array;
      
      private var var_1789:Array;
      
      private var _selectedGroup:int = 0;
      
      private var var_2873:Array;
      
      private var var_2253:ISelectorWindow;
      
      private var var_1357:Array;
      
      public function SpacesNewCatalogWidget(param1:IWindowContainer, param2:ISessionDataManager, param3:String)
      {
         var_3507 = ["wallpaper","floor","landscape"];
         var_1789 = [];
         var_2873 = [0,0,0];
         var_1357 = ["group.walls","group.floors","group.views"];
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         for each(var _loc2_ in var_1789)
         {
            for each(var _loc1_ in _loc2_)
            {
               _loc1_.dispose();
            }
         }
         var_1789 = null;
      }
      
      override public function init() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IWindow = null;
         class_14.log("Init Item Group Catalog Widget (Spaces New)");
         createOfferGroups();
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         var_2253 = _window.findChildByName("groups") as ISelectorWindow;
         if(var_2253)
         {
            _loc2_ = 0;
            while(_loc2_ < var_2253.numSelectables)
            {
               _loc1_ = var_2253.getSelectableAt(_loc2_);
               if(_loc1_ is ISelectableWindow)
               {
                  _loc1_.addEventListener("WE_SELECTED",onSelectGroup);
               }
               _loc2_++;
            }
         }
         switchCategory(var_1357[_selectedGroup]);
         updateRoomPreview();
         return true;
      }
      
      public function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc3_:int = int(var_2873[_selectedGroup]);
         var _loc2_:class_3377 = var_1789[_selectedGroup][_loc3_];
         this.select(_loc2_.gridItem,false);
      }
      
      public function selectIndex(param1:int) : void
      {
         var _loc2_:class_3377 = null;
         if(param1 > -1 && param1 < _itemGrid.numGridItems)
         {
            _loc2_ = var_1789[_selectedGroup][param1];
            this.select(_loc2_.gridItem,false);
         }
      }
      
      override public function select(param1:class_3517, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.select(param1,false);
         var _loc3_:class_3377 = (param1 as ProductContainer).offer;
         if(_loc3_ == null)
         {
            return;
         }
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc3_.product.extraParam));
         var_2873[_selectedGroup] = (var_1789[_selectedGroup] as Vector.<class_3377>).indexOf(_loc3_);
         updateRoomPreview();
      }
      
      private function updateRoomPreview() : void
      {
         var _loc5_:int = int(var_2873[0]);
         var _loc6_:int = int(var_2873[1]);
         var _loc3_:int = int(var_2873[2]);
         var _loc2_:class_3377 = var_1789[0].length > _loc5_ ? var_1789[0][_loc5_] : null;
         var _loc4_:class_3377 = var_1789[1].length > _loc6_ ? var_1789[1][_loc6_] : null;
         var _loc1_:class_3377 = var_1789[2].length > _loc3_ ? var_1789[2][_loc3_] : null;
         if(!_loc4_ || !_loc2_ || !_loc1_)
         {
            return;
         }
         events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_loc4_.product.extraParam,_loc2_.product.extraParam,_loc1_.product.extraParam,64));
      }
      
      private function createOfferGroups() : Boolean
      {
         var _loc2_:class_3388 = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         for each(var _loc1_ in page.offers)
         {
            if(!(_loc1_.pricingModel == "pricing_model_single" || _loc1_.pricingModel == "pricing_model_multi"))
            {
               continue;
            }
            _loc2_ = _loc1_.product;
            if(_loc2_ == null)
            {
               continue;
            }
            _loc3_ = _loc2_.productClassId;
            if(!(_loc2_.productType == "i" || _loc2_.productType == "s"))
            {
               continue;
            }
            if(_loc2_.furnitureData == null)
            {
               continue;
            }
            _loc4_ = _loc2_.furnitureData.className;
            _loc5_ = var_3507.indexOf(_loc4_);
            if(var_3507.indexOf(_loc4_) == -1)
            {
               var_3507.push(_loc4_);
            }
            while(var_1789.length < var_3507.length)
            {
               var_1789.push(new Vector.<class_3377>(0));
            }
            switch(_loc4_)
            {
               case "floor":
                  (var_1789[_loc5_] as Vector.<class_3377>).push(_loc1_);
                  break;
               case "wallpaper":
                  (var_1789[_loc5_] as Vector.<class_3377>).push(_loc1_);
                  break;
               case "landscape":
                  (var_1789[_loc5_] as Vector.<class_3377>).push(_loc1_);
                  break;
               default:
                  class_14.log("[Spaces Catalog Widget] : " + _loc4_);
                  break;
            }
         }
         page.replaceOffers(new Vector.<class_3377>(0),false);
         return true;
      }
      
      private function onSelectGroup(param1:WindowEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ISelectableWindow = param1.target as ISelectableWindow;
         if(_loc3_)
         {
            _loc2_ = var_2253.getSelectableIndex(_loc3_);
            class_14.log("select: " + [_loc3_.name,_loc2_]);
            switchCategory(_loc3_.name);
         }
      }
      
      private function switchCategory(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         if(disposed)
         {
            return;
         }
         if(!var_2253)
         {
            return;
         }
         var_2253.setSelected(var_2253.getSelectableByName(param1));
         var _loc5_:int = -1;
         switch(param1)
         {
            case "group.walls":
               _loc5_ = 0;
               break;
            case "group.floors":
               _loc5_ = 1;
               break;
            case "group.views":
               _loc5_ = 2;
               break;
            default:
               _loc5_ = -1;
         }
         if(_loc5_ > -1)
         {
            if(var_2003 != null)
            {
               var_2003.deactivate();
            }
            var_2003 = null;
            _selectedGroup = _loc5_;
            if(_itemGrid)
            {
               _itemGrid.destroyGridItems();
            }
            _loc2_ = var_1789[_selectedGroup] == null ? new Vector.<class_3377>(0) : var_1789[_selectedGroup];
            page.replaceOffers(_loc2_,false);
            resetTimer();
            _loc3_ = populateItemGrid();
            loadItemGridGraphics(null,_loc3_);
            if(var_1883)
            {
               var_1883.start();
            }
            _loc4_ = int(var_2873[_selectedGroup]);
            selectIndex(_loc4_);
         }
      }
   }
}
