package com.sulake.habbo.communication.messages.parser.sound {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class JukeboxSongDisksMessageEventParser implements IMessageParser {

        public function JukeboxSongDisksMessageEventParser() {
            super();
            var_458 = new Map();
        }
        private var var_458: Map;
        private var var_382: int;

        public function get songDisks(): Map {
            return var_458;
        }

        public function get maxLength(): int {
            return var_382;
        }

        public function flush(): Boolean {
            var_458.reset();
            var_382 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_382 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            var _loc4_: int = -1;
            var _loc5_: int = -1;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _loc4_ = param1.readInteger();
                _loc5_ = param1.readInteger();
                var_458.add(_loc4_, _loc5_);
                _loc3_++;
            }
            return true;
        }
    }
}
