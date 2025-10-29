package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.class_3863;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.communication.messages.parser.quest.class_1363;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_1052;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_429;
   import com.sulake.habbo.communication.messages.outgoing.quest.class_823;
   import com.sulake.habbo.communication.messages.incoming.quest.class_1715;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestDailyMessageEvent;
   
   public class class_3891 implements IElementHandler, class_3863, IDisposable
   {
       
      
      private var _landingView:HabboLandingView;
      
      private var var_1629:GenericWidget;
      
      private var _window:IWindowContainer;
      
      private var _container:IWindowContainer;
      
      private var var_47:class_1715;
      
      private var var_1029:int;
      
      private var var_1400:int;
      
      private var _index:int;
      
      private var var_4485:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      private var var_556:String = "";
      
      private var var_687:String = "";
      
      public function class_3891()
      {
         super();
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
      
      public function initialize(param1:HabboLandingView, param2:IWindow, param3:Array, param4:GenericWidget) : void
      {
         var_1629 = param4;
         _landingView = param1;
         _window = param2 as IWindowContainer;
         if(param3.length > 2)
         {
            var_4485 = param3[2] == "true";
         }
         if(param3.length > 3)
         {
            param2.x = int(param3[3]);
         }
         if(param3.length > 4)
         {
            param2.y = int(param3[4]);
         }
         if(param3.length > 5)
         {
            var_556 = param3[5];
         }
         if(param3.length > 6)
         {
            var_687 = param3[6];
         }
         param1.communicationManager.addHabboConnectionMessageEvent(new QuestDailyMessageEvent(onDailyQuest));
         _container = param2 as IWindowContainer;
         _container.findChildByName("accept_button").procedure = onAcceptButton;
         _container.findChildByName("go_button").procedure = onGoButton;
         _container.findChildByName("next_quest_region").procedure = onNextQuest;
         _container.findChildByName("cancel_quest_region").procedure = onCancelQuest;
         _container.findChildByName("easy_region").procedure = onEasyRegion;
         _container.findChildByName("hard_region").procedure = onHardRegion;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _disposed = true;
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return var_4485;
      }
      
      public function refresh() : void
      {
         _index = 0;
         _landingView.send(new class_1052(true,0));
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onDailyQuest(param1:IMessageEvent) : void
      {
         var _loc2_:class_1363 = class_1363(param1.parser);
         var_47 = _loc2_.quest;
         var_1029 = _loc2_.easyQuestCount;
         var_1400 = _loc2_.hardQuestCount;
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         _container.findChildByName("caption_txt").caption = !!var_47 ? getChainSpecificText("chaincaption") : getText("landing.view.quest.currenttask.alldone.caption");
         _container.findChildByName("accept_button").visible = var_47 && !var_47.accepted;
         _container.findChildByName("next_quest_region").visible = var_47 && !var_47.accepted && (var_47.easy ? var_1029 : var_1400) > 1;
         _container.findChildByName("next_quest_txt").caption = getText("landing.view.quest.nextquest." + (var_47 && var_47.easy ? "easy" : "hard"));
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
            _landingView.send(new class_429(var_47.id));
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
            _landingView.send(new class_823());
         }
      }
      
      private function sendGetDailyQuest(param1:Boolean) : void
      {
         _landingView.send(new class_1052(param1,_index));
      }
   }
}
