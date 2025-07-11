package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class Game2SnowWarGameStats {

        public function Game2SnowWarGameStats(param1: IMessageDataWrapper) {
            super();
            var_1418 = param1.readInteger();
            var_1045 = param1.readInteger();
        }
        private var var_1418: int;
        private var var_1045: int;

        public function get playerWithMostKills(): int {
            return var_1418;
        }

        public function get playerWithMostHits(): int {
            return var_1045;
        }
    }
}
