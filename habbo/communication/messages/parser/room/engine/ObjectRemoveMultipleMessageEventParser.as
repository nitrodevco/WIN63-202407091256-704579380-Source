package com.sulake.habbo.communication.messages.parser.room.engine {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class ObjectRemoveMultipleMessageEventParser implements IMessageParser {

        public function ObjectRemoveMultipleMessageEventParser() {
            super();
        }
        private var var_535: Array;
        private var var_582: int;

        public function get ids(): Array {
            return var_535;
        }

        public function get pickerId(): int {
            return var_582;
        }

        public function flush(): Boolean {
            var_535 = [];
            var_582 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            if (param1 == null) {
                return false;
            }
            var _loc2_: int = param1.readInteger();
            var_535 = [];
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                ids.push(param1.readInteger());
                _loc3_++;
            }
            var_582 = param1.readInteger();
            return true;
        }
    }
}
