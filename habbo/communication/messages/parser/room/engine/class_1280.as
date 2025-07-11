package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1280 implements IMessageParser {

        public function class_1280() {
            super();
        }
        private var var_280: int;
        private var var_1134: Boolean;
        private var var_582: int;
        private var var_488: int;

        public function get id(): int {
            return var_280;
        }

        public function get isExpired(): Boolean {
            return var_1134;
        }

        public function get pickerId(): int {
            return var_582;
        }

        public function get delay(): int {
            return var_488;
        }

        public function flush(): Boolean {
            var_280 = 0;
            var_488 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_280 = int(param1.readString());
            var_1134 = param1.readBoolean();
            var_582 = param1.readInteger();
            var_488 = param1.readInteger();
            return true;
        }
    }
}
