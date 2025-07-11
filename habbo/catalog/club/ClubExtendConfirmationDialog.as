package com.sulake.habbo.catalog.club
{
    import assets.class_14

    import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.purse.class_3473;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_1646;
   
   public class ClubExtendConfirmationDialog
   {
      
      private static const CREDIT_IMAGE_COUNT:int = 7;
      
      private static const YOUR_PRICE_ICON_BITMAP_ELEMENT_NAME:String = "your_price_icon_left";
      
      private static const const_739:String = "${image.library.catalogue.url}catalogue/vip_extend_tsr.png";
      
      private static const TEASER_IMAGE_MIME_TYPE:String = "image/png";
      
      private static const ANIMATION_TRIGGER_INTERVAL:int = 2000;
      
      private static const const_635:int = 75;
      
      private static const LINK_COLOR_DEFAULT:uint = 0;
      
      private static const LINK_COLOR_HOVER:uint = 9552639;
       
      
      private var var_319:ClubExtendController;
      
      private var var_1631:class_3514;
      
      private var _offer:class_1646;
      
      private var var_2439:IRegionWindow;
      
      private var var_2428:ITextWindow;
      
      private var var_2148:IBitmapWrapperWindow;
      
      private var var_2488:Vector.<BitmapData>;
      
      private var var_2602:Timer;
      
      private var var_2130:Timer;
      
      private var _animationFrame:int = 0;
      
      private var var_3236:int = 0;
      
      private var _disposed:Boolean = false;
      
      private var _localizationKey:String = "catalog.club.extend.";
      
      public function ClubExtendConfirmationDialog(param1:ClubExtendController, param2:class_1646)
      {
         super();
         var_319 = param1;
         _offer = param2;
         var_2488 = new Vector.<BitmapData>(7);
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_disposed)
         {
            return;
         }
         _offer = null;
         var_319 = null;
         clearAnimation();
         if(var_2439)
         {
            var_2439.removeEventListener("WME_OUT",onMouseOutLaterRegion);
            var_2439.removeEventListener("WME_OVER",onMouseOverLaterRegion);
            var_2439 = null;
         }
         if(var_2428)
         {
            var_2428 = null;
         }
         if(var_2148)
         {
            var_2148 = null;
         }
         if(var_2488)
         {
            while(_loc1_ < 7)
            {
               var_2488[_loc1_].dispose();
               var_2488[_loc1_] = null;
               _loc1_++;
            }
            var_2488 = null;
         }
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         _disposed = true;
      }
      
      public function showConfirmation() : void
      {
         var _loc10_:IIconWindow = null;
         var _loc11_:String = null;
         var _loc8_:int = 0;
         var _loc6_:BitmapDataAsset = null;
         var _loc12_:BitmapData = null;
         if(!_offer || !var_319 || _disposed)
         {
            return;
         }
         var_1631 = createWindow("club_extend_confirmation") as class_3514;
         if(!var_1631)
         {
            return;
         }
         var_1631.procedure = windowEventHandler;
         var_1631.center();
         if(!_offer.vip)
         {
            _localizationKey += "basic.";
            if(_loc10_ = var_1631.findChildByName("club_level_icon") as IIconWindow)
            {
               _loc10_.style = 17;
               _loc10_.x += 15;
            }
         }
         var _loc3_:IHabboLocalizationManager = var_319.localization;
         var_1631.findChildByName("normal_price_price_left").caption = _offer.originalPrice.toString();
         var_1631.findChildByName("normal_price_price_right").caption = _offer.originalActivityPointPrice.toString();
         var_1631.findChildByName("you_save_price_left").caption = _offer.discountCreditAmount.toString();
         var_1631.findChildByName("you_save_price_right").caption = _offer.discountActivityPointAmount.toString();
         var_1631.findChildByName("your_price_price_left").caption = _offer.priceCredits.toString();
         var_1631.findChildByName("your_price_price_right").caption = _offer.priceActivityPoints.toString();
         var_1631.title.caption = _loc3_.getLocalization(_localizationKey + "confirm.caption");
         var_1631.findChildByName("extend_title").caption = _loc3_.getLocalization(_localizationKey + "confirm.title");
         var_1631.findChildByName("normal_price_label").caption = _loc3_.getLocalization(_localizationKey + "normal.label");
         var_1631.findChildByName("you_save_label").caption = _loc3_.getLocalization(_localizationKey + "save.label");
         var_1631.findChildByName("your_price_label").caption = _loc3_.getLocalization(_localizationKey + "price.label");
         var_1631.findChildByName("buy_now_button").caption = _loc3_.getLocalization(_localizationKey + "buy.button");
         var_1631.findChildByName("maybe_later_link").caption = _loc3_.getLocalization(_localizationKey + "later.link");
         if(_offer.subscriptionDaysLeft > 1)
         {
            _loc3_.registerParameter(_localizationKey + "expiration_days_left","day",_offer.subscriptionDaysLeft.toString());
            _loc3_.registerParameter(_localizationKey + "expiration_days_left","duration",(31 * _offer.months).toString());
            _loc11_ = String(_loc3_.getLocalization(_localizationKey + "expiration_days_left"));
         }
         else
         {
            _loc11_ = String(_loc3_.getLocalization(_localizationKey + "expires_today"));
         }
         var_1631.findChildByName("offer_expiration").caption = _loc11_;
         var_2439 = var_1631.findChildByName("maybe_later_region") as IRegionWindow;
         var_2428 = var_1631.findChildByName("maybe_later_link") as ITextWindow;
         if(!var_2439 || !var_2428)
         {
            return;
         }
         var_2439.addEventListener("WME_OUT",onMouseOutLaterRegion);
         var_2439.addEventListener("WME_OVER",onMouseOverLaterRegion);
         var _loc5_:BitmapData = getBitmapDataFromAsset("icon_credit_0");
         setElementBitmapData("normal_price_icon_left",_loc5_);
         setElementBitmapData("you_save_icon_left",_loc5_);
         setActivityPointIconStyle("normal_price_icon_right");
         setActivityPointIconStyle("you_save_icon_right");
         setActivityPointIconStyle("your_price_icon_right");
         var _loc1_:IBitmapWrapperWindow = var_1631.findChildByName("club_teaser") as IBitmapWrapperWindow;
         _loc1_.x = 1;
         _loc1_.y = var_1631.height - 144;
         _loc1_.height = 144;
         _loc1_.width = 133;
         var _loc7_:String = String(var_319.config.interpolate("${image.library.catalogue.url}catalogue/vip_extend_tsr.png"));
         if(var_319.config)
         {
            _loc7_ = String(var_319.config.updateUrlProtocol(_loc7_));
         }
         loadAssetFromUrl("club_teaser","club_teaser",_loc7_,"image/png",onTeaserLoaded);
         var _loc9_:IItemListWindow;
         if(!(_loc9_ = var_1631.findChildByName("itemlist_vertical") as IItemListWindow))
         {
            return;
         }
         var _loc4_:IWindowContainer;
         if(!(_loc4_ = var_1631.findChildByName("total_amount_line") as IWindowContainer))
         {
            return;
         }
         var _loc2_:IWindowContainer = var_1631.findChildByName("background_container") as IWindowContainer;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.height = _loc9_.y + _loc4_.height + _loc4_.y;
         var_2148 = var_1631.findChildByName("your_price_icon_left") as IBitmapWrapperWindow;
         if(var_2148 == null)
         {
            return;
         }
         _loc8_ = 0;
         while(_loc8_ < 7)
         {
            _loc12_ = (_loc6_ = var_319.assets.getAssetByName("icon_credit_" + _loc8_) as BitmapDataAsset).content as BitmapData;
            var_2488[_loc8_] = _loc12_.clone();
            _loc8_++;
         }
         startAnimation();
      }
      
      private function setActivityPointIconStyle(param1:String) : void
      {
         var _loc2_:IWindow = var_1631.findChildByName(param1);
         _loc2_.style = class_3473.getIconStyleFor(_offer.originalActivityPointType,var_319.config,true);
      }
      
      private function onMouseOutLaterRegion(param1:WindowMouseEvent) : void
      {
         if(var_2428)
         {
            var_2428.textColor = 0;
         }
      }
      
      private function onMouseOverLaterRegion(param1:WindowMouseEvent) : void
      {
         if(var_2428)
         {
            var_2428.textColor = 9552639;
         }
      }
      
      private function startAnimation() : void
      {
         if(var_2602)
         {
            clearAnimation();
         }
         setAnimationFrame();
         var_2602 = new Timer(2000);
         var_2602.addEventListener("timer",onAnimationTrigger);
         var_2602.start();
      }
      
      private function clearAnimation() : void
      {
         _animationFrame = 0;
         var_3236 = 0;
         if(var_2130)
         {
            var_2130.stop();
            var_2130 = null;
         }
         if(var_2602)
         {
            var_2602.stop();
            var_2602 = null;
         }
      }
      
      private function setAnimationFrame() : void
      {
         if(!var_2148)
         {
            return;
         }
         if(var_2148.bitmap)
         {
            var_2148.bitmap.dispose();
         }
         if(_animationFrame < 7)
         {
            var_2148.bitmap = new BitmapData(var_2148.width,var_2148.height,true,0);
            var_2148.bitmap.copyPixels(var_2488[_animationFrame],var_2488[_animationFrame].rect,new Point(0,0));
         }
         else
         {
            class_14.log("Animation frame " + _animationFrame);
         }
      }
      
      private function startAnimationFrame() : void
      {
         var_2130 = new Timer(75,7 - 1);
         var_2130.addEventListener("timer",onAnimationFrame);
         var_2130.addEventListener("timerComplete",onAnimationFrameComplete);
         var_2130.start();
      }
      
      private function onAnimationTrigger(param1:TimerEvent) : void
      {
         startAnimationFrame();
      }
      
      private function onAnimationFrame(param1:TimerEvent) : void
      {
         _animationFrame += 1;
         setAnimationFrame();
      }
      
      private function onAnimationFrameComplete(param1:TimerEvent) : void
      {
         if(var_2130)
         {
            var_2130.stop();
            var_2130 = null;
         }
         _animationFrame = 0;
         setAnimationFrame();
         if(var_3236 == 0)
         {
            var_3236 = 1;
            startAnimationFrame();
         }
         else
         {
            var_3236 = 0;
         }
      }
      
      private function getBitmapDataFromAsset(param1:String) : BitmapData
      {
         var _loc2_:BitmapDataAsset = var_319.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ != null)
         {
            return _loc2_.content as BitmapData;
         }
         return null;
      }
      
      private function setElementBitmapData(param1:String, param2:BitmapData) : void
      {
         var _loc3_:IBitmapWrapperWindow = var_1631.findChildByName(param1) as IBitmapWrapperWindow;
         if(_loc3_.bitmap != null)
         {
            _loc3_.bitmap.dispose();
         }
         if(param2 != null && _loc3_ != null)
         {
            if(_loc3_.width != param2.width)
            {
               _loc3_.width = param2.width;
            }
            if(_loc3_.height != param2.height)
            {
               _loc3_.height = param2.height;
            }
            _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
            _loc3_.bitmap.copyPixels(param2,param2.rect,new Point(0,0));
         }
      }
      
      private function loadAssetFromUrl(param1:String, param2:String, param3:String, param4:String, param5:Function) : Boolean
      {
         var _loc8_:BitmapData;
         if((_loc8_ = getBitmapDataFromAsset(param2)) != null)
         {
            setElementBitmapData(param1,_loc8_);
            return true;
         }
         var _loc6_:URLRequest = new URLRequest(param3);
         var _loc7_:AssetLoaderStruct;
         if(!(_loc7_ = var_319.assets.loadAssetFromFile(param2,_loc6_,param4)))
         {
            return false;
         }
         _loc7_.addEventListener("AssetLoaderEventComplete",param5);
         return true;
      }
      
      private function onTeaserLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:BitmapData = null;
         if(!_disposed)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               _loc3_ = getBitmapDataFromAsset(_loc2_.assetName);
               setElementBitmapData("club_teaser",_loc3_);
            }
         }
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindow) : void
      {
         if(!param1 || !param2 || !var_319 || !_offer || _disposed)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "buy_now_button":
               var_319.confirmSelection();
               break;
            case "header_button_close":
            case "maybe_later_region":
               var_319.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : IWindow
      {
         if(!var_319 || !var_319.assets || !var_319.windowManager || _disposed)
         {
            return null;
         }
         var _loc3_:XmlAsset = var_319.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return var_319.windowManager.buildFromXML(_loc2_);
      }
   }
}
