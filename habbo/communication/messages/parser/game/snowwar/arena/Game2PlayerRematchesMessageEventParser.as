package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class Game2PlayerRematchesMessageEventParser implements IMessageParser {

        public function Game2PlayerRematchesMessageEventParser() {
            super();
        }
        private var var_418: int;

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_418 = param1.readInteger();
            return true;
        }
    }
}
