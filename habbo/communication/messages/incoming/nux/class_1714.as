package com.sulake.habbo.communication.messages.incoming.nux {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1714 {

        public function class_1714(param1: IMessageDataWrapper) {
            var _loc2_: int = 0;
            super();
            var_1024 = param1.readInteger();
            var_1075 = param1.readInteger();
            var_752 = new Vector.<class_1779>(0);
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_752.push(new class_1779(param1));
                _loc2_++;
            }
        }
        private var var_1024: int;
        private var var_1075: int;
        private var var_752: Vector.<class_1779>;

        public function get dayIndex(): int {
            return var_1024;
        }

        public function get stepIndex(): int {
            return var_1075;
        }

        public function get options(): Vector.<class_1779> {
            return var_752;
        }
    }
}
