package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1462 implements IMessageParser {

        public static const const_275: int = 0;

        public static const const_25: int = 1;

        public static const const_202: int = 2;

        public static const const_176: int = 3;

        public static const const_76: int = 4;

        public static const const_131: int = 5;

        public function class_1462() {
            super();
        }

        private var _status: Array;

        public function get status(): Array {
            return _status;
        }

        public function flush(): Boolean {
            _status = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            _status = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _status.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
