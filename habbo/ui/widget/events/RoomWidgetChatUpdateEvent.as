package com.sulake.habbo.ui.widget.events
{
   import flash.display.BitmapData;
   
   public class RoomWidgetChatUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const WIDGET_UPDATE_EVENT_CHAT:String = "RWCUE_EVENT_CHAT";
      
      public static const CHAT_TYPE_SPEAK:int = 0;
      
      public static const CHAT_TYPE_WHISPER:int = 1;
      
      public static const CHAT_TYPE_SHOUT:int = 2;
      
      public static const CHAT_TYPE_RESPECT:int = 3;
      
      public static const CHAT_TYPE_PETRESPECT:int = 4;
      
      public static const CHAT_TYPE_NOTIFY:int = 5;
      
      public static const CHAT_TYPE_PETTREAT:int = 6;
      
      public static const CHAT_TYPE_PETREVIVE:int = 7;
      
      public static const CHAT_TYPE_PET_REBREED_FERTILIZE:int = 8;
      
      public static const CHAT_TYPE_PET_SPEED_FERTILIZE:int = 9;
      
      public static const CHAT_TYPE_BOT_SPEAK:int = 10;
      
      public static const CHAT_TYPE_BOT_SHOUT:int = 11;
      
      public static const CHAT_TYPE_BOT_WHISPER:int = 12;
       
      
      private var var_418:int = 0;
      
      private var _text:String = "";
      
      private var var_2088:int = 0;
      
      private var _userName:String;
      
      private var var_343:Array;
      
      private var var_4707:Number;
      
      private var var_4587:Number;
      
      private var var_4391:BitmapData;
      
      private var _userColor:uint;
      
      private var var_369:int;
      
      private var var_4671:int;
      
      private var var_1347:int;
      
      private var var_4276:int;
      
      private var var_950:int;
      
      public function RoomWidgetChatUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:int, param6:int, param7:int, param8:Number, param9:Number, param10:BitmapData, param11:uint, param12:int, param13:int = 0, param14:int = 0, param15:Array = null, param16:Boolean = false, param17:Boolean = false)
      {
         super(param1,param16,param17);
         var_418 = param2;
         _text = param3;
         var_2088 = param13;
         _userName = param4;
         var_4671 = param5;
         var_1347 = param6;
         var_4276 = param7;
         var_343 = param15;
         var_4707 = param8;
         var_4587 = param9;
         var_4391 = param10;
         _userColor = param11;
         var_369 = param12;
         var_950 = param14;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get chatType() : int
      {
         return var_2088;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userCategory() : int
      {
         return var_4671;
      }
      
      public function get userType() : int
      {
         return var_1347;
      }
      
      public function get petType() : int
      {
         return var_4276;
      }
      
      public function get links() : Array
      {
         return var_343;
      }
      
      public function get userX() : Number
      {
         return var_4707;
      }
      
      public function get userY() : Number
      {
         return var_4587;
      }
      
      public function get userImage() : BitmapData
      {
         return var_4391;
      }
      
      public function get userColor() : uint
      {
         return _userColor;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get styleId() : int
      {
         return var_950;
      }
   }
}
