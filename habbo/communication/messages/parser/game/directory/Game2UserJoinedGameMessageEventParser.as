package com.sulake.habbo.communication.messages.parser.game.directory {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser
    import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData

    [SecureSWF(rename="true")]
    public class Game2UserJoinedGameMessageEventParser implements IMessageParser {

        public function Game2UserJoinedGameMessageEventParser() {
            super();
        }
        private var var_847: GameLobbyPlayerData;
        private var var_1449: Boolean;

        public function get user(): GameLobbyPlayerData {
            return var_847;
        }

        public function get wasTeamSwitched(): Boolean {
            return var_1449;
        }

        public function flush(): Boolean {
            return false;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_847 = new GameLobbyPlayerData(param1);
            var_1449 = param1.readBoolean();
            return true;
        }
    }
}
