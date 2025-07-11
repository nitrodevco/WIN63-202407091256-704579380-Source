package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3847;
   
   public class class_3747 extends DefaultVariableType
   {
       
      
      private var _cont:IWindowContainer;
      
      public function class_3747()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3838.CONTEXT_VARIABLE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(!!hasValueCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc2_:* = param1.intParams[0] != 0;
         Util.select(hasValueCheckbox,_loc2_);
         initialVariableName = param1.stringParam;
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(variableNameTxt.text);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get hasValueCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("has_value_checkbox"));
      }
      
      override public function variableType() : int
      {
         return class_3847.var_4926;
      }
   }
}
