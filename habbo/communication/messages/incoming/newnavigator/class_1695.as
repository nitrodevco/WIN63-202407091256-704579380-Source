package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1695 {

        public function class_1695(param1: IMessageDataWrapper) {
            super();
            _flatId = param1.readInteger();
            var_1231 = param1.readInteger();
            var_859 = param1.readString();
            _caption = param1.readString();
        }
        private var var_1231: int;

        private var var_859: String;

        private var _flatId: int;

        public function get flatId(): int {
            return _flatId;
        }

        private var _caption: String;

        public function get caption(): String {
            return _caption;
        }

        public function get areaId(): int {
            return var_1231;
        }

        public function get image(): String {
            return var_859;
        }
    }
}
