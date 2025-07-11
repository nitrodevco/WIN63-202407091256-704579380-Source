package com.sulake.habbo.communication.messages.parser.game.score {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2LeaderboardParser implements IMessageParser {

        public function Game2LeaderboardParser() {
            super();
        }
        private var var_474: int;
        private var var_281: Array;
        private var var_416: int;

        public function get gameTypeId(): int {
            return var_474;
        }

        public function get leaderboard(): Array {
            return var_281;
        }

        public function get totalListSize(): int {
            return var_416;
        }

        public function flush(): Boolean {
            var_474 = -1;
            var_281 = null;
            var_416 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_281 = [];
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                var_281.push(new class_1729(param1));
                _loc3_++;
            }
            var_416 = param1.readInteger();
            var_474 = param1.readInteger();
            return true;
        }
    }
}
