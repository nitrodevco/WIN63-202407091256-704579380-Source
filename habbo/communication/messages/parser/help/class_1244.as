package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1244 implements IMessageParser {

        public function class_1244() {
            super();
        }
        private var var_561: String;

        private var _questionIdsForWrongAnswers: Array;

        public function get questionIdsForWrongAnswers(): Array {
            return _questionIdsForWrongAnswers;
        }

        public function get quizCode(): String {
            return var_561;
        }

        public function flush(): Boolean {
            var_561 = null;
            _questionIdsForWrongAnswers = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_561 = param1.readString();
            _questionIdsForWrongAnswers = [];
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                _questionIdsForWrongAnswers.push(param1.readInteger());
                _loc2_++;
            }
            return true;
        }
    }
}
