package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class DisconnectReasonEventParser implements IMessageParser {

        public function DisconnectReasonEventParser() {
            super();
            var_326 = -1;
        }
        private var var_326: int;

        public function get reason(): int {
            return var_326;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1.bytesAvailable) {
                var_326 = param1.readInteger();
            }
            return true;
        }
    }
}
