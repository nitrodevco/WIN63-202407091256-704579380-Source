package com.sulake.habbo.communication.messages.parser.help {
    import com.sulake.core.communication.messages.IMessageDataWrapper
    import com.sulake.core.communication.messages.IMessageParser

    [SecureSWF(rename="true")]
    public class GuideSessionInvitedToGuideRoomMessageEventParser implements IMessageParser {

        public function GuideSessionInvitedToGuideRoomMessageEventParser() {
            super();
        }
        private var var_369: int = 0;
        private var _roomName: String = "";

        public function flush(): Boolean {
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean {
            var_369 = param1.readInteger();
            _roomName = param1.readString();
            return true;
        }

        public function getRoomId(): int {
            return var_369;
        }

        public function getRoomName(): String {
            return _roomName;
        }
    }
}
