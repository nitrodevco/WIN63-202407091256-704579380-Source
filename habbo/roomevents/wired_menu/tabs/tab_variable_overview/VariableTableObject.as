package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.ITableObject;
   import com.sulake.habbo.roomevents.wired_menu.views.tables.TableCell;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   
   public class VariableTableObject implements ITableObject
   {
       
      
      private var var_1318:WiredVariable;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function VariableTableObject(param1:WiredVariable, param2:HabboUserDefinedRoomEvents)
      {
         super();
         var_1318 = param1;
         _roomEvents = param2;
      }
      
      public function get identifier() : String
      {
         return String(var_1318.variableId);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:WiredVariable = (param2 as VariableTableObject).variable;
         if(param1 == WiredMenuOverviewTab.LIST_COLUMN_NAME)
         {
            return var_1318.variableName != _loc3_.variableName;
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:WiredVariable = (param1 as VariableTableObject).variable;
         return var_1318.variableName != _loc2_.variableName;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         if(param1 == WiredMenuOverviewTab.LIST_COLUMN_NAME)
         {
            return new TableCell(TableCell.var_2017,Util.variableDisplayName(variable,_roomEvents.wiredMenu.variableSyntaxMode));
         }
         return null;
      }
      
      public function get variable() : WiredVariable
      {
         return var_1318;
      }
   }
}
