package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.class_500;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.class_702;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.class_809;
   import com.sulake.habbo.communication.messages.parser.room.permissions.class_1202;
   import com.sulake.habbo.communication.messages.parser.room.permissions.class_1250;
   
   public class RoomPermissionsHandler extends BaseHandler
   {
       
      
      public function RoomPermissionsHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new class_809(onYouAreController));
         param1.addMessageEvent(new class_702(onYouAreNotController));
         param1.addMessageEvent(new class_500(onYouAreOwner));
      }
      
      private function onYouAreController(param1:IMessageEvent) : void
      {
         var _loc4_:class_809;
         if((_loc4_ = param1 as class_809) == null)
         {
            return;
         }
         var _loc2_:class_1250 = _loc4_.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomControllerLevel = _loc2_.roomControllerLevel;
      }
      
      private function onYouAreNotController(param1:IMessageEvent) : void
      {
         var _loc4_:class_702;
         if((_loc4_ = param1 as class_702) == null)
         {
            return;
         }
         var _loc2_:class_1202 = _loc4_.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomControllerLevel = 0;
      }
      
      private function onYouAreOwner(param1:IMessageEvent) : void
      {
         var _loc3_:class_500 = param1 as class_500;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_1662);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.isRoomOwner = true;
      }
   }
}
