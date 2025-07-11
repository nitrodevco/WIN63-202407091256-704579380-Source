package com.sulake.habbo.communication.messages.parser.game.score {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.incoming.catalog.class_1718

    public class class_1466 implements IMessageParser {

        public function class_1466() {
            var_300 = [];
            super();
        }
        private var var_474: int;
        private var var_300: Array;
        private var var_456: int;
        private var var_470: Boolean;

        public function get gameTypeId(): int {
            return var_474;
        }

        public function get products(): Array {
            return var_300;
        }

        public function get minutesUntilNextWeek(): int {
            return var_456;
        }

        public function get rewardingOn(): Boolean {
            return var_470;
        }

        public function flush(): Boolean {
            var_474 = -1;
            var_300 = [];
            var_456 = 0;
            var_470 = true;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc2_: int = 0;
            var_474 = param1.readInteger();
            var _loc3_: int = param1.readInteger();
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                var_300.push(new class_1718(param1));
                _loc2_++;
            }
            var_456 = param1.readInteger();
            var_470 = param1.readBoolean();
            return true;
        }
    }
}
