package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1651 {

        public function class_1651(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var _loc5_: int = 0;
            super();
            var_709 = [];
            var_653 = [];
            var _loc2_: int = param1.readInteger(); //Image Datas Count
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_709.push(param1.readString()); //Single Image Data
                _loc3_++;
            }
            var _loc4_: int = param1.readInteger(); //Text Datas Count
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                var_653.push(param1.readString()); //Single Text Data
                _loc5_++;
            }
        }
        private var var_709: Array;
        private var var_653: Array;

        public function get images(): Array {
            return var_709;
        }

        public function get texts(): Array {
            return var_653;
        }
    }
}
