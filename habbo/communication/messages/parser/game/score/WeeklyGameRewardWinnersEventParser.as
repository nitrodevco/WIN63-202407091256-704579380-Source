package com.sulake.habbo.communication.messages.parser.game.score {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class WeeklyGameRewardWinnersEventParser implements IMessageParser {

        public function WeeklyGameRewardWinnersEventParser() {
            var_299 = [];
            super();
        }
        private var var_474: int;
        private var var_299: Array;

        public function get gameTypeId(): int {
            return var_474;
        }

        public function get winners(): Array {
            return var_299;
        }

        public function flush(): Boolean {
            var_474 = -1;
            var_299 = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_474 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_299.push(new class_1637(param1));
                _loc3_++;
            }
            return true;
        }
    }
}
