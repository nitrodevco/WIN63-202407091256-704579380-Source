package com.sulake.habbo.game.events
{
   import flash.events.Event;
   
   public class GameChatEvent extends Event
   {
      
      public static const GAME_CHAT:String = "gce_game_chat";
       
      
      private var var_418:int;
      
      private var var_368:String;
      
      private var var_1074:int;
      
      private var _color:uint;
      
      private var var_426:String;
      
      private var var_129:String;
      
      private var _name:String;
      
      private var var_893:int;
      
      private var var_2856:Boolean;
      
      public function GameChatEvent(param1:String, param2:int, param3:String, param4:int, param5:uint, param6:String, param7:String, param8:String, param9:int, param10:Boolean, param11:Boolean = false, param12:Boolean = false)
      {
         super(param1,param11,param12);
         var_418 = param2;
         var_368 = param3;
         var_1074 = param4;
         _color = param5;
         var_426 = param6;
         var_129 = param7;
         _name = param8;
         var_893 = param9;
         var_2856 = param10;
      }
      
      public function get userId() : int
      {
         return var_418;
      }
      
      public function get message() : String
      {
         return var_368;
      }
      
      public function get locX() : int
      {
         return var_1074;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get figure() : String
      {
         return var_426;
      }
      
      public function get gender() : String
      {
         return var_129;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get teamId() : int
      {
         return var_893;
      }
      
      public function get notify() : Boolean
      {
         return var_2856;
      }
   }
}
