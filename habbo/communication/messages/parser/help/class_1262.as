package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1262 implements IMessageParser {

        public function class_1262() {
            super();
        }
        private var var_1390: String;

        public function get infoUrl(): String {
            return var_1390;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1390 = param1.readString();
            return true;
        }
    }
}
