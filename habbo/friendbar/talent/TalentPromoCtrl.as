package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.talent.class_1158;
   import com.sulake.habbo.communication.messages.parser.talent.class_1313;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_556;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_1018;
   import com.sulake.habbo.communication.messages.outgoing.talent.class_330;
   import com.sulake.habbo.communication.messages.incoming.talent.class_1107;
   import com.sulake.habbo.communication.messages.incoming.talent.class_381;
   
   public class TalentPromoCtrl implements IDisposable
   {
      
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
       
      
      private var var_480:HabboTalent;
      
      private var _window:IWindowContainer;
      
      private var var_360:int;
      
      private var var_1100:int;
      
      private var var_4263:int;
      
      public function TalentPromoCtrl(param1:HabboTalent)
      {
         super();
         var_480 = param1;
      }
      
      public function dispose() : void
      {
         if(toolbarAttachAllowed())
         {
            var_480.toolbar.extensionView.detachExtension("talent_promo");
         }
         var_480 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_480 == null;
      }
      
      public function initialize() : void
      {
         if(!enabled)
         {
            return;
         }
         var_480.communicationManager.addHabboConnectionMessageEvent(new class_381(onTalentLevelUp));
         var_480.communicationManager.addHabboConnectionMessageEvent(new class_556(onUserObject));
         var_480.communicationManager.addHabboConnectionMessageEvent(new class_1107(onTalentTrackLevel));
      }
      
      private function onUserObject(param1:class_556) : void
      {
         var_480.send(new class_330(promotedTalentTrack));
      }
      
      private function onTalentTrackLevel(param1:class_1107) : void
      {
         var _loc2_:class_1313 = param1.getParser();
         if(_loc2_.talentTrackName == promotedTalentTrack)
         {
            var_1100 = _loc2_.maxLevel;
            var_360 = _loc2_.level;
            refresh();
         }
      }
      
      private function onTalentLevelUp(param1:class_381) : void
      {
         var _loc2_:class_1158 = param1.getParser();
         if(_loc2_.talentTrackName == promotedTalentTrack)
         {
            var_360 = _loc2_.level;
            refresh();
         }
      }
      
      private function refresh() : void
      {
         if(!enabled || maxLevelReached)
         {
            close();
            return;
         }
         prepareWindow();
         setText("title");
         _window.x = 0;
         _window.y = 0;
         if(toolbarAttachAllowed())
         {
            var_480.toolbar.extensionView.attachExtension("talent_promo",_window,7);
         }
      }
      
      private function setText(param1:String) : void
      {
         _window.findChildByName(param1 + "_txt").caption = "${talentpromo." + promotedTalentTrack + "." + param1 + "}";
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowContainer(var_480.getXmlWindow("track_promo"));
         _window.addEventListener("WME_CLICK",onCheckProgress);
         _window.addEventListener("WME_OVER",onContainerMouseOver);
         _window.addEventListener("WME_OUT",onContainerMouseOut);
         var_4263 = _window.height;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            if(toolbarAttachAllowed())
            {
               var_480.toolbar.extensionView.detachExtension("talent_promo");
            }
         }
      }
      
      private function onCheckProgress(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK" && enabled)
         {
            var_480.tracking.trackTalentTrackOpen(promotedTalentTrack,"talentpromo");
            var_480.send(new class_1018(promotedTalentTrack));
         }
      }
      
      private function toolbarAttachAllowed() : Boolean
      {
         return var_480 != null && var_480.toolbar != null && var_480.toolbar.extensionView != null && enabled;
      }
      
      private function get enabled() : Boolean
      {
         return promotedTalentTrack != "";
      }
      
      private function get promotedTalentTrack() : String
      {
         return var_480.getProperty("talentpromo.track");
      }
      
      private function get maxLevelReached() : Boolean
      {
         return var_360 >= var_1100;
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = 4286084205;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = 4283781966;
      }
   }
}
