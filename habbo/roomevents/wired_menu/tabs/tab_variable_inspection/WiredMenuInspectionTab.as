package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_inspection
{
   import com.sulake.core.communication.util.Long;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3398;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.common.VariableTypePicker;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.ITableObject;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableColumn;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableView;
   import com.sulake.habbo.roomevents.wired_setup.common.class_3819;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredMenuErrorEventParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredHoldingVariablesData;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredVariablesForObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredMenuErrorEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetVariablesForObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetObjectVariableValueMessageComposer;
   
   public class WiredMenuInspectionTab extends WiredMenuDefaultTab implements IUpdateReceiver
   {
      
      private static var POLL_VARIABLES_MS:uint = 500;
      
      private static var STATE_NOTHING:int = 0;
      
      private static var STATE_FETCHING_HOLDING_VARIABLES:int = 1;
      
      private static var STATE_AWAITING_VARIABLES:int = 2;
      
      private static var STATE_DISPLAYING:int = 3;
      
      public static var VARIABLES_COLUMN_VARIABLE:String = "variable";
      
      public static var VARIABLES_COLUMN_VALUE:String = "value";
       
      
      private var var_2617:TableView;
      
      private var var_1935:VariableTypePicker;
      
      private var var_2319:VariableHolderPreviewer;
      
      private var var_149:int;
      
      private var var_4677:int = 0;
      
      private var var_2627:Dictionary;
      
      private var var_47:WiredHoldingVariablesData = null;
      
      private var var_4611:int = -1;
      
      private var var_4713:int = 0;
      
      public function WiredMenuInspectionTab(param1:WiredMenuController, param2:IWindowContainer)
      {
         var_149 = STATE_NOTHING;
         var_2627 = new Dictionary();
         super(param1,param2);
         var_2617 = new TableView(param1,variableValuesTableContainer);
         var_1935 = new VariableTypePicker(typePickerContainer,onSelectVariableType);
         var_2319 = new VariableHolderPreviewer(previewContainer,param1);
         createVariableValuesTable();
         updateTableUI();
         updatePreviewUI();
         addMessageEvent(new WiredVariablesForObjectEvent(onWiredVariablesForObject));
         addMessageEvent(new WiredMenuErrorEvent(onWiredMenuError));
      }
      
      private function createVariableValuesTable() : void
      {
         var _loc1_:Array = [new TableColumn(VARIABLES_COLUMN_VARIABLE,loc("wiredmenu.variable_inspection.variables.variable"),0.65,"left"),new TableColumn(VARIABLES_COLUMN_VALUE,loc("wiredmenu.variable_inspection.variables.value"),0.35,"right")];
         var_2617.initialize(Vector.<TableColumn>(_loc1_));
         var_2617.onCellEditCallback = onCellEdit;
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         maybePollNewVariables(false);
      }
      
      private function maybePollNewVariables(param1:Boolean = true) : void
      {
         if(var_149 == STATE_DISPLAYING)
         {
            if(!param1)
            {
               var_149 = STATE_FETCHING_HOLDING_VARIABLES;
               updateLoadingState();
            }
            requestVariablesForObject(var_47.type,getObjectIdForType());
         }
      }
      
      private function getObjectIdForType() : int
      {
         if(var_47.type == WiredInputSourcePicker.USER_SOURCE)
         {
            return var_47.userIndex;
         }
         if(var_47.type == WiredInputSourcePicker.var_1736)
         {
            return var_47.objectId;
         }
         return 0;
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_149 == STATE_NOTHING || var_149 == STATE_DISPLAYING;
      }
      
      private function clearDataAndState() : void
      {
         var_149 = STATE_NOTHING;
         var_47 = null;
         updateTableUI();
      }
      
      private function onCellEdit(param1:ITableObject, param2:String, param3:String) : void
      {
         if(param2 != VARIABLES_COLUMN_VALUE)
         {
            return;
         }
         var _loc5_:VariableValueTableObject;
         var _loc4_:WiredVariable = (_loc5_ = param1 as VariableValueTableObject).variable;
         if(!controller.hasWritePermission || !_loc4_.hasValue || !_loc4_.canWriteValue)
         {
            return;
         }
         var _loc6_:int;
         if((_loc6_ = Util.getIntFromString(param3,-2147483648,true)) != -2147483648)
         {
            controller.send(new WiredSetObjectVariableValueMessageComposer(_loc4_.variableType,getObjectIdForType(),new Long(_loc4_.variableId),_loc6_));
         }
      }
      
      private function onWiredVariablesForObject(param1:WiredVariablesForObjectEvent) : void
      {
         if(var_149 != STATE_FETCHING_HOLDING_VARIABLES && var_149 != STATE_DISPLAYING)
         {
            return;
         }
         var _loc2_:WiredHoldingVariablesData = param1.getParser().data;
         if(_loc2_.type != var_1935.selectedType)
         {
            return;
         }
         var_47 = _loc2_;
         if(!allVariablesAvailable)
         {
            var_149 = STATE_AWAITING_VARIABLES;
            if(!controller.variablesSynchronizer.getAllVariables(onAllVariables))
            {
               updateLoadingState();
            }
         }
         else
         {
            var_149 = STATE_DISPLAYING;
            updateTableUI();
            updatePreviewUI();
            updateLoadingState();
         }
      }
      
      private function onWiredMenuError(param1:WiredMenuErrorEvent) : void
      {
         var _loc2_:WiredMenuErrorEventParser = param1.getParser();
         if(_loc2_.errorCode == WiredMenuErrorEventParser.var_1606)
         {
            if(var_149 != STATE_DISPLAYING)
            {
               clearDataAndState();
               updatePreviewUI();
               updateLoadingState();
            }
         }
      }
      
      private function get allVariablesAvailable() : Boolean
      {
         for each(var _loc1_ in var_47.variableValues.getKeys())
         {
            if(!(_loc1_ in var_2627))
            {
               return false;
            }
         }
         return true;
      }
      
      private function updatePreviewUI() : void
      {
         var _loc1_:* = var_1935.selectedType == class_3819.GLOBAL_SOURCE;
         Util.disableSection(pinContainer,_loc1_);
         if(_loc1_)
         {
            var_2319.setGlobalPlaceholder();
            return;
         }
         var _loc2_:* = var_1935.selectedType == WiredInputSourcePicker.var_1736;
         var _loc3_:* = var_1935.selectedType == WiredInputSourcePicker.USER_SOURCE;
         if(!_loc2_ && !_loc3_)
         {
            var_2319.clearPreviewer();
            return;
         }
         if(var_149 == STATE_NOTHING)
         {
            if(_loc2_)
            {
               var_2319.setFurniInstructions();
            }
            else if(_loc3_)
            {
               var_2319.setUserInstructions();
            }
         }
         else if(var_149 == STATE_DISPLAYING)
         {
            if(_loc2_)
            {
               var_2319.setFurniByObjectId(var_47.objectId);
            }
            else if(_loc3_)
            {
               var_2319.setPreviewByUserIndex(var_47.userIndex);
            }
         }
      }
      
      private function updateTableUI() : void
      {
         var _loc4_:WiredVariable = null;
         var _loc5_:Map = null;
         var _loc1_:Array = null;
         var _loc3_:Boolean = false;
         var _loc2_:* = undefined;
         if(var_149 == STATE_NOTHING)
         {
            var_2617.clear();
            Util.disableSection(variableValuesTableContainer);
         }
         else if(var_149 == STATE_DISPLAYING)
         {
            if(!variableValuesTableContainer.isEnabled())
            {
               Util.disableSection(variableValuesTableContainer,false);
            }
            _loc5_ = var_47.variableValues;
            _loc1_ = [];
            for each(var _loc6_ in _loc5_.getKeys())
            {
               if((_loc4_ = var_2627[_loc6_]) != null)
               {
                  _loc1_.push(_loc4_);
               }
            }
            Util.sortVariables(_loc1_);
            _loc3_ = getObjectIdForType() == var_4713 && var_47.type == var_4611;
            _loc2_ = new Vector.<ITableObject>();
            for each(_loc4_ in _loc1_)
            {
               _loc2_.push(new VariableValueTableObject(_loc4_,_loc5_.getValue(_loc4_.variableId),controller.hasWritePermission,_loc3_,controller.roomEvents));
            }
            var_2617.setObjects(_loc2_);
            var_4713 = getObjectIdForType();
            var_4611 = var_47.type;
         }
      }
      
      private function onAllVariables(param1:Vector.<WiredVariable>) : void
      {
         if(var_149 != STATE_AWAITING_VARIABLES)
         {
            return;
         }
         var_2627 = new Dictionary();
         for each(var _loc2_ in param1)
         {
            var_2627[_loc2_.variableId] = _loc2_;
         }
         var_149 = STATE_DISPLAYING;
         updateTableUI();
         updateLoadingState();
         updatePreviewUI();
      }
      
      private function onSelectVariableType(param1:int) : void
      {
         clearDataAndState();
         initializeInterface();
         if(param1 == class_3819.GLOBAL_SOURCE)
         {
            var_149 = STATE_FETCHING_HOLDING_VARIABLES;
            requestVariablesForObject(param1,0);
            updateLoadingState();
         }
         updatePreviewUI();
      }
      
      private function requestVariablesForObject(param1:int, param2:int) : void
      {
         var_4677 = getTimer();
         controller.send(new WiredGetVariablesForObjectMessageComposer(param1,param2));
      }
      
      public function inspectFurni(param1:int, param2:Boolean = false) : void
      {
         if(!isViewing)
         {
            return;
         }
         if(pinCheckbox.isSelected && var_149 == STATE_DISPLAYING && !param2)
         {
            return;
         }
         if(param2)
         {
            pinCheckbox.select();
         }
         var _loc3_:* = var_1935.selectedType == WiredInputSourcePicker.var_1736;
         if(param2 && !_loc3_)
         {
            var_1935.selectedType = WiredInputSourcePicker.var_1736;
            updatePreviewUI();
         }
         else if(!_loc3_)
         {
            return;
         }
         if(var_1935.selectedType == WiredInputSourcePicker.var_1736)
         {
            if(var_47 != null && var_47.objectId == param1)
            {
               return;
            }
            var_149 = STATE_FETCHING_HOLDING_VARIABLES;
            updateLoadingState();
            requestVariablesForObject(WiredInputSourcePicker.var_1736,param1);
         }
      }
      
      public function inspectUser(param1:int, param2:Boolean = false) : void
      {
         if(!isViewing)
         {
            return;
         }
         if(pinCheckbox.isSelected && var_149 == STATE_DISPLAYING && !param2)
         {
            return;
         }
         if(param2)
         {
            pinCheckbox.select();
         }
         var _loc3_:* = var_1935.selectedType == WiredInputSourcePicker.USER_SOURCE;
         if(param2 && !_loc3_)
         {
            var_1935.selectedType = WiredInputSourcePicker.USER_SOURCE;
            updatePreviewUI();
         }
         else if(!_loc3_)
         {
            return;
         }
         if(var_1935.selectedType == WiredInputSourcePicker.USER_SOURCE)
         {
            if(var_47 != null && var_47.userIndex == param1)
            {
               return;
            }
            var_149 = STATE_FETCHING_HOLDING_VARIABLES;
            updateLoadingState();
            requestVariablesForObject(WiredInputSourcePicker.USER_SOURCE,param1);
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         controller.variablesSynchronizer.removeListener(onAllVariables);
         var_1935.dispose();
         var_1935 = null;
         var_2617.dispose();
         var_2617 = null;
         var_149 = STATE_NOTHING;
         var_2627 = null;
         var_47 = null;
         var_2319.dispose();
         var_2319 = null;
         super.dispose();
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var_1935.update(param1);
         var _loc2_:int = getTimer();
         if(var_4677 < _loc2_ - POLL_VARIABLES_MS && isDataReady())
         {
            maybePollNewVariables();
         }
      }
      
      private function get variableValuesTableContainer() : IWindowContainer
      {
         return container.findChildByName("variable_values_table_container") as IWindowContainer;
      }
      
      private function get typePickerContainer() : IWindowContainer
      {
         return container.findChildByName("type_picker_container") as IWindowContainer;
      }
      
      private function get previewContainer() : IWindowContainer
      {
         return container.findChildByName("preview_container") as IWindowContainer;
      }
      
      private function get pinContainer() : IWindowContainer
      {
         return container.findChildByName("pin_option_container") as IWindowContainer;
      }
      
      private function get pinCheckbox() : class_3398
      {
         return container.findChildByName("pin_checkbox") as class_3398;
      }
   }
}
