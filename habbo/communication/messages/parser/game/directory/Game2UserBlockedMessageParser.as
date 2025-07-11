package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2UserBlockedMessageParser implements IMessageParser {

        public function Game2UserBlockedMessageParser() {
            super();
        }
        private var var_569: int;

        public function get playerBlockLength(): int {
            return var_569;
        }

        public function flush(): Boolean {
            var_569 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_569 = param1.readInteger();
            return true;
        }
    }
}
