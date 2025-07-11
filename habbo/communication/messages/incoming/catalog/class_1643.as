package com.sulake.habbo.communication.messages.incoming.catalog {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1643 {

        public function class_1643(param1: IMessageDataWrapper) {
            super();
            _offerId = param1.readInteger();
            var_946 = param1.readBoolean();
            var_878 = param1.readInteger();
            var_901 = param1.readBoolean();
        }
        private var var_946: Boolean;

        private var var_901: Boolean;

        private var var_878: int;

        private var _offerId: int;

        public function get offerId(): int {
            return _offerId;
        }

        public function get isVip(): Boolean {
            return var_946;
        }

        public function get isSelectable(): Boolean {
            return var_901;
        }

        public function get daysRequired(): int {
            return var_878;
        }
    }
}
