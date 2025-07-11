package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2GameDirectoryStatusMessageParser implements IMessageParser {

        public static const const_156: int = 0;

        public static const const_56: int = 1;

        public static const const_138: int = 2;

        public static const const_224: int = 3;

        public function Game2GameDirectoryStatusMessageParser() {
            super();
        }
        private var var_1225: int;

        private var var_1253: int;

        private var var_718: int;

        private var _status: int;

        public function get status(): int {
            return _status;
        }

        public function get blockLength(): int {
            return var_1225;
        }

        public function get gamesPlayed(): int {
            return var_1253;
        }

        public function get freeGamesLeft(): int {
            return var_718;
        }

        public function get hasUnlimitedGames(): Boolean {
            return var_718 == -1;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _status = param1.readInteger();
            var_1225 = param1.readInteger();
            var_1253 = param1.readInteger();
            var_718 = param1.readInteger();
            return true;
        }
    }
}
