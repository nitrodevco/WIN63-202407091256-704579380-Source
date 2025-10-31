package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;

   [SecureSWF(rename = "true")]
      public class TradingNotOpenEvent implements IMessageParser
      {

         public function TradingNotOpenEvent()
         {
            super();
         }

         public function flush():Boolean
         {
            return true;
         }

         public function parse(param1:IMessageDataWrapper):Boolean
         {
            return true;
         }
      }
   }
