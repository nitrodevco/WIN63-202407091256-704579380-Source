package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.communication.messages.parser.quest.class_1143;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1678;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   
   public class CommunityGoalWidget implements IUpdateReceiver, ILandingViewWidget, ISettingsAwareWidget
   {
      
      private static const CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES:Array = [0,8,16,23];
      
      private static const METER_INITIAL_DELAY_MS:int = 1500;
      
      private static const METER_BUILDUP_TIME_MS:int = 1000;
       
      
      protected var _landingView:HabboLandingView;
      
      protected var var_1731:IWindowContainer;
      
      private var var_4369:IStaticBitmapWrapperWindow;
      
      protected var var_1792:class_1678;
      
      private var var_3887:Boolean = false;
      
      private var var_4128:Number = 0;
      
      private var var_2996:Number = 0;
      
      private var var_1618:Boolean = false;
      
      private var var_4165:Boolean = true;
      
      private var var_3380:Boolean = false;
      
      public function CommunityGoalWidget(param1:HabboLandingView, param2:Boolean = false)
      {
         super();
         _landingView = param1;
         var_3380 = param2;
      }
      
      public function get container() : IWindow
      {
         return var_1731;
      }
      
      public function dispose() : void
      {
         if(_landingView != null && _landingView.windowManager)
         {
            Component(_landingView.windowManager).removeUpdateReceiver(this);
         }
         _landingView = null;
         var_1731 = null;
         var_1792 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize() : void
      {
         var _loc1_:IWindow = null;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         var_1731 = IWindowContainer(var_3380 ? _landingView.getXmlWindow("community_goal_voting") : _landingView.getXmlWindow("community_goal"));
         var_4369 = IStaticBitmapWrapperWindow(var_1731.findChildByName("meter_needle"));
         if(!var_3380)
         {
            _loc1_ = var_1731.findChildByName("community_catalog_button");
            var_4165 = _landingView.getBoolean("landing.view.community.interactive");
            _loc1_.visible = var_4165;
            _loc1_.procedure = onCommunityCatalogButtonClick;
         }
         HabboLandingView.positionAfterAndStretch(var_1731,"community_title","hdr_line");
      }
      
      private function campaignizeMeterElementAssetUri(param1:IWindow) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param1);
         var _loc2_:int = _loc3_.assetUri.indexOf(".png");
         _loc3_.assetUri = _loc3_.assetUri.substr(0,_loc2_) + "_" + var_1792.goalCode + ".png";
      }
      
      protected function setCampaignLocalization(param1:String, param2:String) : void
      {
         var _loc3_:IWindow = var_1731.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.caption = "${" + param2 + "." + var_1792.goalCode + "}";
         }
      }
      
      protected function getCurrentNeedleFrame() : int
      {
         if(var_1792.communityHighestAchievedLevel >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1)
         {
            return CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1];
         }
         var _loc1_:int = int(CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[var_1792.communityHighestAchievedLevel]);
         var _loc2_:int = CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[var_1792.communityHighestAchievedLevel + 1] - _loc1_;
         return _loc1_ + Math.floor(var_1792.percentCompletionTowardsNextLevel * (_loc2_ + 0.001) / 100);
      }
      
      private function initializeLocalizations() : void
      {
         var _loc1_:int = 0;
         if(var_1792 != null && var_1792.goalCode != null)
         {
            _loc1_ = 0;
            while(_loc1_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
            {
               campaignizeMeterElementAssetUri(var_1731.findChildByName("meter_level_" + _loc1_));
               if(_loc1_ > 0)
               {
                  campaignizeMeterElementAssetUri(var_1731.findChildByName("meter_level_" + _loc1_ + "_icon"));
                  campaignizeMeterElementAssetUri(var_1731.findChildByName("meter_level_" + _loc1_ + "_icon_locked"));
               }
               _loc1_++;
            }
            setCampaignLocalization("community_title","landing.view.community.headline");
            setCampaignLocalization("goal_caption","landing.view.community.caption");
            setCampaignLocalization("goal_info","landing.view.community.info");
            setCampaignLocalization("community_catalog_button","landing.view.community_catalog_button.text");
            var_1618 = true;
         }
      }
      
      private function refreshContent() : void
      {
         var _loc3_:int = 0;
         if(var_1792 == null)
         {
            var_1731.visible = false;
            return;
         }
         if(!var_1618)
         {
            initializeLocalizations();
         }
         _loc3_ = 1;
         while(_loc3_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
         {
            var_1731.findChildByName("meter_level_" + _loc3_).visible = false;
            var_1731.findChildByName("meter_level_" + _loc3_ + "_icon").visible = false;
            var_1731.findChildByName("meter_level_" + _loc3_ + "_icon_locked").visible = false;
            _loc3_++;
         }
         var _loc2_:String = "landing.view.community.meter";
         _landingView.localizationManager.registerParameter(_loc2_,"userRank",var_1792.personalContributionRank.toString());
         _landingView.localizationManager.registerParameter(_loc2_,"userAmount",var_1792.personalContributionScore.toString());
         _landingView.localizationManager.registerParameter(_loc2_,"totalAmount",var_1792.communityTotalScore.toString());
         if(var_1792 != null && var_1792.goalCode != null)
         {
            _landingView.localizationManager.registerParameter("landing.view.community.meter." + var_1792.goalCode,"totalAmount",var_1792.communityTotalScore.toString());
            setCampaignLocalization("community_total_status","landing.view.community.meter");
            if(var_3380)
            {
               setCampaignLocalization("community_vote_one_button","landing.view.vote_one_button.text");
               setCampaignLocalization("community_vote_two_button","landing.view.vote_two_button.text");
            }
         }
         var _loc1_:ITextWindow = ITextWindow(var_1731.findChildByName("goal_info"));
         _loc1_.height = _loc1_.textHeight + 6;
         if(!var_3380)
         {
            var_1731.findChildByName("community_catalog_button").visible = var_4165;
         }
         var_1731.visible = true;
         var_1731.invalidate();
      }
      
      protected function updateMeter(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc3_ = 1;
         while(_loc3_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
         {
            _loc4_ = param2 && param1 >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_loc3_];
            var_1731.findChildByName("meter_level_" + _loc3_).visible = _loc4_;
            var_1731.findChildByName("meter_level_" + _loc3_ + "_icon").visible = _loc4_;
            var_1731.findChildByName("meter_level_" + _loc3_ + "_icon_locked").visible = !_loc4_;
            _loc3_++;
         }
         var_4369.assetUri = "landing_view_needle_meter_needle" + param1;
      }
      
      public function refresh() : void
      {
         requestCommunityGoalProgress();
         refreshContent();
      }
      
      private function requestCommunityGoalProgress() : void
      {
         if(!var_3887)
         {
            _landingView.send(new GetCommunityGoalProgressMessageComposer());
            var_3887 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         var_4128 += param1;
         if(var_4128 > 1500)
         {
            var_2996 += param1 / 1000;
            if(var_2996 > 1)
            {
               var_2996 = 1;
               Component(_landingView.windowManager).removeUpdateReceiver(this);
            }
            updateMeter(Math.floor(getCurrentNeedleFrame() * var_2996));
         }
      }
      
      private function onCommunityGoalProgress(param1:IMessageEvent) : void
      {
         var_1792 = class_1143(param1.parser).data;
         var_3887 = false;
         refreshContent();
         Component(_landingView.windowManager).registerUpdateReceiver(this,10);
      }
      
      private function onCommunityCatalogButtonClick(param1:WindowEvent, param2:IWindow) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _landingView.getProperty("landing.view.community.catalog.target");
            _landingView.catalog.openCatalogPage(_loc3_);
            _landingView.tracking.trackGoogle("landingView","click_communityCatalogTarget");
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(var_1731,param1);
      }
      
      protected function get communityProgress() : class_1678
      {
         return var_1792;
      }
   }
}
