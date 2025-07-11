package com.sulake.habbo.communication.messages.incoming.nux {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1779 {

        public function class_1779(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            super();
            var_340 = param1.readString();
            if (var_340 == "") {
                var_340 = null;
            }
            var_685 = new Vector.<class_1792>();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_685.push(new class_1792(param1));
                _loc3_++;
            }
        }
        private var var_685: Vector.<class_1792>;
        private var var_340: String;

        public function get productOfferList(): Vector.<class_1792> {
            return var_685;
        }

        public function get thumbnailUrl(): String {
            return var_340;
        }
    }
}
