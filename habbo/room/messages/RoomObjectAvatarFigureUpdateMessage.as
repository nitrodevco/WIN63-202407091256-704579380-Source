package com.sulake.habbo.room.messages {
    public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage {

        public function RoomObjectAvatarFigureUpdateMessage(param1: String, param2: String = null, param3: String = null, param4: Boolean = false) {
            super();
            var_426 = param1;
            var_129 = param2;
            var_4526 = param3;
            var_768 = param4;
        }
        private var var_426: String;
        private var var_4526: String;
        private var var_129: String;
        private var var_768: Boolean;

        public function get figure(): String {
            return var_426;
        }

        public function get race(): String {
            return var_4526;
        }

        public function get gender(): String {
            return var_129;
        }

        public function get isRiding(): Boolean {
            return var_768;
        }
    }
}
