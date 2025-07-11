package com.sulake.habbo.communication.messages.parser.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1369 implements IMessageParser {

        public function class_1369() {
            super();
        }
        private var var_393: int = -1;
        private var var_1442: int = -1;
        private var var_1467: int = 0;

        public function get petId(): int {
            return var_393;
        }

        public function get petRoomIndex(): int {
            return var_1442;
        }

        public function get gainedExperience(): int {
            return var_1467;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_393 = param1.readInteger();
            var_1442 = param1.readInteger();
            var_1467 = param1.readInteger();
            return true;
        }
    }
}
