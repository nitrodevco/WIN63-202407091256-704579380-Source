package com.sulake.habbo.game
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.class_1090;
   import com.sulake.habbo.communication.messages.incoming.availability.class_686;
   import com.sulake.habbo.communication.messages.incoming.availability.class_960;
   
   public class IncomingMessages implements IDisposable
   {
       
      
      private var _gameManager:HabboGameManager;
      
      private var var_318:Boolean = false;
      
      public function IncomingMessages(param1:HabboGameManager)
      {
         super();
         _gameManager = param1;
         var _loc2_:IHabboCommunicationManager = _gameManager.communication;
         _loc2_.addHabboConnectionMessageEvent(new class_1090(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new class_960(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new class_686(onHotelClosed));
      }
      
      public function dispose() : void
      {
         _gameManager = null;
         var_318 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_318;
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         _gameManager.hotelClosed = true;
      }
   }
}
