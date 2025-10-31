package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedEventParser;

    [SecureSWF(rename="true")]
    public class TradingCompletedEvent extends MessageEvent
    {

        public function TradingCompletedEvent(param1:Function)
        {
            super(param1, TradingCompletedEventParser);
        }

        public function getParser():TradingCompletedEventParser
        {
            return _parser as TradingCompletedEventParser;
        }
    }
}
