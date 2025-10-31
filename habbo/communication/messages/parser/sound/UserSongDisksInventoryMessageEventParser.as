package com.sulake.habbo.communication.messages.parser.sound {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class UserSongDisksInventoryMessageEventParser implements IMessageParser {

        public function UserSongDisksInventoryMessageEventParser() {
            super();
            var_141 = new Map();
        }
        private var var_141: Map;

        public function get songDiskCount(): int {
            return var_141.length;
        }

        public function getDiskId(param1: int): int {
            if (param1 >= 0 && param1 < var_141.length) {
                return var_141.getKey(param1);
            }
            return -1;
        }

        public function getSongId(param1: int): int {
            if (param1 >= 0 && param1 < var_141.length) {
                return var_141.getWithIndex(param1);
            }
            return -1;
        }

        public function flush(): Boolean {
            var_141.reset();
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: int = 0;
            var _loc5_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                var_141.add(_loc4_, _loc5_);
                _loc3_++;
            }
            return true;
        }
    }
}
