package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.quest.QuestTracker;
   import com.sulake.habbo.quest.events.QuestCompletedEvent;
   import com.sulake.habbo.quest.events.QuestsListEvent;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   
   public class MainWindow implements IDisposable
   {
       
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_3514;
      
      private var var_2167:WindowToggle;
      
      private var _calendar:Calendar;
      
      private var var_2479:CatalogPromo;
      
      private var var_2878:RareTeaser;
      
      private var var_4743:Boolean = false;
      
      private var var_285:int;
      
      public function MainWindow(param1:HabboQuestEngine)
      {
         super();
         _questEngine = param1;
         _calendar = new Calendar(_questEngine,this);
         var_2479 = new CatalogPromo(_questEngine,this);
         var_2878 = new RareTeaser(_questEngine);
         _questEngine.events.addEventListener("qe_quests_seasonal",onSeasonalQuests);
         _questEngine.events.addEventListener("qce_seasonal",onSeasonalQuestCompleted);
      }
      
      public function dispose() : void
      {
         if(_questEngine)
         {
            _questEngine.events.removeEventListener("qe_quests_seasonal",onSeasonalQuests);
            _questEngine.events.removeEventListener("qce_seasonal",onSeasonalQuestCompleted);
            _questEngine = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2167)
         {
            var_2167.dispose();
            var_2167 = null;
         }
         if(_calendar)
         {
            _calendar.close();
            _calendar.dispose();
            _calendar = null;
         }
         if(var_2479)
         {
            var_2479.dispose();
            var_2479 = null;
         }
         if(var_2878)
         {
            var_2878.dispose();
            var_2878 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function isVisible() : Boolean
      {
         return _window && _window.visible;
      }
      
      public function close() : void
      {
         if(_calendar)
         {
            _calendar.close();
         }
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      public function onRoomExit() : void
      {
         this.close();
      }
      
      public function onToolbarClick() : void
      {
         if(!_window)
         {
            _questEngine.requestSeasonalQuests();
            return;
         }
         if(!var_2167 || var_2167.disposed)
         {
            var_2167 = new WindowToggle(_window,_window.desktop,_questEngine.requestSeasonalQuests,close);
         }
         var_2167.toggle();
      }
      
      public function getCalendarImageGalleryHost() : String
      {
         var _loc1_:String = _questEngine.getSeasonalCampaignCodePrefix();
         return _questEngine.configuration.getProperty("image.library.url") + _loc1_ + "_quest_calendar/";
      }
      
      public function onQuests(param1:Array, param2:Boolean) : void
      {
         if(!this.isVisible() && !param2)
         {
            return;
         }
         var_285 = resolveCurrentDay(param1);
         _calendar.onQuests(param1);
         refresh();
         if(param2)
         {
            this._window.visible = true;
            this._window.activate();
         }
      }
      
      private function onSeasonalQuests(param1:QuestsListEvent) : void
      {
         this.onQuests(param1.quests,true);
      }
      
      private function onSeasonalQuestCompleted(param1:QuestCompletedEvent) : void
      {
         var _loc2_:QuestTracker = _questEngine.questController.getTracker(param1.questData.campaignChainCode);
         if(_loc2_ != null)
         {
            _loc2_.forceWindowCloseAfterAnimationsFinished();
         }
         _questEngine.requestSeasonalQuests();
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         var_2479.onActivityPoints(param1,param2);
      }
      
      private function resolveCurrentDay(param1:Array) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            if(_questEngine.isSeasonalQuest(_loc3_))
            {
               _loc2_ = Math.max(_loc2_,_loc3_.sortOrder);
            }
         }
         return _loc2_;
      }
      
      private function refresh() : void
      {
         prepareWindow();
         _calendar.refresh();
         var_2479.refresh();
         var_2878.refresh();
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = class_3514(_questEngine.getXmlWindow("SeasonalCalendar"));
         var _loc1_:String = "quests." + _questEngine.getSeasonalCampaignCodePrefix() + ".title";
         _window.caption = _questEngine.localization.getLocalizationWithParams(_loc1_,_loc1_);
         _window.findChildByTag("close").procedure = onWindowClose;
         _calendar.prepare(_window);
         var_2479.prepare(_window);
         var_2878.prepare(_window);
         _window.center();
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      public function get currentDay() : int
      {
         return var_285;
      }
      
      public function get catalogPromo() : CatalogPromo
      {
         return var_2479;
      }
      
      public function update(param1:uint) : void
      {
         if(_questEngine.configuration != null && _questEngine.isFirstLoginOfDay && !var_4743 && _questEngine.isSeasonalCalendarEnabled())
         {
            _questEngine.requestSeasonalQuests();
            var_4743 = true;
         }
      }
   }
}
