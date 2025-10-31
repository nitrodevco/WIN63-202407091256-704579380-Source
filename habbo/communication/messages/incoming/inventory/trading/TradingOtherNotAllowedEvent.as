package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedEventParser;

    [SecureSWF(rename="true")]
    public class TradingOtherNotAllowedEvent extends MessageEvent
    {

        public function TradingOtherNotAllowedEvent(param1:Function)
        {
            super(param1, TradingOtherNotAllowedEventParser);
        }

        public function getParser():TradingOtherNotAllowedEventParser
        {
            return _parser as TradingOtherNotAllowedEventParser;
        }
    }
}
