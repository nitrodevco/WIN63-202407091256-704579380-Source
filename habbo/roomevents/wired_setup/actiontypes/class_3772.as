package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.IWidgetWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class class_3772 extends class_3664
   {
      
      private static const STRING_PARAM_DELIMITER:String = "\t";
       
      
      private var var_1660:HabboUserDefinedRoomEvents;
      
      private var _figureString:String;
      
      private var _botName:String;
      
      private var _window:IWindowContainer;
      
      public function class_3772()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.BOT_CHANGE_FIGURE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_1660 = param3;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = String(getInput(cont,"bot_name").text);
         return _loc1_ + "\t" + _figureString;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         if(_loc2_.length > 0)
         {
            _botName = _loc2_[0];
         }
         if(_loc2_.length > 1)
         {
            _figureString = _loc2_[1];
         }
         getInput(cont,"bot_name").text = _botName;
         IAvatarImageWidget(IWidgetWindow(cont.findChildByName("avatar_image")).widget).figure = _figureString;
         cont.findChildByName("capture_figure").procedure = captureFigureButtonProcedure;
         _window = cont;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer, param2:String) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName(param2));
      }
      
      private function captureFigureButtonProcedure(param1:WindowEvent, param2:IWindow) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _figureString = var_1660.sessionDataManager.figure;
            IAvatarImageWidget(IWidgetWindow(_window.findChildByName("avatar_image")).widget).figure = _figureString;
         }
      }
   }
}
