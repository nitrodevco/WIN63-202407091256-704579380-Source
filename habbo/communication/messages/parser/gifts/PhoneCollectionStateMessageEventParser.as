package com.sulake.habbo.communication.messages.parser.gifts {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class PhoneCollectionStateMessageEventParser implements IMessageParser {

        public function PhoneCollectionStateMessageEventParser() {
            super();
        }
        private var var_578: int;
        private var var_1286: int;
        private var var_383: int;

        public function get phoneStatusCode(): int {
            return var_578;
        }

        public function get collectionStatusCode(): int {
            return var_1286;
        }

        public function get millisecondsToAllowProcessReset(): int {
            return var_383;
        }

        public function flush(): Boolean {
            var_578 = -1;
            var_383 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_578 = param1.readInteger();
            var_1286 = param1.readInteger();
            var_383 = param1.readInteger();
            return true;
        }
    }
}
