package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1266 implements IMessageParser {

        public function class_1266() {
            super();
        }
        private var var_964: int;
        private var var_1199: int;

        public function get homeRoomId(): int {
            return var_964;
        }

        public function get roomIdToEnter(): int {
            return var_1199;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_964 = param1.readInteger();
            var_1199 = param1.readInteger();
            return true;
        }
    }
}
