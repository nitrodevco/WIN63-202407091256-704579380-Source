package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1339 implements IMessageParser {

        public function class_1339() {
            super();
        }
        private var var_1278: int;
        private var var_609: Boolean;

        public function get guestRoomId(): int {
            return var_1278;
        }

        public function get owner(): Boolean {
            return var_609;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1278 = param1.readInteger();
            var_609 = param1.readBoolean();
            return true;
        }
    }
}
