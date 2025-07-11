package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarPostureUpdateMessage(param1: String, param2: String = "") {
            super();
            var_4323 = param1;
            var_215 = param2;
        }
        private var var_4323: String;
        private var var_215: String;

        public function get postureType(): String {
            return var_4323;
        }

        public function get parameter(): String {
            return var_215;
        }
    }
}
