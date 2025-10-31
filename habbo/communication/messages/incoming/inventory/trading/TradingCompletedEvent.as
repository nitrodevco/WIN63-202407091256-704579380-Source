package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.class_1125;

    [SecureSWF(rename = "true")]
        public class TradingCompletedEvent extends MessageEvent
        {

            public function TradingCompletedEvent(param1:Function)
            {
                super(param1, class_1125);
            }

            public function getParser():class_1125
            {
                return _parser as class_1125;
            }
        }
    }
