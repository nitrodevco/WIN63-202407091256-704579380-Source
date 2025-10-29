package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindow;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1678;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   
   public class class_3889 extends class_3886
   {
       
      
      public function class_3889()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         param1.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
      }
      
      override public function refresh() : void
      {
         landingView.send(new GetCommunityGoalProgressMessageComposer());
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         var _loc2_:class_1678 = param1.getParser().data;
         setTimer(_loc2_.hasGoalExpired ? 0 : _loc2_.timeRemainingInSeconds);
      }
   }
}
