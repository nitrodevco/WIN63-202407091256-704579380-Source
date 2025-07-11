package com.sulake.habbo.communication.messages.outgoing.camera.json {
    [SecureSWF(rename="false")]
    public class JsonPoint {

        public function JsonPoint(param1: int, param2: int) {
            super();
            this.var_31 = param1;
            this.var_28 = param2;
        }
        private var var_31: int;
        private var var_28: int;

        public function get x(): int {
            return var_31;
        }

        public function get y(): int {
            return var_28;
        }
    }
}
