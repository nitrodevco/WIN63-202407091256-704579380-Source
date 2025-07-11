package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1764 {

        public function class_1764(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            var_993 = new Vector.<class_1706>(0);
            super();
            var_1066 = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                quickLinks.push(new class_1706(param1));
                _loc3_++;
            }
        }
        private var var_1066: String;
        private var var_993: Vector.<class_1706>;

        public function get searchCode(): String {
            return var_1066;
        }

        public function get quickLinks(): Vector.<class_1706> {
            return var_993;
        }
    }
}
