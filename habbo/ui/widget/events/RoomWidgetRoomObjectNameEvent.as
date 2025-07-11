package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectNameEvent extends RoomWidgetUpdateEvent
   {
      
      public static const OBJECT_NAME:String = "RWONE_TYPE";
       
      
      private var var_418:int;
      
      private var var_638:int;
      
      private var _userName:String;
      
      private var var_1347:int;
      
      private var var_871:int;
      
      public function RoomWidgetRoomObjectNameEvent(param1:int, param2:int, param3:String, param4:int, param5:int)
      {
         var_418 = param1;
         var_638 = param2;
         _userName = param3;
         var_1347 = param4;
         var_871 = param5;
         super("RWONE_TYPE",false,false);
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get category() : int
      {
         return var_638;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userType() : int
      {
         return var_1347;
      }
      
      public function get roomIndex() : int
      {
         return var_871;
      }
   }
}
