package com.sulake.habbo.communication.messages.incoming.avatar {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1717 {

        public function class_1717(param1: IMessageDataWrapper) {
            super();
            var_888 = param1.readInteger();
            _figureString = param1.readString();
            var_129 = param1.readString();
        }
        private var var_888: int;
        private var var_129: String;

        private var _figureString: String;

        public function get figureString(): String {
            return _figureString;
        }

        public function get slotId(): int {
            return var_888;
        }

        public function get gender(): String {
            return var_129;
        }
    }
}
