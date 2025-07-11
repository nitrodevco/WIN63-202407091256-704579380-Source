package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1325 implements IMessageParser {

        public function class_1325() {
            super();
        }
        private var var_1373: int;
        private var var_672: Array;

        public function get percentage(): int {
            return var_1373;
        }

        public function get finishedPlayers(): Array {
            return var_672;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_1373 = param1.readInteger();
            var_672 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_672.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
