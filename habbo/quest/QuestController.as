package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.quest.seasonalcalendar.MainWindow;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class QuestController implements IDisposable, IUpdateReceiver
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_2369:QuestsList;
      
      private var _questDetails:QuestDetails;
      
      private var var_2411:QuestCompleted;
      
      private var var_2543:NextQuestTimer;
      
      private var var_2220:MainWindow;
      
      private var _questTrackers:Map;
      
      public function QuestController(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _questTrackers = new Map();
         var_2369 = new QuestsList(_questEngine);
         _questDetails = new QuestDetails(_questEngine);
         var_2411 = new QuestCompleted(_questEngine);
         var_2543 = new NextQuestTimer(_questEngine);
         var_2220 = new MainWindow(_questEngine);
      }
      
      public function onToolbarClick() : void
      {
         if(_questEngine.isSeasonalCalendarEnabled())
         {
            var_2220.onToolbarClick();
            var_2369.close();
         }
         else
         {
            var_2369.onToolbarClick();
         }
      }
      
      private function getOrCreateTracker(param1:String, param2:Boolean = true) : QuestTracker
      {
         var _loc3_:QuestTracker = _questTrackers.getValue(param1);
         if(_loc3_ == null && param2)
         {
            _loc3_ = new QuestTracker(_questEngine);
            _questTrackers.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function getTracker(param1:String) : QuestTracker
      {
         return getOrCreateTracker(param1,false);
      }
      
      private function cleanTrackers(param1:Boolean) : void
      {
         var _loc3_:QuestTracker = null;
         var _loc4_:Array = [];
         for each(var _loc2_ in _questTrackers.getKeys())
         {
            _loc3_ = _questTrackers.getValue(_loc2_);
            if(_loc3_.canBeDisposed || param1)
            {
               _loc3_.dispose();
               _loc4_.push(_loc2_);
            }
         }
         for each(_loc2_ in _loc4_)
         {
            _questTrackers.remove(_loc2_);
         }
      }
      
      public function onQuest(param1:class_1715) : void
      {
         var _loc2_:QuestTracker = getOrCreateTracker(param1.campaignChainCode);
         _loc2_.onQuest(param1);
         if(_loc2_.campaignChainCode == null)
         {
            _questTrackers.remove(param1.campaignChainCode);
         }
         _questDetails.onQuest(param1);
         var_2411.onQuest(param1);
         var_2543.onQuest(param1);
      }
      
      public function onQuestCompleted(param1:class_1715, param2:Boolean) : void
      {
         var _loc3_:QuestTracker = getOrCreateTracker(param1.campaignChainCode);
         _loc3_.onQuestCompleted(param1,param2);
         _questDetails.onQuestCompleted(param1);
         var_2411.onQuestCompleted(param1,param2);
      }
      
      public function onQuestCancelled(param1:String) : void
      {
         var _loc2_:QuestTracker = getOrCreateTracker(param1,false);
         if(_loc2_ != null)
         {
            _loc2_.onQuestCancelled();
         }
         _questDetails.onQuestCancelled(param1);
         var_2411.onQuestCancelled();
         var_2543.onQuestCancelled();
      }
      
      public function onRoomEnter() : void
      {
         var _loc1_:String = getDefaultCampaign();
         if(_loc1_ == null || _loc1_ == "")
         {
            return;
         }
         getOrCreateTracker(_loc1_).startDefaultCampaign(_loc1_);
      }
      
      public function onRoomExit() : void
      {
         var_2369.onRoomExit();
         var_2220.onRoomExit();
         for each(var _loc1_ in _questTrackers.getValues())
         {
            _loc1_.onRoomExit();
         }
         _questDetails.onRoomExit();
         var_2543.onRoomExit();
      }
      
      public function update(param1:uint) : void
      {
         var_2411.update(param1);
         for each(var _loc2_ in _questTrackers.getValues())
         {
            _loc2_.update(param1);
         }
         var_2543.update(param1);
         var_2369.update(param1);
         _questDetails.update(param1);
         var_2220.update(param1);
         cleanTrackers(false);
      }
      
      public function dispose() : void
      {
         _questEngine = null;
         if(var_2369)
         {
            var_2369.dispose();
            var_2369 = null;
         }
         if(_questTrackers)
         {
            cleanTrackers(true);
            _questTrackers.dispose();
            _questTrackers = null;
         }
         if(_questDetails)
         {
            _questDetails.dispose();
            _questDetails = null;
         }
         if(var_2411)
         {
            var_2411.dispose();
            var_2411 = null;
         }
         if(var_2543)
         {
            var_2543.dispose();
            var_2543 = null;
         }
         if(var_2220)
         {
            var_2220.dispose();
            var_2220 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function get questsList() : QuestsList
      {
         return var_2369;
      }
      
      public function get questDetails() : QuestDetails
      {
         return _questDetails;
      }
      
      public function get seasonalCalendarWindow() : MainWindow
      {
         return var_2220;
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         if(var_2220)
         {
            var_2220.onActivityPoints(param1,param2);
         }
      }
      
      public function getDefaultCampaign() : String
      {
         var _loc1_:String = _questEngine.getProperty("questing.defaultCampaign");
         return _loc1_ == null ? "" : _loc1_;
      }
   }
}
