package com.sulake.habbo.communication.messages.parser.users {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map
    import com.sulake.habbo.communication.messages.incoming.users.class_1758

    [SecureSWF(rename="true")]
    public class class_1243 implements IMessageParser {

        public function class_1243() {
            super();
        }
        private var var_418: int;
        private var var_163: Map;

        public function get userId(): int {
            return var_418;
        }

        public function get relationshipStatusMap(): Map {
            return var_163;
        }

        public function flush(): Boolean {
            if (var_163) {
                var_163.dispose();
                var_163 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: class_1758 = null;
            var_418 = param1.readInteger();
            var_163 = new Map();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = new class_1758(param1);
                var_163.add(_loc4_.relationshipStatusType, _loc4_);
                _loc3_++;
            }
            return true;
        }
    }
}
