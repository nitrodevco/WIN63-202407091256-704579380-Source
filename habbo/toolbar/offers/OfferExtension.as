package com.sulake.habbo.toolbar.offers
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.offers.IOfferCenter;
   import com.sulake.habbo.catalog.offers.IOfferExtension;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManager;
   
   public class OfferExtension implements IOfferExtension, IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var _window:IWindowContainer;
      
      private var _toolbar:HabboToolbar;
      
      private var _offerCenter:IOfferCenter;
      
      private var var_19:IItemListWindow;
      
      public function OfferExtension(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboCatalog)
      {
         super();
         _toolbar = param1;
         _window = param2.buildFromXML(param3.getAssetByName("offer_extension_xml").content as XML) as IWindowContainer;
         _window.procedure = windowProcedure;
         _window.visible = false;
         var_19 = _window.findChildByName("list") as IItemListWindow;
         _offerCenter = param4.getOfferCenter(this);
         param1.extensionView.attachExtension("video_offers",window,8);
         refresh();
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "start_video":
               _offerCenter.showVideo();
               break;
            case "check_rewards":
               _offerCenter.showRewards();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_19 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _toolbar = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowContainer
      {
         return _window;
      }
      
      public function indicateRewards() : void
      {
         if(_window != null)
         {
            _window.visible = true;
            _window.findChildByName("check_rewards").visible = true;
            refresh();
         }
      }
      
      public function indicateVideoAvailable(param1:Boolean) : void
      {
         var _loc2_:IWindow = null;
         if(_window != null)
         {
            _window.visible ||= param1;
            _loc2_ = _window.findChildByName("start_video");
            _loc2_.visible = param1;
            if(_offerCenter.showingVideo)
            {
               _loc2_.disable();
               _loc2_.color = 10066329;
            }
            else
            {
               _loc2_.enable();
               _loc2_.color = 12932417;
            }
            refresh();
         }
      }
      
      private function refresh() : void
      {
         var_19.arrangeListItems();
         _window.visible = var_19.getListItemAt(0).visible || var_19.getListItemAt(1).visible;
         _toolbar.extensionView.refreshItemWindow();
      }
   }
}
