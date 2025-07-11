package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.FriendlyTime;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1666;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1740;
   import com.sulake.habbo.communication.messages.parser.groupforums.class_1754;
   
   public class ComposeMessageView
   {
      
      public static const SUBJECT_MIN_LENGTH:int = 10;
      
      public static const SUBJECT_MAX_LENGTH:int = 120;
      
      public static const MESSAGE_MIN_LENGTH:int = 10;
      
      public static const MESSAGE_MAX_LENGTH:int = 4000;
      
      public static const const_1158:int = 30000;
       
      
      private var var_319:GroupForumController;
      
      private var var_1747:GroupForumView;
      
      private var var_1883:Timer;
      
      private var _window:class_3514;
      
      private var var_2338:ITextFieldWindow;
      
      private var var_639:ITextFieldWindow;
      
      private var var_2264:IWindow;
      
      private var _status:IWindow;
      
      private var var_513:class_1754;
      
      private var var_2434:class_1740;
      
      private var _hasErrors:Boolean = false;
      
      private var var_3363:Boolean = false;
      
      public function ComposeMessageView(param1:GroupForumView, param2:int, param3:int, param4:class_1754, param5:class_1740, param6:class_1666)
      {
         super();
         var_1747 = param1;
         var_319 = var_1747.controller;
         var_513 = param4;
         var_2434 = param5;
         _window = class_3514(var_319.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_compose_message_xml())));
         _window.x = param2;
         var _loc7_:int = int(var_319.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc7_)
         {
            _window.x = _loc7_ - _window.width;
         }
         _window.y = param3;
         initControls(param6);
         if(_status.caption.length == 0)
         {
            _status.caption = var_319.localizationManager.getLocalization("groupforum.compose.reply_hint");
         }
         var_1883 = new Timer(1000,0);
         var_1883.addEventListener("timer",onTimerEvent);
         var_1883.start();
      }
      
      public function focus(param1:class_1754, param2:class_1740, param3:class_1666) : void
      {
         if(!var_3363)
         {
            var_513 = param1;
            if(var_2434 != null && param2 == null)
            {
               var_2338.text = "";
            }
            var_2434 = param2;
            initControls(param3);
         }
         _window.activate();
      }
      
      private function initControls(param1:class_1666) : void
      {
         var _loc3_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,var_513);
         _loc3_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc3_.addEventListener("WME_CLICK",onTopAreaClick);
         var _loc5_:IWindow = _window.findChildByName("thread_subject_header");
         var_2338 = _window.findChildByName("thread_subject") as ITextFieldWindow;
         if(var_2434)
         {
            _loc5_.caption = var_319.localizationManager.getLocalization("groupforum.compose.subject_replying_to");
            var_2338.text = var_2434.header;
            var_2338.disable();
         }
         else
         {
            _loc5_.caption = var_319.localizationManager.getLocalization("groupforum.compose.subject");
            var_2338.addEventListener("WKE_KEY_UP",onHeaderKeyUpEvent);
            var_2338.maxChars = 120;
            var_2338.enable();
         }
         var_639 = _window.findChildByName("message_text") as ITextFieldWindow;
         var_639.removeEventListener("WKE_KEY_UP",onMessageKeyUpEvent);
         var_639.addEventListener("WKE_KEY_UP",onMessageKeyUpEvent);
         var_639.maxChars = 4000;
         if(param1 != null)
         {
            addQuote(param1);
         }
         var _loc2_:IWindow = _window.findChildByName("cancel_btn");
         _loc2_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc2_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc4_:IWindow;
         (_loc4_ = _window.findChildByName("header_button_close")).removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc4_.addEventListener("WME_CLICK",onCancelButtonClick);
         var_2264 = _window.findChildByName("post_btn");
         var_2264.removeEventListener("WME_CLICK",onPostButtonClick);
         var_2264.addEventListener("WME_CLICK",onPostButtonClick);
         _status = _window.findChildByName("status_text");
         validateInputs();
      }
      
      private function addQuote(param1:class_1666) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:StringBuffer;
         (_loc4_ = new StringBuffer()).add(var_639.text);
         if(_loc4_.length > 0)
         {
            _loc4_.add("\r\r");
         }
         _loc4_.add(var_319.localizationManager.getLocalizationWithParams("groupforum.compose.reply_template","","author_name",param1.authorName,"creation_time",var_1747.getAsDaysHoursMinutes(param1.creationTimeAsSecondsAgo)));
         _loc4_.add("\r");
         var _loc5_:Array = param1.messageText.split("\r");
         var _loc6_:Boolean = false;
         for each(var _loc3_ in _loc5_)
         {
            _loc2_ = MessageListView.const_434.exec(_loc3_);
            if(_loc2_ != null)
            {
               if(!_loc6_)
               {
                  _loc6_ = true;
                  _loc4_.add("> ").add(var_319.localizationManager.getLocalization("groupforum.compose.skipped_quote")).add("\r");
               }
            }
            else
            {
               _loc4_.add("> ").add(_loc3_).add("\r");
               _loc6_ = false;
            }
         }
         _loc4_.add("\r");
         var_639.text = _loc4_.toString();
      }
      
      public function dispose() : void
      {
         var_1883.stop();
         var_1883.removeEventListener("timer",onTimerEvent);
         var_1883 = null;
         var_319.composeMessageView = null;
         _window.dispose();
         _window = null;
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         validateInputs();
      }
      
      private function onHeaderKeyUpEvent(param1:WindowKeyboardEvent) : void
      {
         validateInputs();
      }
      
      private function onMessageKeyUpEvent(param1:WindowKeyboardEvent) : void
      {
         validateInputs();
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         var_319.context.createLinkEvent("group/" + var_513.groupId);
      }
      
      private function onPostButtonClick(param1:WindowMouseEvent) : void
      {
         if(var_3363)
         {
            return;
         }
         validateInputs();
         if(_hasErrors)
         {
            return;
         }
         var_3363 = true;
         var_2338.disable();
         var_639.disable();
         var_2264.disable();
         _status.caption = var_319.localizationManager.getLocalization("groupforum.compose.posting");
         if(var_2434)
         {
            var_319.postNewMessage(var_513.groupId,var_2434.threadId,var_639.text);
         }
         else
         {
            var_319.postNewThread(var_513.groupId,var_2338.text,var_639.text);
         }
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function validateInputs() : void
      {
         var _loc1_:int = 0;
         _hasErrors = false;
         if(!var_2434)
         {
            if(var_2338.text.length <= 10)
            {
               _hasErrors = true;
               _status.caption = var_319.localizationManager.getLocalization("groupforum.compose.subject_too_short");
            }
         }
         if(!_hasErrors && var_639.text.length <= 10)
         {
            _hasErrors = true;
            _status.caption = var_319.localizationManager.getLocalization("groupforum.compose.message_too_short");
         }
         if(!_hasErrors && !var_3363)
         {
            _loc1_ = getTimer() - var_319.lastPostTime;
            if(_loc1_ < 30000)
            {
               _hasErrors = true;
               _status.caption = var_319.localizationManager.getLocalizationWithParams("groupforum.compose.post_cooldown","","time_remaining",FriendlyTime.getFriendlyTime(var_319.localizationManager,(30000 - _loc1_) / 1000 + 1,"",1));
            }
         }
         if(!var_3363 && !_hasErrors)
         {
            var_2264.enable();
            _status.caption = "";
         }
         else
         {
            var_2264.disable();
         }
      }
   }
}
