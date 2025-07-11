package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetConversionPointMessage extends RoomWidgetMessage
   {
      
      public static const const_556:String = "RWCPM_CONVERSION_POINT";
       
      
      private var var_638:String;
      
      private var var_4650:String;
      
      private var _action:String;
      
      private var _extraString:String;
      
      private var var_1483:int;
      
      public function RoomWidgetConversionPointMessage(param1:String, param2:String, param3:String, param4:String, param5:String = "", param6:int = 0)
      {
         super(param1);
         var_638 = param2;
         var_4650 = param3;
         _action = param4;
         _extraString = !!param5 ? param5 : "";
         var_1483 = !!param6 ? param6 : 0;
      }
      
      public function get category() : String
      {
         return var_638;
      }
      
      public function get pointType() : String
      {
         return var_4650;
      }
      
      public function get action() : String
      {
         return _action;
      }
      
      public function get extraString() : String
      {
         return _extraString;
      }
      
      public function get extraInt() : int
      {
         return var_1483;
      }
   }
}
