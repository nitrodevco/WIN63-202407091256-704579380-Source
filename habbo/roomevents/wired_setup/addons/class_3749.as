package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class class_3749 extends class_3748
   {
       
      
      private var var_2631:VariablePicker;
      
      private var var_1303:int = 0;
      
      private var var_2915:WiredVariable;
      
      public function class_3749()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      public static function prettifiedName(param1:WiredVariable) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.variableName.replace("@","");
      }
      
      override public function get code() : int
      {
         return class_3833.VARIABLE_PLACEHOLDER;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_2631 = new VariablePicker(param3,variableMenu,variableSelectionFilter,onChangeVariable);
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         super.onEditStart(param1);
         var _loc3_:Number = Number(param1.variableIds[0]);
         var_1303 = param1.intParams[1];
         var _loc2_:int = int(param1.intParams[2]);
         displayTypeSelector.setSelected(getDisplayTypeRadio(_loc2_));
         var_2631.init(param1.wiredContext.roomVariablesList,_loc3_,var_1303);
         var_2915 = var_2631.selectedVariable;
         onChangeVariable(var_2631.selectedVariable);
         updateMultipleOptionVisibility();
      }
      
      override public function onEditInitialized() : void
      {
         roomEventsCtrl.mergedSourcePickers[0].sourceTypePicker.moveLayoutTo(sourceTypeContainer);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = super.readIntParamsFromForm();
         _loc1_.push(var_1303);
         _loc1_.push(displayTypeSelector.getSelected().id);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      private function onChangeVariable(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 == null || !param1.hasTextConnector;
         Util.disableSection(getDisplayTypeText(1),_loc2_);
         Util.disableSection(getDisplayTypeRadio(1),_loc2_);
         if(_loc2_)
         {
            displayTypeSelector.setSelected(getDisplayTypeRadio(0));
         }
         if(placeholderName == "" || var_2915 != null && prettifiedName(var_2915) == placeholderName)
         {
            placeholderName = prettifiedName(param1);
         }
         var_2915 = param1;
      }
      
      private function updateMultipleOptionVisibility() : void
      {
         var _loc1_:Boolean = var_1303 == class_3819.CONTEXT_SOURCE || var_1303 == class_3819.GLOBAL_SOURCE;
         Util.disableSection(getPlaceholderRadio(1),_loc1_);
         Util.disableSection(getPlaceholderText(1),_loc1_);
         if(_loc1_)
         {
            placeholderType = 0;
         }
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(cont.findChildByName("menu_variables"));
      }
      
      private function get sourceTypeContainer() : IWindowContainer
      {
         return IWindowContainer(cont.findChildByName("sourcetype_container_1"));
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
         updateMultipleOptionVisibility();
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
      
      private function getDisplayTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(cont.findChildByName("display_" + param1 + "_radio"));
      }
      
      private function getDisplayTypeText(param1:int) : ITextWindow
      {
         return ITextWindow(cont.findChildByName("display_" + param1 + "_text"));
      }
      
      private function get displayTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(cont.findChildByName("display_selector"));
      }
   }
}
