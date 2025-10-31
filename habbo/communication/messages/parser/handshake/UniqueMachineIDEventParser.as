package com.sulake.habbo.communication.messages.parser.handshake {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class UniqueMachineIDEventParser implements IMessageParser {

        public function UniqueMachineIDEventParser() {
            super();
            var_233 = "";
        }
        private var var_233: String;

        public function get machineID(): String {
            return var_233;
        }

        public function flush(): Boolean {
            var_233 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_233 = param1.readString();
            return true;
        }
    }
}
