package com.sulake.habbo.toolbar.extensions
{
    import assets.class_14

    import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_930;
   import com.sulake.habbo.communication.messages.outgoing.tracking.class_955;
   
   public class ClubDiscountPromoExtension
   {
      
      private static const const_1180:String = "club_promo";
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
       
      
      private var _toolbar:HabboToolbar;
      
      private var var_1631:IWindowContainer;
      
      private var _disposed:Boolean = false;
      
      private var var_1709:IBitmapWrapperWindow;
      
      private var var_2367:Timer;
      
      private var var_3550:int = 0;
      
      private var _animBlockMoveAmount:int;
      
      private var var_2511:Timer;
      
      private var var_2928:BitmapData;
      
      private var var_2415:Timer;
      
      public function ClubDiscountPromoExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      private function createWindow() : IWindowContainer
      {
         var _loc4_:IAsset = null;
         var _loc2_:IRegionWindow = null;
         var _loc1_:IWindowContainer = null;
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("club_discount_promotion_xml") as XmlAsset;
         if(_loc3_)
         {
            _loc1_ = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,1) as IWindowContainer;
            if(_loc1_)
            {
               var_1709 = _loc1_.findChildByName("flashing_animation") as IBitmapWrapperWindow;
               if(var_1709)
               {
                  if(_loc4_ = _toolbar.assets.getAssetByName("extend_hilite_png") as IAsset)
                  {
                     var_2928 = _loc4_.content as BitmapData;
                     if(var_2928)
                     {
                        var_1709.bitmap = var_2928.clone();
                     }
                  }
                  var_1709.visible = false;
               }
               _loc2_ = _loc1_.findChildByName("text_region") as IRegionWindow;
               if(_loc2_)
               {
                  _loc2_.addEventListener("WME_CLICK",onTextRegionClicked);
                  _loc2_.addEventListener("WME_OVER",onTextRegionMouseOver);
                  _loc2_.addEventListener("WME_OUT",onTextRegionMouseOut);
               }
               assignState();
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
            var_1709 = null;
         }
         animate(false);
         destroyExpirationTimer();
      }
      
      public function dispose() : void
      {
         if(_disposed || !_toolbar)
         {
            return;
         }
         if(_toolbar.extensionView)
         {
            _toolbar.extensionView.detachExtension("club_promo");
         }
         clearAnimation();
         destroyWindow();
         _toolbar = null;
         _disposed = true;
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(_toolbar.inventory.clubLevel == 2)
         {
            _toolbar.connection.send(new class_955("DiscountPromo","discount","client.club.extend.discount.clicked"));
            _toolbar.connection.send(new class_930());
         }
      }
      
      private function assignState() : void
      {
         switch(_toolbar.inventory.clubLevel)
         {
            case 0:
               setText("${discount.bar.no.club.promo}");
               setClubIcon(14);
               break;
            case 2:
               setText("${discount.bar.vip.expiring}");
               setClubIcon(14);
         }
         animate(true);
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.clubIsExpiring && !var_1631 && isExtensionEnabled())
         {
            var_1631 = createWindow();
            if(var_2415 != null)
            {
               destroyExpirationTimer();
            }
            if(_toolbar.inventory.clubMinutesUntilExpiration < 1440 && _toolbar.inventory.clubMinutesUntilExpiration > 0)
            {
               var_2415 = new Timer(_toolbar.inventory.clubMinutesUntilExpiration * 60 * 1000,1);
               var_2415.addEventListener("timerComplete",onExtendOfferExpire);
               var_2415.start();
            }
            assignState();
            _toolbar.extensionView.attachExtension("club_promo",var_1631,10);
         }
         else
         {
            _toolbar.extensionView.detachExtension("club_promo");
            destroyWindow();
         }
      }
      
      private function destroyExpirationTimer() : void
      {
         if(var_2415)
         {
            var_2415.stop();
            var_2415.removeEventListener("timerComplete",onExtendOfferExpire);
            var_2415 = null;
         }
      }
      
      private function onExtendOfferExpire(param1:TimerEvent) : void
      {
         _toolbar.extensionView.detachExtension("club_promo");
         destroyWindow();
      }
      
      private function isExtensionEnabled() : Boolean
      {
         if(_toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled"))
         {
            return true;
         }
         return false;
      }
      
      private function setText(param1:String) : void
      {
         var _loc2_:ITextWindow = null;
         var _loc3_:ITextWindow = null;
         if(var_1631)
         {
            _loc2_ = var_1631.findChildByName("promo_text") as ITextWindow;
            _loc3_ = var_1631.findChildByName("promo_text_shadow") as ITextWindow;
            if(_loc2_)
            {
               _loc2_.text = param1;
            }
            if(_loc3_)
            {
               _loc3_.text = param1;
            }
         }
      }
      
      private function animate(param1:Boolean) : void
      {
         if(param1)
         {
            class_14.log("Animate window");
            if(var_2511)
            {
               var_2511.stop();
            }
            var_2511 = new Timer(15000);
            var_2511.addEventListener("timer",onTriggerTimer);
            var_2511.start();
         }
         else
         {
            if(var_2511)
            {
               var_2511.stop();
               var_2511 = null;
            }
            clearAnimation();
         }
      }
      
      private function clearAnimation() : void
      {
         if(var_1709)
         {
            var_1709.visible = false;
            var_1709.bitmap = null;
            var_1709 = null;
            var_1631.invalidate();
            if(var_2367)
            {
               var_2367.stop();
               var_2367 = null;
            }
         }
      }
      
      private function onTriggerTimer(param1:TimerEvent) : void
      {
         if(var_1709)
         {
            if(var_1709.context)
            {
               var_1709.visible = true;
               resetAnimationVariables();
               startAnimationTimer();
            }
         }
      }
      
      private function resetAnimationVariables() : void
      {
         var_1709.x = 3;
         var_1709.y = 3;
         var_1709.bitmap = var_2928.clone();
         var_1709.height = var_1631.height - 6;
         var_1709.width = var_1709.bitmap.width;
         var_1709.invalidate();
         _animBlockMoveAmount = var_1631.width - 7 - var_1709.bitmap.width;
         var_3550 = 0;
      }
      
      private function startAnimationTimer() : void
      {
         var_2367 = new Timer(25,26);
         var_2367.addEventListener("timer",onAnimationTimer);
         var_2367.addEventListener("timerComplete",onAnimationTimerComplete);
         var_2367.start();
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BitmapData = null;
         if(var_1709)
         {
            var_1709.x = 3 + var_3550 / 20 * _animBlockMoveAmount;
            if(var_1709.x > _animBlockMoveAmount)
            {
               _loc2_ = var_1631.width - 4 - var_1709.x;
               _loc3_ = new BitmapData(_loc2_,var_2928.height);
               _loc3_.copyPixels(var_2928,new Rectangle(0,0,_loc2_,var_2928.height),new Point(0,0));
               var_1709.bitmap = _loc3_;
               var_1709.width = _loc2_;
            }
            var_1709.invalidate();
            var_3550++;
         }
      }
      
      private function onAnimationTimerComplete(param1:TimerEvent) : void
      {
         clearAnimation();
      }
      
      private function setClubIcon(param1:int) : void
      {
         var _loc2_:IIconWindow = null;
         if(var_1631)
         {
            _loc2_ = var_1631.findChildByName("club_icon") as IIconWindow;
            if(_loc2_)
            {
               _loc2_.style = param1;
               _loc2_.invalidate();
            }
         }
      }
      
      private function onTextRegionMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(var_1631)
         {
            _loc2_ = var_1631.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 12247545;
         }
      }
      
      private function onTextRegionMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(var_1631)
         {
            _loc2_ = var_1631.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 16777215;
         }
      }
   }
}
