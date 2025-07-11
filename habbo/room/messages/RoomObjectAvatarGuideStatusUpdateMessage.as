package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarGuideStatusUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarGuideStatusUpdateMessage(param1: int) {
            super();
            _guideStatus = param1;
        }

        private var _guideStatus: int;

        public function get guideStatus(): int {
            return _guideStatus;
        }
    }
}
