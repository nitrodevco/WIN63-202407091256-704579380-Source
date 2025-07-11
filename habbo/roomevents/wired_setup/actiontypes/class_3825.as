package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3825 extends class_3664
   {
       
      
      public function class_3825()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.BOT_TELEPORT;
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(getInput(cont).text);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         getInput(cont).text = param1.stringParam;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("bot_name"));
      }
   }
}
