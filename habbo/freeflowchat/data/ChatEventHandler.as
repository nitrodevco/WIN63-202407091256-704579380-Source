package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.game.events.GameChatEvent;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IVector3d;
   import flash.utils.getTimer;
   
   public class ChatEventHandler implements IDisposable
   {
      
      public static const CHAT_STYLE_SNOWWAR_RED:int = 120;
      
      public static const CHAT_STYLE_SNOWWAR_BLUE:int = 121;
       
      
      private var var_1660:HabboFreeFlowChat;
      
      private var var_4852:uint = 0;
      
      private var var_3317:uint = 0;
      
      public function ChatEventHandler(param1:HabboFreeFlowChat)
      {
         super();
         var_1660 = param1;
         var_1660.roomSessionManager.events.addEventListener("RSCE_CHAT_EVENT",onRoomChat);
         if(var_1660.gameManager)
         {
            var_1660.gameManager.events.addEventListener("gce_game_chat",gameEventHandler);
         }
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_1660)
            {
               var_1660.roomSessionManager.events.removeEventListener("RSCE_CHAT_EVENT",onRoomChat);
               var_1660.gameManager.events.removeEventListener("gce_game_chat",gameEventHandler);
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
         var _loc3_:IRoomObject = var_1660.roomEngine.getRoomObject(param1.session.roomId,param1.userId,100);
         var _loc4_:IVector3d = null;
         if(_loc3_ != null)
         {
            _loc4_ = _loc3_.getLocation();
         }
         var _loc2_:uint = uint(getTimer());
         if(_loc2_ == var_4852)
         {
            var_3317++;
         }
         else
         {
            var_3317 = 0;
         }
         var_1660.insertChat(new ChatItem(param1,_loc2_ + var_3317,_loc4_,param1.extraParam));
         var_4852 = _loc2_;
      }
      
      private function gameEventHandler(param1:GameChatEvent) : void
      {
         var _loc3_:int = param1.teamId == 1 ? 121 : 120;
         var _loc2_:RoomSessionChatEvent = new RoomSessionChatEvent("RSCE_CHAT_EVENT",null,param1.userId,param1.message,0,_loc3_);
         var_1660.insertChat(new ChatItem(_loc2_,getTimer(),null,0,param1.locX,param1.color,param1.figure,param1.name));
      }
   }
}
