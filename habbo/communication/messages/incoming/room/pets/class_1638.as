package com.sulake.habbo.communication.messages.incoming.room.pets {
    [SecureSWF(rename="true")]
    public class class_1638 {

        public function class_1638(param1: int, param2: int, param3: String, param4: int, param5: String, param6: int, param7: Boolean) {
            super();
            _stuffId = param1;
            var_390 = param2;
            var_394 = param3;
            var_418 = param4;
            _userName = param5;
            var_806 = param6;
            var_1292 = param7;
        }
        private var var_390: int;

        private var var_394: String;

        private var var_418: int;
        private var var_806: int;
        private var var_1292: Boolean;

        private var _stuffId: int;

        public function get stuffId(): int {
            return _stuffId;
        }

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function get classId(): int {
            return var_390;
        }

        public function get productCode(): String {
            return var_394;
        }

        public function get userId(): int {
            return var_418;
        }

        public function get rarityLevel(): int {
            return var_806;
        }

        public function get hasMutation(): Boolean {
            return var_1292;
        }
    }
}
