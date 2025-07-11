package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2StartCounterMessageParser implements IMessageParser {

        public function Game2StartCounterMessageParser() {
            super();
        }
        private var var_1017: int;

        public function get countDownLength(): int {
            return var_1017;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1017 = param1.readInteger();
            return true;
        }
    }
}
