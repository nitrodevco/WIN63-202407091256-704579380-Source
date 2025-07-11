package com.sulake.habbo.communication.messages.incoming.moderation {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1774 {

        public function class_1774(param1: IMessageDataWrapper) {
            super();
            var_781 = param1.readString();
            var_979 = param1.readInteger();
            var_1197 = param1.readString();
            _msg = param1.readString();
            var_776 = param1.readBoolean();
        }
        private var var_781: String;
        private var var_979: int;
        private var var_1197: String;
        private var var_776: Boolean;

        private var _msg: String;

        public function get msg(): String {
            return _msg;
        }

        public function get timeStamp(): String {
            return var_781;
        }

        public function get chatterId(): int {
            return var_979;
        }

        public function get chatterName(): String {
            return var_1197;
        }

        public function get hasHighlighting(): Boolean {
            return var_776;
        }
    }
}
