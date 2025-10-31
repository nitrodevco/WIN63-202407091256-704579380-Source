package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedEventParser;

    [SecureSWF(rename="true")]
    public class TradingYouAreNotAllowedEvent extends MessageEvent
    {

        public function TradingYouAreNotAllowedEvent(param1:Function)
        {
            super(param1, TradingYouAreNotAllowedEventParser);
        }

        public function getParser():TradingYouAreNotAllowedEventParser
        {
            return _parser as TradingYouAreNotAllowedEventParser;
        }
    }
}
