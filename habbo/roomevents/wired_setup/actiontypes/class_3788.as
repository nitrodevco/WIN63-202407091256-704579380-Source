package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class class_3788 extends DefaultActionType
   {
       
      
      public function class_3788()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3849.CHAT;
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
         return ITextFieldWindow(param1.findChildByName("chat_message"));
      }
      
      override public function validate() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = 100;
         if(getInput(cont).text.length > _loc1_)
         {
            _loc2_ = "wiredfurni.chatmsgtoolong";
            return roomEvents.localization.getLocalization(_loc2_,_loc2_);
         }
         return null;
      }
   }
}
