package com.sulake.habbo.communication.messages.parser.game.lobby {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class AchievementResolutionCompletedMessageEventParser implements IMessageParser {

        public function AchievementResolutionCompletedMessageEventParser() {
            super();
        }
        private var var_633: String;
        private var var_413: String;

        public function get stuffCode(): String {
            return var_633;
        }

        public function get badgeCode(): String {
            return var_413;
        }

        public function flush(): Boolean {
            var_633 = "";
            var_413 = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_633 = param1.readString();
            var_413 = param1.readString();
            return true;
        }
    }
}
