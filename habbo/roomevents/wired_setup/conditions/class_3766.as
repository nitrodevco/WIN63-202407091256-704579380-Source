package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class class_3766 extends DefaultConditionType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var var_2631:VariablePicker;
      
      private var var_1303:int = 0;
      
      public function class_3766()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canReadCreationTime || param1.canReadLastUpdateTime;
      }
      
      private static function getTimeUnitId(param1:String) : int
      {
         var _loc2_:Array = param1.split(".");
         return parseInt(_loc2_[4]);
      }
      
      override public function get code() : int
      {
         return class_3848.VARIABLE_AGE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         var_2631 = new VariablePicker(param3,variableMenu,variableSelectionFilter,updateAgeOptions);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1303);
         _loc1_.push(getComparisonSelector().getSelected().id);
         _loc1_.push(getAgeSelector().getSelected().id);
         Util.pushIntAsLong(_loc1_,Util.getIntFromInput(valueInput,0));
         _loc1_.push(selectedTimeUnitId);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc3_:Array = param1.intParams;
         var _loc5_:Number = Number(param1.variableIds[0]);
         var_1303 = _loc3_[0];
         var_2631.init(param1.wiredContext.roomVariablesList,_loc5_,var_1303);
         var _loc2_:int = int(_loc3_[1]);
         var _loc6_:int = int(_loc3_[2]);
         var _loc7_:int = int(_loc3_[4]);
         var _loc4_:int = int(_loc3_[5]);
         getComparisonSelector().setSelected(getComparisonRadio(_loc2_));
         getAgeSelector().setSelected(getAgeRadio(_loc6_));
         valueInput.text = _loc7_ + "";
         selectedTimeUnitId = _loc4_;
         updateAgeOptions(var_2631.selectedVariable);
      }
      
      override public function onEditInitialized() : void
      {
         roomEventsCtrl.mergedSourcePickers[0].sourceTypePicker.moveLayoutTo(sourceTypeContainer);
      }
      
      private function updateAgeOptions(param1:WiredVariable) : void
      {
         setAgeOptionState(0,true);
         setAgeOptionState(1,true);
         if(param1 == null)
         {
            return;
         }
         if(!param1.canReadCreationTime)
         {
            setAgeOptionState(0,false);
            getAgeSelector().setSelected(getAgeRadio(1));
         }
         else if(!param1.canReadLastUpdateTime)
         {
            setAgeOptionState(1,false);
            getAgeSelector().setSelected(getAgeRadio(0));
         }
      }
      
      private function setAgeOptionState(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            getAgeRadio(param1).enable();
            getAgeText(param1).enable();
            getAgeRadio(param1).color = 16777215;
            getAgeText(param1).textColor = 16777215;
         }
         else
         {
            getAgeRadio(param1).disable();
            getAgeText(param1).disable();
            getAgeRadio(param1).color = 10066329;
            getAgeText(param1).textColor = 10066329;
         }
      }
      
      private function get sourceTypeContainer() : IWindowContainer
      {
         return IWindowContainer(cont.findChildByName("sourcetype_container_1"));
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      private function getComparisonRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("comp_" + param1 + "_radio"));
      }
      
      private function getComparisonSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("comp_selector"));
      }
      
      private function getAgeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("age_" + param1 + "_radio"));
      }
      
      private function getAgeText(param1:int) : ITextWindow
      {
         return ITextWindow(_cont.findChildByName("age_" + param1 + "_text"));
      }
      
      private function getAgeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("age_selector"));
      }
      
      private function get timeUnitMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_time_unit"));
      }
      
      private function get selectedTimeUnitId() : int
      {
         var _loc2_:Array = timeUnitMenu.enumerateSelection();
         var _loc1_:int = timeUnitMenu.selection;
         if(_loc1_ == -1)
         {
            return 0;
         }
         return getTimeUnitId(_loc2_[_loc1_]);
      }
      
      private function set selectedTimeUnitId(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_3520;
         var _loc2_:Array = (_loc4_ = timeUnitMenu).enumerateSelection();
         var _loc5_:* = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(getTimeUnitId(_loc2_[_loc3_]) == param1)
            {
               _loc5_ = _loc3_;
            }
            _loc3_++;
         }
         _loc4_.selection = _loc5_;
      }
      
      private function get valueInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("value_input"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         var_1303 = param2;
         var_2631.variableType = var_1303;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return var_1303;
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
