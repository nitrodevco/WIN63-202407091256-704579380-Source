package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3556;
   
   public class DefaultVariableType extends DefaultElement implements class_3532, IUpdateReceiver
   {
       
      
      private var _initialVariableName:String;
      
      public function DefaultVariableType()
      {
         super();
      }
      
      protected static function isVariableStored(param1:int) : Boolean
      {
         return param1 == class_3556.var_4965 || param1 == class_3556.var_4950;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         roomEvents.context.registerUpdateReceiver(this,0);
      }
      
      override public function onEditEnd() : void
      {
         super.onEditEnd();
         roomEvents.context.removeUpdateReceiver(this);
      }
      
      protected function get variableNameTxt() : ITextFieldWindow
      {
         return ITextFieldWindow(cont.findChildByName("variable_name"));
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:String = String(variableNameTxt.text);
         var _loc3_:String = String(variableNameTxt.text.split(" ").join("_").toLowerCase());
         if(_loc2_ != _loc3_)
         {
            variableNameTxt.text = _loc3_;
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function set initialVariableName(param1:String) : void
      {
         _initialVariableName = param1;
         variableNameTxt.text = param1;
      }
      
      public function get initialVariableName() : String
      {
         return _initialVariableName;
      }
      
      public function variableType() : int
      {
         return 0;
      }
   }
}
