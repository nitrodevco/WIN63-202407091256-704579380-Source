package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamScoreData

    [SecureSWF(rename="true")]
    public class Game2GameEndingMessageEventParser implements IMessageParser {

        public function Game2GameEndingMessageEventParser() {
            super();
        }
        private var var_423: int;
        private var var_1213: Array;

        private var var_1027: Game2SnowWarGameStats;

        private var var_780: Game2GameResult;

        private var _teams: Array;

        public function get teams(): Array {
            return _teams;
        }

        public function get timeToNextState(): int {
            return var_423;
        }

        public function get teamScores(): Array {
            return var_1213;
        }

        public function get gameResult(): Game2GameResult {
            return var_780;
        }

        public function get generalStats(): Game2SnowWarGameStats {
            return var_1027;
        }

        public function flush(): Boolean {
            var_423 = -1;
            _teams = [];
            var_1213 = [];
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var_423 = param1.readInteger();
            var_780 = new Game2GameResult(param1);
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _teams.push(new Game2TeamScoreData(param1));
                _loc3_++;
            }
            var_1027 = new Game2SnowWarGameStats(param1);
            return true;
        }
    }
}
