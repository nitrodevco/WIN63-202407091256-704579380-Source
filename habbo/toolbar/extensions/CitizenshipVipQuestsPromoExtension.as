package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.localization.ICoreLocalizationManager;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.IExtensionView;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import com.sulake.habbo.communication.messages.outgoing.quest.StartCampaignMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.perk.CitizenshipVipOfferPromoEnabledEvent;
   
   public class CitizenshipVipQuestsPromoExtension
   {
       
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var name_1:IEventDispatcher;
      
      private var _localization:ICoreLocalizationManager;
      
      private var var_26:IConnection;
      
      private var var_1945:IExtensionView;
      
      private var var_1631:class_3437;
      
      private var _disposed:Boolean = false;
      
      private var _expanded:Boolean = true;
      
      private var var_4263:int = 216;
      
      private var _vipQuestsCampaignName:String;
      
      private var var_3102:IMessageEvent = null;
      
      public function CitizenshipVipQuestsPromoExtension(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher, param5:ICoreLocalizationManager, param6:IConnection)
      {
         super();
         _windowManager = param2;
         _assets = param3;
         name_1 = param4;
         _localization = param5;
         var_26 = param6;
         var_1945 = param1.extensionView;
         var_3102 = new CitizenshipVipOfferPromoEnabledEvent(onCitizenshipQuestPromoEnabled);
         var_26.addMessageEvent(var_3102);
         _vipQuestsCampaignName = param1.getProperty("citizenship.vip.tutorial.quest.campaign.name");
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_26 && var_3102)
         {
            var_26.removeMessageEvent(var_3102);
            var_3102 = null;
         }
         destroyWindow();
         _localization = null;
         _assets = null;
         name_1 = null;
         _windowManager = null;
         var_26 = null;
         var_1945 = null;
         _disposed = true;
      }
      
      private function createWindow() : class_3437
      {
         var _loc1_:class_3437 = null;
         var _loc2_:IAsset = _assets.getAssetByName("vip_quests_promo_xml");
         if(_loc2_)
         {
            _loc1_ = _windowManager.buildFromXML(_loc2_.content as XML,1) as class_3437;
            if(_loc1_)
            {
               class_3357(_loc1_.findChildByName("quests_button").addEventListener("WME_CLICK",onButtonClicked));
               IRegionWindow(_loc1_.findChildByName("minimize_region")).addEventListener("WME_CLICK",onMinMax);
               IRegionWindow(_loc1_.findChildByName("maximize_region")).addEventListener("WME_CLICK",onMinMax);
               var_4263 = _loc1_.height;
            }
         }
         return _loc1_;
      }
      
      private function destroyWindow() : void
      {
         if(var_1945)
         {
            var_1945.detachExtension("vip_quests");
         }
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(var_26)
         {
            var_26.send(new StartCampaignMessageComposer(_vipQuestsCampaignName));
         }
         destroyWindow();
      }
      
      private function onMinMax(param1:WindowMouseEvent) : void
      {
         _expanded = !_expanded;
         assignState();
      }
      
      private function assignState() : void
      {
         IItemListWindow(var_1631.findChildByName("content_itemlist")).visible = _expanded;
         IStaticBitmapWrapperWindow(var_1631.findChildByName("promo_img")).visible = _expanded;
         var_1631.height = _expanded ? var_4263 : 33;
      }
      
      private function onCitizenshipQuestPromoEnabled(param1:IMessageEvent) : void
      {
         if(var_1631 == null)
         {
            var_1631 = createWindow();
         }
         assignState();
         var_1945.detachExtension("club_promo");
         var_1945.attachExtension("vip_quests",var_1631,10);
      }
   }
}
