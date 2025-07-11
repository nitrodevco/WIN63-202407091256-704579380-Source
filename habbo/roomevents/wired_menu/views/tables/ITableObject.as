package com.sulake.habbo.roomevents.wired_menu.views.tables
{
   public interface ITableObject
   {
       
      
      function get identifier() : String;
      
      function isPropertyUpdated(param1:String, param2:Object) : Boolean;
      
      function isUpdated(param1:Object) : Boolean;
      
      function getTableCell(param1:String) : TableCell;
   }
}
