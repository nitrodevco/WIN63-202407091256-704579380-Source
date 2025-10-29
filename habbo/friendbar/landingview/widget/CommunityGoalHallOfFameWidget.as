package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.communication.messages.outgoing.competition.class_1011;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToACompetitionRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalHallOfFameMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.competition.CurrentTimingCodeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1673;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1772;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1773;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFameMessageEvent;
   
   public class CommunityGoalHallOfFameWidget extends UserListWidget
   {
       
      
      private var var_47:class_1673;
      
      private var var_1372:String;
      
      public function CommunityGoalHallOfFameWidget(param1:HabboLandingView)
      {
         super(param1);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         var_1372 = landingView.getProperty("landing.view.dynamic.slot.6.conf");
      }
      
      override protected function registerMessageListeners() : void
      {
         landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalHallOfFameMessageEvent(onCommunityGoalHallOfFame));
         landingView.communicationManager.addHabboConnectionMessageEvent(new CurrentTimingCodeMessageEvent(onTimingCode));
      }
      
      override public function refresh() : void
      {
         landingView.send(new class_1011(var_1372));
      }
      
      override protected function get users() : Array
      {
         return var_47 == null ? null : var_47.hof;
      }
      
      override protected function refreshPopup(param1:class_1772, param2:IWindowContainer) : void
      {
         var _loc4_:class_1773 = class_1773(param1);
         param2.findChildByName("user_name_txt").caption = _loc4_.userName;
         var _loc3_:String = "landing.view.competition.hof.points";
         landingView.localizationManager.registerParameter(_loc3_,"points","" + _loc4_.currentScore);
         param2.findChildByName("score_txt").caption = getText(_loc3_);
         param2.findChildByName("rank_desc_txt").caption = getText("landing.view.competition.hof." + var_47.goalCode + ".rankdesc.leader");
      }
      
      override protected function getPopupXml() : String
      {
         return "competition_user_popup";
      }
      
      private function onCommunityGoalHallOfFame(param1:CommunityGoalHallOfFameMessageEvent) : void
      {
         var_47 = param1.getParser().data;
         refreshContent();
      }
      
      override protected function hasExtraLink() : Boolean
      {
         return landingView.getBoolean("landing.view.communitygoalhof.hasroomlink");
      }
      
      override protected function extraLinkClicked(param1:class_1772) : void
      {
         landingView.send(new ForwardToACompetitionRoomMessageComposer(var_47.goalCode,param1.userId));
      }
      
      private function onTimingCode(param1:CurrentTimingCodeMessageEvent) : void
      {
         var _loc2_:String = param1.getParser().code;
         if(param1.getParser().schedulingStr == var_1372 && _loc2_ != "" && !disposed)
         {
            loadConfigurationOverrides(_loc2_);
            landingView.send(new GetCommunityGoalHallOfFameMessageComposer(param1.getParser().code));
         }
      }
      
      private function loadConfigurationOverrides(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         var _loc6_:String = "landing.view." + param1 + ".avatarlist.yoffsets.array";
         if(landingView.propertyExists(_loc6_))
         {
            _loc4_ = landingView.getProperty(_loc6_).split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               _loc4_[_loc3_] = parseInt(_loc4_[_loc3_]);
               _loc3_++;
            }
            avatarOffsetsY = _loc4_;
         }
         var _loc5_:String = "landing.view." + param1 + ".avatarlist.widths.array";
         if(landingView.propertyExists(_loc5_))
         {
            _loc4_ = landingView.getProperty(_loc5_).split(",");
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               _loc4_[_loc3_] = parseInt(_loc4_[_loc3_]);
               _loc3_++;
            }
            avatarContainerWidths = _loc4_;
         }
         var _loc2_:String = "landing.view." + param1 + ".avatarlist.startoffset";
         if(landingView.propertyExists(_loc2_))
         {
            startOffset = parseInt(landingView.getProperty(_loc2_));
         }
      }
   }
}
