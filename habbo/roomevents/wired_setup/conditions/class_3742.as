package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3742 extends DefaultConditionType
   {
       
      
      public function class_3742()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3848.ACTOR_IS_WEARING_EFFECT;
      }
      
      override public function get negativeCode() : int
      {
         return class_3848.NOT_ACTOR_IS_WEARING_EFFECT;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(int(getInput(cont).text));
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         getInput(cont).text = param1.intParams[0];
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:IWindowContainer) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("effect_id"));
      }
   }
}
