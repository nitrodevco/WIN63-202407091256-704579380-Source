package com.sulake.habbo.communication.messages.parser.friendlist {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.friendlist.class_1741

    [SecureSWF(rename="true")]
    public class class_1378 implements IMessageParser {

        public function class_1378() {
            super();
        }
        private var var_1517: int;
        private var var_758: Array;

        public function get chatId(): int {
            return var_1517;
        }

        public function get historyFragment(): Array {
            return var_758;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            this.var_1517 = param1.readInteger();
            var_758 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                this.var_758.push(new class_1741(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
