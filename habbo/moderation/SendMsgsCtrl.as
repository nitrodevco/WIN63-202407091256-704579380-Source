package com.sulake.habbo.moderation
{
    import assets.class_14

    import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3514;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.class_3348;
   import com.sulake.habbo.communication.messages.parser.moderation.class_1722;
   import com.sulake.habbo.communication.messages.outgoing.moderator.class_229;
   
   public class SendMsgsCtrl implements IDisposable, ITrackedWindow
   {
      
      private static const TOPIC_ID_NOT_SELECTED:int = -999;
       
      
      private var _main:ModerationManager;
      
      private var var_2109:int;
      
      private var _targetUserName:String;
      
      private var var_3769:class_1722;
      
      private var _frame:class_3514;
      
      private var _msgSelect:class_3520;
      
      private var var_2195:ITextFieldWindow;
      
      private var _disposed:Boolean;
      
      private var _placeHolderMessage:Boolean = true;
      
      public function SendMsgsCtrl(param1:ModerationManager, param2:int, param3:String, param4:class_1722)
      {
         super();
         _main = param1;
         var_2109 = param2;
         _targetUserName = param3;
         var_3769 = param4;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_3514(_main.getXmlWindow("send_msgs"));
         _frame.caption = "Msg To: " + _targetUserName;
         _frame.findChildByName("send_message_but").procedure = onSendMessageButton;
         var_2195 = ITextFieldWindow(_frame.findChildByName("message_input"));
         var_2195.procedure = onInputClick;
         _msgSelect = class_3520(_frame.findChildByName("msgTemplatesSelect"));
         prepareMessageSelection(_msgSelect);
         _msgSelect.procedure = onSelectTemplate;
         var _loc1_:IWindow = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 2;
      }
      
      public function getId() : String
      {
         return _targetUserName;
      }
      
      public function getFrame() : class_3514
      {
         return _frame;
      }
      
      private function prepareMessageSelection(param1:class_3520) : void
      {
         class_14.log("MSG TEMPLATES: " + _main.initMsg.messageTemplates.length);
         param1.populate(_main.initMsg.messageTemplates);
      }
      
      private function onSelectTemplate(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc3_:String = String(_main.initMsg.messageTemplates[_msgSelect.selection]);
         if(_loc3_ != null)
         {
            _placeHolderMessage = false;
            var_2195.text = _loc3_;
         }
      }
      
      private function onSendMessageButton(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_placeHolderMessage || var_2195.text == "")
         {
            _main.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         class_14.log("Sending message...");
         _main.connection.send(new class_229(var_2109,var_2195.text,-999,var_3769 != null ? var_3769.issueId : -1));
         this.dispose();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(_placeHolderMessage)
         {
            var_2195.text = "";
            _placeHolderMessage = false;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         _msgSelect = null;
         var_2195 = null;
         _main = null;
      }
      
      private function onAlertClose(param1:class_3348, param2:WindowEvent) : void
      {
         param1.dispose();
      }
   }
}
