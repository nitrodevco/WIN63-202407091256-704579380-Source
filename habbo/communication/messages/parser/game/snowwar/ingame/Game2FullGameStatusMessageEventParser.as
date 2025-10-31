package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FullGameStatusData

    [SecureSWF(rename="true")]
    public class Game2FullGameStatusMessageEventParser implements IMessageParser {

        public function Game2FullGameStatusMessageEventParser() {
            super();
        }
        private var var_899: FullGameStatusData;

        public function get fullStatus(): FullGameStatusData {
            return var_899;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_899 = new FullGameStatusData(param1);
            return true;
        }
    }
}
