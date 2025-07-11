package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents {
    import com.sulake.core.communication.messages.IMessageDataWrapper

    [SecureSWF(rename="true")]
    public class class_1752 {

        public function class_1752(param1: IMessageDataWrapper) {
            super();
            _key = param1.readString();
            _value = param1.readString();
        }

        private var _key: String;

        public function get key(): String {
            return _key;
        }

        private var _value: String;

        public function get value(): String {
            return _value;
        }
    }
}
