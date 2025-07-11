package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class class_1480 implements IMessageParser {

        public function class_1480() {
            super();
        }
        private var var_414: int;

        public function get gameType(): int {
            return var_414;
        }

        public function flush(): Boolean {
            var_414 = -1;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_414 = param1.readInteger();
            return true;
        }
    }
}
