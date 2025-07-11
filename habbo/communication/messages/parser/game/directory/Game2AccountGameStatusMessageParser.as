package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2AccountGameStatusMessageParser implements IMessageParser {

        public function Game2AccountGameStatusMessageParser() {
            super();
        }
        private var var_474: int;
        private var var_718: int;
        private var var_1080: int;

        public function get gameTypeId(): int {
            return var_474;
        }

        public function get freeGamesLeft(): int {
            return var_718;
        }

        public function get gamesPlayedTotal(): int {
            return var_1080;
        }

        public function get hasUnlimitedGames(): Boolean {
            return var_718 == -1;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_474 = param1.readInteger();
            var_718 = param1.readInteger();
            var_1080 = param1.readInteger();
            return true;
        }
    }
}
