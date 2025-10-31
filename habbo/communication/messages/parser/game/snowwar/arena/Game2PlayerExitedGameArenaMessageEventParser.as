package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class Game2PlayerExitedGameArenaMessageEventParser implements IMessageParser {

        public function Game2PlayerExitedGameArenaMessageEventParser() {
            super();
        }
        private var var_418: int;
        private var var_604: int;

        public function get userId(): int {
            return var_418;
        }

        public function get playerGameObjectId(): int {
            return var_604;
        }

        public function flush(): Boolean {
            var_418 = NaN;
            var_604 = NaN;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            var_604 = param1.readInteger();
            return true;
        }
    }
}
