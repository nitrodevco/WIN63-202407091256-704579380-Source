package com.sulake.habbo.ui.widget.chatinput
{
    import assets.class_14

    import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.ChatInputWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomChatInputWidget extends RoomWidgetBase
   {
      
      private static const MIN_PASTE_INTERVAL_MS:int = 0;
       
      
      private var _visualization:RoomChatInputView;
      
      private var _selectedUserName:String = "";
      
      private var var_3489:Boolean = false;
      
      private var var_2023:Timer = null;
      
      private var _lastPasteTime:int;
      
      private var var_2738:RoomUI;
      
      private var var_2894:IRoomDesktop;
      
      public function RoomChatInputWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager, param5:RoomUI, param6:IRoomDesktop)
      {
         super(param1,param2,param3,param4);
         var_2738 = param5;
         var_2894 = param6;
         _visualization = new RoomChatInputView(this);
         (param1 as ChatInputWidgetHandler).widget = this;
      }
      
      public function get floodBlocked() : Boolean
      {
         return var_3489;
      }
      
      public function get roomUi() : RoomUI
      {
         return var_2738;
      }
      
      public function get handler() : ChatInputWidgetHandler
      {
         return var_1653 as ChatInputWidgetHandler;
      }
      
      override public function dispose() : void
      {
         if(_visualization != null)
         {
            _visualization.dispose();
            _visualization = null;
         }
         if(var_2023 != null)
         {
            var_2023.stop();
            var_2023 = null;
         }
         var_2738 = null;
         super.dispose();
      }
      
      public function get allowPaste() : Boolean
      {
         return getTimer() - _lastPasteTime > 0;
      }
      
      public function setLastPasteTime() : void
      {
         _lastPasteTime = getTimer();
      }
      
      public function sendChat(param1:String, param2:int, param3:String = "", param4:int = 0) : void
      {
         if(var_3489)
         {
            return;
         }
         var _loc5_:RoomWidgetChatMessage = new RoomWidgetChatMessage("RWCM_MESSAGE_CHAT",param1,param2,param3,param4);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc5_);
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onRoomObjectDeselected);
         param1.addEventListener("RWWCIDE_CHAT_INPUT_CONTENT",onChatInputUpdate);
         param1.addEventListener("RWUIUE_PEER",onUserInfo);
         param1.addEventListener("RWFCE_FLOOD_CONTROL",onFloodControl);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onRoomObjectDeselected);
         param1.removeEventListener("RWWCIDE_CHAT_INPUT_CONTENT",onChatInputUpdate);
         param1.removeEventListener("RWUIUE_PEER",onUserInfo);
         param1.removeEventListener("RWFCE_FLOOD_CONTROL",onFloodControl);
      }
      
      private function onRoomObjectDeselected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         _selectedUserName = "";
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         _selectedUserName = param1.name;
      }
      
      private function onChatInputUpdate(param1:RoomWidgetChatInputContentUpdateEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.messageType)
         {
            case "whisper":
               _loc2_ = String(localizations.getLocalization("widgets.chatinput.mode.whisper",":tell"));
               _visualization.displaySpecialChatMessage(_loc2_,param1.userName);
               break;
            case "shout":
         }
      }
      
      private function onReleaseTimerComplete(param1:TimerEvent) : void
      {
         class_14.log("Releasing flood blocking");
         var_3489 = false;
         if(_visualization != null)
         {
            _visualization.hideFloodBlocking();
         }
         var_2023 = null;
      }
      
      private function onReleaseTimerTick(param1:TimerEvent) : void
      {
         if(_visualization != null)
         {
            _visualization.updateBlockText(var_2023.repeatCount - var_2023.currentCount);
         }
      }
      
      public function checkChatInputPosition() : void
      {
         _visualization.updatePosition(null);
      }
      
      public function getFriendBarWidth() : int
      {
         if(!var_2738.friendBarView)
         {
            return 1000;
         }
         return var_2738.friendBarView.friendBarWidth;
      }
      
      public function getToolBarWidth() : int
      {
         if(!var_2738.toolbar)
         {
            return 1000;
         }
         return var_2738.toolbar.toolBarAreaWidth;
      }
      
      public function getRoomToolsWidth() : int
      {
         var _loc1_:RoomToolsWidget = var_2894.getWidget("RWE_ROOM_TOOLS") as RoomToolsWidget;
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.getWidgetAreaWidth();
      }
      
      public function get selectedUserName() : String
      {
         return _selectedUserName;
      }
      
      public function onFloodControl(param1:RoomWidgetFloodControlEvent) : void
      {
         var_3489 = true;
         class_14.log("Enabling flood blocking for " + param1.seconds + " seconds");
         if(var_2023)
         {
            var_2023.reset();
         }
         else
         {
            var_2023 = new Timer(1000,param1.seconds);
            var_2023.addEventListener("timer",onReleaseTimerTick);
            var_2023.addEventListener("timerComplete",onReleaseTimerComplete);
         }
         var_2023.start();
         if(_visualization != null)
         {
            _visualization.updateBlockText(param1.seconds);
            _visualization.showFloodBlocking();
         }
      }
      
      override public function get mainWindow() : IWindow
      {
         return _visualization.window;
      }
      
      public function hide() : void
      {
         if(mainWindow)
         {
            mainWindow.visible = false;
         }
      }
      
      public function getChatInputY() : int
      {
         return !!_visualization ? _visualization.getChatInputY() : 0;
      }
      
      public function getChatInputElements() : Array
      {
         var _loc1_:Array = null;
         if(_visualization)
         {
            _loc1_ = _visualization.getChatWindowElements();
         }
         return _loc1_;
      }
   }
}
