package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.communication.messages.incoming.landingview.votes.class_860;
   
   public class CommunityGoalVsModeWidgetWithVoting extends CommunityGoalVsModeWidget
   {
       
      
      private var var_3482:IWindow;
      
      private var var_3537:IWindow;
      
      private var var_1570:String;
      
      public function CommunityGoalVsModeWidgetWithVoting(param1:HabboLandingView)
      {
         super(param1,true);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         var_3482 = var_1731.findChildByName("community_vote_one_button");
         var_3482.procedure = onVoteOptionOneClick;
         var_3537 = var_1731.findChildByName("community_vote_two_button");
         var_3537.procedure = onVoteOptionTwoClick;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new class_860(onInfo));
      }
      
      override public function refresh() : void
      {
         super.refresh();
         if(communityProgress != null)
         {
            if(var_3482 != null)
            {
               var_3482.visible = communityProgress.personalContributionScore == 0;
            }
            if(var_3537 != null)
            {
               var_3537.visible = communityProgress.personalContributionScore == 0;
            }
         }
      }
      
      private function onVoteOptionOneClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hideVoteButtons();
            _landingView.communityGoalVote(1);
            _landingView.tracking.trackGoogle("landingView","click_voteoption_one");
         }
      }
      
      private function onVoteOptionTwoClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hideVoteButtons();
            _landingView.communityGoalVote(2);
            _landingView.tracking.trackGoogle("landingView","click_voteoption_two");
         }
      }
      
      private function onInfo(param1:class_860) : void
      {
         if(param1.getParser().acknowledged)
         {
            hideVoteButtons();
         }
      }
      
      private function hideVoteButtons() : void
      {
         var_3482.visible = false;
         var_3537.visible = false;
      }
   }
}
