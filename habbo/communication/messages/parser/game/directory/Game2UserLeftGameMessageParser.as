package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2UserLeftGameMessageParser implements IMessageParser {

        public function Game2UserLeftGameMessageParser() {
            super();
        }
        private var var_418: int;

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            return true;
        }
    }
}
