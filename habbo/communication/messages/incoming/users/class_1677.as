package com.sulake.habbo.communication.messages.incoming.users {
    [SecureSWF(rename="true")]
    public class class_1677 {

        public function class_1677(param1: int, param2: String, param3: Boolean) {
            super();
            var_369 = param1;
            _roomName = param2;
            var_1430 = param3;
        }
        private var var_369: int;
        private var var_1430: Boolean = false;

        private var _roomName: String;

        public function get roomName(): String {
            return _roomName;
        }

        public function get roomId(): int {
            return var_369;
        }

        public function get hasControllers(): Boolean {
            return var_1430;
        }
    }
}
