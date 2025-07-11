package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetSpamWallPostItFinishEditingMessage extends RoomWidgetMessage
   {
      
      public static const SEND_POSTIT_DATA:String = "RWSWPFEE_SEND_POSTIT_DATA";
       
      
      private var var_455:int;
      
      private var var_587:String;
      
      private var _text:String;
      
      private var var_821:String;
      
      public function RoomWidgetSpamWallPostItFinishEditingMessage(param1:String, param2:int, param3:String, param4:String, param5:String)
      {
         super(param1);
         var_455 = param2;
         var_587 = param3;
         _text = param4;
         var_821 = param5;
      }
      
      public function get location() : String
      {
         return var_587;
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
