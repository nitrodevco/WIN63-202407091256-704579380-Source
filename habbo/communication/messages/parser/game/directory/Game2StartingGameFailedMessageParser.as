package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2StartingGameFailedMessageParser implements IMessageParser {

        public static const const_119: int = 1;

        public static const const_337: int = 2;

        public function Game2StartingGameFailedMessageParser() {
            super();
        }
        private var var_326: int;

        public function get reason(): int {
            return var_326;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_326 = param1.readInteger();
            return true;
        }
    }
}
