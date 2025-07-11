package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class Game2PlayerStatsData {

        public function Game2PlayerStatsData(param1: IMessageDataWrapper) {
            super();
            var_367 = param1.readInteger();
            var_966 = param1.readInteger();
            var_1297 = param1.readInteger();
            var_1359 = param1.readInteger();
            var_1214 = param1.readInteger();
            var_816 = param1.readInteger();
            var_898 = param1.readInteger();
            var_915 = param1.readInteger();
            var_1412 = param1.readInteger();
            var_1267 = param1.readInteger();
        }
        private var var_367: int;
        private var var_966: int;
        private var var_1297: int;
        private var var_1359: int;
        private var var_1214: int;
        private var var_816: int;
        private var var_898: int;
        private var var_915: int;
        private var var_1412: int;
        private var var_1267: int;

        public function get score(): int {
            return var_367;
        }

        public function get kills(): int {
            return var_966;
        }

        public function get deaths(): int {
            return var_1297;
        }

        public function get snowballHits(): int {
            return var_1359;
        }

        public function get snowballHitsTaken(): int {
            return var_1214;
        }

        public function get snowballsThrown(): int {
            return var_816;
        }

        public function get snowballsCreated(): int {
            return var_898;
        }

        public function get snowballsFromMachine(): int {
            return var_915;
        }

        public function get friendlyHits(): int {
            return var_1412;
        }

        public function get friendlyKills(): int {
            return var_1267;
        }
    }
}
