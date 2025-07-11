package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.inventory.pets.class_1657

    [SecureSWF(rename="true")]
    public class class_1613 implements IMessageParser {

        public function class_1613() {
            super();
        }
        private var var_455: int = -1;
        private var var_145: class_1657;

        public function get objectId(): int {
            return var_455;
        }

        public function get figureData(): class_1657 {
            return var_145;
        }

        public function flush(): Boolean {
            var_455 = -1;
            var_145 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_455 = param1.readInteger();
            if (!param1.bytesAvailable) {
                return true;
            }
            var_145 = new class_1657(param1);
            return true;
        }
    }
}
