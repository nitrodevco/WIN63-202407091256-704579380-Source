package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class GameLobbyData {

        public function GameLobbyData(param1: IMessageDataWrapper) {
            var _loc3_: int = 0;
            _players = [];
            super();
            var_1140 = param1.readInteger();
            _levelName = param1.readString();
            var_414 = param1.readInteger();
            var_552 = param1.readInteger();
            _numberOfTeams = param1.readInteger();
            var_1319 = param1.readInteger();
            var_1463 = param1.readString();
            var_1124 = param1.readInteger();
            var _loc2_: int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                _players.push(new GameLobbyPlayerData(param1));
                _loc3_++;
            }
        }
        private var var_1140: int;
        private var _levelName: String;
        private var var_414: int;
        private var var_552: int;
        private var var_1319: int;

        private var var_1463: String;

        private var var_1124: int;

        private var _numberOfTeams: int;

        public function get numberOfTeams(): int {
            return _numberOfTeams;
        }

        private var _players: Array;

        public function get players(): Array {
            return _players;
        }

        public function get gameId(): int {
            return var_1140;
        }

        public function get gameType(): int {
            return var_414;
        }

        public function get fieldType(): int {
            return var_552;
        }

        public function get maximumPlayers(): int {
            return var_1319;
        }

        public function get owningPlayerName(): String {
            return var_1463;
        }

        public function get levelEntryId(): int {
            return var_1124;
        }
    }
}
