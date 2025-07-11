package com.sulake.habbo.quest
{
    import assets.class_14

    import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.catalog.purse.class_3473;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.quest.events.QuestCompletedEvent;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1109;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_470;
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_854;
   import com.sulake.habbo.communication.messages.incoming.room.session.class_640;
   import com.sulake.habbo.communication.messages.parser.handshake.class_1142;
   import com.sulake.habbo.communication.messages.parser.quest.class_1231;
   import com.sulake.habbo.communication.messages.parser.quest.class_1265;
   import com.sulake.habbo.communication.messages.parser.quest.class_1414;
   import com.sulake.habbo.communication.messages.parser.quest.class_1536;
   import com.sulake.habbo.communication.messages.parser.quest.class_1593;
   import com.sulake.habbo.communication.messages.parser.notifications.class_1271;
   import com.sulake.habbo.communication.messages.parser.game.lobby.class_1506;
   import com.sulake.habbo.communication.messages.parser.game.lobby.class_1572;
   import com.sulake.habbo.communication.messages.parser.game.lobby.class_1622;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1430;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1433;
   import com.sulake.habbo.communication.messages.parser.inventory.achievements.class_1525;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_198;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_333;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_510;
   import com.sulake.habbo.communication.messages.incoming.room.engine.class_762;
   import com.sulake.habbo.communication.messages.incoming.notifications.class_205;
   import com.sulake.habbo.communication.messages.incoming.notifications.class_289;
   import com.sulake.habbo.communication.messages.incoming.notifications.class_469;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.users.class_1057;
   import com.sulake.habbo.communication.messages.incoming.game.lobby.class_1012;
   import com.sulake.habbo.communication.messages.incoming.game.lobby.class_494;
   import com.sulake.habbo.communication.messages.incoming.game.lobby.class_894;
   import com.sulake.habbo.communication.messages.incoming.handshake.class_474;
   import com.sulake.habbo.communication.messages.incoming.competition.class_394;
   import com.sulake.habbo.communication.messages.incoming.competition.class_692;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_540;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1001;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1016;
   import com.sulake.habbo.communication.messages.incoming.quest.class_345;
   import com.sulake.habbo.communication.messages.incoming.quest.class_907;
   import com.sulake.habbo.communication.messages.incoming.quest.class_983;
   
   [SecureSWF(rename="true")]
   public class class_3353 implements IDisposable
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_4202:class_3348;
      
      private var var_318:Boolean = false;
      
      public function class_3353(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         var _loc2_:IHabboCommunicationManager = _questEngine.communication;
         _loc2_.addHabboConnectionMessageEvent(new class_494(onAchievementResolutionProgress));
         _loc2_.addHabboConnectionMessageEvent(new class_474(onIsFirstLoginOfDay));
         _loc2_.addHabboConnectionMessageEvent(new class_198(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_983(onQuest));
         _loc2_.addHabboConnectionMessageEvent(new class_289(onActivityPoints));
         _loc2_.addHabboConnectionMessageEvent(new class_894(onAchievementResolutions));
         _loc2_.addHabboConnectionMessageEvent(new class_510(onRoomEnter));
         _loc2_.addHabboConnectionMessageEvent(new class_205(onLevelUp));
         _loc2_.addHabboConnectionMessageEvent(new class_333(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_1012(onAchievementResolutionCompleted));
         _loc2_.addHabboConnectionMessageEvent(new class_394(onCompetitionVotingInfo));
         _loc2_.addHabboConnectionMessageEvent(new class_1001(onQuestCancelled));
         _loc2_.addHabboConnectionMessageEvent(new class_1109(onAchievementsScore));
         _loc2_.addHabboConnectionMessageEvent(new class_640(onRoomExit));
         _loc2_.addHabboConnectionMessageEvent(new class_1057(onSubscriptionUserInfoEvent));
         _loc2_.addHabboConnectionMessageEvent(new class_540(onRoomSettingsSaved));
         _loc2_.addHabboConnectionMessageEvent(new class_469(onActivityPointsNotification));
         _loc2_.addHabboConnectionMessageEvent(new class_854(onAchievement));
         _loc2_.addHabboConnectionMessageEvent(new class_762(onFurnisChanged));
         _loc2_.addHabboConnectionMessageEvent(new class_907(onQuests));
         _loc2_.addHabboConnectionMessageEvent(new class_345(onSeasonalQuests));
         _loc2_.addHabboConnectionMessageEvent(new class_470(onAchievements));
         _loc2_.addHabboConnectionMessageEvent(new class_692(onCompetitionEntrySubmitResult));
         _loc2_.addHabboConnectionMessageEvent(new class_1016(onQuestCompleted));
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function onQuestCompleted(param1:IMessageEvent) : void
      {
         var _loc2_:class_1414 = (param1 as class_1016).getParser();
         class_14.log("Quest Completed: " + _loc2_.questData.campaignCode + " quest: " + _loc2_.questData.id);
         _questEngine.questController.onQuestCompleted(_loc2_.questData,_loc2_.showDialog);
         if(_questEngine.isSeasonalQuest(_loc2_.questData))
         {
            _questEngine.events.dispatchEvent(new QuestCompletedEvent("qce_seasonal",_loc2_.questData));
         }
      }
      
      private function onQuestCancelled(param1:IMessageEvent) : void
      {
         var _loc2_:class_1536 = class_1001(param1).getParser();
         class_14.log("Quest Cancelled: " + _loc2_.quest.id);
         _questEngine.questController.onQuestCancelled(_loc2_.quest.campaignChainCode);
         if(_loc2_.expired)
         {
            _questEngine.windowManager.alert("${quests.expired.title}","${quests.expired.body}",0,null);
         }
      }
      
      private function onQuests(param1:IMessageEvent) : void
      {
         var _loc2_:class_1265 = (param1 as class_907).getParser();
         class_14.log("Got Quests: " + _loc2_.quests + ", " + _loc2_.openWindow);
         _questEngine.events.dispatchEvent(new QuestsListEvent("qu_quests",_loc2_.quests,_loc2_.openWindow));
      }
      
      private function onSeasonalQuests(param1:IMessageEvent) : void
      {
         var _loc2_:class_1593 = (param1 as class_345).getParser();
         class_14.log("Got seasonal Quests: " + _loc2_.quests);
         _questEngine.events.dispatchEvent(new QuestsListEvent("qe_quests_seasonal",_loc2_.quests,true));
      }
      
      private function onQuest(param1:IMessageEvent) : void
      {
         var _loc2_:class_1231 = (param1 as class_983).getParser();
         class_14.log("Got Quest: " + _loc2_.quest);
         _questEngine.questController.onQuest(_loc2_.quest);
      }
      
      public function dispose() : void
      {
         if(var_4202)
         {
            var_4202.dispose();
            var_4202 = null;
         }
         var_318 = true;
      }
      
      private function onRoomEnter(param1:class_510) : void
      {
         _questEngine.roomCompetitionController.onRoomEnter(param1);
         _questEngine.currentlyInRoom = true;
      }
      
      private function onRoomExit(param1:IMessageEvent) : void
      {
         _questEngine.questController.onRoomExit();
         _questEngine.achievementController.onRoomExit();
         _questEngine.roomCompetitionController.onRoomExit();
         _questEngine.currentlyInRoom = false;
      }
      
      private function onFurnisChanged(param1:IMessageEvent) : void
      {
         _questEngine.roomCompetitionController.onContextChanged();
      }
      
      private function onRoomSettingsSaved(param1:IMessageEvent) : void
      {
         _questEngine.roomCompetitionController.onContextChanged();
      }
      
      private function onAchievements(param1:IMessageEvent) : void
      {
         var _loc2_:class_470 = param1 as class_470;
         var _loc3_:class_1525 = _loc2_.getParser() as class_1525;
         _questEngine.achievementController.onAchievements(_loc3_.achievements,_loc3_.defaultCategory);
      }
      
      private function onAchievementResolutions(param1:class_894) : void
      {
         var _loc2_:class_1506 = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionAchievements(_loc2_.stuffId,_loc2_.achievements,_loc2_.endTime);
      }
      
      private function onAchievementResolutionProgress(param1:class_494) : void
      {
         var _loc2_:class_1622 = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionProgress(_loc2_.stuffId,_loc2_.achievementId,_loc2_.requiredLevelBadgeCode,_loc2_.userProgress,_loc2_.totalProgress,_loc2_.endTime);
      }
      
      private function onAchievementResolutionCompleted(param1:class_1012) : void
      {
         var _loc2_:class_1572 = param1.getParser();
         _questEngine.achievementsResolutionController.onResolutionCompleted(_loc2_.badgeCode,_loc2_.stuffCode);
      }
      
      private function onAchievement(param1:IMessageEvent) : void
      {
         var _loc2_:class_854 = param1 as class_854;
         var _loc3_:class_1433 = _loc2_.getParser() as class_1433;
         _questEngine.achievementController.onAchievement(_loc3_.achievement);
         _questEngine.achievementsResolutionController.onAchievement(_loc3_.achievement);
      }
      
      private function onAchievementsScore(param1:IMessageEvent) : void
      {
         var _loc2_:class_1109 = param1 as class_1109;
         var _loc3_:class_1430 = _loc2_.getParser() as class_1430;
         _questEngine.localization.registerParameter("achievements.categories.score","score",_loc3_.score.toString());
      }
      
      private function onLevelUp(param1:IMessageEvent) : void
      {
         var _loc2_:class_205 = param1 as class_205;
         var _loc3_:class_1271 = _loc2_.getParser();
         var _loc4_:String = String(_questEngine.localization.getBadgeBaseName(_loc3_.data.badgeCode));
         _questEngine.send(new EventLogMessageComposer("Achievements",_loc4_,"Leveled","",_loc3_.data.level));
         _questEngine.achievementsResolutionController.onLevelUp(_loc3_.data);
      }
      
      private function onIsFirstLoginOfDay(param1:IMessageEvent) : void
      {
         var _loc2_:class_1142 = (param1 as class_474).getParser();
         _questEngine.setIsFirstLoginOfDay(_loc2_.isFirstLoginOfDay);
      }
      
      private function onCompetitionEntrySubmitResult(param1:class_692) : void
      {
         _questEngine.roomCompetitionController.onCompetitionEntrySubmitResult(param1);
      }
      
      private function onCompetitionVotingInfo(param1:class_394) : void
      {
         _questEngine.roomCompetitionController.onCompetitionVotingInfo(param1);
      }
      
      private function onSubscriptionUserInfoEvent(param1:class_1057) : void
      {
         if(param1.getParser().isVIP && param1.getParser().responseType == 2)
         {
            _questEngine.roomCompetitionController.sendRoomCompetitionInit();
         }
      }
      
      private function onActivityPoints(param1:IMessageEvent) : void
      {
         var _loc3_:Dictionary = class_289(param1).points;
         for each(var _loc4_ in class_3473.values())
         {
            _questEngine.questController.onActivityPoints(_loc4_,0);
         }
         for(var _loc2_ in _loc3_)
         {
            _questEngine.questController.onActivityPoints(int(_loc2_),_loc3_[_loc2_]);
         }
      }
      
      private function onActivityPointsNotification(param1:class_469) : void
      {
         _questEngine.questController.onActivityPoints(param1.type,param1.amount);
      }
   }
}
