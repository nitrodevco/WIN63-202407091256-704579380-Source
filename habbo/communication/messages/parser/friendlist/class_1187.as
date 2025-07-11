package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1187 implements IMessageParser {

        public function class_1187() {
            super();
        }
        private var var_779: int;
        private var var_639: String;

        public function get senderId(): int {
            return this.var_779;
        }

        public function get messageText(): String {
            return this.var_639;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_779 = param1.readInteger();
            this.var_639 = param1.readString();
            return true;
        }
    }
}
