package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.room.utils.IVector3d;
   
   public class ChatItem
   {
       
      
      private var var_407:int = 0;
      
      private var var_418:int = 0;
      
      private var var_369:int = 0;
      
      private var _text:String = "";
      
      private var var_2088:int = 0;
      
      private var var_343:Array;
      
      private var _style:int;
      
      private var var_4731:IVector3d;
      
      private var _forcedColor:*;
      
      private var var_4361:*;
      
      private var var_4754:String;
      
      private var _forcedUserName:String;
      
      private var var_586:int;
      
      public function ChatItem(param1:RoomSessionChatEvent, param2:int, param3:IVector3d = null, param4:int = 0, param5:* = null, param6:* = null, param7:String = null, param8:String = null)
      {
         super();
         var_407 = param2;
         var_4731 = param3;
         var_418 = param1.userId;
         if(param1.session)
         {
            var_369 = param1.session.roomId;
         }
         else
         {
            var_369 = 1;
         }
         _text = param1.text;
         var_2088 = param1.chatType;
         _style = param1.style;
         var_343 = new Array(param1.links);
         _forcedColor = param6;
         var_4361 = param5;
         var_4754 = param7;
         _forcedUserName = param8;
         var_586 = param4;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get roomId() : int
      {
         return var_369;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get chatType() : int
      {
         return var_2088;
      }
      
      public function get links() : Array
      {
         return var_343;
      }
      
      public function get style() : int
      {
         return _style;
      }
      
      public function get timeStamp() : uint
      {
         return var_407;
      }
      
      public function get userLocation() : IVector3d
      {
         return var_4731;
      }
      
      public function get forcedColor() : *
      {
         return _forcedColor;
      }
      
      public function get forcedScreenLocation() : *
      {
         return var_4361;
      }
      
      public function get forcedFigure() : String
      {
         return var_4754;
      }
      
      public function get forcedUserName() : String
      {
         return _forcedUserName;
      }
      
      public function get extraParam() : int
      {
         return var_586;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
   }
}
