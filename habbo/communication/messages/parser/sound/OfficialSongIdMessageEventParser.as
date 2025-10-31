package com.sulake.habbo.communication.messages.parser.sound {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class OfficialSongIdMessageEventParser implements IMessageParser {

        public function OfficialSongIdMessageEventParser() {
            super();
        }
        private var var_606: int;

        private var _officialSongId: String;

        public function get officialSongId(): String {
            return _officialSongId;
        }

        public function get songId(): int {
            return var_606;
        }

        public function flush(): Boolean {
            var_606 = 0;
            _officialSongId = "";
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            _officialSongId = param1.readString();
            var_606 = param1.readInteger();
            return true;
        }
    }
}
