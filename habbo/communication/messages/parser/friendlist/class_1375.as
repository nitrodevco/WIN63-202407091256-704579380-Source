package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1375 implements IMessageParser {

        public function class_1375() {
            super();
        }
        private var var_412: int;
        private var var_418: int;
        private var var_368: String;

        public function get errorCode(): int {
            return this.var_412;
        }

        public function get userId(): int {
            return this.var_418;
        }

        public function get message(): String {
            return this.var_368;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_412 = param1.readInteger();
            this.var_418 = param1.readInteger();
            this.var_368 = param1.readString();
            return true;
        }
    }
}
