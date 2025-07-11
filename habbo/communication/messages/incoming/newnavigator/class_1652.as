package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1675

    [SecureSWF(rename="true")]
    public class class_1652 {

        public function class_1652(param1: IMessageDataWrapper, param2: class_1770 = null) {
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            var_291 = new Vector.<class_1770>(0);
            super();
            if (param2 != null) {
                var_503 = param2.searchCode;
                var_365 = param2.text;
                var_291.push(param2);
            } else {
                var_503 = param1.readString();
                var_365 = param1.readString();
                _loc3_ = param1.readInteger();
                _loc4_ = 0;
                while (_loc4_ < _loc3_) {
                    var_291.push(new class_1770(param1));
                    _loc4_++;
                }
            }
        }
        private var var_503: String;
        private var var_365: String;
        private var var_291: Vector.<class_1770>;

        public function get searchCodeOriginal(): String {
            return var_503;
        }

        public function get filteringData(): String {
            return var_365;
        }

        public function get blocks(): Vector.<class_1770> {
            return var_291;
        }

        public function findGuestRoom(param1: int): class_1675 {
            var _loc3_: class_1675 = null;
            for each(var _loc2_ in var_291) {
                _loc3_ = _loc2_.findGuestRoom(param1);
                if (_loc3_ != null) {
                    return _loc3_;
                }
            }
            return null;
        }
    }
}
