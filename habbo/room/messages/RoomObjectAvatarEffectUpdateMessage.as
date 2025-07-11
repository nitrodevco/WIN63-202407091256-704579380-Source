package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarEffectUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarEffectUpdateMessage(param1: int = 0, param2: int = 0) {
            super();
            var_1758 = param1;
            var_777 = param2;
        }
        private var var_1758: int;
        private var var_777: int;

        public function get effect(): int {
            return var_1758;
        }

        public function get delayMilliSeconds(): int {
            return var_777;
        }
    }
}
