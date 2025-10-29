package com.sulake.habbo.friendbar.landingview.widget
{
    import assets.class_14

    import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1678;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   
   public class CommunityGoalPrizesWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowContainer;
      
      private var var_47:class_1678;
      
      private var var_426:String;
      
      public function CommunityGoalPrizesWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : IWindow
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
         var_47 = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowContainer(_landingView.getXmlWindow("achievement_competition_prizes"));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
      }
      
      public function refresh() : void
      {
         refreshContent();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshContent() : void
      {
         if(var_47 == null)
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         setPrizeRankLimits(1);
         setPrizeRankLimits(2);
         setPrizeRankLimits(3);
         _landingView.localizationManager.registerParameter(getCompetitionSpecificKey("yourrankinfo"),"points","" + var_47.personalContributionScore);
         _container.findChildByName("caption_txt").caption = getCompetitionSpecificText("caption");
         _container.findChildByName("info_txt").caption = getCompetitionSpecificText("info");
         _container.findChildByName("reward_name_txt").caption = getCompetitionSpecificText("rewardname");
         _container.findChildByName("reward_info_txt").caption = getCompetitionSpecificText("rewardinfo");
         _container.findChildByName("rank_1_txt").caption = getCompetitionSpecificText("rank1");
         _container.findChildByName("rank_2_txt").caption = getCompetitionSpecificText("rank2");
         _container.findChildByName("rank_3_txt").caption = getCompetitionSpecificText("rank3");
         _container.findChildByName("user_rank_border").visible = !var_47.hasGoalExpired || var_47.personalContributionRank > 0;
         var _loc1_:String = var_47.hasGoalExpired ? "yourfinalrank" : (var_47.personalContributionRank > 0 ? "yourrank" : "youarenotranked");
         _landingView.localizationManager.registerParameter(getKey(_loc1_),"rank","" + var_47.personalContributionRank);
         _container.findChildByName("user_rank_txt").caption = getText(_loc1_);
         _container.findChildByName("user_rank_info_txt").visible = !var_47.hasGoalExpired;
         _container.findChildByName("user_rank_info_txt").caption = getCompetitionSpecificText(var_47.personalContributionRank > 0 ? "yourrankinfo" : "youarenotrankedinfo");
         IStaticBitmapWrapperWindow(_container.findChildByName("reward_image")).assetUri = "${image.library.url}reception/" + var_47.goalCode + "Reward.png";
      }
      
      private function setPrizeRankLimits(param1:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         var _loc5_:int = 1;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc5_ += resolveStartRank(param1 - _loc4_);
            _loc4_++;
         }
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc3_ += resolveEndRank(param1 - _loc4_);
            _loc4_++;
         }
         var _loc6_:String = _loc5_ == _loc3_ ? getKey("rank") : getKey("ranks");
         var _loc2_:* = _landingView.localizationManager.getLocalizationWithParams(_loc6_,"","start",_loc5_,"end",_loc3_);
         _container.findChildByName("rank_" + param1 + "_info_txt").caption = _loc2_;
      }
      
      private function resolveStartRank(param1:int) : int
      {
         return var_47.rewardUserLimits[param1 - 2];
      }
      
      private function resolveEndRank(param1:int) : int
      {
         return var_47.rewardUserLimits[param1 - 1];
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         var_47 = param1.getParser().data;
         refreshContent();
      }
      
      private function getKey(param1:String) : String
      {
         return "landing.view.competition.prizes." + param1;
      }
      
      private function getCompetitionSpecificKey(param1:String) : String
      {
         var _loc2_:String = getKey(var_47.goalCode + "." + param1);
         class_14.log("foobar: " + _loc2_);
         return _loc2_;
      }
      
      private function getCompetitionSpecificText(param1:String) : String
      {
         var _loc2_:String = getCompetitionSpecificKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function getText(param1:String) : String
      {
         var _loc2_:String = getKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         var_426 = param1.getParser().figure;
         refreshAvatarInfo();
      }
      
      private function onUserChange(param1:UserChangeMessageEvent) : void
      {
         if(param1 != null && param1.id == -1)
         {
            var_426 = param1.figure;
            refreshAvatarInfo();
         }
      }
      
      private function refreshAvatarInfo() : void
      {
         var _loc1_:IWidgetWindow = IWidgetWindow(_container.findChildByName("avatar_image"));
         var _loc2_:IAvatarImageWidget = IAvatarImageWidget(_loc1_.widget);
         _loc2_.figure = var_426;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}
