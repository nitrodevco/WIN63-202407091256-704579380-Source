package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseEventParser;

    [SecureSWF(rename="true")]
    public class TradingCloseEvent extends MessageEvent
    {

        public function TradingCloseEvent(param1:Function)
        {
            super(param1, TradingCloseEventParser);
        }

        public function get userID():int
        {
            return getParser().userID;
        }

        public function getParser():TradingCloseEventParser
        {
            return _parser as TradingCloseEventParser;
        }
    }
}
