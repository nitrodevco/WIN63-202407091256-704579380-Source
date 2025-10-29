package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideTicketCreationResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.help.GuideTicketResolutionMessageEvent;
   
   public class ChatReviewReporterFeedbackCtrl implements IDisposable
   {
       
      
      private var _habboHelp:HabboHelp;
      
      private var _window:class_3514;
      
      public function ChatReviewReporterFeedbackCtrl(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideTicketResolutionMessageEvent(onTicketResolved));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new GuideTicketCreationResultMessageEvent(onCreateResult));
      }
      
      public function dispose() : void
      {
         _habboHelp = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _habboHelp == null;
      }
      
      private function onTicketResolved(param1:GuideTicketResolutionMessageEvent) : void
      {
         show(param1.getParser().localizationCode);
      }
      
      private function onCreateResult(param1:GuideTicketCreationResultMessageEvent) : void
      {
         show(param1.getParser().localizationCode);
      }
      
      public function show(param1:String) : void
      {
         if(!enabled)
         {
            return;
         }
         prepare();
         setText("caption_txt",param1,"caption");
         setText("body_txt",param1,"body");
         setText("note_txt",param1,"note");
         var _loc2_:ITextWindow = ITextWindow(_window.findChildByName("caption_txt"));
         _window.findChildByName("body_txt").y = _loc2_.y + _loc2_.textHeight + 5;
         _window.visible = true;
      }
      
      private function setText(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = "guide.bully.request.reporter." + param2 + "." + param3;
         if(_habboHelp.localization.getLocalization(_loc4_,"") == "")
         {
            _loc4_ = "guide.bully.request.reporter." + param3;
         }
         _window.findChildByName(param1).caption = "${" + _loc4_ + "}";
      }
      
      private function prepare() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_3514(_habboHelp.getXmlWindow("chat_review_reporter_feedback"));
         _window.procedure = windowProcedure;
         _window.center();
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK" || _window == null || Boolean(_window.disposed))
         {
            return;
         }
         if(param2.name == "close_button" || param2.name == "header_button_close")
         {
            _window.visible = false;
         }
      }
      
      private function get enabled() : Boolean
      {
         return _habboHelp.getBoolean("chatreviewreporterfeedbackctrl.enabled");
      }
   }
}
