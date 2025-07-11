package com.sulake.habbo.groups
{
   public class GuildKickData
   {
       
      
      private var var_4445:int;
      
      private var var_4615:int;
      
      private var var_4793:Boolean;
      
      public function GuildKickData(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         var_4445 = param1;
         var_4615 = param2;
         var_4793 = param3;
      }
      
      public function get kickTargetId() : int
      {
         return var_4445;
      }
      
      public function get kickGuildId() : int
      {
         return var_4615;
      }
      
      public function get targetBlocked() : Boolean
      {
         return var_4793;
      }
   }
}
