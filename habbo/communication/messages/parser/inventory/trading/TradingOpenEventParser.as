package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.IMessageParser;

    [SecureSWF(rename = "true")]
        public class TradingOpenEventParser implements IMessageParser
        {

            public function TradingOpenEventParser()
            {
                super();
            }
            private var var_476:int;
        private var var_589:Boolean;
        private var var_504:int;
        private var var_612:Boolean;

        public function get userID():int
        {
            return var_476;
        }

        public function get userCanTrade():Boolean
        {
            return var_589;
        }

        public function get otherUserID():int
        {
            return var_504;
        }

        public function get otherUserCanTrade():Boolean
        {
            return var_612;
        }

        public function flush():Boolean
        {
            var_476 = -1;
            var_589 = false;
            var_504 = -1;
            var_612 = false;
            return true;
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var_476 = param1.readInteger();
            var_589 = param1.readInteger() == 1;
            var_504 = param1.readInteger();
            var_612 = param1.readInteger() == 1;
            return true;
        }
    }
}
