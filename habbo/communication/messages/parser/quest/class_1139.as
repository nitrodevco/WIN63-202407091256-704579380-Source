package com.sulake.habbo.communication.messages.parser.quest {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.quest.class_1760

    [SecureSWF(rename="true")]
    public class class_1139 implements IMessageParser {

        public function class_1139() {
            super();
        }
        private var var_700: Array;

        public function get prizes(): Array {
            return var_700;
        }

        public function flush(): Boolean {
            var_700 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_700.push(new class_1760(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
