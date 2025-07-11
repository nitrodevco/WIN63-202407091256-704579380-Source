package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3489;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3623;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class TrophyCatalogWidget extends CatalogWidget implements class_3558, IGetImageListener
   {
      
      private static const gold:int = 16763904;
      
      private static const silver:int = 13421772;
      
      private static const bronze:int = 13395456;
       
      
      private var var_1250:IBitmapWrapperWindow;
      
      private var _trophyOffers:Map;
      
      private var var_1961:int = 0;
      
      private var var_2499:String = "g";
      
      private var _catalog:HabboCatalog;
      
      private var var_2248:IWindow;
      
      public function TrophyCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(_trophyOffers != null)
         {
            _trophyOffers.dispose();
         }
         _trophyOffers = null;
         _catalog = null;
         var_2248 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc2_:Map = null;
         var _loc3_:IWindowContainer = null;
         if(!super.init())
         {
            return false;
         }
         var_1250 = window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("COLOUR_INDEX",onColourIndex);
         events.addEventListener("TEXT_INPUT",onTextInput);
         var _loc5_:class_3489 = window.findChildByName("ctlg_nextmodel_button") as class_3489;
         var _loc4_:class_3489 = window.findChildByName("ctlg_prevmodel_button") as class_3489;
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onClickNext);
         }
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onClickPrev);
         }
         _trophyOffers = new Map();
         var _loc1_:Offer = null;
         for each(_loc1_ in page.offers)
         {
            _loc7_ = getBaseNameFromProduct(_loc1_.localizationId);
            _loc6_ = getTrophyTypeFromProduct(_loc1_.localizationId);
            if(_trophyOffers.getValue(_loc7_) == null)
            {
               _trophyOffers.add(_loc7_,new Map());
            }
            _loc2_ = _trophyOffers.getValue(_loc7_) as Map;
            _loc2_.add(_loc6_,_loc1_);
         }
         if(page.offers.length == 1)
         {
            _loc5_.visible = _loc4_.visible = false;
            if(page.offers[0].product.isColorable == false)
            {
               if(IWindowContainer(window.parent))
               {
                  _loc3_ = IWindowContainer(window.parent).findChildByName("colourGridWidget") as IWindowContainer;
                  if(_loc3_)
                  {
                     _loc3_.visible = false;
                  }
               }
            }
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         return true;
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc3_:Offer = null;
         var _loc4_:Array;
         (_loc4_ = []).push(16763904);
         _loc4_.push(13421772);
         _loc4_.push(13395456);
         var _loc2_:Map = _trophyOffers.getWithIndex(var_1961);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getValue(var_2499);
            if(_loc3_ == null)
            {
               _loc3_ = _loc2_.getWithIndex(0);
            }
            if(_loc3_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc3_));
            }
         }
         events.dispatchEvent(new CatalogWidgetColoursEvent(_loc4_,"ctlg_clr_40x32_1","ctlg_clr_40x32_2","ctlg_clr_40x32_3"));
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc5_:BitmapData = null;
         var _loc3_:class_3388 = null;
         var _loc4_:class_3499 = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_3377 = param1.offer;
         var _loc6_:class_3423 = page.viewer.catalog.getProductData(_loc2_.localizationId);
         if(class_3623.hasProductImage(_loc2_.localizationId))
         {
            setPreviewFromAsset(class_3623.PRODUCT_IMAGES[_loc2_.localizationId]);
         }
         else
         {
            _loc3_ = _loc2_.product;
            _loc4_ = page.viewer.roomEngine.getFurnitureImage(_loc3_.productClassId,new Vector3d(2,0,0),64,this,0,_loc3_.extraParam);
            _loc2_.previewCallbackId = _loc4_.id;
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.data;
            }
            setPreviewImage(_loc5_,true);
         }
         var_2248 = _catalog.utils.showPriceOnProduct(_loc2_,_window,var_2248,var_1250,0,false,0);
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         var _loc3_:Offer = null;
         if(param1.index == 0)
         {
            var_2499 = "g";
         }
         if(param1.index == 1)
         {
            var_2499 = "s";
         }
         if(param1.index == 2)
         {
            var_2499 = "b";
         }
         var _loc2_:Map = _trophyOffers.getWithIndex(var_1961);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getValue(var_2499);
            if(_loc3_ == null)
            {
               _loc3_ = _loc2_.getWithIndex(0);
            }
            if(_loc3_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc3_));
            }
         }
         var_2248 = _catalog.utils.showPriceOnProduct(_loc3_,_window,var_2248,var_1250,0,false,0);
      }
      
      public function onTextInput(param1:TextInputEvent) : void
      {
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(param1.text));
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || page == null || page.offers == null)
         {
            return;
         }
         for each(var _loc3_ in page.offers)
         {
            if(_loc3_.previewCallbackId == param1)
            {
               _loc3_.previewCallbackId = 0;
               setPreviewImage(param2,true);
               break;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getBaseNameFromProduct(param1:String) : String
      {
         var _loc2_:String = getTrophyTypeFromProduct(param1);
         if(_loc2_.length > 0)
         {
            return param1.slice(0,param1.length - 1 - _loc2_.length);
         }
         return param1;
      }
      
      private function getTrophyTypeFromProduct(param1:String) : String
      {
         var _loc3_:int = param1.indexOf("prizetrophy_2011_");
         if(_loc3_ != -1)
         {
            return "";
         }
         var _loc2_:int = param1.lastIndexOf("_") + 1;
         if(_loc2_ <= 0)
         {
            return "";
         }
         var _loc4_:String;
         if((_loc4_ = param1.substr(_loc2_)).length > 1 || _loc4_ != "g" && _loc4_ != "s" && _loc4_ != "b")
         {
            return "";
         }
         return _loc4_;
      }
      
      private function onClickNext(param1:WindowMouseEvent) : void
      {
         var _loc3_:Offer = null;
         var_1961++;
         if(var_1961 >= _trophyOffers.length)
         {
            var_1961 = 0;
         }
         var _loc2_:Map = _trophyOffers.getWithIndex(var_1961);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getValue(var_2499);
            if(_loc3_ == null)
            {
               _loc3_ = _loc2_.getWithIndex(0);
            }
            if(_loc3_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc3_));
            }
         }
      }
      
      private function onClickPrev(param1:WindowMouseEvent) : void
      {
         var _loc3_:Offer = null;
         var_1961--;
         if(var_1961 < 0)
         {
            var_1961 = _trophyOffers.length - 1;
         }
         var _loc2_:Map = _trophyOffers.getWithIndex(var_1961);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getValue(var_2499);
            if(_loc3_ == null)
            {
               _loc3_ = _loc2_.getWithIndex(0);
            }
            if(_loc3_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc3_));
            }
         }
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc3_:Point = null;
         if(!window.disposed && var_1250 != null)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            if(var_1250.bitmap == null)
            {
               var_1250.bitmap = new BitmapData(var_1250.width,var_1250.height,true,16777215);
            }
            var_1250.bitmap.fillRect(var_1250.bitmap.rect,16777215);
            _loc3_ = new Point((var_1250.width - param1.width) / 2,(var_1250.height - param1.height) / 2);
            var_1250.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
            var_1250.invalidate();
         }
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            retrievePreviewAsset(param1);
            return;
         }
         setPreviewImage(_loc2_.content as BitmapData,false);
      }
      
      private function retrievePreviewAsset(param1:String) : void
      {
         var _loc4_:String = page.viewer.catalog.imageGalleryHost + param1 + ".gif";
         class_14.log("[TrophyCatalogWidget] Retrieve Product Preview Asset: " + _loc4_);
         var _loc2_:URLRequest = new URLRequest(_loc4_);
         var _loc3_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         _loc3_.addEventListener("AssetLoaderEventComplete",onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
         }
      }
   }
}
