package com.sulake.habbo.communication.messages.parser.userclassification {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class UserClassificationMessageEventParser implements IMessageParser {

        public function UserClassificationMessageEventParser() {
            super();
        }
        private var var_167: Map;
        private var var_184: Map;

        public function get classifiedUsernameMap(): Map {
            return var_167;
        }

        public function get classifiedUserTypeMap(): Map {
            return var_184;
        }

        public function flush(): Boolean {
            if (var_167) {
                var_167.dispose();
                var_167 = null;
            }
            if (var_184) {
                var_184.dispose();
                var_184 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc4_: int = 0;
            var _loc6_: String = null;
            var _loc5_: String = null;
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            var_167 = new Map();
            var_184 = new Map();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = param1.readInteger();
                _loc6_ = param1.readString();
                _loc5_ = param1.readString();
                var_167.add(_loc4_, _loc6_);
                var_184.add(_loc4_, _loc5_);
                _loc3_++;
            }
            return true;
        }
    }
}
