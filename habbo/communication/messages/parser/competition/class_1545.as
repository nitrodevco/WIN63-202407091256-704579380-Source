package com.sulake.habbo.communication.messages.parser.competition {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1545 implements IMessageParser {

        public function class_1545() {
            super();
        }
        private var var_1372: String;
        private var var_1078: String;

        public function get schedulingStr(): String {
            return var_1372;
        }

        public function get code(): String {
            return var_1078;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1372 = param1.readString();
            var_1078 = param1.readString();
            return true;
        }
    }
}
