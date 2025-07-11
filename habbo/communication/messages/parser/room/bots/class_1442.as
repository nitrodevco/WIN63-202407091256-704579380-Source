package com.sulake.habbo.communication.messages.parser.room.bots {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1442 implements IMessageParser {

        public function class_1442() {
            super();
        }
        private var var_536: int;
        private var var_756: Array;

        public function get skillList(): Array {
            return var_756;
        }

        public function get botId(): int {
            return var_536;
        }

        public function flush(): Boolean {
            var_536 = -1;
            var_756 = new Array(0);
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_536 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_756.push(new class_1736(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
