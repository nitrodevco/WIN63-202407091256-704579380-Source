package com.sulake.habbo.ui.widget.roomqueue
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.runtime.ICoreConfiguration;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   
   public class RoomQueueWidget extends RoomWidgetBase
   {
       
      
      private var _window:class_3514;
      
      private var _config:ICoreConfiguration;
      
      private var var_2629:int;
      
      private var var_4576:Boolean;
      
      private var var_936:String;
      
      private var var_4099:Boolean;
      
      public function RoomQueueWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:ICoreConfiguration)
      {
         super(param1,param2,param3,param4);
         _config = param5;
      }
      
      override public function dispose() : void
      {
         removeWindow();
         _config = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWRQUE_VISITOR_QUEUE_STATUS",onQueueStatus);
         param1.addEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS",onQueueStatus);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWRQUE_VISITOR_QUEUE_STATUS",onQueueStatus);
         param1.removeEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS",onQueueStatus);
      }
      
      private function removeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onQueueStatus(param1:RoomWidgetRoomQueueUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.isActive)
         {
            var_936 = param1.type;
            var_2629 = param1.position;
         }
         var_4576 = param1.hasHabboClub;
         var_4099 = param1.isClubQueue;
         localizations.registerParameter("room.queue.position","position",var_2629.toString());
         localizations.registerParameter("room.queue.position.hc","position",var_2629.toString());
         localizations.registerParameter("room.queue.spectator.position","position",var_2629.toString());
         localizations.registerParameter("room.queue.spectator.position.hc","position",var_2629.toString());
         showInterface();
      }
      
      private function createWindow() : Boolean
      {
         if(_window != null)
         {
            return true;
         }
         var _loc2_:XmlAsset = assets.getAssetByName("room_queue") as XmlAsset;
         _window = windowManager.buildFromXML(_loc2_.content as XML) as class_3514;
         if(_window == null)
         {
            return false;
         }
         _window.visible = false;
         var _loc1_:IWindow = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",exitQueue);
         }
         _loc1_ = _window.findChildByName("cancel_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",exitQueue);
         }
         _loc1_ = _window.findChildByName("link_text");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",openLink);
         }
         _loc1_ = _window.findChildByName("change_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",changeQueue);
         }
         return true;
      }
      
      private function showInterface() : void
      {
         if(!createWindow())
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ != null)
         {
            switch(var_936)
            {
               case "RWRQUE_VISITOR_QUEUE_STATUS":
                  _loc2_.caption = var_4099 ? "${room.queue.position.hc}" : "${room.queue.position}";
                  break;
               case "RWRQUE_SPECTATOR_QUEUE_STATUS":
                  _loc2_.caption = var_4099 ? "${room.queue.spectator.position.hc}" : "${room.queue.spectator.position}";
            }
         }
         var _loc1_:IWindowContainer = _window.findChildByName("club_container") as IWindowContainer;
         if(_loc1_ != null)
         {
            _loc1_.visible = !var_4576;
         }
         _window.visible = true;
      }
      
      private function exitQueue(param1:WindowMouseEvent) : void
      {
         if(messageListener == null)
         {
            return;
         }
         var _loc2_:RoomWidgetRoomQueueMessage = new RoomWidgetRoomQueueMessage("RWRQM_EXIT_QUEUE");
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
      
      private function openLink(param1:WindowMouseEvent) : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomQueueMessage("RWRQM_CLUB_LINK"));
      }
      
      private function changeQueue(param1:WindowMouseEvent) : void
      {
         var _loc2_:RoomWidgetRoomQueueMessage = null;
         if(messageListener == null)
         {
            return;
         }
         if(var_936 == "RWRQUE_VISITOR_QUEUE_STATUS")
         {
            _loc2_ = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_SPECTATOR_QUEUE");
         }
         else
         {
            _loc2_ = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_VISITOR_QUEUE");
         }
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
   }
}
