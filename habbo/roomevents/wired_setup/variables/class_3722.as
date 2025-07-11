package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.class_3847;
   
   public class class_3722 extends DefaultVariableType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function class_3722()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_3838.GLOBAL_VARIABLE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getAvailabilitySelector().getSelected().id);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc2_:int = int(param1.intParams[0]);
         getAvailabilitySelector().setSelected(getEvalRadio(_loc2_));
         initialVariableName = param1.stringParam;
         var _loc3_:int = param1.wiredContext.globalVariableInfo.value;
         _roomEvents.localization.registerParameter("wiredfurni.params.variables.inspection.current_value","value","" + _loc3_);
      }
      
      override public function readStringParamFromForm() : String
      {
         return String(variableNameTxt.text);
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getEvalRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("avail_" + param1 + "_radio"));
      }
      
      private function getAvailabilitySelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("availability_selector"));
      }
      
      override public function variableType() : int
      {
         return class_3847.var_4967;
      }
   }
}
