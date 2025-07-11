package com.sulake.habbo.communication.messages.incoming.sound {
    [SecureSWF(rename="true")]
    public class class_1763 extends class_1648 {

        public function class_1763(param1: int, param2: int, param3: String, param4: String, param5: String) {
            super(param1, param2, param3, param4);
            var_1447 = param5;
        }
        private var var_1447: String = "";

        public function get data(): String {
            return var_1447;
        }
    }
}
