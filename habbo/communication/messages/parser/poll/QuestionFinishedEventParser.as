package com.sulake.habbo.communication.messages.parser.poll {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class QuestionFinishedEventParser implements IMessageParser {

        public function QuestionFinishedEventParser() {
            super();
        }
        private var var_516: int;
        private var var_308: Map;

        public function get questionId(): int {
            return var_516;
        }

        public function get answerCounts(): Map {
            return var_308;
        }

        public function flush(): Boolean {
            var_516 = -1;
            var_308 = null;
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: String = null;
            var _loc2_: int = 0;
            var_516 = param1.readInteger();
            var_308 = new Map();
            var _loc5_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc5_) {
                _loc4_ = param1.readString();
                _loc2_ = param1.readInteger();
                var_308.add(_loc4_, _loc2_);
                _loc3_++;
            }
            return true;
        }
    }
}
