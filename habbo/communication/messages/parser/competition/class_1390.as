package com.sulake.habbo.communication.messages.parser.competition {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1390 implements IMessageParser {

        public function class_1390() {
            super();
        }
        private var var_1191: String;
        private var var_1038: int;

        public function get timeStr(): String {
            return var_1191;
        }

        public function get secondsUntil(): int {
            return var_1038;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1191 = param1.readString();
            var_1038 = param1.readInteger();
            return true;
        }
    }
}
