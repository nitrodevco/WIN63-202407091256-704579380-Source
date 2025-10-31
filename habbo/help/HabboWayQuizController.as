package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.help.QuizDataMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.help.QuizResultsMessageEventParser;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.habbo.communication.messages.incoming.help.QuizDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.QuizResultsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.help.GetQuizQuestionsComposer;
   import com.sulake.habbo.communication.messages.outgoing.help.PostQuizAnswersComposer;
   
   public class HabboWayQuizController implements IDisposable
   {
      
      private static const HABBO_WAY_QUIZ_CODE:String = "HabboWay1";
      
      private static const SAFETY_QUIZ_CODE:String = "SafetyQuiz1";
      
      private static const PAGE_QUESTION:int = 1;
      
      private static const PAGE_SUCCESS:int = 2;
      
      private static const PAGE_FAILURE:int = 3;
      
      private static const PAGE_ANALYSIS:int = 4;
       
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var var_1907:IModalDialog;
      
      private var _window:IWindowContainer;
      
      private var var_3346:IWindowContainer;
      
      private var var_2265:ISelectorListWindow;
      
      private var var_2976:ISelectableWindow;
      
      private var var_2355:IItemListWindow;
      
      private var var_2984:IWindow;
      
      private var var_561:String;
      
      private var var_350:Array;
      
      private var var_3003:Array;
      
      private var _answerOrders:Array;
      
      private var _questionIdsForWrongAnswers:Array;
      
      private var var_2180:int;
      
      public function HabboWayQuizController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new QuizDataMessageEvent(onQuizData));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new QuizResultsMessageEvent(onQuizResults));
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_3346 = null;
            var_2265 = null;
            if(var_2976 != null)
            {
               var_2976.dispose();
               var_2976 = null;
            }
            var_2355 = null;
            if(var_2984 != null)
            {
               var_2984.dispose();
               var_2984 = null;
            }
            closeWindow();
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showHabboWayQuiz() : void
      {
         _habboHelp.sendMessage(new GetQuizQuestionsComposer("HabboWay1"));
      }
      
      public function showSafetyQuiz() : void
      {
         _habboHelp.sendMessage(new GetQuizQuestionsComposer("SafetyQuiz1"));
      }
      
      private function onQuizData(param1:QuizDataMessageEvent) : void
      {
         var _loc2_:QuizDataMessageEventParser = param1.getParser();
         _habboHelp.closeHabboWay();
         _habboHelp.closeSafetyBooklet();
         showWindow(_loc2_.quizCode,_loc2_.questionIds);
      }
      
      private function onQuizResults(param1:QuizResultsMessageEvent) : void
      {
         var _loc2_:QuizResultsMessageEventParser = param1.getParser();
         _questionIdsForWrongAnswers = _loc2_.questionIdsForWrongAnswers;
         if(_questionIdsForWrongAnswers.length == 0)
         {
            showPage(2);
         }
         else
         {
            showPage(3);
         }
      }
      
      private function showWindow(param1:String, param2:Array) : void
      {
         closeWindow();
         var_1907 = _habboHelp.getModalXmlWindow("habbo_way_quiz");
         _window = IWindowContainer(var_1907.rootWindow);
         _window.procedure = onWindowEvent;
         var_3346 = IWindowContainer(_window.findChildByName("question_pane"));
         var_2265 = ISelectorListWindow(var_3346.findChildByName("answer_list"));
         var_2976 = var_2265.getSelectableAt(0);
         var_2265.removeSelectable(var_2976);
         var_2355 = IItemListWindow(_window.findChildByName("analysis_pane"));
         var_2984 = var_2355.getListItemAt(0);
         var_2355.removeListItems();
         var_2355.spacing = 4;
         var_561 = param1;
         var_350 = param2;
         var_3003 = new Array(questionCount);
         _answerOrders = new Array(questionCount);
         setCurrentQuestion(0);
         var _loc3_:IWindowContainer = IWindowContainer(IItemListWindow(var_2984).getListItemByName("explanation_container"));
         switch(var_561)
         {
            case "HabboWay1":
               IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}habboway/quiz_question.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "help_habboway_dove_on";
               IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}habboway/quiz_success.png";
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("explanation_illustration")).assetUri = "help_habboway_dove_quizz";
               break;
            case "SafetyQuiz1":
               IStaticBitmapWrapperWindow(_window.findChildByName("question_illustration")).assetUri = "${image.library.url}safetyquiz/question_illustration.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("indicator_image")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("failure_illustration")).assetUri = "${image.library.url}safetyquiz/result_failure.png";
               IStaticBitmapWrapperWindow(_window.findChildByName("success_illustration")).assetUri = "${image.library.url}safetyquiz/result_success.png";
               IStaticBitmapWrapperWindow(_loc3_.findChildByName("explanation_illustration")).assetUri = "${image.library.url}safetyquiz/safety_on.png";
         }
         showPage(1);
      }
      
      private function closeWindow() : void
      {
         _window = null;
         if(var_1907 != null)
         {
            var_1907.dispose();
            var_1907 = null;
         }
      }
      
      private function showPage(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc8_:IItemListWindow = null;
         var _loc6_:String = null;
         var _loc9_:String = null;
         _window.findChildByName("question_pane").visible = param1 == 1;
         _window.findChildByName("success_pane").visible = param1 == 2;
         _window.findChildByName("failure_pane").visible = param1 == 3;
         var_2355.visible = param1 == 4;
         _window.findChildByName("prev_next_buttons").visible = param1 == 1;
         _window.findChildByName("failure_buttons").visible = param1 == 3;
         _window.findChildByName("exit_button_container").visible = param1 == 2 || param1 == 4;
         var _loc3_:IWindow = _window.findChildByName("top_indicator");
         var _loc7_:IWindow = _window.findChildByName("indicator_image");
         switch(param1 - 1)
         {
            case 0:
               _window.caption = getFullLocalizationKey("question.title");
               _loc7_.visible = true;
               _loc3_.visible = true;
               _loc3_.caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"),"","current_page",1,"page_count",questionCount.toString());
               _loc3_.caption = getFullLocalizationKey("question.page");
               break;
            case 1:
               _window.caption = getFullLocalizationKey("success.title");
               _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
               _window.findChildByName("success_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("success.results"),"","question_count",questionCount.toString());
               _loc7_.visible = false;
               _loc3_.visible = false;
               _loc3_.caption = "";
               break;
            case 2:
               _loc5_ = var_350.length - _questionIdsForWrongAnswers.length;
               _window.caption = getFullLocalizationKey("failure.title");
               _window.findChildByName("failure_advice").caption = getFullLocalizationKey("failure.advice");
               _window.findChildByName("failure_results").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("failure.results"),"","correct_count",_loc5_.toString(),"total_count",questionCount.toString());
               _loc7_.visible = false;
               _loc3_.visible = false;
               _loc3_.caption = "";
               break;
            case 3:
               _window.caption = getFullLocalizationKey("analysis.title");
               _loc7_.visible = true;
               _loc3_.visible = true;
               _loc3_.caption = getFullLocalizationKey("analysis.top");
               for each(var _loc4_ in _questionIdsForWrongAnswers)
               {
                  _loc2_ = int(var_3003[var_350.indexOf(_loc4_)]);
                  _loc8_ = IItemListWindow(var_2984.clone());
                  _loc6_ = "${quiz." + var_561 + ".";
                  _loc9_ = "." + _loc4_ + "." + _loc2_ + "}";
                  _loc8_.getListItemByName("question").caption = _loc6_ + "question." + _loc4_ + "}";
                  IWindowContainer(_loc8_.getListItemByName("answer_container")).findChildByName("answer").caption = _loc6_ + "answer" + _loc9_;
                  IWindowContainer(_loc8_.getListItemByName("explanation_container")).findChildByName("explanation").caption = _loc6_ + "explanation" + _loc9_;
                  var_2355.addListItem(_loc8_);
               }
               IItemListWindow(var_2355.getListItemAt(var_2355.numListItems - 1)).getListItemByName("separator").dispose();
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindow) : void
      {
         if(_disposed || _window == null || param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2 is ISelectableWindow)
         {
            var_3003[var_2180] = int(param2.name);
            _window.findChildByName("next_dimmer").visible = false;
         }
         else
         {
            switch(param2.name)
            {
               case "header_button_close":
               case "exit_button":
                  closeWindow();
                  break;
               case "prev_button":
                  setCurrentQuestion(var_2180 - 1);
                  break;
               case "next_button":
                  setCurrentQuestion(var_2180 + 1);
                  break;
               case "review_button":
                  showPage(4);
            }
         }
      }
      
      private function setCurrentQuestion(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc10_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc6_:ISelectableWindow = null;
         var _loc7_:int = 0;
         var _loc5_:ISelectableWindow = null;
         var _loc9_:ISelectableWindow = null;
         if(param1 >= questionCount)
         {
            _habboHelp.sendMessage(new PostQuizAnswersComposer(var_561,var_3003));
         }
         else if(param1 >= 0)
         {
            var_2180 = param1;
            _window.findChildByName("prev_dimmer").visible = param1 <= 0;
            _window.findChildByName("next_dimmer").visible = var_3003[var_2180] == null;
            _window.findChildByName("top_indicator").caption = _habboHelp.localization.getLocalizationWithParams(getRawLocalizationKey("question.page"),"","current_page",String(param1 + 1),"page_count",questionCount.toString());
            while(var_2265.numSelectables > 0)
            {
               var_2265.removeSelectable(var_2265.getSelectableAt(0)).dispose();
            }
            _loc3_ = int(var_350[var_2180]);
            _loc10_ = [];
            var_3346.findChildByName("question").caption = "${quiz." + var_561 + ".question." + _loc3_ + "}";
            _loc2_ = 0;
            while((_loc4_ = String(_habboHelp.localization.getLocalization("quiz." + var_561 + ".answer." + _loc3_ + "." + _loc2_,""))).length > 0)
            {
               (_loc6_ = ISelectableWindow(var_2976.clone())).caption = _loc4_;
               _loc6_.name = _loc2_.toString();
               _loc10_.push(_loc6_);
               _loc2_++;
            }
            if(_answerOrders[var_2180] == null)
            {
               _answerOrders[var_2180] = [];
               _loc7_ = 0;
               while(_loc7_ < _loc2_)
               {
                  _loc5_ = _loc10_.splice(int(Math.random() * _loc10_.length),1)[0];
                  var_2265.addSelectable(_loc5_);
                  _answerOrders[var_2180].push(int(_loc5_.name));
                  _loc7_++;
               }
            }
            else
            {
               for each(var _loc8_ in _answerOrders[var_2180])
               {
                  var_2265.addSelectable(_loc10_[_loc8_]);
               }
            }
            if((_loc9_ = var_2265.getSelectableByName(String(var_3003[var_2180]))) != null)
            {
               _loc9_.select();
            }
         }
      }
      
      private function get questionCount() : int
      {
         return var_350 != null ? var_350.length : 0;
      }
      
      private function getFullLocalizationKey(param1:String) : String
      {
         return "${" + getRawLocalizationKey(param1) + "}";
      }
      
      private function getRawLocalizationKey(param1:String) : String
      {
         var _loc2_:String = var_561;
         if("HabboWay1" !== _loc2_)
         {
            return "quiz." + var_561 + "." + param1;
         }
         return "habbo.way.quiz." + param1;
      }
   }
}
