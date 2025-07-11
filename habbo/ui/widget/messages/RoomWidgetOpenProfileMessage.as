package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetOpenProfileMessage extends RoomWidgetMessage
   {
      
      public static const const_777:String = "RWOPEM_OPEN_USER_PROFILE";
       
      
      private var var_418:int;
      
      private var var_4291:String;
      
      public function RoomWidgetOpenProfileMessage(param1:String, param2:int, param3:String)
      {
         super(param1);
         var_418 = param2;
         var_4291 = param3;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get trackingLocation() : String
      {
         return var_4291;
      }
   }
}
