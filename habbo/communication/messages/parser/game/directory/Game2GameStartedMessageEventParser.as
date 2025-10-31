package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData

    [SecureSWF(rename="true")]
    public class Game2GameStartedMessageEventParser implements IMessageParser {

        public function Game2GameStartedMessageEventParser() {
            super();
        }
        private var var_605: GameLobbyData;

        public function get lobbyData(): GameLobbyData {
            return var_605;
        }

        public function flush(): Boolean {
            var_605 = null;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_605 = new GameLobbyData(param1);
            return true;
        }
    }
}
