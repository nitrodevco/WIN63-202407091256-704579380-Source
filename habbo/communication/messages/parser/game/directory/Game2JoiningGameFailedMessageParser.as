package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    public class Game2JoiningGameFailedMessageParser implements IMessageParser {

        public static const const_173: int = 1;

        public static const const_398: int = 2;

        public static const const_105: int = 3;

        public static const const_75: int = 4;

        public static const const_286: int = 5;

        public static const const_185: int = 6;

        public static const const_197: int = 7;

        public static const const_48: int = 8;

        public function Game2JoiningGameFailedMessageParser() {
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
