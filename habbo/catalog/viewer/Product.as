package com.sulake.habbo.catalog.viewer
{
    import assets.class_14

    import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.class_3499;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.furniture.class_3365;
   import com.sulake.habbo.session.product.class_3423;
   import flash.display.BitmapData;
   
   public class Product extends ProductGridItem implements class_3388, IGetImageListener
   {
      
      public static const EFFECT_CLASSID_NINJA_DISAPPEAR:int = 108;
       
      
      private var var_398:String;
      
      private var var_389:int;
      
      private var var_586:String;
      
      private var var_519:int;
      
      private var var_1236:class_3423;
      
      private var var_2047:class_3365;
      
      private var var_4727:Boolean;
      
      private var var_1488:int;
      
      private var var_1157:int;
      
      private var var_1916:class_3553;
      
      public function Product(param1:String, param2:int, param3:String, param4:int, param5:class_3423, param6:class_3365, param7:HabboCatalog, param8:Boolean = false, param9:int = 0, param10:int = 0)
      {
         super(param7);
         var_398 = param1;
         var_389 = param2;
         var_586 = param3;
         var_519 = param4;
         var_1236 = param5;
         var_2047 = param6;
         var_4727 = param8;
         var_1488 = param9;
         var_1157 = param10;
      }
      
      public static function stripAddonProducts(param1:Vector.<class_3388>) : Vector.<class_3388>
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            return param1;
         }
         var _loc3_:Vector.<class_3388> = new Vector.<class_3388>(0);
         for each(_loc2_ in param1)
         {
            if(_loc2_.productType != "b" && !(_loc2_.productType == "e" && _loc2_.productClassId == 108))
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function get productType() : String
      {
         return var_398;
      }
      
      public function get productClassId() : int
      {
         return var_389;
      }
      
      public function set extraParam(param1:String) : void
      {
         var_586 = param1;
      }
      
      public function get extraParam() : String
      {
         return var_586;
      }
      
      public function get productCount() : int
      {
         return var_519;
      }
      
      public function get productData() : class_3423
      {
         return var_1236;
      }
      
      public function get furnitureData() : class_3365
      {
         return var_2047;
      }
      
      public function get isUniqueLimitedItem() : Boolean
      {
         return var_4727;
      }
      
      public function get uniqueLimitedItemSeriesSize() : int
      {
         return var_1488;
      }
      
      public function get uniqueLimitedItemsLeft() : int
      {
         return var_1157;
      }
      
      public function set uniqueLimitedItemsLeft(param1:int) : void
      {
         var_1157 = param1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_398 = "";
         var_389 = 0;
         var_586 = "";
         var_519 = 0;
         var_1236 = null;
         var_2047 = null;
         if(catalog && catalog.sessionDataManager)
         {
            catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
         }
         super.dispose();
      }
      
      public function initIcon(param1:class_3553, param2:IGetImageListener = null, param3:IAvatarImageListener = null, param4:class_3377 = null, param5:IBitmapWrapperWindow = null, param6:IStuffData = null, param7:Function = null) : BitmapData
      {
         var _loc10_:IRoomEngine = null;
         var _loc8_:class_3499 = null;
         var _loc11_:String = null;
         if(disposed)
         {
            return null;
         }
         var _loc9_:BitmapData = null;
         if(param2 == null)
         {
            param2 = this;
         }
         if(param1 is BundleGridViewCatalogWidget)
         {
            _loc10_ = (param1 as BundleGridViewCatalogWidget).offer.page.viewer.roomEngine;
         }
         else
         {
            _loc10_ = (param1 as ProductContainer).offer.page.viewer.roomEngine;
         }
         if(!_loc10_ || !catalog)
         {
            return null;
         }
         switch(var_398)
         {
            case "s":
               _loc8_ = _loc10_.getFurnitureIcon(productClassId,param2,null,param6);
               break;
            case "i":
               if(param4 && var_2047)
               {
                  _loc11_ = "";
                  switch(var_2047.className)
                  {
                     case "floor":
                        _loc11_ = ["th",var_2047.className,param4.product.extraParam].join("_");
                        break;
                     case "wallpaper":
                        _loc11_ = ["th","wall",param4.product.extraParam].join("_");
                        break;
                     case "landscape":
                        _loc11_ = ["th",var_2047.className,param4.product.extraParam.replace(".","_"),"001"].join("_");
                        break;
                     default:
                        _loc8_ = _loc10_.getWallItemIcon(productClassId,param2,var_586);
                  }
                  catalog.setImageFromAsset(param5,_loc11_,param7);
               }
               else
               {
                  _loc8_ = _loc10_.getWallItemIcon(productClassId,param2,var_586);
               }
               break;
            case "e":
               _loc9_ = catalog.getPixelEffectIcon(productClassId);
               if(param2 == this)
               {
                  this.setIconImage(_loc9_,true);
               }
               break;
            case "h":
               _loc9_ = catalog.getSubscriptionProductIcon(productClassId);
               break;
            case "b":
               catalog.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
               _loc9_ = catalog.sessionDataManager.getBadgeImage(var_586);
               var_1916 = param1;
               break;
            case "r":
               _loc9_ = renderAvatarImage(var_586,param3);
               setIconImage(_loc9_,false);
               break;
            default:
               class_14.log("[Product] Can not yet handle this type of product: " + productType);
         }
         if(_loc8_ != null)
         {
            _loc9_ = _loc8_.data;
            if(param2 == this)
            {
               this.setIconImage(_loc9_,true);
            }
         }
         return _loc9_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(!disposed)
         {
            setIconImage(param2,true);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         if(!disposed)
         {
            if(var_398 == "b" && param1.badgeId == var_586)
            {
               ProductGridItem(var_1916).setIconImage(param1.badgeImage,false);
               if(catalog && catalog.sessionDataManager)
               {
                  catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
               }
            }
         }
      }
      
      public function get isColorable() : Boolean
      {
         if(var_2047 && var_2047.fullName)
         {
            return var_2047.fullName.indexOf("*") != -1;
         }
         return false;
      }
      
      override public function set view(param1:IWindowContainer) : void
      {
         var _loc2_:IWindow = null;
         var _loc3_:ITextWindow = null;
         if(!param1)
         {
            return;
         }
         super.view = param1;
         if(var_519 > 1)
         {
            _loc2_ = var_1631.findChildByName("multiContainer");
            if(_loc2_)
            {
               _loc2_.visible = true;
            }
            _loc3_ = var_1631.findChildByName("multiCounter") as ITextWindow;
            if(_loc3_)
            {
               _loc3_.text = "x" + productCount;
            }
         }
      }
   }
}
