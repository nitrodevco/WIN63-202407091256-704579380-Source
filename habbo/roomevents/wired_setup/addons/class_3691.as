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
   
   public class class_3691 extends class_3690
   {
       
      
      private var var_2631:VariablePicker;
      
      private var var_2915:WiredVariable;
      
      public function class_3691()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canWriteValue;
      }
      
      override public function get code() : int
      {
         return class_3833.VARIABLE_CAPTURER;
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
         var _loc2_:int = int(param1.intParams[0]);
         displayTypeSelector.setSelected(getDisplayTypeRadio(_loc2_));
         var_2631.init(param1.wiredContext.roomVariablesList,_loc3_,class_3819.CONTEXT_SOURCE);
         var_2915 = var_2631.selectedVariable;
         onChangeVariable(var_2631.selectedVariable);
         placeholderName = param1.stringParam;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(displayTypeSelector.getSelected().id);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      override public function readStringParamFromForm() : String
      {
         return placeholderNameWindow.text;
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
         if(placeholderName == "" || var_2915 != null && class_3749.prettifiedName(var_2915) == placeholderName)
         {
            placeholderName = class_3749.prettifiedName(param1);
         }
         var_2915 = param1;
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(cont.findChildByName("menu_variables"));
      }
      
      override protected function get syntaxPrefix() : String
      {
         return "#";
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
