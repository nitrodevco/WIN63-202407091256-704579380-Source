package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationEventParser;

    [SecureSWF(rename="true")]
    public class TradingConfirmationEvent extends MessageEvent
    {

        public function TradingConfirmationEvent(param1:Function)
        {
            super(param1, TradingConfirmationEventParser);
        }

        public function getParser():TradingConfirmationEventParser
        {
            return _parser as TradingConfirmationEventParser;
        }
    }
}
