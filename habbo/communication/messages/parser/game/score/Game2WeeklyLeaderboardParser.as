package com.sulake.habbo.communication.messages.parser.game.score {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class Game2WeeklyLeaderboardParser extends Game2LeaderboardParser {

        public function Game2WeeklyLeaderboardParser() {
            super();
        }
        private var var_557: int;
        private var var_486: int;
        private var var_600: int;

        private var var_635: int;

        private var _maxOffset: int;

        public function get maxOffset(): int {
            return _maxOffset;
        }

        public function get year(): int {
            return var_557;
        }

        public function get week(): int {
            return var_486;
        }

        public function get currentOffset(): int {
            return var_600;
        }

        public function get minutesUntilReset(): int {
            return var_635;
        }

        override public function flush(): Boolean {
            var_557 = -1;
            var_486 = -1;
            _maxOffset = -1;
            var_600 = -1;
            var_635 = -1;
            return super.flush();
        }

        override public function parse(param1: IMessageDataWrapper): Boolean {
            var_557 = param1.readInteger();
            var_486 = param1.readInteger();
            _maxOffset = param1.readInteger();
            var_600 = param1.readInteger();
            var_635 = param1.readInteger();
            return super.parse(param1);
        }
    }
}
