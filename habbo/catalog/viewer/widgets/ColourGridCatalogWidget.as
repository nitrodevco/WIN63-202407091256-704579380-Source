package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class ColourGridCatalogWidget extends CatalogWidget implements class_3558
   {
       
      
      private var _colours:Array;
      
      private var _colourGrid:IItemGridWindow;
      
      private var _colourChooserLayout:XML;
      
      private var var_2466:BitmapData;
      
      private var var_2869:BitmapData;
      
      private var _colourChosen:BitmapData;
      
      private var var_2003:IWindowContainer;
      
      private var var_4401:String = "";
      
      private var _colourGridCache:Dictionary;
      
      public function ColourGridCatalogWidget(param1:IWindowContainer)
      {
         _colourGridCache = new Dictionary();
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(!_colourGrid.disposed)
         {
            _colourGrid.destroyGridItems();
            _colourGrid.dispose();
         }
         _colourGrid = null;
         _colourChooserLayout = null;
         var_2003 = null;
         events.removeEventListener("COLOUR_ARRAY",onAvailableColours);
         events.removeEventListener("MULTI_COLOUR_ARRAY",onAvailableMultiColours);
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("colourGridWidget");
         var _loc2_:* = _window.tags.indexOf("FIXED") > -1;
         if(!_loc2_)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         _colourGrid = _window.findChildByName("colourGrid") as IItemGridWindow;
         _colourGrid.width = window.width - 6;
         _colourGrid.height = window.height - 6;
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("color_chooser_cell") as XmlAsset;
         _colourChooserLayout = _loc1_.content as XML;
         events.addEventListener("COLOUR_ARRAY",onAvailableColours);
         events.addEventListener("MULTI_COLOUR_ARRAY",onAvailableMultiColours);
         return true;
      }
      
      private function onAvailableColours(param1:CatalogWidgetColoursEvent) : void
      {
         _colours = [];
         for each(var _loc4_ in param1.colours)
         {
            _colours.push([_loc4_]);
         }
         var _loc5_:BitmapDataAsset;
         var_2466 = (_loc5_ = page.viewer.catalog.assets.getAssetByName(param1.backgroundAssetName) as BitmapDataAsset).content as BitmapData;
         var _loc3_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.colourAssetName) as BitmapDataAsset;
         var_2869 = _loc3_.content as BitmapData;
         var_4401 = param1.backgroundAssetName + "\t" + param1.colourAssetName;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.chosenColourAssetName) as BitmapDataAsset;
         _colourChosen = _loc2_.content as BitmapData;
         populateColourGrid();
         select(_colourGrid.getGridItemAt(param1.index) as IWindowContainer);
      }
      
      private function onAvailableMultiColours(param1:CatalogWidgetMultiColoursEvent) : void
      {
         _colours = [];
         for each(var _loc4_ in param1.colours)
         {
            _colours.push(_loc4_.slice());
         }
         var _loc5_:BitmapDataAsset;
         var_2466 = (_loc5_ = page.viewer.catalog.assets.getAssetByName(param1.backgroundAssetName) as BitmapDataAsset).content as BitmapData;
         var _loc3_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.colourAssetName) as BitmapDataAsset;
         var_2869 = _loc3_.content as BitmapData;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1.chosenColourAssetName) as BitmapDataAsset;
         _colourChosen = _loc2_.content as BitmapData;
         populateColourGrid();
         select(_colourGrid.getGridItemAt(0) as IWindowContainer);
      }
      
      private function select(param1:IWindowContainer) : void
      {
         var _loc2_:IWindow = null;
         class_14.log("[ColourGridCatalogWidget] Select: " + param1);
         if(var_2003 != null)
         {
            _loc2_ = var_2003.getChildByName("chosen");
            if(_loc2_ != null)
            {
               _loc2_.visible = false;
            }
         }
         var_2003 = param1;
         if(var_2003 != null)
         {
            _loc2_ = var_2003.getChildByName("chosen");
         }
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function populateColourGrid() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc3_:IWindowContainer = null;
         var _loc1_:IBitmapWrapperWindow = null;
         class_14.log("[ColourGridCatalogWidget] Display colors: " + [_colours.length,_colourGrid.numGridItems]);
         _colourGrid.removeGridItems();
         var_2003 = null;
         _loc2_ = 0;
         while(_loc2_ < _colours.length)
         {
            if((_loc4_ = _colours[_loc2_]).length > 0)
            {
               _loc3_ = createColorContainer(_loc4_,_loc2_);
               _colourGrid.addGridItem(_loc3_);
               _loc1_ = _loc3_.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow;
               if(_loc1_ != null)
               {
                  _loc1_.bitmap = new BitmapData(_colourChosen.width,_colourChosen.height,true,16777215);
                  _loc1_.bitmap.copyPixels(_colourChosen,_colourChosen.rect,new Point(0,0),null,null,true);
                  _loc1_.visible = false;
               }
            }
            _loc2_++;
         }
      }
      
      private function createColorContainer(param1:Array, param2:int) : IWindowContainer
      {
         var _loc10_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:String = coloursCacheKey(param1,param2);
         var _loc6_:IWindowContainer;
         if((_loc6_ = _colourGridCache[_loc12_]) != null)
         {
            return _loc6_;
         }
         (_loc6_ = page.viewer.catalog.windowManager.buildFromXML(_colourChooserLayout) as IWindowContainer).addEventListener("WME_CLICK",onClick);
         _loc6_.background = true;
         _loc6_.color = 4294967295;
         _loc6_.width = var_2466.width;
         _loc6_.height = var_2466.height;
         var _loc9_:IBitmapWrapperWindow;
         if((_loc9_ = _loc6_.findChildByTag("BG_BORDER") as IBitmapWrapperWindow) != null)
         {
            _loc9_.bitmap = new BitmapData(var_2466.width,var_2466.height,true,0);
            _loc9_.bitmap.copyPixels(var_2466,var_2466.rect,new Point(0,0));
         }
         var _loc14_:IBitmapWrapperWindow;
         if((_loc14_ = _loc6_.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow) != null)
         {
            _loc14_.bitmap = new BitmapData(var_2869.width,var_2869.height,true,0);
            _loc10_ = 255;
            _loc4_ = 255;
            _loc3_ = 255;
            _loc7_ = null;
            _loc5_ = null;
            if((_loc11_ = int(param1[0])) >= 0)
            {
               _loc10_ = uint(_loc11_ >> 16 & 255);
               _loc4_ = uint(_loc11_ >> 8 & 255);
               _loc3_ = uint(_loc11_ >> 0 & 255);
            }
            _loc7_ = var_2869.clone();
            _loc7_.colorTransform(_loc7_.rect,new ColorTransform(_loc10_ / 255,_loc4_ / 255,_loc3_ / 255));
            if(param1.length > 1)
            {
               if((_loc8_ = int(param1[1])) >= 0)
               {
                  _loc10_ = uint(_loc8_ >> 16 & 255);
                  _loc4_ = uint(_loc8_ >> 8 & 255);
                  _loc3_ = uint(_loc8_ >> 0 & 255);
               }
               _loc5_ = var_2869.clone();
               _loc5_.colorTransform(_loc5_.rect,new ColorTransform(_loc10_ / 255,_loc4_ / 255,_loc3_ / 255));
            }
            _loc14_.bitmap.copyPixels(_loc7_,_loc7_.rect,new Point(0,0));
            _loc7_.dispose();
            if(_loc5_ != null)
            {
               _loc13_ = _loc5_.width / 2;
               _loc14_.bitmap.copyPixels(_loc5_,new Rectangle(_loc13_,0,_loc5_.width - _loc13_,_loc5_.height),new Point(_loc5_.width / 2,0));
               _loc5_.dispose();
            }
         }
         _colourGridCache[_loc12_] = _loc6_;
         return _loc6_;
      }
      
      private function coloursCacheKey(param1:Array, param2:int) : String
      {
         var _loc4_:String = (_loc4_ = (_loc4_ = var_4401) + "\t") + param2;
         for each(var _loc3_ in param1)
         {
            _loc4_ = (_loc4_ += "\t") + _loc3_;
         }
         return _loc4_;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         select(param1.target as IWindowContainer);
         var _loc2_:int = _colourGrid.getGridItemIndex(param1.target as IWindow);
         events.dispatchEvent(new CatalogWidgetColourIndexEvent(_loc2_));
      }
   }
}
