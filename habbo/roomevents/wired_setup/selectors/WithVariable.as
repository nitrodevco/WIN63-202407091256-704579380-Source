package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.IWindow;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class WithVariable extends DefaultSelectorType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2631:VariablePicker;
      
      private var var_3620:VariablePicker;
      
      private var var_2817:int = 0;
      
      public function WithVariable()
      {
         super();
      }
      
      private static function variableSelectionFilter1(param1:WiredVariable) : Boolean
      {
         return true;
      }
      
      private static function variableSelectionFilter2(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         var cont:IWindowContainer = param1;
         var advancedCont:IWindowContainer = param2;
         var roomEvents:HabboUserDefinedRoomEvents = param3;
         super.onInit(cont,advancedCont,roomEvents);
         _cont = cont;
         _roomEvents = roomEvents;
         var_2631 = new VariablePicker(roomEvents,variableMenu,variableSelectionFilter1,onVariableSelected);
         var_3620 = new VariablePicker(roomEvents,variableReferenceMenu,variableSelectionFilter2);
         getReferenceRadio(1).addEventListener("WE_SELECTED",onSpecifyRefVariableSelect);
         getReferenceRadio(1).addEventListener("WE_UNSELECTED",onSpecifyRefVariableUnselect);
         selectByValueCheckbox.addEventListener("WE_SELECTED",function(param1:WindowEvent):void
         {
            setValueSelectionVisibility(true);
         });
         selectByValueCheckbox.addEventListener("WE_UNSELECTED",function(param1:WindowEvent):void
         {
            setValueSelectionVisibility(false);
         });
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getComparisonSelector().getSelected().id);
         _loc1_.push(!!selectByValueCheckbox.isSelected ? getReferenceSelector().getSelected().id + 1 : 0);
         Util.pushIntAsLong(_loc1_,Util.getIntFromInput(valueInput,0,true));
         _loc1_.push(var_2817);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId,var_3620.selectedVariableId];
      }
      
      protected function get variableSource() : int
      {
         return -1;
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc4_:Array = param1.intParams;
         var _loc6_:Number = Number(param1.variableIds[0]);
         var _loc2_:Number = Number(param1.variableIds[1]);
         var _loc3_:int = int(_loc4_[0]);
         var _loc5_:int = int(_loc4_[1]);
         var _loc7_:int = int(_loc4_[3]);
         var_2817 = _loc4_[4];
         var_2631.init(param1.wiredContext.roomVariablesList,_loc6_,variableSource);
         getComparisonSelector().setSelected(getComparisonRadio(_loc3_));
         if(_loc5_ == 0 || var_2631.selectedVariable == null || !var_2631.selectedVariable.hasValue)
         {
            _loc2_ = 0;
            _loc7_ = 0;
            _loc5_ = 0;
            selectByValueCheckbox.isSelected = false;
         }
         else if(_loc5_ == 1)
         {
            _loc2_ = 0;
            selectByValueCheckbox.isSelected = true;
         }
         else
         {
            _loc7_ = 0;
            selectByValueCheckbox.isSelected = true;
         }
         var_3620.init(param1.wiredContext.roomVariablesList,_loc2_,var_2817);
         getReferenceSelector().setSelected(getReferenceRadio(Math.max(_loc5_ - 1,0)));
         setReferenceActive(_loc5_ == 2);
         valueInput.text = _loc7_ + "";
         setValueSelectionVisibility(var_2631.selectedVariable != null && var_2631.selectedVariable.hasValue && _loc5_ > 0);
         onVariableSelected(var_2631.selectedVariable);
      }
      
      override public function onEditInitialized() : void
      {
         roomEventsCtrl.mergedSourcePickers[0].sourceTypePicker.moveLayoutTo(sourceTypeContainer2);
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 0)
         {
            return !variableReferenceMenu.isEnabled() || !variableValueSection.isEnabled() || !valueOptionsEnabledSection.isEnabled();
         }
         return false;
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
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 != null && param1.hasValue;
         Util.disableSection(variableValueSection,!_loc2_);
         setValueSelectionVisibility(_loc2_ && Boolean(selectByValueCheckbox.isSelected));
      }
      
      private function setValueSelectionVisibility(param1:Boolean) : void
      {
         Util.disableSection(valueOptionsEnabledSection,!param1);
         if(param1)
         {
            setReferenceActive(getReferenceSelector().getSelected().id == 1 && Boolean(selectByValueCheckbox.isSelected));
         }
         _roomEvents.userDefinedRoomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function get variableValueSection() : IWindow
      {
         return _cont.getChildByTag("variable_value_section");
      }
      
      private function get valueOptionsSelection() : IWindowContainer
      {
         return IWindowContainer(_cont.getChildByName("value_options_selection"));
      }
      
      private function get valueOptionsEnabledSection() : IWindow
      {
         return valueOptionsSelection.getChildByTag("variable_value_enabled_section");
      }
      
      private function get valueInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("value_input"));
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      private function get operationMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_operations"));
      }
      
      private function get variableReferenceMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_ref_variable"));
      }
      
      private function get sourceTypeContainer2() : IWindowContainer
      {
         return IWindowContainer(cont.findChildByName("sourcetype_container_2"));
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
         _roomEvents.userDefinedRoomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function onSpecifyRefVariableUnselect(param1:WindowEvent) : void
      {
         setReferenceActive(false);
         _roomEvents.userDefinedRoomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function getComparisonRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("comp_" + param1 + "_radio"));
      }
      
      private function getComparisonSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("comp_selector"));
      }
      
      private function get selectByValueCheckbox() : class_3398
      {
         return class_3398(_cont.findChildByName("select_by_value_checkbox"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         var_2817 = param2;
         var_3620.variableType = var_2817;
      }
      
      override public function getMergedType(param1:int) : int
      {
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
