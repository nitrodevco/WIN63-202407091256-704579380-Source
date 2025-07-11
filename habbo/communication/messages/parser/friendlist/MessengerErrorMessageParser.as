package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class MessengerErrorMessageParser implements IMessageParser {

        public function MessengerErrorMessageParser() {
            super();
        }
        private var var_1535: int;
        private var var_412: int;

        public function get clientMessageId(): int {
            return this.var_1535;
        }

        public function get errorCode(): int {
            return this.var_412;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            this.var_1535 = param1.readInteger();
            this.var_412 = param1.readInteger();
            return true;
        }
    }
}
