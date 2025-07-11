package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1190 implements IMessageParser {

        public function class_1190() {
            super();
        }
        private var var_514: Boolean;

        public function get isTyping(): Boolean {
            return var_514;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_514 = param1.readBoolean();
            return true;
        }
    }
}
