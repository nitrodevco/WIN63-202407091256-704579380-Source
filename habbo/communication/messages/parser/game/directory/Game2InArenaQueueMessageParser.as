package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2InArenaQueueMessageParser implements IMessageParser {

        public function Game2InArenaQueueMessageParser() {
            super();
        }
        private var var_810: int;

        public function get position(): int {
            return var_810;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_810 = param1.readInteger();
            return true;
        }
    }
}
