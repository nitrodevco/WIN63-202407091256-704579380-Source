package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3696 extends DefaultConditionType
   {
       
      
      public function class_3696()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.ACTOR_IS_WEARING_BADGE;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_ACTOR_IS_WEARING_BADGE;
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
         return ITextFieldWindow(param1.findChildByName("badge_code"));
      }
   }
}
