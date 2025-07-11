package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3847;
   
   public class class_3662 extends DefaultVariableType
   {
      
      public static var STRING_PARAM_SPLITTER:String = "\t";
       
      
      private var _cont:IWindowContainer;
      
      public function class_3662()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3838.var_4960;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc2_:Array = param1.stringParam.split(STRING_PARAM_SPLITTER);
         initialVariableName = _loc2_.length > 0 ? _loc2_[0] : "";
         questNameTxt.text = _loc2_.length > 1 ? _loc2_[1] : "";
      }
      
      override public function readStringParamFromForm() : String
      {
         return variableNameTxt.text + STRING_PARAM_SPLITTER + questNameTxt.text;
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get questNameTxt() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("quest_name"));
      }
      
      override public function variableType() : int
      {
         return class_3847.USER;
      }
   }
}
