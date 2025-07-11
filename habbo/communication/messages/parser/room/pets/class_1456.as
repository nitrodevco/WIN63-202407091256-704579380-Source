package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1456 implements IMessageParser {

        public function class_1456() {
            super();
        }
        private var var_871: int;
        private var var_393: int;
        private var var_360: int;

        public function get roomIndex(): int {
            return var_871;
        }

        public function get petId(): int {
            return var_393;
        }

        public function get level(): int {
            return var_360;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_871 = param1.readInteger();
            var_393 = param1.readInteger();
            var_360 = param1.readInteger();
            return true;
        }
    }
}
