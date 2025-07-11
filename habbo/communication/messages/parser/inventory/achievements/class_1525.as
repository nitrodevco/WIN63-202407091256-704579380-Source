package com.sulake.habbo.communication.messages.parser.inventory.achievements {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.class_1724

    [SecureSWF(rename="true")]
    public class class_1525 implements IMessageParser {

        public function class_1525() {
            super();
        }
        private var var_275: Array;
        private var var_1375: String;

        public function get achievements(): Array {
            return var_275;
        }

        public function get defaultCategory(): String {
            return var_1375;
        }

        public function flush(): Boolean {
            var_275 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_275 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_275.push(new class_1724(param1));
                _loc3_++;
            }
            var_1375 = param1.readString();
            return true;
        }
    }
}
