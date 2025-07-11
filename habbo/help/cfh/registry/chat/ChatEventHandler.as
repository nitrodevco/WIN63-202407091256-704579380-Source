package com.sulake.habbo.help.cfh.registry.chat
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1675;
   
   public class ChatEventHandler implements IDisposable
   {
       
      
      private var var_1660:HabboHelp;
      
      public function ChatEventHandler(param1:HabboHelp)
      {
         super();
         var_1660 = param1;
         var_1660.roomSessionManager.events.addEventListener("RSCE_CHAT_EVENT",onRoomChat);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1660)
            {
               var_1660.roomSessionManager.events.removeEventListener("RSCE_CHAT_EVENT",onRoomChat);
               var_1660 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
      
      private function onRoomChat(param1:RoomSessionChatEvent) : void
      {
         var _loc2_:class_3490 = var_1660.roomSessionManager.getSession(param1.session.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc3_:class_1675 = var_1660.navigator.enteredGuestRoomData;
         if(!_loc2_ || _loc2_.type != 1 || !_loc3_)
         {
            return;
         }
         var _loc4_:String = !!_loc3_ ? _loc3_.roomName : "Unknown Room";
         var_1660.chatRegistry.addItem(param1.session.roomId,_loc4_,_loc2_.webID,_loc2_.name,param1.text);
      }
   }
}
