package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1314 implements IMessageParser {

        public function class_1314() {
            super();
        }
        private var var_603: int;
        private var var_1399: String;
        private var var_1343: int;
        private var var_833: int;
        private var var_149: int;

        public function get furniId(): int {
            return var_603;
        }

        public function get videoId(): String {
            return var_1399;
        }

        public function get startAtSeconds(): int {
            return var_1343;
        }

        public function get endAtSeconds(): int {
            return var_833;
        }

        public function get state(): int {
            return var_149;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_603 = param1.readInteger();
            var_1399 = param1.readString();
            var_1343 = param1.readInteger();
            var_833 = param1.readInteger();
            var_149 = param1.readInteger();
            return true;
        }
    }
}
