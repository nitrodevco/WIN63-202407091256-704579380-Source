package com.sulake.habbo.communication.messages.parser.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1718

    [SecureSWF(rename="true")]
    public class ClubGiftSelectedEventParser implements IMessageParser {

        public function ClubGiftSelectedEventParser() {
            super();
        }
        private var var_394: String;
        private var var_300: Array;

        public function get productCode(): String {
            return var_394;
        }

        public function get products(): Array {
            return var_300;
        }

        public function flush(): Boolean {
            var_300 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_300 = [];
            var_394 = param1.readString();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_300.push(new class_1718(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
