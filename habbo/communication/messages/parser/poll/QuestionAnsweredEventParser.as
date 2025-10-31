package com.sulake.habbo.communication.messages.parser.poll {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.core.utils.Map

    [SecureSWF(rename="true")]
    public class QuestionAnsweredEventParser implements IMessageParser {

        public function QuestionAnsweredEventParser() {
            super();
        }
        private var var_418: int;
        private var var_308: Map;

        private var _value: String;

        public function get value(): String {
            return _value;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get answerCounts(): Map {
            return var_308;
        }

        public function flush(): Boolean {
            var_418 = -1;
            _value = "";
            var_308 = null;
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: String = null;
            var _loc2_: int = 0;
            var_418 = param1.readInteger();
            _value = param1.readString();
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
