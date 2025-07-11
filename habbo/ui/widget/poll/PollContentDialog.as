package com.sulake.habbo.ui.widget.poll
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
   import com.sulake.habbo.communication.messages.parser.poll.class_1664;
   import com.sulake.habbo.communication.messages.parser.poll.class_1687;
   
   public class PollContentDialog implements class_3685
   {
       
      
      private var var_280:int = -1;
      
      private var _disposed:Boolean = false;
      
      private var _window:class_3514;
      
      private var var_1629:PollWidget;
      
      private var var_2020:class_3514;
      
      private var var_4645:Boolean = false;
      
      private var var_2400:Array;
      
      private var var_53:int = -1;
      
      private var var_3315:int = 0;
      
      private var var_3497:int = -1;
      
      private var var_782:Boolean = false;
      
      private var var_2940:int = 0;
      
      private var var_2180:class_1664 = null;
      
      public function PollContentDialog(param1:int, param2:String, param3:Array, param4:PollWidget, param5:Boolean)
      {
         var _loc8_:ITextWindow = null;
         var _loc7_:IWindow = null;
         var _loc9_:IWindow = null;
         var _loc6_:IWindow = null;
         super();
         var_280 = param1;
         var_2400 = param3;
         var_1629 = param4;
         var_782 = param5;
         answerableQuestionCount();
         var _loc10_:XmlAsset;
         if((_loc10_ = var_1629.assets.getAssetByName("poll_question") as XmlAsset) != null)
         {
            _window = var_1629.windowManager.buildFromXML(_loc10_.content as XML) as class_3514;
            if(_loc8_ = _window.findChildByName("poll_question_headline") as ITextWindow)
            {
               _loc8_.text = param2;
            }
            _window.center();
            if((_loc7_ = _window.findChildByName("header_button_close")) != null)
            {
               _loc7_.addEventListener("WME_CLICK",onClose);
            }
            if((_loc9_ = _window.findChildByName("poll_question_button_ok")) != null)
            {
               _loc9_.addEventListener("WME_CLICK",onOk);
            }
            if((_loc6_ = _window.findChildByName("poll_question_cancel")) != null)
            {
               _loc6_.addEventListener("WME_CLICK",onCancel);
            }
         }
      }
      
      public function start() : void
      {
         if(!var_4645)
         {
            var_4645 = true;
            nextQuestion();
         }
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         showCancelConfirm();
      }
      
      private function onOk(param1:WindowEvent) : void
      {
         answerPollQuestion();
      }
      
      private function onCancel(param1:WindowEvent) : void
      {
         showCancelConfirm();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_2020)
         {
            var_2020.dispose();
            var_2020 = null;
         }
         var_1629 = null;
         var_2400 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function nextQuestion() : void
      {
         var _loc5_:ITextWindow = null;
         var _loc1_:IWindowContainer = null;
         var _loc2_:String = null;
         var _loc4_:IItemListWindow = null;
         var _loc3_:int = 0;
         var_2180 = getNextQuestion();
         if(var_2180)
         {
            if(_window != null)
            {
               if((_loc5_ = _window.findChildByName("poll_question_text") as ITextWindow) != null)
               {
                  _loc5_.text = var_2180.questionText;
               }
               if((_loc5_ = _window.findChildByName("poll_question_number") as ITextWindow) != null)
               {
                  _loc5_.text = "${poll_question_number}";
                  _loc2_ = _loc5_.text;
                  _loc2_ = _loc2_.replace("%number%",var_53 + 1);
                  _loc2_ = _loc2_.replace("%count%",var_3315);
                  _loc5_.text = _loc2_;
               }
               _loc1_ = _window.findChildByName("poll_question_answer_container") as IWindowContainer;
               if(_loc1_ != null)
               {
                  while(_loc1_.numChildren > 0)
                  {
                     _loc1_.getChildAt(0).dispose();
                  }
                  _loc1_.invalidate();
               }
               switch(var_2180.questionType - 1)
               {
                  case 0:
                     populateRadionButtonType(_loc1_,var_2180.questionChoices);
                     break;
                  case 1:
                     populateCheckBoxType(_loc1_,var_2180.questionChoices);
                     break;
                  case 2:
                     populateTextLineType(_loc1_);
                     break;
                  case 3:
                     populateTextAreaType(_loc1_);
                     break;
                  default:
                     nextQuestion();
               }
               if((_loc4_ = _window.findChildByName("poll_content_wrapper") as IItemListWindow) != null)
               {
                  _loc3_ = _loc4_.scrollableRegion.height - _loc4_.visibleRegion.height;
                  _window.height += _loc3_;
                  _window.center();
               }
            }
         }
         else
         {
            var_1629.pollFinished(var_280);
         }
      }
      
      private function getNextQuestion() : class_1664
      {
         var _loc1_:class_1664 = null;
         var _loc3_:int = 0;
         var _loc2_:class_1664 = null;
         if(var_782 && var_3497 >= 0 && var_2940 != 0)
         {
            _loc1_ = var_2400[var_3497];
            _loc3_ = 0;
            while(_loc3_ < _loc1_.children.length)
            {
               _loc2_ = _loc1_.children[_loc3_];
               if(_loc2_ && _loc2_.questionCategory == var_2940)
               {
                  var_3497 = -1;
                  return _loc2_;
               }
               _loc3_++;
            }
         }
         var_53++;
         if(var_53 < var_2400.length)
         {
            var_3497 = var_53;
            return var_2400[var_53];
         }
         return null;
      }
      
      private function populateRadionButtonType(param1:IWindowContainer, param2:Vector.<class_1687>) : void
      {
         var _loc3_:XmlAsset = var_1629.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_radiobutton_input\"!");
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = var_1629.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer) != null)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function resolveRadionButtonTypeAnswer(param1:class_1664) : Array
      {
         var _loc3_:ISelectorWindow = null;
         var _loc4_:ISelectableWindow = null;
         var _loc5_:class_1687 = null;
         var _loc2_:Array = [];
         if(_window != null)
         {
            _loc3_ = _window.findChildByName("poll_answer_selector") as ISelectorWindow;
            if(_loc3_)
            {
               if(_loc4_ = _loc3_.getSelected())
               {
                  _loc5_ = param1.questionChoices[_loc4_.id];
                  if(var_782)
                  {
                     var_2940 = _loc5_.choiceType;
                  }
                  else
                  {
                     var_2940 = 0;
                  }
                  _loc2_.push(_loc5_.value);
               }
            }
         }
         return _loc2_;
      }
      
      private function populateCheckBoxType(param1:IWindowContainer, param2:Vector.<class_1687>) : void
      {
         var _loc3_:XmlAsset = var_1629.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset;
         if(!_loc3_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_checkbox_input\"!");
         }
         var _loc4_:IWindowContainer;
         if((_loc4_ = var_1629.windowManager.buildFromXML(_loc3_.content as XML) as IWindowContainer) != null)
         {
            populateSelectionList(param2,_loc4_);
            param1.addChild(_loc4_);
         }
      }
      
      private function resolveCheckBoxTypeAnswer(param1:class_1664) : Array
      {
         var _loc5_:IItemListWindow = null;
         var _loc3_:int = 0;
         var _loc6_:IWindowContainer = null;
         var _loc4_:class_3398 = null;
         var _loc2_:Array = [];
         if(_window != null)
         {
            if((_loc5_ = _window.findChildByName("poll_answer_itemlist") as IItemListWindow) != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc5_.numListItems)
               {
                  if((_loc6_ = _loc5_.getListItemAt(_loc3_) as IWindowContainer) != null)
                  {
                     if((_loc4_ = _loc6_.findChildByName("poll_answer_checkbox") as class_3398) != null)
                     {
                        if(_loc4_.testStateFlag(8))
                        {
                           _loc2_.push(param1.questionChoices[_loc3_].value);
                        }
                     }
                  }
                  _loc3_++;
               }
            }
         }
         return _loc2_;
      }
      
      private function populateSelectionList(param1:Vector.<class_1687>, param2:IWindowContainer) : void
      {
         var _loc7_:IWindowContainer = null;
         var _loc4_:int = 0;
         var _loc5_:ITextWindow = null;
         var _loc3_:IWindow = null;
         var _loc6_:IItemListWindow;
         if((_loc6_ = param2.findChildByName("poll_answer_itemlist") as IItemListWindow) != null)
         {
            if((_loc7_ = param2.findChildByName("poll_answer_entity") as IWindowContainer) != null)
            {
               _loc4_ = 0;
               while(_loc4_ < param1.length - 1)
               {
                  _loc4_++;
                  _loc6_.addListItem(_loc7_.clone());
               }
               _loc4_ = 0;
               while(_loc4_ < param1.length)
               {
                  if(_loc5_ = (_loc7_ = _loc6_.getListItemAt(_loc4_) as IWindowContainer).findChildByName("poll_answer_entity_text") as ITextWindow)
                  {
                     _loc5_.text = param1[_loc4_].choiceText;
                  }
                  _loc3_ = _loc7_.findChildByTag("POLL_SELECTABLE_ITEM");
                  if(_loc3_)
                  {
                     _loc3_.id = _loc4_;
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      private function populateTextLineType(param1:IWindowContainer) : void
      {
         var _loc2_:XmlAsset = var_1629.assets.getAssetByName("poll_answer_text_input") as XmlAsset;
         if(!_loc2_)
         {
            throw new Error("Asset for poll widget hot found: \"poll_answer_text_input\"!");
         }
         param1.addChild(var_1629.windowManager.buildFromXML(_loc2_.content as XML));
      }
      
      private function resolveTextLineTypeAnswer() : Array
      {
         var _loc2_:ITextWindow = null;
         var _loc1_:Array = [];
         if(_window != null)
         {
            _loc2_ = _window.findChildByName("poll_answer_input") as ITextWindow;
            if(_loc2_ != null)
            {
               _loc1_.push(_loc2_.text);
            }
            return _loc1_;
         }
         throw new Error("Invalid or disposed poll dialog!");
      }
      
      private function populateTextAreaType(param1:IWindowContainer) : void
      {
         populateTextLineType(param1);
      }
      
      private function resolveTextAreaTypeAnswer() : Array
      {
         return resolveTextLineTypeAnswer();
      }
      
      private function cancelPoll() : void
      {
         var_1629.pollCancelled(var_280);
      }
      
      private function answerPollQuestion() : void
      {
         var answerArray:Array;
         var answers:Array;
         var message:RoomWidgetPollMessage;
         var answerValue:int;
         var question:class_1664 = null;
         if(var_782 && var_2180)
         {
            question = var_2180;
         }
         else
         {
            question = var_2400[var_53];
         }
         var_2940 = 0;
         switch(question.questionType - 1)
         {
            case 0:
               answerArray = resolveRadionButtonTypeAnswer(question);
               break;
            case 1:
               answerArray = resolveCheckBoxTypeAnswer(question);
               if(answerArray.length < 0)
               {
                  var_1629.windowManager.alert("${win_error}","${poll_alert_answer_missing}",0,function(param1:class_3348, param2:WindowEvent):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               if(answerArray.length > question.questionChoices.length)
               {
                  var_1629.windowManager.alert("${win_error}","${poll_alert_invalid_selection}",0,function(param1:class_3348, param2:WindowEvent):void
                  {
                     param1.dispose();
                  });
                  return;
               }
               break;
            case 2:
               answerArray = resolveTextLineTypeAnswer();
               break;
            case 3:
               answerArray = resolveTextAreaTypeAnswer();
               break;
            default:
               throw new Error("Unknown poll question type: " + question.questionType + "!");
         }
         answers = [];
         message = new RoomWidgetPollMessage("RWPM_ANSWER",var_280);
         message.questionId = question.questionId;
         if(question.questionChoices.length > 0)
         {
            for each(answerValue in answerArray)
            {
               answers.push(answerValue);
            }
         }
         else
         {
            answers.push(answerArray);
         }
         message.answers = answers;
         var_1629.messageListener.processWidgetMessage(message);
         nextQuestion();
      }
      
      private function showCancelConfirm() : void
      {
         var _loc4_:XmlAsset = null;
         var _loc2_:IWindow = null;
         var _loc3_:IWindow = null;
         var _loc1_:IWindow = null;
         if(!var_2020)
         {
            _loc4_ = var_1629.assets.getAssetByName("poll_cancel_confirm") as XmlAsset;
            var_2020 = var_1629.windowManager.buildFromXML(_loc4_.content as XML,2) as class_3514;
            var_2020.center();
            _loc2_ = var_2020.findChildByName("header_button_close");
            if(_loc2_ != null)
            {
               _loc2_.addEventListener("WME_CLICK",onCancelPollClose);
            }
            _loc3_ = var_2020.findChildByName("poll_cancel_confirm_button_ok");
            if(_loc3_ != null)
            {
               _loc3_.addEventListener("WME_CLICK",onCancelPollOk);
            }
            _loc1_ = var_2020.findChildByName("poll_cancel_confirm_button_cancel");
            if(_loc1_ != null)
            {
               _loc1_.addEventListener("WME_CLICK",onCancelPollCancel);
            }
         }
      }
      
      private function hideCancelConfirm() : void
      {
         if(var_2020 != null)
         {
            var_2020.dispose();
            var_2020 = null;
         }
      }
      
      private function onCancelPollClose(param1:WindowEvent) : void
      {
         hideCancelConfirm();
      }
      
      private function onCancelPollOk(param1:WindowEvent) : void
      {
         hideCancelConfirm();
         cancelPoll();
      }
      
      private function onCancelPollCancel(param1:WindowEvent) : void
      {
         hideCancelConfirm();
      }
      
      private function answerableQuestionCount() : void
      {
         var_3315 = var_2400.length;
         for each(var _loc1_ in var_2400)
         {
            if(_loc1_.children.length > 0)
            {
               var_3315++;
            }
         }
      }
   }
}
