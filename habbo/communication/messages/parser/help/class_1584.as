package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1584 implements IMessageParser {

        public function class_1584() {
            super();
        }
        private var var_632: int;
        private var var_447: int;
        private var var_332: Array;

        public function get winningVoteCode(): int {
            return var_632;
        }

        public function get ownVoteCode(): int {
            return var_447;
        }

        public function get finalStatus(): Array {
            return var_332;
        }

        public function flush(): Boolean {
            var_632 = -1;
            var_447 = -1;
            var_332 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_632 = param1.readInteger();
            var_447 = param1.readInteger();
            var_332 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_332.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
