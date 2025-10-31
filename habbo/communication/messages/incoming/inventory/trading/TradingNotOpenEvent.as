package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenEvent;

   [SecureSWF(rename="true")]
   public class TradingNotOpenEvent extends MessageEvent
   {

      public function TradingNotOpenEvent(param1:Function)
      {
         super(param1, TradingNotOpenEvent);
      }

      public function getParser():TradingNotOpenEvent
      {
         return _parser as TradingNotOpenEvent;
      }
   }
}
