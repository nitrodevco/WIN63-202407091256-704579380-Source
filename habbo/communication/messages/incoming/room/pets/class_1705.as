package com.sulake.habbo.communication.messages.incoming.room.pets {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1705 {

        public function class_1705(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            super();
            var_508 = param1.readInteger();
            var_282 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_282.push(param1.readInteger());
                _loc3_++;
            }
        }
        private var var_508: int;
        private var var_282: Array;

        public function get chance(): int {
            return var_508;
        }

        public function get breeds(): Array {
            return var_282;
        }

        public function dispose(): void {
            var_508 = -1;
            var_282 = [];
        }
    }
}
