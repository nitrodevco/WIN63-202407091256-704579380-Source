package com.sulake.habbo.communication.messages.parser.room.chat {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1344 implements IMessageParser {

        public function class_1344() {
            super();
        }
        private var var_418: int = 0;
        private var var_343: Array;

        private var var_471: int = 0;

        private var var_959: int = -1;

        private var var_950: int = 0;

        private var _text: String = "";

        public function get text(): String {
            return _text;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get links(): Array {
            return var_343;
        }

        public function get gesture(): int {
            return var_471;
        }

        public function get trackingId(): int {
            return var_959;
        }

        public function get styleId(): int {
            return var_950;
        }

        public function flush(): Boolean {
            var_418 = 0;
            _text = "";
            var_471 = 0;
            var_343 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            if (param1 == null) {
                return false;
            }
            var_418 = param1.readInteger();
            _text = param1.readString();
            var_471 = param1.readInteger();
            var_950 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            if (_loc2_ > 0) {
                var_343 = [];
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    var_343.push([param1.readString(), param1.readString(), param1.readBoolean()]);
                    _loc3_++;
                }
            }
            var_959 = param1.readInteger();
            return true;
        }
    }
}
