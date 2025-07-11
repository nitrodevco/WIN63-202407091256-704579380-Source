package com.sulake.habbo.communication.messages.parser.poll {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    import flash.utils.Dictionary

    [SecureSWF(rename="true")]
    public class class_1534 implements IMessageParser {

        public function class_1534() {
            super();
        }
        private var var_490: String = null;
        private var var_607: int = -1;
        private var var_516: int = -1;
        private var var_377: int = -1;
        private var var_53: Dictionary = null;

        public function get pollType(): String {
            return var_490;
        }

        public function get pollId(): int {
            return var_607;
        }

        public function get questionId(): int {
            return var_516;
        }

        public function get duration(): int {
            return var_377;
        }

        public function get question(): Dictionary {
            return var_53;
        }

        public function flush(): Boolean {
            var_490 = null;
            var_607 = -1;
            var_516 = -1;
            var_377 = -1;
            var_53 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var _loc3_: int = 0;
            var_490 = param1.readString();
            var_607 = param1.readInteger();
            var_516 = param1.readInteger();
            var_377 = param1.readInteger();
            var_53 = new Dictionary();
            var_53["id"] = param1.readInteger();
            var_53["number"] = param1.readInteger();
            var_53["type"] = param1.readInteger();
            var_53["content"] = param1.readString();
            if (var_53["type"] == 1 || var_53["type"] == 2) {
                var_53["selection_min"] = param1.readInteger();
                _loc2_ = param1.readInteger();
                var _loc4_: Array = [];
                var _loc5_: Array = [];
                var_53["selections"] = _loc4_;
                var_53["selection_values"] = _loc5_;
                var_53["selection_count"] = _loc2_;
                var_53["selection_max"] = _loc2_;
                _loc3_ = 0;
                while (_loc3_ < _loc2_) {
                    _loc5_.push(param1.readString());
                    _loc4_.push(param1.readString());
                    _loc3_++;
                }
            }
            return true;
        }
    }
}
