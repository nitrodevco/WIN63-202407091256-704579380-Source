package com.sulake.habbo.groups
{
   import com.sulake.habbo.communication.messages.incoming.users.class_1183;
   
   public class GuildSettingsData
   {
       
      
      private var var_1424:int = 0;
      
      private var var_3547:int = 0;
      
      private var var_3280:Boolean = false;
      
      public function GuildSettingsData(param1:class_1183 = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var_1424 = param1.guildType;
         var_3547 = param1.guildRightsLevel;
      }
      
      public function get guildType() : int
      {
         return var_1424;
      }
      
      public function set guildType(param1:int) : void
      {
         if(param1 != var_1424)
         {
            var_3280 = true;
         }
         var_1424 = param1;
      }
      
      public function get rightsLevel() : int
      {
         return var_3547;
      }
      
      public function set rightsLevel(param1:int) : void
      {
         if(param1 != var_3547)
         {
            var_3280 = true;
         }
         var_3547 = param1;
      }
      
      public function get isModified() : Boolean
      {
         return var_3280;
      }
      
      public function resetModified() : void
      {
         var_3280 = false;
      }
   }
}
