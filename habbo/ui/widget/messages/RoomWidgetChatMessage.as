package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetChatMessage extends RoomWidgetMessage
   {
      
      public static const WIDGET_MESSAGE_CHAT:String = "RWCM_MESSAGE_CHAT";
      
      public static const CHAT_TYPE_SPEAK:int = 0;
      
      public static const CHAT_TYPE_WHISPER:int = 1;
      
      public static const CHAT_TYPE_SHOUT:int = 2;
       
      
      private var var_2088:int = 0;
      
      private var _text:String = "";
      
      private var _recipientName:String = "";
      
      private var var_950:int;
      
      public function RoomWidgetChatMessage(param1:String, param2:String, param3:int = 0, param4:String = "", param5:int = 0)
      {
         super(param1);
         _text = param2;
         var_2088 = param3;
         _recipientName = param4;
         var_950 = param5;
      }
      
      public function get chatType() : int
      {
         return var_2088;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get recipientName() : String
      {
         return _recipientName;
      }
      
      public function get styleId() : int
      {
         return var_950;
      }
   }
}
