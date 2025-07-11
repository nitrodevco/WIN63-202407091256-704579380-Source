package com.sulake.habbo.communication.messages.parser.collectibles {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1322 implements IMessageParser {

        public function class_1322() {
            super();
        }
        private var var_296: *;

        public function get success(): Boolean {
            return var_296 == 0;
        }

        public function get resultCode(): * {
            return var_296;
        }

        public function flush(): Boolean {
            var_296 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_296 = param1.readShort();
            return true;
        }
    }
}
