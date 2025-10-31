package com.sulake.habbo.communication.messages.parser.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomSettingsErrorEventParser implements IMessageParser {

        public function RoomSettingsErrorEventParser() {
            super();
        }
        private var var_369: int;
        private var var_412: int;

        public function get roomId(): int {
            return var_369;
        }

        public function get errorCode(): int {
            return var_412;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_369 = param1.readInteger();
            var_412 = param1.readInteger();
            return true;
        }

        public function flush(): Boolean {
            var_369 = 0;
            var_412 = 0;
            return true;
        }
    }
}
