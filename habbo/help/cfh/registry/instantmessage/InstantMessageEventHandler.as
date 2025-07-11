package com.sulake.habbo.help.cfh.registry.instantmessage
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.communication.messages.parser.friendlist.class_1187;
   import com.sulake.habbo.communication.messages.parser.friendlist.class_1500;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_193;
   import com.sulake.habbo.communication.messages.incoming.friendlist.class_609;
   
   public class InstantMessageEventHandler implements IDisposable
   {
       
      
      private var var_1660:HabboHelp;
      
      public function InstantMessageEventHandler(param1:HabboHelp)
      {
         super();
         var_1660 = param1;
         var_1660.addMessageEvent(new class_609(onInstantMessage));
         var_1660.addMessageEvent(new class_193(onRoomInvite));
      }
      
      public function onInstantMessage(param1:class_609) : void
      {
         var _loc2_:class_1500 = param1.getParser();
         if(_loc2_.chatId < 0)
         {
            var_1660.instantMessageRegistry.addItem(_loc2_.chatId,_loc2_.senderName,_loc2_.messageText);
         }
         else
         {
            var_1660.instantMessageRegistry.addItem(_loc2_.chatId,_loc2_.senderName,_loc2_.messageText);
         }
      }
      
      public function onRoomInvite(param1:class_193) : void
      {
         var _loc2_:class_1187 = param1.getParser();
         var_1660.instantMessageRegistry.addItem(_loc2_.senderId,"",_loc2_.messageText);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1660)
            {
               var_1660 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
   }
}
