package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1775 {

        public function class_1775(param1: IMessageDataWrapper) {
            super();
            var_369 = param1.readInteger();
            _roomName = param1.readString();
            var_1389 = param1.readInteger();
            var_802 = param1.readInteger();
        }
        private var var_369: int;
        private var var_1389: int;

        private var var_802: int;

        private var _roomName: String;

        public function get roomName(): String {
            return _roomName;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function get enterHour(): int {
            return var_1389;
        }

        public function get enterMinute(): int {
            return var_802;
        }
    }
}
