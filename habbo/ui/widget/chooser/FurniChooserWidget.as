package com.sulake.habbo.ui.widget.chooser
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class FurniChooserWidget extends ChooserWidgetBase
   {
       
      
      private var var_2430:ChooserView;
      
      public function FurniChooserWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(var_2430 != null)
         {
            var_2430.dispose();
            var_2430 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCE_FURNI_CHOOSER_CONTENT",onChooserContent);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onUpdateFurniChooser);
         param1.addEventListener("RWROUE_FURNI_ADDED",onUpdateFurniChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCE_FURNI_CHOOSER_CONTENT",onChooserContent);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onUpdateFurniChooser);
         param1.removeEventListener("RWROUE_FURNI_ADDED",onUpdateFurniChooser);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         if(var_2430 == null)
         {
            var_2430 = new ChooserView(this,"${widget.chooser.furni.title}");
         }
         var_2430.populate(param1.items,param1.isAnyRoomController);
      }
      
      private function onUpdateFurniChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(var_2430 == null || !var_2430.isOpen())
         {
            return;
         }
         var _loc2_:RoomWidgetRequestWidgetMessage = new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER");
         messageListener.processWidgetMessage(_loc2_);
      }
   }
}
