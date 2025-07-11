package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1529 implements IMessageParser {

        public function class_1529() {
            super();
        }
        private var var_280: int = 0;
        private var var_199: String;

        public function get id(): int {
            return var_280;
        }

        public function get itemData(): String {
            return var_199;
        }

        public function flush(): Boolean {
            var_280 = 0;
            var_199 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var _loc2_: String = param1.readString();
            var_280 = int(_loc2_);
            var_199 = param1.readString();
            return true;
        }
    }
}
