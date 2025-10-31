package com.sulake.habbo.catalog.offers
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.parser.notifications.OfferRewardDeliveredMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.notifications.OfferRewardDeliveredMessageEvent;
   
   public class OfferCenter implements IOfferCenter, IDisposable
   {
      
      private static const PROVIDER_POLLING_FREQUENCY:int = 1800000;
       
      
      private var _disposed:Boolean;
      
      private var _windowManager:IHabboWindowManager;
      
      private var _assets:IAssetLibrary;
      
      private var _catalog:IHabboCatalog;
      
      private var _offerExtension:IOfferExtension;
      
      private var _window:IWindowContainer;
      
      private var var_2809:IOfferProvider;
      
      private var _providers:Vector.<IOfferProvider>;
      
      private var var_3410:Vector.<OfferReward>;
      
      private var var_3556:IWindow;
      
      private var var_2551:Timer;
      
      private var _offerRewardDeliveredMessageEvent:OfferRewardDeliveredMessageEvent;
      
      public function OfferCenter(param1:IHabboWindowManager, param2:IAssetLibrary, param3:IHabboCatalog)
      {
         super();
         _windowManager = param1;
         _assets = param2;
         _catalog = param3;
         _offerRewardDeliveredMessageEvent = new OfferRewardDeliveredMessageEvent(onOfferRewardDelivered);
         _catalog.connection.addMessageEvent(_offerRewardDeliveredMessageEvent);
         _providers = new Vector.<IOfferProvider>(0);
         _providers.push(new SupersonicProvider(this));
         _providers.push(new SponsorPayProvider(this));
         var_3410 = new Vector.<OfferReward>(0);
         var_2551 = new Timer(1800000);
         var_2551.addEventListener("timer",onPollTimer);
         var_2551.start();
         onPollTimer(null);
      }
      
      private function onPollTimer(param1:TimerEvent) : void
      {
         if(_providers == null)
         {
            return;
         }
         for each(var _loc2_ in _providers)
         {
            if(_loc2_.enabled)
            {
               _loc2_.load();
            }
         }
      }
      
      private function getNextProvider() : IOfferProvider
      {
         if(_providers == null)
         {
            return null;
         }
         for each(var _loc1_ in _providers)
         {
            if(_loc1_.enabled && _loc1_.videoAvailable)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      private function onOfferRewardDelivered(param1:OfferRewardDeliveredMessageEvent) : void
      {
         var _loc2_:OfferRewardDeliveredMessageEventParser = param1.getParser();
         addReward(_loc2_.name,_loc2_.contentType,_loc2_.classId);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_providers != null)
         {
            for each(var _loc1_ in _providers)
            {
               _loc1_.dispose();
            }
            _providers = null;
         }
         if(var_2551 != null)
         {
            var_2551.stop();
            var_2551 = null;
         }
         _catalog.connection.removeMessageEvent(_offerRewardDeliveredMessageEvent);
         _offerRewardDeliveredMessageEvent = null;
         var_3410 = null;
         _offerExtension = null;
         _windowManager = null;
         _catalog = null;
         _assets = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set offerExtension(param1:IOfferExtension) : void
      {
         _offerExtension = param1;
      }
      
      public function showRewards() : void
      {
         hide();
         _window = _windowManager.buildFromXML(_assets.getAssetByName("offer_center_xml").content as XML) as IWindowContainer;
         _window.procedure = windowProcedure;
         _window.center();
         var_3556 = IItemListWindow(_window.findChildByName("reward_list")).removeListItemAt(0);
         populateRewardList();
      }
      
      public function showVideo() : void
      {
         if(var_2809 != null)
         {
            var_2809.showVideo();
         }
      }
      
      public function get showingVideo() : Boolean
      {
         return var_2809 != null && var_2809.showingPopup;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK" || !visible)
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         if(_window != null)
         {
            var_3556.dispose();
            var_3556 = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function addReward(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:OfferReward = new OfferReward(param1,param2,param3);
         var_3410.unshift(_loc4_);
         if(visible)
         {
            IItemListWindow(_window.findChildByName("reward_list")).addListItemAt(createRewardItem(_loc4_),0);
         }
         else if(_offerExtension != null)
         {
            _offerExtension.indicateRewards();
         }
      }
      
      public function get configuration() : ICoreConfiguration
      {
         return _catalog as ICoreConfiguration;
      }
      
      public function updateVideoStatus() : void
      {
         if(_offerExtension != null)
         {
            var_2809 = getNextProvider();
            _offerExtension.indicateVideoAvailable(var_2809 != null && var_2809.videoAvailable);
         }
      }
      
      private function populateRewardList() : void
      {
         if(!visible)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("reward_list") as IItemListWindow;
         _loc2_.destroyListItems();
         for each(var _loc1_ in var_3410)
         {
            _loc2_.addListItem(createRewardItem(_loc1_));
         }
      }
      
      private function createRewardItem(param1:OfferReward) : IWindow
      {
         var _loc2_:IWindowContainer = var_3556.clone() as IWindowContainer;
         _loc2_.findChildByName("reward_date").caption = new Date().toLocaleString();
         _loc2_.findChildByName("reward_name").caption = param1.name;
         _catalog.displayProductIcon(param1.contentType,param1.classId,IBitmapWrapperWindow(_loc2_.findChildByName("reward_icon")));
         return _loc2_;
      }
      
      private function get visible() : Boolean
      {
         return _window != null && !_window.disposed && Boolean(_window.visible);
      }
      
      public function showSuccess() : void
      {
      }
   }
}
