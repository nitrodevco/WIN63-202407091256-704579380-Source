package com.sulake.habbo.communication.messages.parser.navigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1656

    [SecureSWF(rename="true")]
    public class UserEventCatsEventParser implements IMessageParser {

        public function UserEventCatsEventParser() {
            super();
        }
        private var var_324: Array;

        public function get eventCategories(): Array {
            return var_324;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_324 = [];
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_324.push(new class_1656(param1));
                _loc2_++;
            }
            return true;
        }

        public function flush(): Boolean {
            var_324 = null;
            return true;
        }
    }
}
