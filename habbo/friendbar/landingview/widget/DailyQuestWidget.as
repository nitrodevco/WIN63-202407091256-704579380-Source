package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISlotAwareWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.class_3836;
   import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetDailyQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.ActivateQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.CancelQuestMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent;
   
   public class DailyQuestWidget implements IDisposable, ILandingViewWidget, ISlotAwareWidget, class_3836
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowContainer;
      
      private var var_47:class_1715;
      
      private var var_1029:int;
      
      private var var_1400:int;
      
      private var _index:int;
      
      private var var_4844:int;
      
      private var var_3406:int;
      
      private var var_3846:String;
      
      public function DailyQuestWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public static function moveChildrenToRow(param1:IWindowContainer, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:IWindow = null;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            (_loc5_ = param1.getChildAt(_loc3_)).x = _loc4_;
            _loc4_ += _loc5_.width + param2;
            _loc3_++;
         }
      }
      
      public function set configurationCode(param1:String) : void
      {
         var_3846 = param1;
      }
      
      public function set slot(param1:int) : void
      {
         var_3406 = param1;
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
         _container = IWindowContainer(_landingView.getXmlWindow("daily_quest"));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new QuestDailyMessageEvent(onDailyQuest));
         _container.findChildByName("accept_button").procedure = onAcceptButton;
         _container.findChildByName("go_button").procedure = onGoButton;
         _container.findChildByName("next_quest_region").procedure = onNextQuest;
         _container.findChildByName("cancel_quest_region").procedure = onCancelQuest;
         _container.findChildByName("easy_region").procedure = onEasyRegion;
         _container.findChildByName("hard_region").procedure = onHardRegion;
         var _loc1_:IWindow = _container.findChildByName("hdr_line");
         var_4844 = _loc1_.x + _loc1_.width;
         GenericWidget.configureLayout(_landingView,var_3406,var_3846,_container);
      }
      
      public function refresh() : void
      {
         _index = 0;
         _landingView.send(new GetDailyQuestMessageComposer(true,0));
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onDailyQuest(param1:IMessageEvent) : void
      {
         var _loc2_:QuestDailyMessageEventParser = QuestDailyMessageEventParser(param1.parser);
         var_47 = _loc2_.quest;
         var_1029 = _loc2_.easyQuestCount;
         var_1400 = _loc2_.hardQuestCount;
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         _container.findChildByName("caption_txt").caption = !!var_47 ? getChainSpecificText("chaincaption") : getText("landing.view.quest.currenttask.alldone.caption");
         _container.findChildByName("info_txt").caption = !!var_47 ? getChainSpecificText("chaininfo") : getText("landing.view.quest.currenttask.alldone.info");
         _container.findChildByName("accept_button").visible = var_47 && !var_47.accepted;
         _container.findChildByName("next_quest_region").visible = var_47 && !var_47.accepted && (var_47.easy ? var_1029 : var_1400) > 1;
         _container.findChildByName("next_quest_txt").caption = getText("landing.view.quest.nextquest." + (var_47 && var_47.easy ? "easy" : "hard"));
         _container.findChildByName("title_txt").caption = getText("landing.view.quest.title." + (var_47 && var_47.accepted ? "accepted" : "notaccepted"));
         HabboLandingView.positionAfterAndStretch(_container,"title_txt","hdr_line");
         _container.findChildByName("cancel_quest_region").visible = var_47 && var_47.accepted;
         _container.findChildByName("current_quest_border").visible = var_47 && var_47.accepted;
         if(var_47)
         {
            _landingView.localizationManager.registerParameter("landing.view.quest.currenttask","task",getQuestName());
         }
         var _loc1_:IWindowContainer = IWindowContainer(_container.findChildByName("difficulty_container"));
         var _loc2_:int = _loc1_.x + _loc1_.width;
         _loc1_.visible = var_47 && !var_47.accepted && var_1029 > 0 && var_1400 > 0;
         setupDifficultyText("easy_region",var_47 && !var_47.easy);
         setupDifficultyText("hard_region",var_47 && var_47.easy);
         moveChildrenToRow(_loc1_,5);
         _loc1_.width = _loc1_.findChildByName("hard_region").x + _loc1_.findChildByName("hard_region").width;
         _loc1_.x = _loc2_ - _loc1_.width;
         var _loc4_:IWindow = _container.findChildByName("hdr_line");
         var _loc3_:int = int(!!_loc1_.visible ? _loc1_.x - 5 : var_4844);
         _loc4_.width = _loc3_ - _loc4_.x;
      }
      
      private function setupDifficultyText(param1:String, param2:Boolean) : void
      {
         var _loc4_:IWindowContainer = IWindowContainer(_container.findChildByName(param1));
         var _loc3_:ITextWindow = ITextWindow(_loc4_.findChildByName("label_txt"));
         _loc3_.width = _loc3_.textWidth;
         _loc3_.underline = param2;
         _loc4_.width = _loc3_.width;
      }
      
      private function getChainSpecificKey(param1:String) : String
      {
         return "quests." + var_47.campaignCode + "." + var_47.chainCode + "." + param1;
      }
      
      private function getChainSpecificText(param1:String) : String
      {
         var _loc2_:String = getChainSpecificKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function getText(param1:String) : String
      {
         return "${" + param1 + "}";
      }
      
      private function onGoButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.goToRoom();
         }
      }
      
      private function onEasyRegion(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            sendGetDailyQuest(true);
         }
      }
      
      private function onHardRegion(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            sendGetDailyQuest(false);
         }
      }
      
      public function getQuestName() : String
      {
         var _loc1_:String = var_47.getQuestLocalizationKey() + ".name";
         return "${" + _loc1_ + "}";
      }
      
      private function onAcceptButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new ActivateQuestMessageComposer(var_47.id));
         }
      }
      
      private function onNextQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _index++;
            sendGetDailyQuest(var_47.easy);
         }
      }
      
      private function onCancelQuest(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.send(new CancelQuestMessageComposer());
         }
      }
      
      private function sendGetDailyQuest(param1:Boolean) : void
      {
         _landingView.send(new GetDailyQuestMessageComposer(param1,_index));
      }
   }
}
