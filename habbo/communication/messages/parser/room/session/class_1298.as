package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1298 implements IMessageParser {

        public function class_1298() {
            super();
        }
        private var var_521: Boolean = false;

        public function get isPlaying(): Boolean {
            return var_521;
        }

        public function flush(): Boolean {
            var_521 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_521 = param1.readBoolean();
            return true;
        }
    }
}
