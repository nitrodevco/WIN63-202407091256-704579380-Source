package com.sulake.habbo.moderation
{
   public class ModActionDefinition
   {
      
      public static const ALERT:int = 1;
      
      public static const MUTE:int = 2;
      
      public static const BAN:int = 3;
      
      public static const KICK:int = 4;
      
      public static const TRADING_LOCK:int = 5;
      
      public static const MESSAGE:int = 6;
       
      
      private var var_4561:int;
      
      private var _name:String;
      
      private var var_683:int;
      
      private var var_4614:int;
      
      private var _actionLengthHours:int;
      
      public function ModActionDefinition(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         var_4561 = param1;
         _name = param2;
         var_683 = param3;
         var_4614 = param4;
         _actionLengthHours = param5;
      }
      
      public function get actionId() : int
      {
         return var_4561;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get actionType() : int
      {
         return var_683;
      }
      
      public function get sanctionTypeId() : int
      {
         return var_4614;
      }
      
      public function get actionLengthHours() : int
      {
         return _actionLengthHours;
      }
   }
}
