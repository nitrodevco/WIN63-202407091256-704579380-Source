package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class Game2StageRunningMessageEventParser implements IMessageParser {

        public function Game2StageRunningMessageEventParser() {
            super();
        }
        private var var_457: int;

        public function get timeToStageEnd(): int {
            return var_457;
        }

        public function flush(): Boolean {
            var_457 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_457 = param1.readInteger();
            return true;
        }
    }
}
