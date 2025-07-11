package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class GameLobbyPlayerData {

        public static var var_1568: Function = comparePlayersByTotalScore;

        public static var var_1538: Function = comparePlayersBySkillLevel;

        private static function comparePlayersByTotalScore(param1: GameLobbyPlayerData, param2: GameLobbyPlayerData): Number {
            var _loc3_: int = param1.totalScore;
            var _loc4_: int = param2.totalScore;
            if (_loc3_ < _loc4_) {
                return 1;
            }
            if (_loc3_ == _loc4_) {
                return 0;
            }
            return -1;
        }

        private static function comparePlayersBySkillLevel(param1: GameLobbyPlayerData, param2: GameLobbyPlayerData): Number {
            var _loc4_: int = param1.skillLevel;
            var _loc3_: int = param2.skillLevel;
            if (_loc4_ < _loc3_) {
                return 1;
            }
            if (_loc4_ == _loc3_) {
                return 0;
            }
            return -1;
        }

        public function GameLobbyPlayerData(param1: IMessageDataWrapper) {
            super();
            var_418 = param1.readInteger();
            _name = param1.readString();
            var_426 = param1.readString();
            var_129 = param1.readString();
            var_893 = param1.readInteger();
            var_1426 = param1.readInteger();
            var_1256 = param1.readInteger();
            var_1209 = param1.readInteger();
        }
        private var var_418: int;
        private var var_426: String;
        private var var_129: String;
        private var var_893: int;
        private var var_1426: int;
        private var var_1256: int;
        private var var_1209: int;

        private var _name: String;

        public function get name(): String {
            return _name;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get gender(): String {
            return var_129;
        }

        public function get teamId(): int {
            return var_893;
        }

        public function get skillLevel(): int {
            return var_1426;
        }

        public function get totalScore(): int {
            return var_1256;
        }

        public function get scoreToNextLevel(): int {
            return var_1209;
        }
    }
}
