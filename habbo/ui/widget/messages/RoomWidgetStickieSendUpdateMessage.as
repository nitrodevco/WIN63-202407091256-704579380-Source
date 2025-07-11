package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetStickieSendUpdateMessage extends RoomWidgetMessage
   {
      
      public static const const_1071:String = "RWSUM_STICKIE_SEND_UPDATE";
      
      public static const const_710:String = "RWSUM_STICKIE_SEND_DELETE";
       
      
      private var var_455:int;
      
      private var _text:String;
      
      private var var_821:String;
      
      public function RoomWidgetStickieSendUpdateMessage(param1:String, param2:int, param3:String = "", param4:String = "")
      {
         super(param1);
         var_455 = param2;
         _text = param3;
         var_821 = param4;
      }
      
      public function get objectId() : int
      {
         return var_455;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return var_821;
      }
   }
}
