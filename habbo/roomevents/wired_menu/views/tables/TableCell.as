package com.sulake.habbo.roomevents.wired_menu.views.tables
{
   public class TableCell
   {
      
      public static var var_2017:int = 0;
      
      public static var var_4815:int = 1;
       
      
      private var var_329:int;
      
      private var var_1738:Object;
      
      private var var_4304:Boolean;
      
      private var var_4294:Boolean;
      
      private var var_4308:String;
      
      private var _linkClickCallback:Function;
      
      private var _highlightOnChange:Boolean;
      
      private var var_3756:String;
      
      public function TableCell(param1:int, param2:Object, param3:Boolean = false, param4:Boolean = false, param5:String = null, param6:Function = null, param7:Boolean = false, param8:String = null)
      {
         super();
         var_329 = param1;
         var_1738 = param2;
         var_4294 = param3;
         var_4304 = param4;
         _linkClickCallback = param6;
         if(param5 == null && (param3 || param4))
         {
            param5 = param2 as String;
         }
         var_4308 = param5;
         _highlightOnChange = param7;
         var_3756 = param8;
      }
      
      public function get type() : int
      {
         return var_329;
      }
      
      public function get isEditable() : Boolean
      {
         return var_4294;
      }
      
      public function get contents() : Object
      {
         return var_1738;
      }
      
      public function get isInspectable() : Boolean
      {
         return var_4304;
      }
      
      public function get textFieldValue() : String
      {
         return var_4308;
      }
      
      public function get linkClickCallback() : Function
      {
         return _linkClickCallback;
      }
      
      public function get highlightOnChange() : Boolean
      {
         return _highlightOnChange;
      }
      
      public function get tooltipText() : String
      {
         return var_3756;
      }
      
      public function set tooltipText(param1:String) : void
      {
         var_3756 = param1;
      }
   }
}
