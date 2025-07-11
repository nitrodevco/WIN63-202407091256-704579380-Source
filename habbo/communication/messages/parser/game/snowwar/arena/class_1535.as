package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData

    [SecureSWF(rename="true")]
    public class class_1535 implements IMessageParser {

        public function class_1535() {
            super();
            _players = [];
        }
        private var var_414: int;
        private var var_552: int;
        private var var_1392: GameLevelData;

        private var _numberOfTeams: int;

        public function get numberOfTeams(): int {
            return _numberOfTeams;
        }

        private var _players: Array;

        public function get players(): Array {
            return _players;
        }

        public function get gameType(): int {
            return var_414;
        }

        public function get fieldType(): int {
            return var_552;
        }

        public function get gameLevel(): GameLevelData {
            return var_1392;
        }

        public function flush(): Boolean {
            var_414 = -1;
            var_552 = -1;
            _numberOfTeams = -1;
            for each(var _loc1_ in _players) {
                _loc1_.dispose();
            }
            _players = [];
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var _loc3_: int = 0;
            var _loc4_: Game2PlayerData = null;
            var_414 = param1.readInteger();
            var_552 = param1.readInteger();
            _numberOfTeams = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                (_loc4_ = new Game2PlayerData()).parse(param1);
                _players.push(_loc4_);
                _loc3_++;
            }
            var_1392 = new GameLevelData(param1);
            return true;
        }
    }
}
