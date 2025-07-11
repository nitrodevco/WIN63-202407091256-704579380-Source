package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.habbo.communication.messages.incoming.navigator.class_1675

    [SecureSWF(rename="true")]
    public class class_3439 {

        public function class_3439(param1: class_1652) {
            super();
            var_503 = param1.searchCodeOriginal;
            var_365 = param1.filteringData;
            var_3840 = param1;
        }
        private var var_503: String;
        private var var_365: String;
        private var var_3840: class_1652;

        public function get searchCodeOriginal(): String {
            return var_503;
        }

        public function get filteringData(): String {
            return var_365;
        }

        public function get resultSet(): class_1652 {
            return var_3840;
        }

        public function findGuestRoom(param1: int): class_1675 {
            if (var_3840 != null) {
                return var_3840.findGuestRoom(param1);
            }
            return null;
        }
    }
}
