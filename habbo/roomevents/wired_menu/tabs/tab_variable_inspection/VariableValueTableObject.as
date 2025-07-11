package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_inspection
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.ITableObject;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableCell;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class VariableValueTableObject implements ITableObject
   {
       
      
      private var _highlightChanges:Boolean;
      
      private var var_1318:WiredVariable;
      
      private var _value:int;
      
      private var var_646:Boolean;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function VariableValueTableObject(param1:WiredVariable, param2:int, param3:Boolean, param4:Boolean, param5:HabboUserDefinedRoomEvents)
      {
         super();
         var_1318 = param1;
         _value = param2;
         var_646 = param3;
         _highlightChanges = param4;
         _roomEvents = param5;
      }
      
      public function get identifier() : String
      {
         return String(var_1318.variableId);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:VariableValueTableObject = param2 as VariableValueTableObject;
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VARIABLE)
         {
            return var_1318.variableName != _loc3_.variable.variableName;
         }
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VALUE)
         {
            if(var_1318.hasValue != _loc3_.variable.hasValue)
            {
               return true;
            }
            if(!var_1318.hasValue)
            {
               return false;
            }
            return _value != _loc3_.value || Util.getConnectedText(variable,_value) != Util.getConnectedText(_loc3_.variable,_loc3_.value);
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return isPropertyUpdated(WiredMenuInspectionTab.VARIABLES_COLUMN_VALUE,param1) || isPropertyUpdated(WiredMenuInspectionTab.VARIABLES_COLUMN_VARIABLE,param1);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         var _loc2_:String = null;
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VARIABLE)
         {
            return new TableCell(TableCell.var_2017,Util.variableDisplayName(var_1318,_roomEvents.wiredMenu.variableSyntaxMode),false,true,var_1318.variableName);
         }
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VALUE)
         {
            if(var_1318.hasValue)
            {
               _loc2_ = Util.variableValueWithString(var_1318,_value);
               return new TableCell(TableCell.var_2017,_loc2_,var_1318.canWriteValue && var_646,true,String(_value),null,_highlightChanges);
            }
            return new TableCell(TableCell.var_2017,"");
         }
         return null;
      }
      
      public function get variable() : WiredVariable
      {
         return var_1318;
      }
      
      public function get value() : int
      {
         return _value;
      }
   }
}
