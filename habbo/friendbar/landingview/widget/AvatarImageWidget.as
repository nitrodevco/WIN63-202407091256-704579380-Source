package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_337;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_556;
   
   public class AvatarImageWidget implements ILandingViewWidget
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var var_2991:IWidgetWindow;
      
      private var var_3037:class_556;
      
      private var var_3023:class_337;
      
      public function AvatarImageWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         var_3037 = new class_556(onUserObject);
         var_3023 = new class_337(onUserChange);
         _landingView.communicationManager.addHabboConnectionMessageEvent(var_3037);
         _landingView.communicationManager.addHabboConnectionMessageEvent(var_3023);
         _landingView.avatarEditor.events.addEventListener("AVATAR_FIGURE_UPDATED",onAvatarFigureUpdated);
      }
      
      public function get container() : IWindow
      {
         return var_2991;
      }
      
      public function dispose() : void
      {
         if(var_3037 != null)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(var_3037);
            var_3037 = null;
         }
         if(var_3023 != null)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(var_3023);
            var_3023 = null;
         }
         if(_landingView != null)
         {
            _landingView.avatarEditor.events.removeEventListener("AVATAR_FIGURE_UPDATED",onAvatarFigureUpdated);
            _landingView = null;
         }
         var_2991 = null;
      }
      
      public function initialize() : void
      {
         var_2991 = IWidgetWindow(_landingView.getXmlWindow("avatar_image"));
      }
      
      public function refresh() : void
      {
         refreshAvatarInfo();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onUserObject(param1:class_556) : void
      {
         refreshAvatarInfo(param1.getParser().figure);
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:class_337 = param1 as class_337;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            refreshAvatarInfo(_loc2_.figure);
         }
      }
      
      private function onAvatarFigureUpdated(param1:AvatarUpdateEvent) : void
      {
         refreshAvatarInfo(param1.figure);
      }
      
      private function refreshAvatarInfo(param1:String = null) : void
      {
         var _loc2_:IAvatarImageWidget = null;
         if(!param1 && _landingView.sessionDataManager)
         {
            param1 = _landingView.sessionDataManager.figure;
         }
         if(var_2991 != null)
         {
            _loc2_ = var_2991.widget as IAvatarImageWidget;
            if(_loc2_ != null)
            {
               _loc2_.figure = param1;
            }
         }
      }
   }
}
