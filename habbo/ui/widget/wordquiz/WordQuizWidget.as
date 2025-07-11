package com.sulake.habbo.ui.widget.wordquiz
{
   import com.sulake.core.assets.IAssetLibrary;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_3437;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.WordQuizWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetWordQuizUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import com.sulake.habbo.window.IHabboWindowManager;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class WordQuizWidget extends RoomWidgetBase
   {
      
      private static const ASSET_NAME_LIKE:String = "wordquiz_like_xml";
      
      private static const ASSET_NAME_DISLIKE:String = "wordquiz_unlike_xml";
      
      private static const SIGN_FADE_IN_TIME:int = 750;
      
      private static const SIGN_FADE_OUT_TIME:int = 750;
      
      private static const UPDATE_FREQUENCY:int = 40;
      
      public static const VALUE_KEY_DISLIKE:String = "0";
      
      public static const VALUE_KEY_LIKE:String = "1";
       
      
      private var var_1631:WordQuizView;
      
      private var var_4130:Timer;
      
      private var var_2134:Timer;
      
      private var var_1910:Timer;
      
      private var var_4758:int = 0;
      
      private var _showResultTime:int;
      
      private var _countdown:int = 0;
      
      private var var_607:int;
      
      private var var_53:Dictionary;
      
      private var var_4906:int;
      
      private var _showSignCounters:Dictionary;
      
      private var _answerWindows:Vector.<IWindowContainer>;
      
      private var var_3412:Vector.<IWindowContainer>;
      
      private var var_3398:Vector.<IWindowContainer>;
      
      private var var_3645:Boolean;
      
      public function WordQuizWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
      {
         _showSignCounters = new Dictionary();
         _answerWindows = new Vector.<IWindowContainer>(0);
         var_3412 = new Vector.<IWindowContainer>(0);
         var_3398 = new Vector.<IWindowContainer>(0);
         super(handler,param2,param3,param4);
         var_1653 = param1;
         var_1631 = new WordQuizView(this);
         _showResultTime = handler.container.config.getInteger("poll.word.quiz.answer.bubble.seconds",3) * 1000;
      }
      
      override public function get mainWindow() : IWindow
      {
         return !!var_1631 ? var_1631.mainWindow : null;
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPUW_NEW_QUESTION",newQuestion);
         param1.addEventListener("RWPUW_QUESTION_ANSWERED",answeredQuestion);
         param1.addEventListener("RWPUW_QUESION_FINSIHED",questionFinished);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPUW_NEW_QUESTION",newQuestion);
         param1.removeEventListener("RWPUW_QUESTION_ANSWERED",answeredQuestion);
         param1.removeEventListener("RWPUW_QUESION_FINSIHED",questionFinished);
         super.unregisterUpdateEvents(param1);
      }
      
      public function get handler() : WordQuizWidgetHandler
      {
         return var_1653 as WordQuizWidgetHandler;
      }
      
      override public function dispose() : void
      {
         var _loc2_:IWindowContainer = null;
         var _loc1_:int = 0;
         if(disposed)
         {
            return;
         }
         if(var_1631)
         {
            var_1631.dispose();
            var_1631 = null;
         }
         if(var_4130)
         {
            var_4130.reset();
            var_4130 = null;
         }
         if(var_2134)
         {
            var_2134.reset();
            var_2134 = null;
         }
         if(var_1910)
         {
            var_1910.reset();
            var_1910 = null;
         }
         if(windowManager)
         {
            if(_answerWindows)
            {
               _loc1_ = 0;
               while(_loc1_ < _answerWindows.length)
               {
                  _loc2_ = _answerWindows[_loc1_] as IWindowContainer;
                  if(_loc2_)
                  {
                     windowManager.removeWindow(_loc2_.name);
                  }
                  _loc1_++;
               }
            }
            for each(_loc2_ in var_3412)
            {
               _loc2_.destroy();
            }
            var_3412.length = 0;
            for each(_loc2_ in var_3398)
            {
               _loc2_.destroy();
            }
            var_3398.length = 0;
         }
         super.dispose();
      }
      
      private function newQuestion(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var_607 = param1.id;
         var_53 = param1.question;
         var_3645 = false;
         _showSignCounters = new Dictionary();
         showNewQuestion(var_53,param1.duration);
      }
      
      private function questionFinished(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var _loc2_:int = 0;
         clearTimers();
         if(var_1631 && var_53 && var_53.id == param1.questionId)
         {
            var_1631.displayResults(param1.answerCounts);
         }
         _loc2_ = 0;
         while(_loc2_ < _answerWindows.length)
         {
            poolWindow(_answerWindows[_loc2_].name);
            _loc2_++;
         }
         _answerWindows.length = 0;
      }
      
      private function poolWindow(param1:String) : void
      {
         if(windowManager == null)
         {
            return;
         }
         windowManager.removeWindow(param1);
      }
      
      private function answeredQuestion(param1:RoomWidgetWordQuizUpdateEvent) : void
      {
         var _loc7_:IWindowContainer = null;
         if(var_1631)
         {
            var_1631.updateResults(param1.answerCounts);
         }
         var _loc8_:int = param1.userId;
         var _loc9_:String;
         var _loc3_:Vector.<IWindowContainer> = (_loc9_ = param1.value) == "1" ? var_3412 : var_3398;
         var _loc4_:String = _loc9_ == "1" ? "wordquiz_like_xml" : "wordquiz_unlike_xml";
         var _loc5_:String = var_607 + "_" + _loc8_ + "_" + _loc4_;
         if(_loc3_.length)
         {
            _loc7_ = _loc3_.pop();
         }
         else
         {
            _loc7_ = windowManager.buildFromXML(assets.getAssetByName(_loc4_).content as XML) as IWindowContainer;
         }
         _loc7_.name = _loc5_;
         _answerWindows.push(_loc7_);
         _showSignCounters[_loc5_] = _showResultTime + 750 + 750;
         var _loc6_:Rectangle;
         if(_loc6_ = getAvatarRect(_loc8_))
         {
            _loc7_.x = _loc6_.left + 20;
            _loc7_.y = _loc6_.top - 20;
         }
         if(!var_1910)
         {
            var_1910 = new Timer(40);
            var_1910.addEventListener("timer",onLocationTimer);
            var_1910.start();
         }
         var _loc2_:class_3437 = _loc7_.getChildByName("colored") as class_3437;
         if(_loc2_)
         {
            _loc2_.blend = 0;
         }
      }
      
      private function onLocationTimer(param1:TimerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:IWindowContainer = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc4_:Rectangle = null;
         _loc3_ = 0;
         while(_loc3_ < _answerWindows.length)
         {
            if(_loc5_ = _answerWindows[_loc3_])
            {
               _loc2_ = String(_answerWindows[_loc3_].name).split("_");
               if(_loc2_.length > 1)
               {
                  _loc6_ = int(_loc2_[1]);
                  if(!(_loc4_ = getAvatarRect(_loc6_)))
                  {
                     poolWindow(_answerWindows[_loc3_].name);
                     return;
                  }
                  _loc5_.x = _loc4_.left + 29;
                  _loc5_.y = _loc4_.top - 11;
                  handleSignWindowVisibility(_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      private function handleSignWindowVisibility(param1:IWindowContainer) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:class_3437 = param1.getChildByName("colored") as class_3437;
         var _loc3_:IRegionWindow = param1.getChildByName("button_like") as IRegionWindow;
         if(_showSignCounters.hasOwnProperty(param1.name) && _loc2_ && _loc3_)
         {
            _loc4_ = (_loc4_ = int(_showSignCounters[param1.name])) - 40;
            _showSignCounters[param1.name] = _loc4_;
            if(_loc4_ > _showResultTime + 750)
            {
               _loc5_ = 0.1875;
               _loc2_.blend += _loc5_;
               _loc3_.blend = _loc2_.blend;
            }
            else if(_loc4_ > 750)
            {
               _loc2_.blend = 1;
               _loc3_.blend = 1;
            }
            else if(_loc4_ < 750 && _loc4_ > 0)
            {
               _loc5_ = 750 / 40;
               param1.blend -= _loc5_ * 0.01;
               param1.y -= 20 + (70 - param1.blend * 120);
            }
            else if(_loc4_ < 0)
            {
               param1.y -= 20 + (70 - param1.blend * 120);
               poolWindow(param1.name);
            }
         }
      }
      
      private function getAvatarRect(param1:int) : Rectangle
      {
         if(!handler || !handler.container || !handler.container.roomSession || !handler.container.roomEngine)
         {
            return null;
         }
         var _loc3_:int = handler.container.roomSession.roomId;
         var _loc2_:class_3490 = handler.container.roomSessionManager.getSession(_loc3_).userDataManager.getUserData(param1);
         if(_loc2_)
         {
            return handler.container.roomEngine.getRoomObjectBoundingRectangle(_loc3_,_loc2_.roomObjectId,100,handler.container.getFirstCanvasId());
         }
         return null;
      }
      
      private function onCountdownDownTimer(param1:TimerEvent) : void
      {
         if(var_2134 == null)
         {
            return;
         }
         _countdown--;
         var_1631.updateCounter(String(_countdown));
         if(_countdown == 0)
         {
            clearTimers();
            var_1631.removeWindow();
         }
      }
      
      private function showNewQuestion(param1:Dictionary, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         var_1631.createWindow(0,param1.content);
         var_4758++;
         _countdown = 4;
         var_4906 = param1.id;
         if(param2 > 0)
         {
            var_2134 = new Timer(1000);
            _countdown = param2 / 1000;
            var_2134.addEventListener("timer",onCountdownDownTimer);
            var_2134.start();
            var_1910 = new Timer(40);
            var_1910.addEventListener("timer",onLocationTimer);
            var_1910.start();
            var_1631.updateCounter(String(_countdown));
         }
      }
      
      private function clearTimers() : void
      {
         if(var_2134)
         {
            var_2134.reset();
            var_2134 = null;
         }
         if(var_1910)
         {
            var_1910.reset();
            var_1910 = null;
         }
      }
      
      public function sendAnswer(param1:int) : void
      {
         var_1631.removeWindow();
         if(var_3645)
         {
            return;
         }
         var _loc3_:RoomWidgetPollMessage = new RoomWidgetPollMessage("RWPM_ANSWER",var_607);
         _loc3_.questionId = var_53["id"] as int;
         var _loc2_:Array = [];
         _loc2_.push("" + param1);
         _loc3_.answers = _loc2_;
         messageListener.processWidgetMessage(_loc3_);
         var_3645 = true;
         var_1631.createWindow(1);
      }
   }
}
