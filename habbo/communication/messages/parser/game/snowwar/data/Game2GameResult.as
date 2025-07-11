package com.sulake.habbo.communication.messages.parser.game.snowwar.data {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    public class Game2GameResult {

        public static const const_199: int = 0;

        public static const const_309: int = 1;

        public static const const_142: int = 2;

        public function Game2GameResult(param1: IMessageDataWrapper) {
            super();
            var_1089 = param1.readBoolean();
            var_491 = param1.readInteger();
            var_1302 = param1.readInteger();
        }
        private var var_1089: Boolean;
        private var var_491: int;
        private var var_1302: int;

        public function get isDeathMatch(): Boolean {
            return var_1089;
        }

        public function get resultType(): int {
            return var_491;
        }

        public function get winnerId(): int {
            return var_1302;
        }
    }
}
