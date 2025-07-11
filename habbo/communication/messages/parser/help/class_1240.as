package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1240 implements IMessageParser {

        public function class_1240() {
            super();
        }
        private var var_561: String;
        private var var_350: Array;

        public function get quizCode(): String {
            return var_561;
        }

        public function get questionIds(): Array {
            return var_350;
        }

        public function flush(): Boolean {
            var_561 = null;
            var_350 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_561 = param1.readString();
            var_350 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_350.push(param1.readInteger());
                _loc3_++;
            }
            return true;
        }
    }
}
