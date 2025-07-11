package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class NextQuestTimer implements IDisposable
   {
      
      public static const REFRESH_PERIOD_IN_MSECS:int = 1000;
      
      private static const TOOLBAR_EXTENSION_ID:String = "next_quest";
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var var_523:class_1715;
      
      private var _window:IWindowContainer;
      
      private var _expanded:Boolean = false;
      
      private var _msecsToRefresh:int;
      
      public function NextQuestTimer(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.toolbar.extensionView.detachExtension("next_quest");
         }
         _questEngine = null;
         var_523 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onQuestCancelled() : void
      {
         var_523 = null;
         close();
      }
      
      public function onRoomExit() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.findChildByName("more_info_region").visible = false;
            _window.findChildByName("more_info_txt").visible = false;
         }
      }
      
      public function onQuest(param1:class_1715) : void
      {
         if(param1.waitPeriodSeconds < 1)
         {
            close();
            return;
         }
         var_523 = param1;
         prepareWindow();
         refreshVisibility();
         this._window.visible = true;
         _questEngine.toolbar.extensionView.attachExtension("next_quest",_window);
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowContainer(_questEngine.getXmlWindow("NextQuestTimer"));
         _window.x = 0;
         _window.y = 0;
         _window.findChildByName("more_info_region").procedure = onMoreInfo;
         _window.findChildByName("quest_timer_expanded").procedure = onToggleExpanded;
         _window.findChildByName("quest_timer_contracted").procedure = onToggleExpanded;
         refreshVisibility();
      }
      
      private function refresh() : void
      {
         var _loc1_:int = var_523.waitPeriodSeconds;
         if(_loc1_ < 1)
         {
            close();
            var_523.waitPeriodSeconds = 0;
            _questEngine.questController.onQuest(var_523);
         }
         var _loc3_:String = FriendlyTime.getFriendlyTime(_questEngine.localization,_loc1_);
         var _loc2_:String = var_523.getCampaignLocalizationKey() + ".delayedmsg";
         _questEngine.localization.registerParameter("quests.nextquesttimer.caption.contracted","time",_loc3_);
         _questEngine.localization.registerParameter(_loc2_,"time",_loc3_);
         _window.findChildByName("quest_header_txt").caption = _questEngine.localization.getLocalization("quests.nextquesttimer.caption." + (_expanded ? "expanded" : "contracted"));
         _window.findChildByName("desc_txt").caption = _questEngine.localization.getLocalization(_loc2_,_loc2_);
      }
      
      private function refreshVisibility() : void
      {
         _window.findChildByName("quest_timer_expanded").visible = _expanded;
         _window.findChildByName("quest_timer_contracted").visible = !_expanded;
         _window.findChildByName("more_info_txt").visible = _expanded && _questEngine.currentlyInRoom;
         _window.findChildByName("more_info_region").visible = _expanded && _questEngine.currentlyInRoom;
         _window.findChildByName("quest_pic_bitmap").visible = _expanded;
         _window.findChildByName("desc_txt").visible = _expanded;
         refresh();
      }
      
      private function onMoreInfo(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _questEngine.questController.questDetails.showDetails(var_523);
         }
      }
      
      private function onToggleExpanded(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _expanded = !_expanded;
            refreshVisibility();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(_window == null || !_window.visible)
         {
            return;
         }
         _msecsToRefresh -= param1;
         if(_msecsToRefresh > 0)
         {
            return;
         }
         _msecsToRefresh = 1000;
         refresh();
      }
      
      private function getDefaultLocationX() : int
      {
         return 0;
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            _window.visible = false;
            _questEngine.toolbar.extensionView.detachExtension("next_quest");
         }
      }
      
      private function setQuestImageVisible(param1:Boolean) : void
      {
         _window.findChildByName("quest_pic_bitmap").visible = param1;
      }
   }
}
