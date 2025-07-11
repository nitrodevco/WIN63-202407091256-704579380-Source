package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1441 implements IMessageParser {

        public function class_1441() {
            super();
        }
        private var var_401: Boolean = false;

        public function get isHanditemControlBlocked(): Boolean {
            return var_401;
        }

        public function flush(): Boolean {
            var_401 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_401 = param1.readBoolean();
            return true;
        }
    }
}
