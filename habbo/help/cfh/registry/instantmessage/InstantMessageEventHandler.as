package com.sulake.habbo.help.cfh.registry.instantmessage
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.communication.messages.parser.friendlist.class_1187;
   import com.sulake.habbo.communication.messages.parser.friendlist.class_1500;
   import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
   
   public class InstantMessageEventHandler implements IDisposable
   {
       
      
      private var var_1660:HabboHelp;
      
      public function InstantMessageEventHandler(param1:HabboHelp)
      {
         super();
         var_1660 = param1;
         var_1660.addMessageEvent(new NewConsoleMessageEvent(onInstantMessage));
         var_1660.addMessageEvent(new RoomInviteEvent(onRoomInvite));
      }
      
      public function onInstantMessage(param1:NewConsoleMessageEvent) : void
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
      
      public function onRoomInvite(param1:RoomInviteEvent) : void
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
