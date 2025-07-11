package com.sulake.habbo.communication.messages.parser.camera {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1295 implements IMessageParser {

        public function class_1295() {
            super();
        }
        private var var_96: String;

        public function get url(): String {
            return var_96;
        }

        public function flush(): Boolean {
            var_96 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_96 = param1.readString();
            return true;
        }
    }
}
