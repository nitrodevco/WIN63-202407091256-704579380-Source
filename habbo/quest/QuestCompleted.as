package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.OpenQuestTrackerMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetQuestsMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class QuestCompleted implements IDisposable
   {
      
      private static const const_1141:int = 2000;
      
      private static const TEXT_HEIGHT_SPACING:int = 5;
      
      private static const MIN_DESC_HEIGHT:int = 31;
       
      
      private var _window:class_3514;
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_523:class_1715;
      
      private var var_2441:Animation;
      
      private var var_3087:int;
      
      public function QuestCompleted(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         var_523 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2441)
         {
            var_2441.dispose();
            var_2441 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function onQuest(param1:class_1715) : void
      {
         close();
      }
      
      public function onQuestCancelled() : void
      {
         close();
      }
      
      public function onQuestCompleted(param1:class_1715, param2:Boolean) : void
      {
         if(param2)
         {
            prepare(param1);
            var_3087 = 2000;
         }
      }
      
      private function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function onNextQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _window.visible = false;
         _questEngine.questController.questDetails.openForNextQuest = _questEngine.getBoolean("questing.showDetailsForNextQuest");
         _questEngine.send(new OpenQuestTrackerMessageComposer());
      }
      
      private function onMoreQuests(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _window.visible = false;
            _questEngine.questController.questsList.setOpenOnQuestsEvent();
            _questEngine.send(new GetQuestsMessageComposer());
         }
      }
      
      public function prepare(param1:class_1715) : void
      {
         var_523 = param1;
         if(_window == null)
         {
            _window = class_3514(_questEngine.getXmlWindow("QuestCompletedDialog"));
            _window.findChildByTag("close").procedure = onNextQuest;
            _window.findChildByName("next_quest_button").procedure = onNextQuest;
            _window.findChildByName("more_quests_button").procedure = onMoreQuests;
            _window.findChildByName("catalog_link_region").procedure = onCatalogLink;
            var_2441 = _questEngine.getTwinkleAnimation(_window);
         }
         _window.findChildByName("catalog_link_txt").caption = _questEngine.localization.getLocalizationWithParams("quests.completed.cataloglink","","currencyname",_questEngine.catalog.getActivityPointName(var_523.activityPointType));
         var _loc2_:String = "quests.completed.reward";
         _questEngine.localization.registerParameter(_loc2_,"amount",var_523.rewardCurrencyAmount.toString());
         _questEngine.localization.registerParameter(_loc2_,"currencyname",_questEngine.catalog.getActivityPointName(var_523.activityPointType));
         _window.findChildByName("reward_txt").caption = _questEngine.localization.getLocalization(_loc2_,_loc2_);
         _window.findChildByName("reward_txt").visible = var_523.activityPointType >= 0 && var_523.rewardCurrencyAmount > 0;
         _window.visible = false;
         _window.findChildByName("congrats_txt").caption = _questEngine.localization.getLocalization(var_523.lastQuestInCampaign ? "quests.completed.campaign.caption" : "quests.completed.quest.caption");
         _window.findChildByName("more_quests_button").visible = var_523.lastQuestInCampaign;
         _window.findChildByName("campaign_reward_icon").visible = var_523.lastQuestInCampaign;
         _window.findChildByName("catalog_link_region").visible = !var_523.lastQuestInCampaign && var_523.rewardCurrencyAmount > 0;
         _window.findChildByName("next_quest_button").visible = !var_523.lastQuestInCampaign;
         _window.findChildByName("reward_icon").visible = !var_523.lastQuestInCampaign;
         _window.findChildByName("campaign_reward_icon").visible = var_523.lastQuestInCampaign;
         _window.findChildByName("campaign_pic_bitmap").visible = var_523.lastQuestInCampaign;
         setWindowTitle(var_523.lastQuestInCampaign ? "quests.completed.campaign.title" : "quests.completed.quest.title");
         _questEngine.setupCampaignImage(_window,param1,var_523.lastQuestInCampaign);
         var _loc5_:ITextWindow;
         var _loc3_:int = int((_loc5_ = ITextWindow(_window.findChildByName("desc_txt"))).height);
         setDesc(var_523.getQuestLocalizationKey() + ".completed");
         _loc5_.height = Math.max(31,_loc5_.textHeight + 5);
         var _loc4_:int = _loc5_.height - _loc3_;
         _window.height += _loc4_;
      }
      
      private function setWindowTitle(param1:String) : void
      {
         _questEngine.localization.registerParameter(param1,"category",_questEngine.getCampaignName(var_523));
         _window.caption = _questEngine.localization.getLocalization(param1,param1);
      }
      
      private function setDesc(param1:String) : void
      {
         _window.findChildByName("desc_txt").caption = _questEngine.localization.getLocalization(param1,param1);
      }
      
      private function onCatalogLink(param1:WindowEvent, param2:IWindow = null) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.openCatalog(var_523);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_3087 > 0)
         {
            var_3087 -= param1;
            if(var_3087 < 1)
            {
               _window.center();
               _window.visible = true;
               _window.activate();
               if(var_523.lastQuestInCampaign)
               {
                  var_2441.restart();
               }
               else
               {
                  var_2441.stop();
               }
            }
         }
         if(var_2441 != null)
         {
            var_2441.update(param1);
         }
      }
   }
}
