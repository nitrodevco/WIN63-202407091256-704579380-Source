package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   
   public class RoomSessionEventHandler implements IDisposable
   {
       
      
      private var var_1660:HabboFreeFlowChat;
      
      public function RoomSessionEventHandler(param1:HabboFreeFlowChat)
      {
         super();
         var_1660 = param1;
         var_1660.roomSessionManager.events.addEventListener("RSE_CREATED",onRoomSessionCreated);
         var_1660.roomSessionManager.events.addEventListener("RSE_ENDED",onRoomSessionEnded);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1660)
            {
               var_1660.roomSessionManager.events.removeEventListener("RSE_CREATED",onRoomSessionCreated);
               var_1660.roomSessionManager.events.removeEventListener("RSE_ENDED",onRoomSessionEnded);
               var_1660 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1660 == null;
      }
      
      private function onRoomSessionCreated(param1:RoomSessionEvent) : void
      {
         var_1660.roomEntered();
      }
      
      private function onRoomSessionEnded(param1:RoomSessionEvent) : void
      {
         var_1660.roomLeft();
      }
   }
}
