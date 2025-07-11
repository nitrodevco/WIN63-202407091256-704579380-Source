package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1565 implements IMessageParser {

        public function class_1565() {
            super();
        }
        private var var_662: int;
        private var var_992: int;
        private var var_1478: int;
        private var var_391: int;

        public function get secondsLeft(): int {
            return var_662;
        }

        public function get furniLimit(): int {
            return var_992;
        }

        public function get maxFurniLimit(): int {
            return var_1478;
        }

        public function get secondsLeftWithGrace(): int {
            return var_391;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_662 = param1.readInteger();
            var_992 = param1.readInteger();
            var_1478 = param1.readInteger();
            if (param1.bytesAvailable) {
                var_391 = param1.readInteger();
            } else {
                var_391 = var_662;
            }
            return true;
        }
    }
}
