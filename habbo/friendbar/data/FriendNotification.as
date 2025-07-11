package com.sulake.habbo.friendbar.data
{
   public class FriendNotification implements IFriendNotification
   {
      
      public static const TYPE_MESSENGER:int = -1;
      
      public static const const_794:int = 0;
      
      public static const const_1057:int = 1;
      
      public static const TYPE_QUEST:int = 2;
      
      public static const TYPE_PLAYING_GAME:int = 3;
      
      public static const TYPE_FINISHED_GAME:int = 4;
       
      
      private var var_553:int = -1;
      
      private var var_368:String;
      
      private var var_4211:Boolean;
      
      public function FriendNotification(param1:int, param2:String, param3:Boolean)
      {
         super();
         this.var_553 = param1;
         this.var_368 = param2;
         this.var_4211 = param3;
      }
      
      public static function typeCodeToString(param1:int) : String
      {
         switch(param1 - -1)
         {
            case 0:
               return "instant_message";
            case 1:
               return "room_event";
            case 2:
               return "achievement";
            case 3:
               return "quest";
            case 4:
               return "playing_game";
            case 5:
               return "finished_game";
            default:
               return "unknown";
         }
      }
      
      public function get typeCode() : int
      {
         return var_553;
      }
      
      public function set typeCode(param1:int) : void
      {
         var_553 = param1;
      }
      
      public function get message() : String
      {
         return var_368;
      }
      
      public function set message(param1:String) : void
      {
         var_368 = param1;
      }
      
      public function get viewOnce() : Boolean
      {
         return var_4211;
      }
      
      public function set viewOnce(param1:Boolean) : void
      {
         var_4211 = param1;
      }
   }
}
