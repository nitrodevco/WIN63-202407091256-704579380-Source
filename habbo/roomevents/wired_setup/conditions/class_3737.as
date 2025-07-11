package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class class_3737 extends DefaultConditionType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var var_2631:VariablePicker;
      
      private var var_3620:VariablePicker;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1303:int = 0;
      
      private var var_2817:int = 0;
      
      public function class_3737()
      {
         super();
      }
      
      private static function variableSelectionFilter1(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      private static function variableSelectionFilter2(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      override public function get code() : int
      {
         return class_3848.VARIABLE_VALUE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
         var_2631 = new VariablePicker(param3,variableMenu,variableSelectionFilter1);
         var_3620 = new VariablePicker(param3,variableReferenceMenu,variableSelectionFilter2);
         getReferenceRadio(1).addEventListener("WE_SELECTED",onSpecifyRefVariableSelect);
         getReferenceRadio(1).addEventListener("WE_UNSELECTED",onSpecifyRefVariableUnselect);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1303);
         _loc1_.push(getComparisonSelector().getSelected().id);
         _loc1_.push(getReferenceSelector().getSelected().id);
         Util.pushIntAsLong(_loc1_,Util.getIntFromInput(valueInput,0,true));
         _loc1_.push(var_2817);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId,var_3620.selectedVariableId];
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc4_:Array = param1.intParams;
         var _loc6_:Number = Number(param1.variableIds[0]);
         var _loc2_:Number = Number(param1.variableIds[1]);
         var_1303 = _loc4_[0];
         var _loc3_:int = int(_loc4_[1]);
         var _loc5_:int = int(_loc4_[2]);
         var _loc7_:int = int(_loc4_[4]);
         var_2817 = _loc4_[5];
         var_2631.init(param1.wiredContext.roomVariablesList,_loc6_,var_1303);
         getComparisonSelector().setSelected(getComparisonRadio(_loc3_));
         if(_loc5_ == 0)
         {
            _loc2_ = -1;
         }
         else
         {
            _loc7_ = 0;
         }
         var_3620.init(param1.wiredContext.roomVariablesList,_loc2_,var_2817);
         getReferenceSelector().setSelected(getReferenceRadio(_loc5_));
         setReferenceActive(_loc5_ != 0);
         valueInput.text = _loc7_ + "";
      }
      
      override public function onEditInitialized() : void
      {
         roomEventsCtrl.mergedSourcePickers[0].sourceTypePicker.moveLayoutTo(sourceTypeContainer);
         roomEventsCtrl.mergedSourcePickers[1].sourceTypePicker.moveLayoutTo(sourceTypeContainer2);
      }
      
      private function setReferenceActive(param1:Boolean) : void
      {
         if(param1)
         {
            variableReferenceMenu.blend = 1;
            variableReferenceMenu.enable();
         }
         else
         {
            variableReferenceMenu.blend = 0.5;
            variableReferenceMenu.disable();
         }
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 1)
         {
            return !variableReferenceMenu.isEnabled();
         }
         return false;
      }
      
      private function get valueInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("value_input"));
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      private function get sourceTypeContainer() : IWindowContainer
      {
         return IWindowContainer(cont.findChildByName("sourcetype_container_1"));
      }
      
      private function get sourceTypeContainer2() : IWindowContainer
      {
         return IWindowContainer(cont.findChildByName("sourcetype_container_2"));
      }
      
      private function get operationMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_operations"));
      }
      
      private function get variableReferenceMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_ref_variable"));
      }
      
      private function getReferenceRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName(param1 == 0 ? "set_value_radio" : "from_variable_radio"));
      }
      
      private function getReferenceSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("reference_selector"));
      }
      
      private function onSpecifyRefVariableSelect(param1:WindowEvent) : void
      {
         setReferenceActive(true);
         _roomEvents.userDefinedRoomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,1);
      }
      
      private function onSpecifyRefVariableUnselect(param1:WindowEvent) : void
      {
         setReferenceActive(false);
         _roomEvents.userDefinedRoomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,1);
      }
      
      private function getComparisonRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("comp_" + param1 + "_radio"));
      }
      
      private function getComparisonSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("comp_selector"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.merged.title.variables";
         }
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0],[1,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            var_1303 = param2;
            var_2631.variableType = var_1303;
         }
         else
         {
            var_2817 = param2;
            var_3620.variableType = var_2817;
         }
      }
      
      override public function getMergedType(param1:int) : int
      {
         if(param1 == 0)
         {
            return var_1303;
         }
         return var_2817;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [class_3819.GLOBAL_SOURCE,class_3819.CONTEXT_SOURCE];
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}
