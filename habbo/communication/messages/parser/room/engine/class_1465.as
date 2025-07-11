package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1465 implements IMessageParser {

        public function class_1465() {
            super();
        }
        private var var_280: int = 0;
        private var var_199: String;
        private var var_149: int;

        public function get id(): int {
            return var_280;
        }

        public function get itemData(): String {
            return var_199;
        }

        public function get state(): int {
            return var_149;
        }

        public function flush(): Boolean {
            var_280 = 0;
            var_199 = "";
            var_149 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_280 = param1.readInteger();
            var_199 = param1.readString();
            var_149 = 0;
            var _loc2_: Number = parseFloat(var_199);
            if (!isNaN(_loc2_)) {
                var_149 = int(var_199);
            }
            return true;
        }
    }
}
