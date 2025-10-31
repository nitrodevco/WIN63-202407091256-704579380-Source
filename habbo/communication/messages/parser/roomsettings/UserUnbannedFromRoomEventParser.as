package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class UserUnbannedFromRoomEventParser implements IMessageParser {

        public function UserUnbannedFromRoomEventParser() {
            super();
        }
        private var var_369: int;
        private var var_418: int;

        public function get roomId(): int {
            return var_369;
        }

        public function get userId(): int {
            return var_418;
        }

        public function flush(): Boolean {
            var_369 = 0;
            var_418 = 0;
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_369 = param1.readInteger();
            var_418 = param1.readInteger();
            return true;
        }
    }
}
