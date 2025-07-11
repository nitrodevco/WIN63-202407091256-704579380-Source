package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3665 extends class_3664
   {
       
      
      public function class_3665()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.BOT_FOLLOW_AVATAR;
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(getInput(cont,"bot_name").text);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [getSelector(cont,"type_selector").getSelected().id];
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         getInput(cont,"bot_name").text = param1.stringParam;
         getSelector(cont,"type_selector").setSelected(getRadio(cont,"radio_" + param1.intParams[0]));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer, param2:String) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName(param2));
      }
      
      private function getSelector(param1:IWindowContainer, param2:String) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName(param2));
      }
      
      private function getRadio(param1:IWindowContainer, param2:String) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName(param2));
      }
   }
}
