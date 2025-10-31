package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class Game2GameRejoinMessageEventParser implements IMessageParser {

        public function Game2GameRejoinMessageEventParser() {
            super();
        }

        private var _roomBeforeGame: int;

        public function get roomBeforeGame(): int {
            return _roomBeforeGame;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _roomBeforeGame = param1.readInteger();
            return true;
        }
    }
}
