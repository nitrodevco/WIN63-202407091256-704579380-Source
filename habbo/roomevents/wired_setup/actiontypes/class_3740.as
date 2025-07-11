package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3520;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_1659;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.VariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class class_3740 extends DefaultActionType
   {
       
      
      private var _cont:IWindowContainer;
      
      private var var_2631:VariablePicker;
      
      private var var_1303:int = 0;
      
      public function class_3740()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canCreateAndDelete;
      }
      
      override public function get code() : int
      {
         return class_3849.REMOVE_VARIABLE;
      }
      
      override public function onInit(param1:IWindowContainer, param2:IWindowContainer, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         var_2631 = new VariablePicker(param3,variableMenu,variableSelectionFilter);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1303);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2631.selectedVariableId];
      }
      
      override public function onEditStart(param1:class_1659) : void
      {
         var _loc2_:Number = Number(param1.variableIds[0]);
         var_1303 = param1.intParams[0];
         var_2631.init(param1.wiredContext.roomVariablesList,_loc2_,var_1303);
      }
      
      override public function onEditInitialized() : void
      {
         roomEventsCtrl.mergedSourcePickers[0].sourceTypePicker.moveLayoutTo(sourceTypeContainer);
      }
      
      private function get variableMenu() : class_3520
      {
         return class_3520(_cont.findChildByName("menu_variables"));
      }
      
      override protected function get legacyInputMode() : Boolean
      {
         return true;
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
      }
      
      override public function getMergedType(param1:int) : int
      {
         return var_1303;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [class_3819.CONTEXT_SOURCE];
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
