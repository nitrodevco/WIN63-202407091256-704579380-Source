package com.sulake.habbo.session.handler
{
    import assets.class_14

    import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.class_1410;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_1072;
   
   public class AvatarEffectsHandler extends BaseHandler
   {
       
      
      public function AvatarEffectsHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
      }
      
      private function onAvatarEffects(param1:IMessageEvent) : void
      {
         var _loc3_:class_1072 = param1 as class_1072;
         var _loc2_:class_1410 = _loc3_.getParser() as class_1410;
         class_14.log("Received active avatar effects: " + _loc2_.effects);
         if(listener && listener.events)
         {
         }
      }
   }
}
