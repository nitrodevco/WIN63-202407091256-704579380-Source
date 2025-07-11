package com.sulake.habbo.communication.messages.incoming.room.engine {
    [SecureSWF(rename="true")]
    public class class_1711 {

        public function class_1711(param1: String, param2: String) {
            super();
            var_683 = param1;
            var_735 = param2;
        }
        private var var_683: String;
        private var var_735: String;

        public function get actionType(): String {
            return var_683;
        }

        public function get actionParameter(): String {
            return var_735;
        }

        public function toString(): String {
            return var_683 + ":" + var_735;
        }
    }
}
