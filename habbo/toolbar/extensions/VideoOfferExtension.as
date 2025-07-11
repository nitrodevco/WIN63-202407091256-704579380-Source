package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IVideoOfferLauncher;
   import com.sulake.habbo.catalog.enum.VideoOfferTypeEnum;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class VideoOfferExtension implements IVideoOfferLauncher
   {
      
      private static const const_1180:String = "video_offer";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private static const CLOSE_COLOR_NORMAL:uint = 6710886;
      
      private static const CLOSE_COLOR_OVER:uint = 13421772;
       
      
      private var _toolbar:HabboToolbar;
      
      private var var_1631:IWindowContainer;
      
      private var var_2237:IRegionWindow;
      
      private var var_175:IIconWindow;
      
      private var var_4147:Boolean = false;
      
      public function VideoOfferExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      public function get window() : IWindow
      {
         return var_1631;
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.clubIsExpiring && !var_1631 && isClubExtensionEnabled())
         {
            _toolbar.extensionView.detachExtension("video_offer");
            destroyWindow();
            return;
         }
         if(!var_4147 && !var_1631)
         {
            _toolbar.catalog.videoOffers.load(this);
         }
      }
      
      private function isClubExtensionEnabled() : Boolean
      {
         return _toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled");
      }
      
      public function offersAvailable(param1:int) : void
      {
         if(_toolbar == null)
         {
            return;
         }
         if(param1 <= 0 || var_4147 || _toolbar.inventory.clubIsExpiring && isClubExtensionEnabled())
         {
            if(var_1631)
            {
               destroyWindow();
            }
            return;
         }
         if(!var_1631)
         {
            var_1631 = createWindow();
         }
      }
      
      private function createWindow() : IWindowContainer
      {
         var _loc2_:String = null;
         var _loc6_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc5_:BitmapData = null;
         var _loc8_:IBitmapWrapperWindow = null;
         var _loc1_:IWindowContainer = null;
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("video_offer_promotion_xml") as XmlAsset;
         if(_loc3_)
         {
            _loc1_ = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,1) as IWindowContainer;
            if(_loc1_)
            {
               _loc2_ = String(_toolbar.localization.getLocalization("supersaverads.video.promo.offer","Watch a video and earn a credit!"));
               _loc6_ = _loc1_.findChildByName("promo_text") as ITextWindow;
               _loc7_ = _loc1_.findChildByName("promo_text_shadow") as ITextWindow;
               if(_loc6_)
               {
                  _loc6_.text = _loc2_;
               }
               if(_loc7_)
               {
                  _loc7_.text = _loc2_;
               }
               if((_loc4_ = _toolbar.assets.getAssetByName("offer_icon_png") as BitmapDataAsset) != null)
               {
                  _loc5_ = _loc4_.content as BitmapData;
                  _loc8_ = _loc1_.findChildByName("promo_icon") as IBitmapWrapperWindow;
                  if(_loc5_ != null && _loc8_ != null)
                  {
                     _loc8_.bitmap = new BitmapData(_loc8_.width,_loc8_.height,true,0);
                     _loc8_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
                  }
               }
               var_2237 = _loc1_.findChildByName("text_region") as IRegionWindow;
               if(var_2237)
               {
                  var_2237.addEventListener("WME_CLICK",onTextRegionClicked);
                  var_2237.addEventListener("WME_OVER",onTextRegionMouseOver);
                  var_2237.addEventListener("WME_OUT",onTextRegionMouseOut);
               }
               var_175 = _loc1_.findChildByName("promo_close_icon") as IIconWindow;
               if(var_175)
               {
                  var_175.addEventListener("WME_CLICK",onCloseClicked);
                  var_175.addEventListener("WME_OVER",onCloseMouseOver);
                  var_175.addEventListener("WME_OUT",onCloseMouseOut);
               }
               _toolbar.extensionView.attachExtension("video_offer",_loc1_,10);
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(var_1631)
         {
            if(var_2237)
            {
               var_2237.removeEventListener("WME_CLICK",onTextRegionClicked);
               var_2237.removeEventListener("WME_OVER",onTextRegionMouseOver);
               var_2237.removeEventListener("WME_OUT",onTextRegionMouseOut);
               var_2237 = null;
            }
            if(var_175)
            {
               var_175.removeEventListener("WME_CLICK",onCloseClicked);
               var_175.removeEventListener("WME_OVER",onCloseMouseOver);
               var_175.removeEventListener("WME_OUT",onCloseMouseOut);
               var_175 = null;
            }
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      public function dispose() : void
      {
         if(_toolbar == null)
         {
            return;
         }
         _toolbar.extensionView.detachExtension("video_offer");
         destroyWindow();
         _toolbar = null;
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         var_4147 = true;
         destroyWindow();
         _toolbar.connection.send(new EventLogMessageComposer("SuperSaverAds","client_action","supersaverads.video.promo.close_clicked"));
      }
      
      private function onCloseMouseOver(param1:WindowMouseEvent) : void
      {
         if(var_175)
         {
            var_175.color = 13421772;
         }
      }
      
      private function onCloseMouseOut(param1:WindowMouseEvent) : void
      {
         if(var_175)
         {
            var_175.color = 6710886;
         }
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(!_toolbar.catalog.videoOffers.launch(VideoOfferTypeEnum.CREDIT))
         {
            destroyWindow();
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
