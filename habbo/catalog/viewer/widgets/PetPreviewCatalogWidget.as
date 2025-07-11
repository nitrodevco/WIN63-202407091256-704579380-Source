package com.sulake.habbo.catalog.viewer.widgets
{
    import assets.class_14

    import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.class_3388;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.PetColorResult;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PetPreviewCatalogWidget extends CatalogWidget implements class_3558, IGetImageListener
   {
       
      
      private var PET_TYPE_ID:int = 15;
      
      private var BREED:int = 1;
      
      private var COLOR:int = 16777215;
      
      private var PALETTE_ID:int = 2;
      
      private var PART_ID:int = -1;
      
      private var _productName:IWindow;
      
      private var var_396:IWindow;
      
      private var var_1250:IBitmapWrapperWindow;
      
      private var _previewOffset:Point;
      
      private var var_3665:int;
      
      protected var _gridItemLayout:XML;
      
      private var _catalog:HabboCatalog;
      
      private var var_2248:IWindow;
      
      public function PetPreviewCatalogWidget(param1:IWindowContainer, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         _catalog = null;
         var_2248 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _productName = _window.findChildByName("ctlg_product_name");
         _productName.caption = "";
         var_396 = _window.findChildByName("ctlg_description");
         var_396.caption = "";
         var_1250 = _window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         _previewOffset = new Point(var_1250.x,var_1250.y);
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         var _loc2_:class_3499 = (page.viewer.catalog as HabboCatalog).roomEngine.getPetImage(PET_TYPE_ID,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0);
         if(_loc2_ != null)
         {
            setPreviewImage(_loc2_.data,true,new Point(0,0));
            var_3665 = _loc2_.id;
         }
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc30_:String = null;
         var _loc24_:String = null;
         var _loc31_:BitmapData = null;
         var _loc18_:class_3388 = null;
         var _loc4_:class_3499 = null;
         var _loc11_:class_3365 = null;
         var _loc21_:String = null;
         var _loc2_:Array = null;
         var _loc29_:int = 0;
         var _loc14_:Array = null;
         var _loc26_:Array = null;
         var _loc12_:Array = null;
         var _loc15_:Array = null;
         var _loc23_:int = 0;
         var _loc13_:String = null;
         var _loc6_:Array = null;
         var _loc19_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:int = 0;
         var _loc10_:PetColorResult = null;
         var _loc9_:PetColorResult = null;
         var _loc16_:int = 0;
         var _loc27_:int = 0;
         var _loc8_:PetCustomPart = null;
         var _loc22_:PetCustomPart = null;
         if(param1 == null)
         {
            return;
         }
         var _loc7_:class_3377 = param1.offer;
         var _loc25_:class_3423;
         if((_loc25_ = page.viewer.catalog.getProductData(_loc7_.localizationId)) != null)
         {
            _loc30_ = "${" + _loc25_.name + "}";
            _loc24_ = "${" + _loc25_.description + "}";
         }
         else
         {
            _loc30_ = "${" + _loc7_.localizationId + "}";
            _loc24_ = "${" + _loc7_.localizationId + "}";
         }
         _productName.caption = _loc30_;
         var_396.caption = _loc24_;
         var_396.y = _productName.y + _productName.height + 5;
         var_2248 = _catalog.utils.showPriceOnProduct(param1.offer,_window,var_2248,var_1250,-6,true,6);
         var _loc20_:Point = new Point(0,0);
         var _loc28_:IRoomEngine = (page.viewer.catalog as HabboCatalog).roomEngine;
         switch(_loc7_.pricingModel)
         {
            case "pricing_model_single":
            case "pricing_model_multi":
               if((_loc11_ = (_loc18_ = _loc7_.product).furnitureData) == null || _loc11_.customParams == null)
               {
                  class_14.log("[Pet Preview Catalog Widget] Unsupported product: " + _loc18_.productType);
                  break;
               }
               _loc2_ = (_loc21_ = _loc11_.customParams).split(" ");
               if(_loc2_.length < 1)
               {
                  class_14.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                  break;
               }
               _loc29_ = int(_loc2_[0]);
               _loc15_ = [];
               switch(_loc11_.category - 13)
               {
                  case 0:
                     if(_loc2_.length < 2)
                     {
                        class_14.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                        break;
                     }
                     _loc13_ = String(_loc2_[1]);
                     _loc6_ = _loc28_.getPetColorsByTag(_loc29_,_loc13_);
                     for each(var _loc3_ in _loc6_)
                     {
                        if(_loc3_.breed == BREED)
                        {
                           _loc19_ = int(_loc3_.id);
                           break;
                        }
                     }
                     switch(_loc29_ - 15)
                     {
                        case 0:
                           _loc5_ = 2;
                           _loc17_ = 3;
                           _loc10_ = _loc28_.getPetDefaultPalette(_loc29_,"hair");
                           _loc9_ = _loc28_.getPetDefaultPalette(_loc29_,"tail");
                           _loc16_ = !!_loc10_ ? parseInt(_loc10_.id) : -1;
                           _loc27_ = !!_loc9_ ? parseInt(_loc9_.id) : -1;
                           _loc8_ = new PetCustomPart(_loc5_,-1,_loc16_);
                           _loc22_ = new PetCustomPart(_loc17_,-1,_loc27_);
                           _loc15_ = [_loc8_,_loc22_];
                     }
                     _loc4_ = _loc28_.getPetImage(_loc29_,_loc19_,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  case 1:
                     if(_loc2_.length < 4)
                     {
                        class_14.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                        break;
                     }
                     _loc14_ = (_loc2_[1] as String).split(",");
                     _loc26_ = (_loc2_[2] as String).split(",");
                     _loc12_ = (_loc2_[3] as String).split(",");
                     _loc23_ = 0;
                     while(_loc23_ < _loc14_.length)
                     {
                        _loc15_.push(new PetCustomPart(int(_loc14_[_loc23_]),int(_loc26_[_loc23_]),int(_loc12_[_loc23_])));
                        _loc23_++;
                     }
                     _loc4_ = _loc28_.getPetImage(_loc29_,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  case 2:
                     if(_loc2_.length < 3)
                     {
                        class_14.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                        break;
                     }
                     _loc14_ = (_loc2_[1] as String).split(",");
                     _loc12_ = (_loc2_[2] as String).split(",");
                     _loc23_ = 0;
                     while(_loc23_ < _loc14_.length)
                     {
                        _loc15_.push(new PetCustomPart(int(_loc14_[_loc23_]),PART_ID,int(_loc12_[_loc23_])));
                        _loc23_++;
                     }
                     _loc4_ = _loc28_.getPetImage(_loc29_,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  case 3:
                     if(_loc2_.length < 4)
                     {
                        class_14.log("[Pet Preview Catalog Widget] Invalid custom params: " + _loc18_.productType);
                     }
                     _loc15_.push(new PetCustomPart(int(_loc2_[1]),int(_loc2_[2]),int(_loc2_[3])));
                     _loc4_ = _loc28_.getPetImage(_loc29_,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,_loc15_);
                     break;
                  default:
                     class_14.log("[Pet Preview Catalog Widget] Unsupported Product Type: " + _loc18_.productType);
               }
               if(_loc4_ != null)
               {
                  _loc7_.previewCallbackId = _loc4_.id;
                  _loc31_ = _loc4_.data;
               }
               break;
            default:
               class_14.log("[Pet Preview Catalog Widget] Unknown pricing model" + _loc7_.pricingModel);
         }
         setPreviewImage(_loc31_,true,_loc20_);
         _window.invalidate();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || page == null || page.offers == null)
         {
            return;
         }
         if(var_3665 == param1)
         {
            setPreviewImage(param2,true);
            var_3665 = 0;
         }
         else
         {
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
   }
}
