package com.sulake.habbo.communication.messages.parser.camera {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1488 implements IMessageParser {

        public function class_1488() {
            super();
        }
        private var var_344: Boolean = false;
        private var var_524: int = 0;
        private var var_573: String;

        public function isOk(): Boolean {
            return var_344;
        }

        public function getSecondsToWait(): int {
            return var_524;
        }

        public function getExtraDataId(): String {
            return var_573;
        }

        public function flush(): Boolean {
            var_344 = false;
            var_524 = 0;
            var_573 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_344 = param1.readBoolean();
            var_524 = param1.readInteger();
            if (var_344 && param1.bytesAvailable) {
                var_573 = param1.readString();
            }
            return true;
        }
    }
}
