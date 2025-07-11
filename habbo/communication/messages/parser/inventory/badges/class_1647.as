package com.sulake.habbo.communication.messages.parser.inventory.badges {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1647 {

        public function class_1647(param1: String, param2: IMessageDataWrapper) {
            super();
            var_372 = "ACH_" + param1 + param2.readInteger();
            var_1452 = param2.readInteger();
        }
        private var var_372: String;
        private var var_1452: int;

        public function get badgeId(): String {
            return var_372;
        }

        public function get limit(): int {
            return var_1452;
        }
    }
}
