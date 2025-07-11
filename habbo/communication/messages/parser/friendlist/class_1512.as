package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1512 implements IMessageParser {

        public function class_1512() {
            super();
        }
        private var var_258: Boolean;

        public function get success(): Boolean {
            return var_258;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_258 = param1.readBoolean();
            return true;
        }
    }
}
