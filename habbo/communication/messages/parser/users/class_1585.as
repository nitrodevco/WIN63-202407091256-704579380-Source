package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1585 implements IMessageParser {

        public static const const_29: int = 0;

        public static const const_350: int = 1;

        public function class_1585() {
            super();
        }

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _status = param1.readInteger();
            return true;
        }
    }
}
