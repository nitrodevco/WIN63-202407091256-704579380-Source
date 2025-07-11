package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   
   public class UsersByName extends DefaultSelectorType
   {
       
      
      public function UsersByName()
      {
         super();
      }
      
      private static function getInput(param1:IWindowContainer) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("names_input"));
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_BY_NAME;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc2_:String = String(getInput(cont).text);
         return _loc2_.replace(/\n\r/g,"\t").replace(/\r/g,"\t").replace(/\n/g,"\t");
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         getInput(cont).text = param1.stringParam.replace(/\t/g,"\r");
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}
