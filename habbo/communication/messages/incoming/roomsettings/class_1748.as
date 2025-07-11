package com.sulake.habbo.communication.messages.incoming.roomsettings {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1748 implements class_1733 {

        public function class_1748(param1: IMessageDataWrapper) {
            super();
            var_418 = param1.readInteger();
            _userName = param1.readString();
        }
        private var var_418: int;

        private var _userName: String;

        public function get userName(): String {
            return _userName;
        }

        public function get userId(): int {
            return var_418;
        }
    }
}
