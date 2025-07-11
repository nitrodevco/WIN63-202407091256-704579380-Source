package com.sulake.habbo.communication.messages.incoming.newnavigator {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1706 {

        public function class_1706(param1: IMessageDataWrapper) {
            super();
            var_280 = param1.readInteger();
            var_1066 = param1.readString();
            var_1462 = param1.readString();
            _localization = param1.readString();
        }
        private var var_280: int;
        private var var_1066: String;
        private var var_1462: String;

        private var _localization: String;

        public function get localization(): String {
            return _localization;
        }

        public function get id(): int {
            return var_280;
        }

        public function get searchCode(): String {
            return var_1066;
        }

        public function get filter(): String {
            return var_1462;
        }
    }
}
