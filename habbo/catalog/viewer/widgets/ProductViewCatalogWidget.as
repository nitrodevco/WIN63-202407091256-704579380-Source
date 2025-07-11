package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3431;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.animation.class_3526;
   import com.sulake.habbo.avatar.animation.class_3581;
   import com.sulake.habbo.avatar.class_3374;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.class_3458;
   import com.sulake.habbo.catalog.viewer.class_3623;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class ProductViewCatalogWidget extends CatalogWidget implements class_3558, IGetImageListener, class_3458
   {
      
      private static const WALL_PAPER:int = 2;
      
      private static const const_692:int = 3;
      
      private static const LANDSCAPE:int = 4;
       
      
      private var var_3768:BitmapData;
      
      private var _productName:IWindow;
      
      private var var_396:IWindow;
      
      private var var_1250:IBitmapWrapperWindow;
      
      private var var_1821:IWindowContainer;
      
      private var var_2068:class_3431;
      
      private var _previewOffset:Point;
      
      private var _bundleGrid:IItemGridWindow;
      
      protected var _gridItemLayout:XML;
      
      private var var_4631:Array;
      
      private var _overrideStuffData:IStuffData;
      
      private var var_3531:SelectProductEvent = null;
      
      private var _catalog:HabboCatalog;
      
      private var var_2248:IWindow;
      
      private var var_3902:Boolean = true;
      
      private var var_4428:Boolean = false;
      
      private var var_4084:Boolean = true;
      
      private var _offer:class_3377;
      
      private var var_3224:Boolean;
      
      public function ProductViewCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      private static function ninjaEffectBundled(param1:SelectProductEvent) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:class_3388 = null;
         var _loc4_:Boolean = false;
         if(param1.offer.productContainer.products.length == 2)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_ = param1.offer.productContainer.products[_loc3_];
               if(_loc2_.productType == "e" && _loc2_.productClassId == 108)
               {
                  _loc4_ = true;
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onPreviewProduct);
            events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA",onStuffDataSet);
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
            events.removeEventListener("TOTAL_PRICE_WIDGET_INITIALIZED",onTotalPriceWidgetInitialized);
            _catalog = null;
            var_2248 = null;
            super.dispose();
            var_3768 = null;
            var_1821 = null;
         }
      }
      
      override public function init() : Boolean
      {
         var _loc4_:RoomPreviewer = null;
         var _loc3_:DisplayObject = null;
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("productViewWidget");
         if(!_isEmbedded)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         if(_window.tags.indexOf("2X") > -1)
         {
         }
         var_4084 = _window.tags.indexOf("NO_ROOM_CANVAS") == -1;
         var_2248 = null;
         _productName = _window.findChildByName("ctlg_product_name");
         _productName.caption = "";
         var_396 = _window.findChildByName("ctlg_description");
         var_396.caption = "";
         (_productName as ITextWindow).textColor = 0;
         (var_396 as ITextWindow).textColor = 0;
         var_1250 = _window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         var_1821 = _window.findChildByName("room_canvas_container") as IWindowContainer;
         if(var_1821 != null)
         {
            var_1821.visible = false;
            var_2068 = var_1821.findChildByName("room_canvas") as class_3431;
            _loc4_ = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            if(var_2068 != null && _loc4_ != null)
            {
               var_1821.procedure = roomCanvasContainerProcedure;
               _loc4_.disableUpdate = false;
               _loc4_.reset(false);
               _loc3_ = _loc4_.getRoomCanvas(var_2068.width,var_2068.height);
               if(_loc3_ != null)
               {
                  var_2068.setDisplayObject(_loc3_);
               }
            }
            else
            {
               var_1821 = null;
               var_2068 = null;
            }
         }
         _previewOffset = new Point(var_1250.x,var_1250.y);
         _bundleGrid = _window.findChildByName("bundleGrid") as IItemGridWindow;
         if(_bundleGrid == null)
         {
            class_14.log("[Product View Catalog Widget] Bundle Grid not initialized!");
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc2_.content as XML;
         var _loc1_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset;
         var_3768 = _loc1_.content as BitmapData;
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA",onStuffDataSet);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
         events.addEventListener("TOTAL_PRICE_WIDGET_INITIALIZED",onTotalPriceWidgetInitialized);
         return true;
      }
      
      private function roomCanvasContainerProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               if(_catalog.roomPreviewer != null)
               {
                  _catalog.roomPreviewer.changeRoomObjectState();
               }
               break;
            case "WME_UP":
            case "WME_OVER":
               var_3224 = false;
               break;
            case "WME_DOWN":
               var_3224 = true;
               break;
            case "WME_OUT":
               if(var_3224)
               {
                  if(_catalog.isDraggable(_offer))
                  {
                     _catalog.requestSelectedItemToMover(this,_offer);
                  }
               }
               var_3224 = false;
         }
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc28_:String = null;
         var _loc33_:BitmapData = null;
         var _loc27_:Point = null;
         var _loc4_:RoomPreviewer = null;
         var _loc2_:BundleProductContainer = null;
         var _loc24_:class_3388 = null;
         var _loc8_:class_3499 = null;
         var _loc19_:class_3365 = null;
         var _loc15_:* = undefined;
         var _loc23_:Array = null;
         var _loc29_:String = null;
         var _loc22_:String = null;
         var _loc10_:String = null;
         var _loc21_:String = null;
         var _loc3_:String = null;
         var _loc34_:String = null;
         var _loc12_:class_3365 = null;
         var _loc32_:class_3374 = null;
         var _loc25_:String = null;
         var _loc13_:IHabboWindowManager = null;
         var _loc5_:IWindowContainer = null;
         var _loc18_:* = 0;
         var _loc16_:BitmapData = null;
         var _loc9_:HabboCatalog = null;
         var _loc30_:class_3374 = null;
         var _loc6_:Point = null;
         var _loc7_:class_3581 = null;
         var _loc26_:class_3526 = null;
         var _loc31_:int = 0;
         var _loc11_:Point = null;
         if(param1 == null)
         {
            return;
         }
         var_3531 = param1;
         removeEffectSprites();
         var _loc14_:class_3377;
         _offer = _loc14_ = param1.offer;
         if(_bundleGrid != null)
         {
            _bundleGrid.visible = false;
            _bundleGrid.destroyGridItems();
         }
         _productName.caption = _loc14_.localizationName;
         var_396.caption = _loc14_.localizationDescription;
         var_396.y = _productName.y + _productName.height;
         if(_catalog.multiplePurchaseEnabled && _loc14_.bundlePurchaseAllowed && var_4428)
         {
            setSpinnerToBundleRuleset();
            setBundleInfoWidgetToOffer(_loc14_);
            var_3902 = false;
         }
         else
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_HIDE"));
            events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_HIDE"));
            var_3902 = true;
         }
         if(var_3902)
         {
            var_2248 = _catalog.utils.showPriceOnProduct(_loc14_,_window,var_2248,var_1250,-6,false,6,page.acceptSeasonCurrencyAsCredits,page.acceptSeasonCurrencyAsCredits);
         }
         else if(var_2248 != null)
         {
            _window.removeChild(var_2248);
            var_2248.dispose();
            var_2248 = null;
         }
         if(_loc14_.badgeCode != null && _loc14_.badgeCode != "")
         {
            _catalog.utils.showBadgeOnProduct(_loc14_.badgeCode,_window,6,38,true,false);
         }
         else if(ninjaEffectBundled(param1))
         {
            _catalog.utils.showAssetImageAsBadgeOnProduct("catalogue_effects_ninja",_window,6,38,true,false);
         }
         else
         {
            _catalog.utils.hideBadgeFromProduct(_window);
         }
         if(class_3623.hasProductImage(_loc14_.localizationId))
         {
            setPreviewFromAsset(class_3623.PRODUCT_IMAGES[_loc14_.localizationId]);
            if(var_1821 != null)
            {
               var_1821.visible = false;
            }
         }
         else
         {
            _loc27_ = new Point(0,0);
            _loc4_ = _catalog.roomPreviewer;
            switch(_loc14_.pricingModel)
            {
               case "pricing_model_bundle":
                  _loc33_ = var_3768.clone();
                  if(_bundleGrid != null)
                  {
                     _bundleGrid.visible = true;
                     _loc2_ = _loc14_.productContainer as BundleProductContainer;
                     _loc2_.populateItemGrid(_bundleGrid,_gridItemLayout);
                     _bundleGrid.scrollV = 0;
                  }
                  if(var_1821 != null)
                  {
                     var_1821.visible = false;
                  }
                  break;
               case "pricing_model_single":
               case "pricing_model_multi":
               case "pricing_model_furniture":
                  _loc24_ = _loc14_.product;
                  if(var_1821 != null && var_4084)
                  {
                     if(_loc24_.productType == "s" || _loc24_.productType == "i" || _loc24_.productType == "e")
                     {
                        var_1821.visible = true;
                     }
                     else
                     {
                        var_1821.visible = false;
                     }
                  }
                  if(_loc4_ != null && var_2068 != null)
                  {
                     _loc4_.addViewOffset.y = _loc24_.isUniqueLimitedItem ? -15 : 0;
                     _loc4_.disableUpdate = false;
                  }
                  switch(_loc24_.productType)
                  {
                     case "s":
                        if(_loc4_ != null && var_2068 != null)
                        {
                           if(!(_loc24_ == null || _loc24_.furnitureData == null))
                           {
                              if(_loc24_.furnitureData.category == 23)
                              {
                                 _loc19_ = _catalog.sessionDataManager.getFloorItemData(_loc24_.furnitureData.id);
                                 _loc15_ = new Vector.<int>(0);
                                 _loc23_ = _loc19_.customParams.split(",");
                                 for each(var _loc20_ in _loc23_)
                                 {
                                    if((page.viewer.catalog as HabboCatalog).avatarRenderManager.isValidFigureSetForGender(parseInt(_loc20_),(page.viewer.catalog as HabboCatalog).sessionDataManager.gender))
                                    {
                                       _loc15_.push(parseInt(_loc20_));
                                    }
                                 }
                                 _loc28_ = (page.viewer.catalog as HabboCatalog).avatarRenderManager.getFigureStringWithFigureIds((page.viewer.catalog as HabboCatalog).sessionDataManager.figure,(page.viewer.catalog as HabboCatalog).sessionDataManager.gender,_loc15_);
                                 _loc4_.addAvatarIntoRoom(_loc28_,_loc24_.productClassId);
                              }
                              else
                              {
                                 _loc4_.addFurnitureIntoRoom(_loc24_.productClassId,new Vector3d(90,0,0),_overrideStuffData);
                              }
                           }
                           break;
                        }
                        _loc8_ = page.viewer.roomEngine.getFurnitureImage(_loc24_.productClassId,new Vector3d(90,0,0),64,this,0,_loc24_.extraParam,-1,-1,_overrideStuffData);
                        _loc14_.previewCallbackId = _loc8_.id;
                        break;
                     case "i":
                        if(_loc24_.furnitureData.category == 2 || _loc24_.furnitureData.category == 3 || _loc24_.furnitureData.category == 4)
                        {
                           _loc29_ = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_wall_type");
                           _loc22_ = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_floor_type");
                           _loc10_ = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_landscape_type");
                           _loc29_ = _loc29_ && _loc29_.length > 0 ? _loc29_ : "101";
                           _loc22_ = _loc22_ && _loc22_.length > 0 ? _loc22_ : "101";
                           _loc10_ = _loc10_ && _loc10_.length > 0 ? _loc10_ : "1.1";
                           _loc4_.updateRoomWallsAndFloorVisibility(true,true);
                           _loc21_ = _loc24_.furnitureData.category == 3 ? _loc24_.extraParam : _loc22_;
                           _loc3_ = _loc24_.furnitureData.category == 2 ? _loc24_.extraParam : _loc29_;
                           _loc34_ = _loc24_.furnitureData.category == 4 ? _loc24_.extraParam : _loc10_;
                           _loc4_.updateObjectRoom(_loc21_,_loc3_,_loc34_);
                           if(_loc24_.furnitureData.category == 4)
                           {
                              _loc12_ = _catalog.getFurnitureDataByName("ads_twi_windw","i");
                              _loc4_.addWallItemIntoRoom(_loc12_.id,new Vector3d(90,0,0),_loc12_.customParams);
                           }
                        }
                        else if(_loc4_ != null && var_2068 != null)
                        {
                           _loc4_.addWallItemIntoRoom(_loc24_.productClassId,new Vector3d(90,0,0),_loc24_.extraParam);
                        }
                        else
                        {
                           _loc8_ = page.viewer.roomEngine.getWallItemImage(_loc24_.productClassId,new Vector3d(90,0,0),64,this,0,_loc24_.extraParam);
                           _loc14_.previewCallbackId = _loc8_.id;
                        }
                        break;
                     case "r":
                        (_loc32_ = _catalog.avatarRenderManager.createAvatarImage(_loc24_.extraParam,"h",null)).appendAction("gest","sml");
                        _loc32_.setDirection("full",4);
                        _loc32_.setDirection("head",3);
                        _loc33_ = _loc32_.getCroppedImage("full");
                        break;
                     case "e":
                        if(_loc4_ != null && var_2068 != null)
                        {
                           _loc25_ = (page.viewer.catalog as HabboCatalog).sessionDataManager.figure;
                           _loc4_.addAvatarIntoRoom(_loc25_,_loc24_.productClassId);
                        }
                        else
                        {
                           _loc13_ = page.viewer.catalog.windowManager;
                           _loc5_ = _window.findChildByName("pixelsBackground") as IWindowContainer;
                           _loc18_ = 4291611852;
                           if(_loc5_ != null)
                           {
                              _loc5_.visible = true;
                              _loc18_ = uint(_loc5_.color);
                           }
                           _loc33_ = new BitmapData(var_1250.width,var_1250.height,false,_loc18_);
                           _loc16_ = null;
                           if((_loc9_ = page.viewer.catalog as HabboCatalog).avatarRenderManager != null)
                           {
                              _loc28_ = _loc9_.sessionDataManager.figure;
                              if((_loc30_ = _loc9_.avatarRenderManager.createAvatarImage(_loc28_,"h")) != null)
                              {
                                 _loc30_.setDirection("head",3);
                                 _loc30_.initActionAppends();
                                 _loc30_.appendAction("gest","sml");
                                 _loc30_.appendAction("fx",_loc24_.productClassId);
                                 _loc30_.endActionAppends();
                                 _loc30_.updateAnimationByFrames(1);
                                 _loc30_.updateAnimationByFrames(1);
                                 _loc16_ = _loc30_.getImage("full",true);
                                 _loc6_ = new Point(0,0);
                                 if(_loc16_ != null)
                                 {
                                    if((_loc7_ = _loc30_.avatarSpriteData) != null)
                                    {
                                    }
                                    _loc6_.x = (_loc33_.width - _loc16_.width) / 2;
                                    _loc6_.y = (_loc33_.height - _loc16_.height) / 2;
                                    for each(var _loc17_ in _loc30_.getSprites())
                                    {
                                       if(_loc17_.id == "avatar")
                                       {
                                          _loc26_ = _loc30_.getLayerData(_loc17_);
                                          _loc27_.x = _loc26_.dx;
                                          _loc27_.y = _loc26_.dy;
                                       }
                                    }
                                 }
                                 _loc31_ = 64;
                                 _loc11_ = new Point((_loc16_.width - _loc31_) / 2,_loc16_.height - _loc31_ / 4);
                                 addEffectSprites(_loc33_,_loc30_,_loc27_,_loc6_.add(_loc11_),false);
                                 _loc33_.copyPixels(_loc16_,_loc16_.rect,_loc6_,null,null,true);
                                 addEffectSprites(_loc33_,_loc30_,_loc27_,_loc6_.add(_loc11_));
                              }
                           }
                           if(_loc30_)
                           {
                              _loc30_.dispose();
                           }
                        }
                        break;
                     case "h":
                        break;
                     default:
                        class_14.log("[Product View Catalog Widget] Unknown Product Type: " + _loc24_.productType);
                  }
                  if(_loc8_ != null)
                  {
                     _loc33_ = _loc8_.data;
                  }
                  break;
               default:
                  class_14.log("[Product View Catalog Widget] Unknown pricing model" + _loc14_.pricingModel);
            }
            setPreviewImage(_loc33_,true,_loc27_);
         }
         if(var_4084 && _loc4_ && var_2068 && var_1821 && var_2068.visible && var_1821.visible)
         {
            (_productName as ITextWindow).textColor = 4294967295;
            (var_396 as ITextWindow).textColor = 4294967295;
         }
         else
         {
            (_productName as ITextWindow).textColor = 4278190080;
            (var_396 as ITextWindow).textColor = 4278190080;
         }
         _window.invalidate();
      }
      
      private function setBundleInfoWidgetToOffer(param1:class_3377) : void
      {
         var _loc2_:ExtraInfoItemData = new ExtraInfoItemData(5);
         _loc2_.activityPointType = param1.activityPointType;
         _loc2_.priceActivityPoints = param1.priceInActivityPoints;
         _loc2_.priceCredits = param1.priceInCredits;
         _loc2_.priceSilver = param1.priceInSilver;
         _loc2_.badgeCode = param1.badgeCode;
         events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_RESET",_loc2_));
      }
      
      private function setSpinnerToBundleRuleset() : void
      {
         if(_catalog.bundleDiscountEnabled)
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET",1,_catalog.utils.bundleDiscountFlatPriceSteps));
         }
         else
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET",1));
         }
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SHOW"));
         if(_catalog.bundleDiscountRuleset != null)
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MAX",_catalog.bundleDiscountRuleset.maxPurchaseSize));
         }
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MIN",1));
      }
      
      private function addEffectSprites(param1:BitmapData, param2:class_3374, param3:Point, param4:Point, param5:Boolean = true) : void
      {
         var _loc9_:* = null;
         var _loc17_:int = 0;
         var _loc10_:class_3526 = null;
         var _loc19_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc20_:int = 0;
         var _loc7_:String = null;
         var _loc6_:BitmapDataAsset = null;
         var _loc8_:BitmapData = null;
         var _loc18_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc11_:Matrix = null;
         for each(_loc9_ in param2.getSprites())
         {
            _loc17_ = int(_window.getChildIndex(var_1250));
            _loc10_ = param2.getLayerData(_loc9_);
            _loc19_ = 0;
            _loc14_ = _loc9_.getDirectionOffsetX(param2.getDirection());
            _loc15_ = _loc9_.getDirectionOffsetY(param2.getDirection());
            _loc16_ = _loc9_.getDirectionOffsetZ(param2.getDirection());
            _loc20_ = 0;
            if(!param5)
            {
               if(_loc16_ >= 0)
               {
                  continue;
               }
            }
            else if(_loc16_ < 0)
            {
               continue;
            }
            if(_loc9_.hasDirections)
            {
               _loc20_ = param2.getDirection();
            }
            if(_loc10_ != null)
            {
               _loc19_ = _loc10_.animationFrame;
               _loc14_ += _loc10_.dx;
               _loc15_ += _loc10_.dy;
               _loc20_ += _loc10_.directionOffset;
            }
            if(_loc20_ < 0)
            {
               _loc20_ += 8;
            }
            if(_loc20_ > 7)
            {
               _loc20_ -= 8;
            }
            _loc7_ = param2.getScale() + "_" + _loc9_.member + "_" + _loc20_ + "_" + _loc19_;
            if((_loc6_ = param2.getAsset(_loc7_)) != null)
            {
               _loc8_ = (_loc6_.content as BitmapData).clone();
               _loc18_ = 1;
               _loc12_ = param4.x - 1 * _loc6_.offset.x + _loc14_;
               _loc13_ = param4.y - 1 * _loc6_.offset.y + _loc15_;
               if(_loc9_.ink == 33)
               {
                  _loc11_ = new Matrix(1,0,0,1,_loc12_ - param3.x,_loc13_ - param3.y);
                  param1.draw(_loc8_,_loc11_,null,"add",null,false);
               }
               else
               {
                  param1.copyPixels(_loc8_,_loc8_.rect,new Point(_loc12_ - param3.x,_loc13_ - param3.y));
               }
            }
         }
      }
      
      private function removeEffectSprites() : void
      {
         for each(var _loc1_ in var_4631)
         {
            _window.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         var_4631 = [];
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
               setPreviewImage(param2,true);
               _loc3_.previewCallbackId = 0;
               break;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean, param3:Point = null) : void
      {
         var _loc4_:Point = null;
         if(var_1250 != null && !window.disposed)
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
            _loc4_ = new Point((var_1250.width - param1.width) / 2,(var_1250.height - param1.height) / 2);
            var_1250.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
            var_1250.invalidate();
            var_1250.x = _previewOffset.x;
            var_1250.y = _previewOffset.y;
            if(param3 != null)
            {
               var_1250.x += param3.x;
               var_1250.y += param3.y;
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         if(!param1 || !page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return;
         }
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
         if(!param1 || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         var _loc4_:String = page.viewer.catalog.imageGalleryHost + param1 + ".gif";
         class_14.log("[Product View Catalog Widget] Retrieve Product Preview Asset: " + _loc4_);
         var _loc2_:URLRequest = new URLRequest(_loc4_);
         if(!page.viewer.catalog.assets)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         if(!_loc3_)
         {
            return;
         }
         _loc3_.addEventListener("AssetLoaderEventComplete",onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
            _loc2_.removeEventListener("AssetLoaderEventComplete",onPreviewImageReady);
         }
      }
      
      private function onStuffDataSet(param1:SetRoomPreviewerStuffDataEvent) : void
      {
         var _loc2_:RoomPreviewer = null;
         _overrideStuffData = param1.stuffData;
         if(var_3531 != null)
         {
            _loc2_ = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            if(_loc2_ != null)
            {
               _loc2_.reset(false);
            }
            onPreviewProduct(var_3531);
         }
      }
      
      private function onSpinnerEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         var _loc2_:IWindowContainer = null;
         if(param1.type == "CWSE_VALUE_CHANGED")
         {
            _loc2_ = window.findChildByName("price_box_new") as IWindowContainer;
            if(_loc2_ != null && var_3531 != null)
            {
               _catalog.utils.showPriceInContainer(_loc2_,var_3531.offer);
            }
         }
      }
      
      private function onTotalPriceWidgetInitialized(param1:Event) : void
      {
         var_4428 = true;
      }
      
      override public function closed() : void
      {
         var _loc1_:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
         if(_loc1_)
         {
            _loc1_.disableUpdate = true;
         }
      }
      
      public function onDragAndDropDone(param1:Boolean, param2:String) : void
      {
      }
   }
}
