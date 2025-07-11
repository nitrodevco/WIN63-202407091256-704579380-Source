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
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UserChooserWidget extends ChooserWidgetBase
   {
       
      
      private const STATE_USER_CHOOSER_CLOSED:int = 0;
      
      private const STATE_USER_CHOOSER_OPEN:int = 1;
      
      private var var_2189:ChooserView;
      
      public function UserChooserWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function get state() : int
      {
         if(var_2189 != null && var_2189.isOpen())
         {
            return 1;
         }
         return 0;
      }
      
      override public function initialize(param1:int = 0) : void
      {
         var _loc2_:RoomWidgetRequestWidgetMessage = null;
         super.initialize(param1);
         if(param1 == 1)
         {
            _loc2_ = new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER");
            messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         if(var_2189 != null)
         {
            var_2189.dispose();
            var_2189 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCE_USER_CHOOSER_CONTENT",onChooserContent);
         param1.addEventListener("RWROUE_USER_REMOVED",onUpdateUserChooser);
         param1.addEventListener("RWROUE_USER_ADDED",onUpdateUserChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCE_USER_CHOOSER_CONTENT",onChooserContent);
         param1.removeEventListener("RWROUE_USER_REMOVED",onUpdateUserChooser);
         param1.removeEventListener("RWROUE_USER_ADDED",onUpdateUserChooser);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         if(var_2189 == null)
         {
            var_2189 = new ChooserView(this,"${widget.chooser.user.title}");
         }
         var_2189.populate(param1.items,false);
      }
      
      private function onUpdateUserChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var delayedAction:Timer;
         var event:RoomWidgetRoomObjectUpdateEvent = param1;
         if(var_2189 == null || !var_2189.isOpen())
         {
            return;
         }
         delayedAction = new Timer(100,1);
         delayedAction.addEventListener("timer",function(param1:TimerEvent):void
         {
            if(disposed)
            {
               return;
            }
            messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER"));
         });
         delayedAction.start();
      }
   }
}
