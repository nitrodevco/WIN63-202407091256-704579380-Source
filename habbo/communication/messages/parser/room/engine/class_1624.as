package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1624 implements IMessageParser {

        public function class_1624() {
            super();
        }
        private var var_638: int;
        private var var_280: int;
        private var var_467: String;
        private var var_528: String;

        public function get category(): int {
            return var_638;
        }

        public function get id(): int {
            return var_280;
        }

        public function get confirmTitle(): String {
            return var_467;
        }

        public function get confirmBody(): String {
            return var_528;
        }

        public function flush(): Boolean {
            var_638 = 0;
            var_280 = 0;
            var_528 = null;
            var_467 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_638 = param1.readInteger() == 1 ? 20 : 10;
            var_280 = param1.readInteger();
            var_467 = param1.readString();
            var_528 = param1.readString();
            return true;
        }
    }
}
