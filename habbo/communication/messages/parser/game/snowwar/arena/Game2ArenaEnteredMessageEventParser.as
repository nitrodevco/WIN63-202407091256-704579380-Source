package com.sulake.habbo.communication.messages.parser.game.snowwar.arena {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData

    [SecureSWF(rename="true")]
    public class Game2ArenaEnteredMessageEventParser implements IMessageParser {

        public function Game2ArenaEnteredMessageEventParser() {
            super();
        }
        private var var_165: Game2PlayerData;

        public function get player(): Game2PlayerData {
            return var_165;
        }

        public function flush(): Boolean {
            if (var_165) {
                var_165.dispose();
                var_165 = null;
            }
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_165 = new Game2PlayerData();
            var_165.parse(param1);
            return true;
        }
    }
}
