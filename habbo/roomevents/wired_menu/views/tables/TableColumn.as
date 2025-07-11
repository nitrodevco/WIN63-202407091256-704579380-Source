package com.sulake.habbo.roomevents.wired_menu.views.tables
{
   public class TableColumn
   {
       
      
      private var var_280:String;
      
      private var _columnName:String;
      
      private var var_4678:Number;
      
      private var var_3819:String;
      
      public function TableColumn(param1:String, param2:String, param3:Number, param4:String = "center")
      {
         super();
         var_280 = param1;
         _columnName = param2;
         var_4678 = param3;
         if(param4 == "left")
         {
            param4 = "none";
         }
         var_3819 = param4;
      }
      
      public function get id() : String
      {
         return var_280;
      }
      
      public function get columnName() : String
      {
         return _columnName;
      }
      
      public function get widthFactor() : Number
      {
         return var_4678;
      }
      
      public function get alignment() : String
      {
         return var_3819;
      }
   }
}
