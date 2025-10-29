package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.session.product.class_1812;
   import com.sulake.habbo.window.widgets.class_3570;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.class_421;
   import com.sulake.habbo.communication.messages.incoming.catalog.LimitedOfferAppearingNextMessageEvent;
   
   public class NextLimitedRareCountdownWidget implements ILandingViewWidget, class_1812, ISettingsAwareWidget
   {
      
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;
       
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowContainer;
      
      private var var_422:int = 0;
      
      private var var_562:int;
      
      private var _offerId:int;
      
      private var var_398:String;
      
      private var _lastRequestTime:Date;
      
      private var var_2210:Timer;
      
      public function NextLimitedRareCountdownWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_2210 != null)
            {
               var_2210.stop();
               var_2210 = null;
            }
            _landingView = null;
            _container = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function initialize() : void
      {
         _container = IWindowContainer(_landingView.getXmlWindow("next_ltd_available"));
         _container.findChildByName("get").procedure = onOpenCatalogButton;
         _container.findChildByName("catalogue_button").procedure = onOpenCatalogButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new LimitedOfferAppearingNextMessageEvent(onLimitedOfferAppearingNextMessage));
         requestLimitedOfferAppearingNextMessage(null);
      }
      
      private function requestLimitedOfferAppearingNextMessage(param1:TimerEvent) : void
      {
         if(!_landingView.getBoolean("next.limited.rare.countdown.widget.disabled"))
         {
            _landingView.communicationManager.connection.send(new class_421());
         }
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 30000 < new Date().time)
         {
            requestLimitedOfferAppearingNextMessage(null);
            _lastRequestTime = new Date();
         }
      }
      
      public function get container() : IWindow
      {
         return _container;
      }
      
      public function productDataReady() : void
      {
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         if(disposed)
         {
            return;
         }
         if(_landingView.getProductData(var_398,this) != null)
         {
            _container.findChildByName("get").caption = _landingView.getProductData(var_398,this).name;
         }
         if(var_562 >= 0)
         {
            _container.visible = true;
            _container.findChildByName("get").visible = true;
            _container.findChildByName("countdown").visible = false;
         }
         else if(var_422 > 0)
         {
            _container.visible = true;
            _container.findChildByName("get").visible = false;
            _container.findChildByName("countdown").visible = true;
         }
         else
         {
            _container.visible = false;
         }
         refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:IWidgetWindow = IWidgetWindow(_container.findChildByName("countdown"));
         var _loc2_:class_3570 = class_3570(_loc1_.widget);
         _loc2_.seconds = var_422;
         _loc2_.running = true;
      }
      
      private function setModeSwitchTimer(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         if(var_2210 != null)
         {
            var_2210.stop();
            var_2210 = null;
         }
         var_2210 = new Timer((param1 + 1) * 1000,1);
         var_2210.addEventListener("timer",requestLimitedOfferAppearingNextMessage);
         var_2210.start();
      }
      
      private function onLimitedOfferAppearingNextMessage(param1:LimitedOfferAppearingNextMessageEvent) : void
      {
         var_422 = param1.getParser().appearsInSeconds;
         var_562 = param1.getParser().pageId;
         _offerId = param1.getParser().offerId;
         var_398 = param1.getParser().productType;
         refreshContent();
         setModeSwitchTimer(var_422);
      }
      
      private function onOpenCatalogButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.catalog.openCatalogPageById(var_562,_offerId,"NORMAL");
            _landingView.tracking.trackGoogle("landingView","click_goToNextLimitedCatalogPage");
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}
