package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.window.widgets.class_3570;
   import com.sulake.habbo.communication.messages.parser.catalog.class_1621;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageWithEarliestExpiryComposer;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageWithEarliestExpiryMessageEvent;
   
   public class ExpiringCatalogPageWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;
       
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowContainer;
      
      private var _pageName:String = "";
      
      private var var_1270:int;
      
      private var var_4871:String;
      
      private var _lastRequestTime:Date;
      
      public function ExpiringCatalogPageWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : IWindow
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowContainer(_landingView.getXmlWindow("expiring_catalog_page"));
         _container.findChildByName("open_catalog_button").procedure = onOpenCatalogButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CatalogPageWithEarliestExpiryMessageEvent(onCatalogPage));
         HabboLandingView.positionAfterAndStretch(_container,"page_expiry_title","hdr_line");
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 30000 < new Date().time)
         {
            _landingView.send(new GetCatalogPageWithEarliestExpiryComposer());
            _lastRequestTime = new Date();
         }
      }
      
      private function refreshContent() : void
      {
         if(_pageName == "")
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         _container.findChildByName("page_header_txt").caption = getText("landing.view.pageexpiry","page." + _pageName,"header");
         _container.findChildByName("page_desc_txt").caption = getText("landing.view.pageexpiry","page." + _pageName,"desc");
         var _loc1_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("promo_bitmap"));
         _loc1_.assetUri = "${image.library.url}reception/catalog_teaser_" + _pageName + ".png";
         refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:IWidgetWindow = IWidgetWindow(_container.findChildByName("countdown_widget"));
         var _loc2_:class_3570 = class_3570(_loc1_.widget);
         _loc2_.seconds = var_1270;
      }
      
      private function getText(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:String = param1 + (useDefaultLocalization ? "" : "." + param2) + "." + param3;
         return "${" + _loc4_ + "}";
      }
      
      private function get useDefaultLocalization() : Boolean
      {
         return false;
      }
      
      private function onOpenCatalogButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.catalog.openCatalogPage(_pageName);
            _landingView.tracking.trackGoogle("landingView","click_goToExpiringCatalogPage");
         }
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onCatalogPage(param1:IMessageEvent) : void
      {
         var _loc2_:class_1621 = class_1621(param1.parser);
         _pageName = _loc2_.pageName;
         var_1270 = _loc2_.secondsToExpiry;
         var_4871 = _loc2_.image;
         refreshContent();
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}
