package com.sulake.habbo.ui.widget.furniture.placeholder
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class PlaceholderWidget extends RoomWidgetBase
   {
       
      
      private var var_1631:PlaceholderView;
      
      public function PlaceholderWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWSPE_SHOW_PLACEHOLDER",onShowEvent);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSPE_SHOW_PLACEHOLDER",onShowEvent);
      }
      
      private function onShowEvent(param1:RoomWidgetShowPlaceholderEvent) : void
      {
         showInterface();
      }
      
      private function showInterface() : void
      {
         if(var_1631 == null)
         {
            var_1631 = new PlaceholderView(assets,windowManager);
         }
         var_1631.showWindow();
      }
      
      private function hideInterface() : void
      {
         if(var_1631 != null)
         {
            var_1631.dispose();
            var_1631 = null;
         }
      }
   }
}
