package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.communication.util.Long;
   import com.sulake.core.runtime.IUpdateReceiver;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.class_3357;
   import com.sulake.core.window.events.WindowMouseEvent;
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
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEventParser;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.ObjectIdAndValuePair;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariableHoldersMessageComposer;
   
   public class WiredMenuOverviewTab extends WiredMenuDefaultTab implements IUpdateReceiver
   {
      
      private static var POLL_MS:uint = 500;
      
      private static var MAX_HIGHLIGHTS:uint = 1000;
      
      private static var MAX_HIGHLIGHTS_WITH_VALUE:uint = 400;
      
      public static var LIST_COLUMN_NAME:String = "variable";
      
      public static var PROPERTIES_COLUMN_PROPERTY:String = "property";
      
      public static var PROPERTIES_COLUMN_VALUE:String = "value";
      
      public static var var_4890:String = "value";
      
      public static var var_4783:String = "text";
       
      
      private var var_1950:TableView;
      
      private var var_2845:TableView;
      
      private var var_2751:TableView;
      
      private var var_1935:VariableTypePicker;
      
      private var _highlighter:VariableHoldersHighlighter;
      
      private var _highlightEnabled:Boolean;
      
      private var var_4677:int = 0;
      
      private var var_4803:int = 0;
      
      private var var_2585:Vector.<WiredVariable>;
      
      private var var_3435:String = null;
      
      private var var_3731:WiredVariable = null;
      
      public function WiredMenuOverviewTab(param1:WiredMenuController, param2:IWindowContainer)
      {
         super(param1,param2);
         _highlighter = new VariableHoldersHighlighter(param1.roomEvents);
         var_1950 = new TableView(param1,variableListContainer);
         var_2845 = new TableView(param1,propertiesTableContainer);
         var_2751 = new TableView(param1,textsTableContainer);
         var_1935 = new VariableTypePicker(typePickerContainer,onSelectVariableType);
         createVariableList();
         createPropertiesTable();
         createTextTable();
         addMessageEvent(new WiredAllVariableHoldersEvent(onAllVariableHolders));
         highlightHoldersButton.addEventListener("WME_CLICK",onHighlightClick);
      }
      
      private function createVariableList() : void
      {
         var _loc1_:Array = [new TableColumn(LIST_COLUMN_NAME,"",1,"left")];
         var_1950.initialize(Vector.<TableColumn>(_loc1_),false);
         var_1950.onRowSelectedCallback = onSelectVariable;
      }
      
      private function createPropertiesTable() : void
      {
         var _loc1_:Array = [new TableColumn(PROPERTIES_COLUMN_PROPERTY,loc("wiredmenu.variable_overview.properties.column.property"),0.52,"left"),new TableColumn(PROPERTIES_COLUMN_VALUE,loc("wiredmenu.variable_overview.properties.column.value"),0.48,"left")];
         var_2845.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      private function createTextTable() : void
      {
         var _loc1_:Array = [new TableColumn(var_4890,loc("wiredmenu.variable_overview.text.column.value"),0.2,"left"),new TableColumn(var_4783,loc("wiredmenu.variable_overview.text.column.text"),0.8,"right")];
         var_2751.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_2585 != null;
      }
      
      private function clearData() : void
      {
         var_2585 = null;
      }
      
      private function requestData() : void
      {
         var_4677 = getTimer();
         controller.variablesSynchronizer.getAllVariables(onAllVariables);
      }
      
      private function requestHolders() : void
      {
         var_4803 = getTimer();
         controller.send(new WiredGetAllVariableHoldersMessageComposer(new Long(selectedVariableId)));
      }
      
      private function onAllVariables(param1:Vector.<WiredVariable>) : void
      {
         var_2585 = param1;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            initializeInterface();
         }
      }
      
      private function onAllVariableHolders(param1:WiredAllVariableHoldersEvent) : void
      {
         var _loc9_:int = 0;
         var _loc8_:Number = NaN;
         if(!_highlightEnabled || !isViewing)
         {
            return;
         }
         var _loc2_:WiredAllVariableHoldersEventParser = param1.getParser();
         var _loc4_:Vector.<ObjectIdAndValuePair> = _loc2_.variableInfoAndHolders.holders;
         var _loc6_:WiredVariable;
         if((_loc6_ = _loc2_.variableInfoAndHolders.variable).variableId != selectedVariableId)
         {
            return;
         }
         if(!_loc6_.hasValue && _loc4_.length > MAX_HIGHLIGHTS || _loc6_.hasValue && _loc4_.length > MAX_HIGHLIGHTS_WITH_VALUE)
         {
            controller.roomEvents.notifications.addItem(loc("wiredmenu.variable_overview.highlight.error.too_many"),"info","icon_wired_notification_png");
            stopHighlight();
            return;
         }
         var _loc5_:Dictionary = new Dictionary();
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc7_ in _loc4_)
         {
            _loc9_ = int(_loc7_.objectId);
            _loc8_ = _loc6_.hasValue ? _loc7_.value : NaN;
            if(_loc6_.variableType == WiredInputSourcePicker.var_1736)
            {
               _highlighter.highlightObject(_loc9_,Util.variableValueWithString(_loc6_,_loc8_));
               _loc5_[_loc9_] = true;
            }
            else if(_loc6_.variableType == WiredInputSourcePicker.USER_SOURCE)
            {
               _highlighter.highlightUser(_loc9_,Util.variableValueWithString(_loc6_,_loc8_));
               _loc3_[_loc9_] = true;
            }
         }
         _highlighter.removeRemovedHolders(_loc5_,_loc3_);
      }
      
      private function get selectedVariableId() : Number
      {
         var _loc1_:WiredVariable = selectedVariable;
         return _loc1_ == null ? NaN : _loc1_.variableId;
      }
      
      private function get selectedVariable() : WiredVariable
      {
         if(var_1950.selected == null)
         {
            return null;
         }
         return VariableTableObject(var_1950.selected).variable;
      }
      
      override protected function initializeInterface() : void
      {
         if(var_3435 != null)
         {
            findFocusVariable(var_3435);
            var_3435 = null;
         }
         updateVariableListUI();
         updatePropertiesTableUI();
         updateTextTableUI();
         updateHighlightButtonUI();
      }
      
      private function updateVariableListUI() : void
      {
         var _loc5_:ITableObject = null;
         var _loc1_:ITableObject = var_1950.selected;
         var _loc3_:Vector.<ITableObject> = new Vector.<ITableObject>();
         var _loc2_:* = null;
         for each(var _loc4_ in var_2585)
         {
            if(!_loc4_.isInvisible)
            {
               if(_loc4_.variableType == var_1935.selectedType)
               {
                  _loc5_ = new VariableTableObject(_loc4_,controller.roomEvents);
                  if(_loc4_ == var_3731)
                  {
                     _loc2_ = _loc5_;
                  }
                  _loc3_.push(_loc5_);
               }
            }
         }
         var_1950.setObjects(_loc3_);
         if(_loc2_ != null)
         {
            var_1950.trySelect(_loc2_);
         }
         else if(_loc1_ == null && _loc3_.length > 0)
         {
            var_1950.trySelect(_loc3_[0]);
         }
         else if(_loc1_ != null)
         {
            if(var_1950.selected == null)
            {
               var_1950.trySelect(_loc3_[0]);
            }
         }
         var_3731 = null;
      }
      
      private function updateHighlightButtonUI() : void
      {
         Util.disableSection(highlightHoldersButton,!canHighlightCurrentVariable);
      }
      
      private function onSelectVariable(param1:VariableTableObject) : void
      {
         updatePropertiesTableUI();
         updateTextTableUI();
         if(_highlightEnabled)
         {
            _highlighter.clear();
            if(canHighlightCurrentVariable)
            {
               requestHolders();
            }
         }
         updateHighlightButtonUI();
      }
      
      private function get canHighlightCurrentVariable() : Boolean
      {
         return selectedVariable != null && selectedVariable.isStored && (selectedVariable.variableType == WiredInputSourcePicker.USER_SOURCE || selectedVariable.variableType == WiredInputSourcePicker.var_1736);
      }
      
      private function onHighlightClick(param1:WindowMouseEvent) : void
      {
         if(_highlightEnabled)
         {
            stopHighlight();
         }
         else
         {
            startHighlight();
         }
      }
      
      private function startHighlight() : void
      {
         _highlightEnabled = true;
         highlightHoldersButton.caption = loc("wiredmenu.variable_overview.unhighlight_holders");
         requestHolders();
      }
      
      private function stopHighlight() : void
      {
         _highlightEnabled = false;
         highlightHoldersButton.caption = loc("wiredmenu.variable_overview.highlight_holders");
         _highlighter.clear();
      }
      
      private function onSelectVariableType(param1:int) : void
      {
         initializeInterface();
      }
      
      private function updatePropertiesTableUI() : void
      {
         var _loc2_:WiredVariable = getSelectedVariable();
         if(_loc2_ == null)
         {
            var_2845.clear();
            return;
         }
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         _loc1_.push(new PropertyTableObject("name",_loc2_.variableName,localization,true));
         _loc1_.push(new PropertyTableObject("type",getTypeString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("availability",getAvailabilityString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("has_value",_loc2_.hasValue,localization));
         _loc1_.push(new PropertyTableObject("can_write_to",_loc2_.canWriteValue,localization));
         _loc1_.push(new PropertyTableObject("can_create_delete",_loc2_.canCreateAndDelete,localization));
         _loc1_.push(new PropertyTableObject("can_intercept",_loc2_.canInterceptChanges,localization));
         _loc1_.push(new PropertyTableObject("is_always_available",_loc2_.alwaysAvailable,localization));
         _loc1_.push(new PropertyTableObject("can_read_creation_time",_loc2_.canReadCreationTime,localization));
         _loc1_.push(new PropertyTableObject("can_read_last_update_time",_loc2_.canReadLastUpdateTime,localization));
         _loc1_.push(new PropertyTableObject("is_text_connected",_loc2_.hasTextConnector,localization));
         var_2845.setObjects(_loc1_);
      }
      
      private function getTypeString(param1:WiredVariable) : String
      {
         switch(param1.variableType)
         {
            case WiredInputSourcePicker.var_1736:
               return loc("wiredfurni.params.sourcetype.furni");
            case WiredInputSourcePicker.USER_SOURCE:
               return loc("wiredfurni.params.sourcetype.users");
            case class_3819.GLOBAL_SOURCE:
               return loc("wiredfurni.params.sourcetype.global");
            case class_3819.CONTEXT_SOURCE:
               return loc("wiredfurni.params.sourcetype.context");
            default:
               return "";
         }
      }
      
      private function getAvailabilityString(param1:WiredVariable) : String
      {
         return localization.getLocalization("wiredfurni.params.variables.availability." + param1.availabilityType,loc("wiredfurni.params.variables.availability.misc"));
      }
      
      private function updateTextTableUI() : void
      {
         var _loc4_:String = null;
         var _loc6_:WiredVariable;
         var _loc3_:Boolean = (_loc6_ = getSelectedVariable()) == null || !_loc6_.hasTextConnector;
         if(_loc3_)
         {
            var_2751.clear();
            Util.disableSection(textsTableContainer);
            return;
         }
         if(!textsTableContainer.isEnabled())
         {
            Util.disableSection(textsTableContainer,false);
         }
         var _loc5_:Map;
         var _loc2_:Array = (_loc5_ = _loc6_.textConnector).getKeys();
         _loc2_.sort(16);
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc7_ in _loc2_)
         {
            _loc4_ = _loc5_.getValue(_loc7_);
            _loc1_.push(new TextTableObject(_loc7_,_loc4_));
         }
         var_2751.setObjects(_loc1_);
      }
      
      private function getSelectedVariable() : WiredVariable
      {
         var _loc1_:ITableObject = var_1950.selected;
         if(_loc1_ == null)
         {
            return null;
         }
         return (_loc1_ as VariableTableObject).variable;
      }
      
      override public function stopViewing() : void
      {
         super.stopViewing();
         if(_highlightEnabled)
         {
            _highlighter.clear();
         }
      }
      
      public function jumpToVariableByName(param1:String) : void
      {
         if(isDataReady())
         {
            findFocusVariable(param1);
            initializeInterface();
         }
         else
         {
            var_3435 = param1;
         }
      }
      
      private function findFocusVariable(param1:String) : void
      {
         var _loc2_:WiredVariable = getVariableByNameOrPrefix(param1);
         if(_loc2_ == null)
         {
            return;
         }
         var_1935.selectedType = _loc2_.variableType;
         var_3731 = _loc2_;
      }
      
      private function getVariableByNameOrPrefix(param1:String) : WiredVariable
      {
         var _loc2_:* = null;
         for each(var _loc3_ in var_2585)
         {
            if(!_loc3_.isInvisible)
            {
               if(_loc3_.variableName == param1)
               {
                  return _loc3_;
               }
               if(_loc2_ == null && _loc3_.variableName.indexOf(param1 + ".") == 0)
               {
                  _loc2_ = _loc3_;
               }
            }
         }
         return _loc2_;
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var_1935.update(param1);
         var _loc2_:int = getTimer();
         if(var_4677 < _loc2_ - POLL_MS)
         {
            requestData();
         }
         if(_highlightEnabled && var_4803 < _loc2_ - POLL_MS)
         {
            requestHolders();
         }
         _highlighter.update(param1);
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
         var_1950.dispose();
         var_1950 = null;
         var_2845.dispose();
         var_2845 = null;
         var_2751.dispose();
         var_2751 = null;
         var_2585 = null;
         _highlighter.dispose();
         _highlighter = null;
         super.dispose();
      }
      
      private function get variableListContainer() : IWindowContainer
      {
         return container.findChildByName("variable_list_container") as IWindowContainer;
      }
      
      private function get propertiesTableContainer() : IWindowContainer
      {
         return container.findChildByName("variable_properties_table_container") as IWindowContainer;
      }
      
      private function get textsTableContainer() : IWindowContainer
      {
         return container.findChildByName("variable_texts_table_container") as IWindowContainer;
      }
      
      private function get highlightHoldersButton() : class_3357
      {
         return container.findChildByName("highlight_holders_button") as class_3357;
      }
      
      private function get typePickerContainer() : IWindowContainer
      {
         return container.findChildByName("type_picker_container") as IWindowContainer;
      }
   }
}
