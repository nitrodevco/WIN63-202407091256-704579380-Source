package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptEventParser;

    [SecureSWF(rename="true")]
    public class TradingAcceptEvent extends MessageEvent
    {

        public function TradingAcceptEvent(param1:Function)
        {
            super(param1, TradingAcceptEventParser);
        }

        public function get userID():int
        {
            return getParser().userID;
        }

        public function get userAccepts():Boolean
        {
            return getParser().userAccepts;
        }

        public function getParser():TradingAcceptEventParser
        {
            return _parser as TradingAcceptEventParser;
        }
    }
}
