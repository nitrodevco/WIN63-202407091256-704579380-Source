package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.class_3455;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class ClubBuyItem
   {
       
      
      private var _offer:ClubBuyOfferData;
      
      private var _window:IWindowContainer;
      
      private var var_1768:class_3455;
      
      public function ClubBuyItem(param1:ClubBuyOfferData, param2:class_3455)
      {
         var _loc5_:XML = null;
         var _loc3_:ILocalization = null;
         super();
         _offer = param1;
         var_1768 = param2;
         if(param1.vip)
         {
            _loc5_ = getAssetXML("club_buy_vip_item");
         }
         else
         {
            _loc5_ = getAssetXML("club_buy_hc_item");
         }
         _window = var_1768.viewer.catalog.windowManager.buildFromXML(_loc5_) as IWindowContainer;
         var _loc4_:IHabboLocalizationManager;
         (_loc4_ = (param2.viewer.catalog as HabboCatalog).localization).registerParameter("catalog.club.item.header","months",String(param1.months));
         _loc3_ = _loc4_.getLocalizationRaw("catalog.club.item.header");
         _window.findChildByName("item_header").caption = _loc3_.value;
         _loc4_.registerParameter("catalog.club.price","price",String(param1.priceCredits));
         _loc3_ = _loc4_.getLocalizationRaw("catalog.club.price");
         _window.findChildByName("item_price").caption = _loc3_.value;
         var _loc6_:class_3357;
         if((_loc6_ = _window.findChildByName("item_buy") as class_3357) != null)
         {
            _loc6_.addEventListener("WME_CLICK",onBuy);
         }
      }
      
      public function dispose() : void
      {
         _window.dispose();
      }
      
      private function onBuy(param1:WindowMouseEvent) : void
      {
         HabboCatalog(var_1768.viewer.catalog).showPurchaseConfirmation(_offer,var_1768.pageId);
      }
      
      private function getAssetXML(param1:String) : XML
      {
         if(!var_1768 || !var_1768.viewer || !var_1768.viewer.catalog || !var_1768.viewer.catalog.assets)
         {
            return null;
         }
         var _loc2_:XmlAsset = var_1768.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as XML;
      }
      
      public function get window() : IWindow
      {
         return _window;
      }
   }
}
