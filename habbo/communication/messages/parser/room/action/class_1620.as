package com.sulake.habbo.communication.messages.parser.room.action {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1620 implements IMessageParser {

        public function class_1620() {
            super();
        }
        private var var_418: int = 0;
        private var var_580: int = 0;
        private var var_777: int = 0;

        public function get userId(): int {
            return var_418;
        }

        public function get effectId(): int {
            return var_580;
        }

        public function get delayMilliSeconds(): int {
            return var_777;
        }

        public function flush(): Boolean {
            var_418 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            var_580 = param1.readInteger();
            var_777 = param1.readInteger();
            return true;
        }
    }
}
