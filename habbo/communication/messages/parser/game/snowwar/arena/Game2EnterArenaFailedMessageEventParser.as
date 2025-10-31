package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class Game2EnterArenaFailedMessageEventParser implements IMessageParser {

        public static const const_239: int = 1;

        public static const const_85: int = 2;

        public static const const_204: int = 3;

        public static const const_297: int = 4;

        public function Game2EnterArenaFailedMessageEventParser() {
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
