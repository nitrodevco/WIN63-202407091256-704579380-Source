package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   
   public class CitizenshipPopupController implements IDisposable
   {
       
      
      private var _habboTalent:HabboTalent;
      
      private var var_1907:IModalDialog;
      
      private var _disposed:Boolean;
      
      private var var_3493:RoomEntryInfoMessageEvent;
      
      private var var_4318:Boolean;
      
      public function CitizenshipPopupController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
         var_3493 = new RoomEntryInfoMessageEvent(onRoomEnter);
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(var_3493);
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:Timer = null;
         if(_habboTalent.newIdentity && !var_4318 && _habboTalent.getBoolean("new.user.citizenship.popup.enabled"))
         {
            _loc2_ = new Timer(10000,1);
            _loc2_.addEventListener("timer",onCitizenshipPopup);
            _loc2_.start();
         }
      }
      
      private function onCitizenshipPopup(param1:TimerEvent) : void
      {
         removeRoomEnterListener();
         show();
         var_4318 = true;
      }
      
      private function removeRoomEnterListener() : void
      {
         if(_habboTalent != null && !_habboTalent.disposed)
         {
            _habboTalent.communicationManager.removeHabboConnectionMessageEvent(var_3493);
         }
         var_3493 = null;
      }
      
      public function show() : void
      {
         hide();
         var_1907 = _habboTalent.getModalXmlWindow("citizenship_welcome");
         var_1907.rootWindow.procedure = onWindowEvent;
         IWindowContainer(var_1907.rootWindow).findChildByName("header_button_close").visible = false;
      }
      
      private function hide() : void
      {
         if(var_1907 != null && !var_1907.disposed)
         {
            var_1907.dispose();
            var_1907 = null;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            hide();
            removeRoomEnterListener();
            _habboTalent = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(var_1907 == null || Boolean(var_1907.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "postpone_citizenship":
               hide();
               break;
            case "show_citizenship":
               hide();
               _habboTalent.tracking.trackTalentTrackOpen("citizenship","citizenshippopup");
               _habboTalent.send(new GetTalentTrackMessageComposer("citizenship"));
         }
      }
   }
}
