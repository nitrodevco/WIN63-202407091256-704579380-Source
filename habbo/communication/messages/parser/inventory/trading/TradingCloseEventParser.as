package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.core.communication.messages.IMessageParser;

    [SecureSWF(rename = "true")]
        public class TradingCloseEventParser implements IMessageParser
        {

            public static const const_235:int = 1;

        public function TradingCloseEventParser()
        {
            super();
        }
        private var var_418:int;
        private var var_326:int;

        public function get userID():int
        {
            return var_418;
        }

        public function get reason():int
        {
            return var_326;
        }

        public function flush():Boolean
        {
            return true;
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var_418 = param1.readInteger();
            var_326 = param1.readInteger();
            return true;
        }
    }
}
