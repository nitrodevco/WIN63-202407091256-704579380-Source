package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1735

    [SecureSWF(rename="true")]
    public class UserFlatCatsEventParser implements IMessageParser {

        public function UserFlatCatsEventParser() {
            super();
        }
        private var var_348: Array;

        public function get nodes(): Array {
            return var_348;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_348 = [];
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_348.push(new class_1735(param1));
                _loc2_++;
            }
            return true;
        }

        public function flush(): Boolean {
            var_348 = null;
            return true;
        }
    }
}
