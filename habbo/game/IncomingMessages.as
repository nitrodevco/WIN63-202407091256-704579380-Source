package com.sulake.habbo.game
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   
   public class IncomingMessages implements IDisposable
   {
       
      
      private var _gameManager:HabboGameManager;
      
      private var var_318:Boolean = false;
      
      public function IncomingMessages(param1:HabboGameManager)
      {
         super();
         _gameManager = param1;
         var _loc2_:IHabboCommunicationManager = _gameManager.communication;
         _loc2_.addHabboConnectionMessageEvent(new MaintenanceStatusMessageEvent(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosed));
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
