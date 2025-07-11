package com.sulake.habbo.communication.messages.parser.room.furniture {
    [SecureSWF(rename="true")]
    public class class_1728 {

        public function class_1728(param1: String, param2: String, param3: String) {
            super();
            var_1271 = param1;
            var_617 = param2;
            var_363 = param3;
        }
        private var var_1271: String;
        private var var_617: String;
        private var var_363: String;

        public function get playlistId(): String {
            return var_1271;
        }

        public function get title(): String {
            return var_617;
        }

        public function get description(): String {
            return var_363;
        }
    }
}
