package com.sulake.habbo.session.handler
{
    import assets.class_14

    import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_3490;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.communication.messages.parser.users.class_1239;
   import com.sulake.habbo.communication.messages.parser.users.class_1357;
   import com.sulake.habbo.communication.messages.parser.room.chat.class_1344;
   import com.sulake.habbo.communication.messages.parser.room.chat.class_1558;
   import com.sulake.habbo.communication.messages.incoming.room.chat.class_1092;
   import com.sulake.habbo.communication.messages.incoming.room.chat.class_184;
   import com.sulake.habbo.communication.messages.incoming.room.chat.class_372;
   import com.sulake.habbo.communication.messages.incoming.room.chat.class_468;
   import com.sulake.habbo.communication.messages.incoming.room.chat.class_921;
   import com.sulake.habbo.communication.messages.incoming.users.class_147;
   import com.sulake.habbo.communication.messages.incoming.users.class_196;
   import com.sulake.habbo.communication.messages.incoming.users.class_630;
   import com.sulake.habbo.communication.messages.incoming.users.class_799;
   
   public class RoomChatHandler extends BaseHandler
   {
       
      
      public function RoomChatHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new class_184(onRoomChat));
         param1.addMessageEvent(new class_372(onRoomWhisper));
         param1.addMessageEvent(new class_468(onRoomShout));
         param1.addMessageEvent(new class_799(onRespectNotification));
         param1.addMessageEvent(new class_147(onPetRespectNotification));
         param1.addMessageEvent(new class_630(onPetSupplementedNotification));
         param1.addMessageEvent(new class_921(onFloodControl));
         param1.addMessageEvent(new class_196(onHandItemNotification));
         param1.addMessageEvent(new class_1092(onRemainingMutePeriod));
      }
      
      private function onRoomChat(param1:IMessageEvent) : void
      {
         var _loc2_:class_184 = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:class_1344 = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as class_184;
            if(_loc2_ && _loc2_.getParser())
            {
               if((_loc4_ = listener.getSession(var_1662)) == null)
               {
                  return;
               }
               _loc5_ = "RSCE_CHAT_EVENT";
               _loc6_ = 0;
               _loc3_ = _loc2_.getParser();
               if(_loc3_.trackingId != -1)
               {
                  _loc4_.receivedChatWithTrackingId(_loc3_.trackingId);
               }
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.userId,_loc3_.text,_loc6_,_loc3_.styleId,_loc3_.links));
            }
         }
      }
      
      private function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc3_:class_3490 = null;
         var _loc6_:String = null;
         var _loc2_:class_799 = param1 as class_799;
         if(listener && listener.events)
         {
            if((_loc4_ = listener.getSession(var_1662)) == null)
            {
               return;
            }
            _loc5_ = "RSCE_CHAT_EVENT";
            _loc7_ = 3;
            _loc3_ = _loc4_.userDataManager.getUserData(_loc2_.userId);
            if(_loc3_ == null)
            {
               return;
            }
            _loc6_ = "";
            listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.roomObjectId,_loc6_,_loc7_,1));
         }
      }
      
      private function onPetRespectNotification(param1:class_147) : void
      {
         if(param1 == null || listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:class_1239 = param1.getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IRoomSession;
         if((_loc4_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc5_:String = "RSCE_CHAT_EVENT";
         var _loc6_:int = 4;
         if(_loc3_.isTreat())
         {
            _loc6_ = 6;
         }
         var _loc2_:class_3490 = _loc4_.userDataManager.getPetUserData(_loc3_.petData.id);
         if(_loc2_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc2_.roomObjectId,"",_loc6_,1));
      }
      
      private function onPetSupplementedNotification(param1:class_630) : void
      {
         if(param1 == null || listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:class_1357 = param1.getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IRoomSession;
         if((_loc4_ = listener.getSession(var_1662)) == null)
         {
            return;
         }
         var _loc7_:String = "RSCE_CHAT_EVENT";
         var _loc8_:int = 7;
         switch(_loc3_.supplementType - 2)
         {
            case 0:
               _loc8_ = 7;
               break;
            case 1:
               _loc8_ = 8;
               break;
            case 2:
               _loc8_ = 9;
         }
         var _loc2_:class_3490 = _loc4_.userDataManager.getPetUserData(_loc3_.petId);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc6_:int = -1;
         var _loc5_:class_3490;
         if((_loc5_ = _loc4_.userDataManager.getUserData(_loc3_.userId)) != null)
         {
            _loc6_ = _loc5_.roomObjectId;
         }
         listener.events.dispatchEvent(new RoomSessionChatEvent(_loc7_,_loc4_,_loc2_.roomObjectId,"",_loc8_,1,null,_loc6_));
      }
      
      private function onHandItemNotification(param1:class_196) : void
      {
         var _loc2_:IRoomSession = null;
         if(listener && listener.events)
         {
            _loc2_ = listener.getSession(var_1662);
            if(_loc2_)
            {
               listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_loc2_,param1.giverUserId,"",5,1,null,param1.handItemType));
            }
         }
      }
      
      private function onRemainingMutePeriod(param1:class_1092) : void
      {
         var _loc2_:IRoomSession = null;
         if(listener && listener.events)
         {
            _loc2_ = listener.getSession(var_1662);
            if(_loc2_)
            {
               listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_loc2_,_loc2_.ownUserRoomId,"",10,1,null,param1.secondsRemaining));
            }
         }
      }
      
      private function onRoomWhisper(param1:IMessageEvent) : void
      {
         var _loc2_:class_372 = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:class_1344 = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as class_372;
            if(_loc2_ && _loc2_.getParser())
            {
               if((_loc4_ = listener.getSession(var_1662)) == null)
               {
                  return;
               }
               _loc5_ = "RSCE_CHAT_EVENT";
               _loc6_ = 1;
               _loc3_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.userId,_loc3_.text,_loc6_,_loc3_.styleId,_loc3_.links));
            }
         }
      }
      
      private function onRoomShout(param1:IMessageEvent) : void
      {
         var _loc2_:class_468 = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:class_1344 = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as class_468;
            if(_loc2_ && _loc2_.getParser())
            {
               if((_loc4_ = listener.getSession(var_1662)) == null)
               {
                  return;
               }
               _loc5_ = "RSCE_CHAT_EVENT";
               _loc6_ = 2;
               _loc3_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.userId,_loc3_.text,_loc6_,_loc3_.styleId,_loc3_.links));
            }
         }
      }
      
      private function onFloodControl(param1:IMessageEvent) : void
      {
         var _loc3_:class_1558 = null;
         var _loc4_:IRoomSession = null;
         var _loc2_:int = 0;
         if(listener && listener.events)
         {
            _loc3_ = (param1 as class_921).getParser();
            if((_loc4_ = listener.getSession(var_1662)) == null)
            {
               return;
            }
            _loc2_ = _loc3_.seconds;
            class_14.log("received flood control event for " + _loc2_ + " seconds");
            listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_FLOOD_EVENT",_loc4_,-1,"" + _loc2_,0,0,null));
         }
      }
   }
}
