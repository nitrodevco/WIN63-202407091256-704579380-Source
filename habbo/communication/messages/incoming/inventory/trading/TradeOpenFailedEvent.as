package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradeOpenFailedEventPaser;

    [SecureSWF(rename="true")]
    public class TradeOpenFailedEvent extends MessageEvent
    {

        public function TradeOpenFailedEvent(param1:Function)
        {
            super(param1, TradeOpenFailedEventPaser);
        }

        public function getParser():TradeOpenFailedEventPaser
        {
            return _parser as TradeOpenFailedEventPaser;
        }
    }
}
