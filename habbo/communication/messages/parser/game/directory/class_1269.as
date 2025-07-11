package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData

    [SecureSWF(rename="true")]
    public class class_1269 implements IMessageParser {

        public function class_1269() {
            super();
        }
        private var var_1111: GameLobbyData;

        public function get gameLobbyData(): GameLobbyData {
            return var_1111;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_1111 = new GameLobbyData(param1);
            return true;
        }
    }
}
