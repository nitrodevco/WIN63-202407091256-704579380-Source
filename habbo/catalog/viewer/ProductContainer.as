package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.habbo.avatar.IAvatarImageListener;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_3377;
   import com.sulake.habbo.catalog.purse.class_3473;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.IGetImageListener;
   import flash.display.BitmapData;
   
   public class ProductContainer extends ProductGridItem implements IGetImageListener, class_3553, class_3517, IAvatarImageListener
   {
      
      private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
      
      private static const const_1014:String = "amount_text_left";
      
      private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
      
      private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";
       
      
      protected var _offer:class_3377;
      
      protected var var_300:Vector.<class_3388>;
      
      public function ProductContainer(param1:class_3377, param2:Vector.<class_3388>, param3:HabboCatalog)
      {
         var _loc5_:String = null;
         super(param3);
         for each(var _loc4_ in param2)
         {
            if(_loc4_.productType != "b")
            {
               _loc5_ = _loc4_.extraParam;
               break;
            }
         }
         _offer = param1;
         var_300 = param2;
      }
      
      public function get products() : Vector.<class_3388>
      {
         return var_300;
      }
      
      public function get firstProduct() : class_3388
      {
         if(!var_300 || var_300.length == 0)
         {
            return null;
         }
         if(var_300.length == 1)
         {
            return var_300[0];
         }
         var _loc1_:Vector.<class_3388> = Product.stripAddonProducts(var_300);
         return _loc1_.length > 0 ? _loc1_[0] : null;
      }
      
      public function get offer() : class_3377
      {
         return _offer;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in var_300)
         {
            _loc1_.dispose();
         }
         var_300 = null;
         super.dispose();
      }
      
      public function get isLazy() : Boolean
      {
         return false;
      }
      
      public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
      }
      
      override public function set view(param1:IWindowContainer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_3388 = null;
         super.view = param1;
         if(var_1631 == null)
         {
            return;
         }
         if(catalog && _offer.badgeCode && _offer.badgeCode != "" && _offer.productContainer.products.length > 1)
         {
            setAddOnIcon("catalog_icon_badge_included");
         }
         else if(catalog && _offer.productContainer.products.length == 2)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_ = _offer.productContainer.products[_loc3_];
               if(_loc2_.productType == "e" && _loc2_.productClassId == 108)
               {
                  setAddOnIcon("catalog_icon_ninja_effect_included");
               }
               _loc3_++;
            }
         }
         setClubIconLevel(offer.clubLevel);
         if(catalog.isDraggable(offer))
         {
            setDraggable(true);
         }
      }
      
      private function setAddOnIcon(param1:String) : void
      {
         var _loc3_:IBitmapWrapperWindow = var_1631.findChildByName("badge_add_on") as IBitmapWrapperWindow;
         var _loc4_:IAsset = catalog.assets.getAssetByName(param1);
         _loc3_.bitmap = _loc4_.content as BitmapData;
         var _loc2_:BitmapData = _loc4_.content as BitmapData;
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_.height;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setIconImage(param2,true);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function setClubIconLevel(param1:int) : void
      {
         if(view == null)
         {
            return;
         }
         var _loc2_:IWindow = view.findChildByName("clubLevelIcon");
         if(_loc2_ == null)
         {
            return;
         }
         switch(offer.clubLevel)
         {
            case 0:
               _loc2_.visible = false;
               break;
            case 1:
               _loc2_.visible = true;
               _loc2_.style = 11;
               _loc2_.x += 3;
               break;
            case 2:
               _loc2_.visible = true;
               _loc2_.style = 12;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!disposed)
         {
            for each(var _loc2_ in products)
            {
               if(_loc2_.productType == "r" && _loc2_.extraParam == param1)
               {
                  setIconImage(renderAvatarImage(_loc2_.extraParam,this),true);
                  return;
               }
            }
         }
      }
      
      public function createCurrencyIndicators(param1:HabboCatalog) : void
      {
         var _loc3_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc6_:IWindow = null;
         var _loc2_:ITextWindow = null;
         var _loc4_:IWindow = null;
         if(_offer.priceInCredits > 0)
         {
            if(_offer.priceInActivityPoints > 0)
            {
               _loc3_ = ITextWindow(var_1631.findChildByName("amount_text_left"));
            }
            else
            {
               _loc3_ = ITextWindow(var_1631.findChildByName("amount_text_right"));
            }
            if(_loc3_)
            {
               _loc3_.text = _offer.priceInCredits + "";
            }
         }
         if(_offer.priceInActivityPoints > 0)
         {
            if(_loc7_ = ITextWindow(var_1631.findChildByName("amount_text_right")))
            {
               if(_loc6_ = var_1631.findChildByName("currency_indicator_bitmap_right"))
               {
                  _loc6_.style = class_3473.getIconStyleFor(_offer.activityPointType,param1,false);
               }
               _loc7_.text = _offer.priceInActivityPoints + "";
            }
         }
         else if(_offer.priceInSilver > 0)
         {
            _loc2_ = ITextWindow(var_1631.findChildByName("amount_text_right"));
            if(_loc2_)
            {
               if(_loc4_ = var_1631.findChildByName("currency_indicator_bitmap_right"))
               {
                  _loc4_.style = class_3473.getIconStyleFor(1000,param1,false);
               }
               _loc2_.text = _offer.priceInSilver + "";
            }
         }
         var _loc5_:IItemListWindow;
         if(_loc5_ = IItemListWindow(var_1631.findChildByName("totalprice_container")))
         {
            _loc5_.arrangeListItems();
         }
      }
   }
}
