package com.sulake.habbo.communication.messages.parser.room.furniture {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuildFurniContextMenuInfoMessageEventParser implements IMessageParser {

        public function GuildFurniContextMenuInfoMessageEventParser() {
            super();
        }
        private var var_455: int;
        private var var_364: int;
        private var var_627: String;
        private var var_574: int;
        private var var_500: Boolean;
        private var var_628: Boolean;

        public function get objectId(): int {
            return var_455;
        }

        public function get guildId(): int {
            return var_364;
        }

        public function get guildName(): String {
            return var_627;
        }

        public function get guildHomeRoomId(): int {
            return var_574;
        }

        public function get userIsMember(): Boolean {
            return var_500;
        }

        public function get guildHasReadableForum(): Boolean {
            return var_628;
        }

        public function flush(): Boolean {
            var_455 = -1;
            var_364 = -1;
            var_627 = "";
            var_574 = -1;
            var_500 = false;
            var_628 = false;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            if (param1 == null) {
                return false;
            }
            var_455 = param1.readInteger();
            var_364 = param1.readInteger();
            var_627 = param1.readString();
            var_574 = param1.readInteger();
            var_500 = param1.readBoolean();
            var_628 = param1.readBoolean();
            return true;
        }
    }
}
