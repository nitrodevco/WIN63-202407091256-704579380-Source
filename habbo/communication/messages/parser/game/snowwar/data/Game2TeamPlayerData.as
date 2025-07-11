package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class Game2TeamPlayerData {

        public function Game2TeamPlayerData(param1: int, param2: IMessageDataWrapper) {
            super();
            var_893 = param1;
            _userName = param2.readString();
            var_418 = param2.readInteger();
            var_426 = param2.readString();
            var_129 = param2.readString();
            var_367 = param2.readInteger();
            var_864 = new Game2PlayerStatsData(param2);
            var_453 = false;
        }
        private var var_418: int;
        private var var_367: int;

        private var var_426: String;

        private var var_129: String;

        private var var_864: Game2PlayerStatsData;

        private var var_893: int;

        private var var_453: Boolean;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get score(): int {
            return var_367;
        }

        public function get figure(): String {
            return var_426;
        }

        public function get gender(): String {
            return var_129;
        }

        public function get playerStats(): Game2PlayerStatsData {
            return var_864;
        }

        public function get teamId(): int {
            return var_893;
        }

        public function get willRejoin(): Boolean {
            return var_453;
        }

        public function set willRejoin(param1: Boolean): void {
            var_453 = param1;
        }
    }
}
