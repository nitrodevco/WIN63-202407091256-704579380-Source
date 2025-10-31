package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class Game2StageEndingMessageEventParser implements IMessageParser {

        public function Game2StageEndingMessageEventParser() {
            super();
        }
        private var var_423: int;

        public function get timeToNextState(): int {
            return var_423;
        }

        public function flush(): Boolean {
            var_423 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_423 = param1.readInteger();
            return true;
        }
    }
}
