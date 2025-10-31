package com.sulake.habbo.communication.messages.parser.room.session {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class RoomForwardMessageEventParser implements IMessageParser {

        public function RoomForwardMessageEventParser() {
            super();
        }
        private var var_369: int;

        public function get roomId(): int {
            return var_369;
        }

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_369 = param1.readInteger();
            return true;
        }
    }
}
